package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	
	import mx.controls.Menu;
	
	import st.crexi.as3.framework.cafe.core.events.OrderEvent;
	import st.crexi.as3.framework.cafe.core.events.WaiterEvent;
	import st.crexi.as3.framework.cafe.utils.OrderStatusType;
	import st.crexi.as3.framework.cafe.utils.Stock;
	import st.crexi.as3.framework.cafe.utils.Bottle;
	
	/**
	 * Requestを受け取って処理を行うクラスです
	 * @author kaoru_shibasaki
	 * 
	 */	
	public class Waiter
	{
		
		/**
		 * このWaiterが処理するOrderが格納された配列です
		 */		
		private var _orders:Vector.<AbstOrder>;
		
		/**
		 * 実行する,しているOrderを突っ込みます
		 * 
		 */		
		private var _stock:Stock;
		
		
		/**
		 * 完了時にEventを投げます
		 */		
		private var _eventDispatcher:IEventDispatcher;
		
		
		/**
		 * callbackループの数です
		 */		
		private var _isSync:uint = 0;
		
		/**
		 * callback中に呼ばれたCallBackループの数です
		 */		
		private var _isOnCompleteSync:uint = 0;
		
		
		/**
		 * 突っ込まれたRequestの処理をスタートさせます
		 * @param requests
		 * 
		 */		
		public function start(orders:Array):void
		{
			var isWait:Boolean = false;
			var worker:Worker;
			_orders = Vector.<AbstOrder>(orders);
			
			for each(var order:AbstOrder in _orders) {
				
				isWait = hasWaiting(order);

				if (isWait) continue;
				
				if (!order.notifier.hasEventListener(OrderEvent.COMPLETE)) {
					order.notifier.addEventListener(OrderEvent.COMPLETE, onComplete)
				}
				
				worker = new Worker(order, this);
				_stock.add(order, worker);
				
				_isSync++;
				worker.$start();
				_isSync--;
			}
			
			if (_stock.length == 0 && _isSync == 0)  {					
				_eventDispatcher.dispatchEvent(new WaiterEvent(WaiterEvent.ALL_COMPLETE));
			}	
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get notifier():IEventDispatcher
		{
			return _eventDispatcher;
		}
		
		
		
		/**
		 * 現状Waiterで動かしている処理をabortさせます
		 * 
		 */		
		public function stop():void
		{
			/*
			_isStop = true;
			for each(var request:IRequest in _requests) {
				if ($reqDic[request]) $reqDic[request].dispose();
			}
			*/

		}
		
		
		/**
		 * 処理をリスタートさせます
		 * @param menu
		 * 
		 */		
		public function restart(menus:Array):void
		{
			var orders:Array = new Array;
			
			for each(var menu:Menu in menus) {
				menu.order.$variables.argument = menu.argument;
				orders.push(menu.order);
				menu.order.$variables.status = OrderStatusType.IDLE;
				$reloadChildren(menu.order);
			}
			
			start(orders);
		}
		
		
		/**
		 * menuを返します
		 * @param order
		 * @param argument
		 * @return 
		 * 
		 */		
		public function menu(result:AbstResult, argument:*):Menu
		{
			var menu:Menu = new Menu;
			
			menu.order = result.$order;
			menu.argument = argument;
			return menu;
		}
		
		
		
		/**
		 * 
		 * @param orderEvent
		 * 
		 */
		protected function onComplete(orderEvent:OrderEvent):void
		{
			var order:AbstOrder
			var worker:Worker;
			order = orderEvent.order;
			_stock.del(orderEvent.order);
			
			for each(var container:Bottle in order.$variables.children) {
				
				var child:AbstOrder = container.main;
				var isWait:Boolean = hasWaiting(child);
				_stock.add(child, null);
				if (isWait) continue;
				child.$request[container.label] = order.$variables.result;
				
				if (!child.notifier.hasEventListener(OrderEvent.COMPLETE)) {
					child.notifier.addEventListener(OrderEvent.COMPLETE, onComplete)
				}

				
				worker = new Worker(child, this);
				_stock.set(child, worker);
				_isOnCompleteSync++;
				worker.$start();
				_isOnCompleteSync--;
				
			}
			
			if (_stock.length == 0 && _isSync == 0 && _isOnCompleteSync == 0)  {
				_eventDispatcher.dispatchEvent(new WaiterEvent(WaiterEvent.ALL_COMPLETE));
			}
			
		}
		
		/**
		 * Orderが何かの処理待ちが銅貨を返します
		 * @param order
		 * @return 
		 * 
		 */		
		protected function hasWaiting(order:AbstOrder):Boolean
		{
			var isWait:Boolean = false;
			
			
			if (order.$variables.status != OrderStatusType.IDLE) return true
			
			for each(var parent:AbstOrder in order.$variables.parents) {
				if (parent.$variables.status != OrderStatusType.END) isWait = true;
				if (isWait) break;
			}
			
			return isWait;
		}
		
		
		/**
		 * 
		 * @param order
		 * 
		 */		
		internal function $reloadChildren(order:AbstOrder):void
		{
			for each(var container:Bottle in order.$variables.children) {
				var child:AbstOrder = container.main;
				child.$variables.status = OrderStatusType.IDLE;
				if (_stock.hasKey(child)) Worker(_stock.get(child)).dispose();
			}
		}
		
		
		
		/**
		 * オブジェクトをcloneします
		 * @param arg
		 * @return 
		 * 
		 */		
		protected function clone(arg:*):* {
			var byte:ByteArray = new ByteArray();
			
			byte.writeObject(arg);
			byte.position = 0;
			return byte.readObject();
		}
		
		
		/**
		 * コンストラクタ
		 * 
		 */
		public function Waiter()
		{
			_stock = new Stock();
			_eventDispatcher = new EventDispatcher;
		}
	}
}
import st.crexi.as3.framework.cafe.core.AbstOrder;


class Menu
{
	public var order:AbstOrder;
	public var argument:*;
}