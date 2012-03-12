package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;
	
	/**
	 * RequestのProxyですOrder.request経由でrequestのメソッドを呼び出そうとしたらErrorをすっ飛ばします
	 * @author crexista
	 * 
	 */	
	public class RequestProxy extends Proxy
	{
		/**
		 * オリジナルのIRequestオブジェクトです
		 */		
		private var _origin:IRequest2;
		
		/**
		 * オリジナルのIRequestオブジェクトをcloneしてできたObjectです
		 */		
		private var _delegator:Object;
		
		/**
		 * enumをするために必要となった配列です
		 */		
		private var _indexArr:Array;
		
		
		/**
		 * 処理が終了したときに飛ばすEventDispatcherです
		 */		
		private var _notifier:IEventDispatcher;
		
		
		public function get notifier():IEventDispatcher
		{
			return _notifier;
		}
		
		
		
		/**
		 * 何らかのrequestのメソッドが呼ばれた時に飛びます
		 * @param name
		 * @param parameters
		 * @return 
		 * 
		 */
		override flash_proxy function callProperty(name:*, ...parameters):*
		{
			throw new Error("メソッドを呼ばないでください");
		}
		
		
		/**
		 * 基本的にPropertyを返します
		 * @param name
		 * @return 
		 * 
		 */		
		override flash_proxy function getProperty(name:*):*
		{
			return _delegator[name];
		}
		
		
		/**
		 * Propertyが勝手にセットされそうになったらErrorを飛ばします
		 * @param name
		 * @param value
		 * 
		 */		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			throw new Error("これ以上値を入れられません");
		}
		
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index < _indexArr.length) {
				return index + 1;
			} else {
				return 0;
			}
		}
		
		override flash_proxy function nextName(index:int):String {
			
			return _indexArr[index - 1];
		}
		
		
		override flash_proxy function nextValue(index:int):*
		{
			return _delegator[_indexArr[index - 1]];
		}
		
		
		/**
		 * 
		 * @param arg
		 * @return 
		 * 
		 */		
		protected function clone(request:*):* {
			var b:ByteArray = new ByteArray();
			
			b.writeObject(request);
			b.position = 0;
			return b.readObject();
		}
		
		
		
		/**
		 * 
		 * @param origin
		 * 
		 */		
		public function RequestProxy(origin:IRequest2, order:AbstOrder)
		{
			_origin = origin;
			_delegator = clone(origin);
			_indexArr = new Array();
			_notifier = new EventDispatcher();
			var parent:AbstOrder;
			var container:Container;
			for (var key:String in _delegator) {				
				if (!(_delegator[key] is AbstResult)) throw new Error("AbstResultをextendsしたproperty以外を置く事ができません");
				_delegator[key] = new ResultProxy(order);
				_indexArr.push(key);
				
				//Orderが依存している他のOrderの子ノードとして登録
				/*
				parent = getOrder(key);
				if (!parent) continue;
				parent.$children.push(new Container(order, key));
				order.$parents.push(parent);
				*/
				
			}
		}
		
	}
}