package st.crexi.as3.framework.cafe.core
{
	import flash.utils.ByteArray;
	
	import mx.utils.OrderedObject;
	
	import st.crexi.as3.framework.cafe.core.Event.OrderEvent;
	
	import st.crexi.as3.framework.cafe.utils.Stock;
	
	/**
	 * Requestを受け取って処理を行うクラスです
	 * @author kaoru_shibasaki
	 * 
	 */	
	public class Waiter2
	{
		
		/**
		 * このWaiterが処理するRequestの配列です
		 */		
		private var _requests:Array;
		
		
		private var _stock:Stock;
		
		private var _orders:Vector.<AbstOrder>;
		
		
		/**
		 * 突っ込まれたRequestの処理をスタートさせます
		 * @param requests
		 * 
		 */		
		public function start(orders:Array):void
		{
			var isWait:Boolean = false;
			var worker:Worker2;
			_orders = Vector.<AbstOrder>(orders);
			
			for each(var order:AbstOrder in _orders) {
				
				isWait = hasWaiting(order);
				if (isWait) continue;
				
				if (!order.notifier.hasEventListener(OrderEvent.COMPLETE)) {
					order.notifier.addEventListener(OrderEvent.COMPLETE, onComplete)
				}
				
				worker = new Worker2(order);
				_stock.add(order, worker);
				worker.$start();
			}
		}
		
		
		
		protected function onComplete(orderEvent:OrderEvent):void
		{
			var order:AbstOrder
			var worker:Worker2;
			
			_stock.del(orderEvent.order);
			
			for each(var container:Container in order.$children) {
				
				var child:AbstOrder = container.main;
				var isWait:Boolean = hasWaiting(child);
				
				if (isWait) continue;
				child[container.lable] = order.$result;
				
				if (!order.notifier.hasEventListener(OrderEvent.COMPLETE)) {
					order.notifier.addEventListener(OrderEvent.COMPLETE, onComplete)
				}

				_stock.add(child, worker);
				
				//再起処理には入ってしまっているかのチェック
				//_isOnCompleteSync++;
				worker = new Worker2(child);
				worker.$start();
				//_isOnCompleteSync--;
				
			}
			
			/*
			if (_stock.length == 0 && _isSync == 0 && _isOnCompleteSync == 0)  {				
				_eventDispatcher.dispatchEvent(new WaiterEvent(WaiterEvent.ALL_COMPLETE));
			}*/
			
		}
		
		
		protected function hasWaiting(order:AbstOrder):Boolean
		{
			var isWait:Boolean = false;
			
			
			if (order.$status != RequestStatusType.IDLE) return true
			
			for each(var parent:AbstOrder in order.$parents) {
				if (parent.$status != RequestStatusType.END) isWait = true;
				if (isWait) break;
			}
			
			return isWait;
		}
		
		
		protected function reloadChildren(order:AbstOrder):void
		{
			for each(var child:AbstOrder in order.$children) {
				child.$status = RequestStatusType.IDLE;
				if (_stock.hasKey(child)) _stock.get(child).dispose();
			}
		}
		
		
		
		/**
		 * オブジェクトをcloneします
		 * @param arg
		 * @return 
		 * 
		 */		
		protected function clone(arg:*):* {
			var b:ByteArray = new ByteArray();
			
			b.writeObject(arg);
			b.position = 0;
			return b.readObject();
		}
		public function Waiter2()
		{
		}
	}
}