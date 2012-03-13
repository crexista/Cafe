package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.utils.Bottle;
	
	/**
	 * RequestのProxyですOrder.request経由でrequestのメソッドを呼び出そうとしたらErrorをすっ飛ばします
	 * @author crexista
	 * 
	 */	
	internal dynamic class RequestProxy extends Proxy
	{
		/**
		 * オリジナルのIRequestオブジェクトです
		 */		
		private var _origin:IRequest;
		
		/**
		 * オリジナルのIRequestオブジェクトをcloneしてできたObjectです
		 */		
		private var _delegator:Object;
		
		/**
		 * enumをするために必要となった配列です
		 */		
		private var _indexArr:Array;
		
		
		
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
		
		/**
		 * for 文でまわすよう
		 * @param index
		 * @return 
		 * 
		 */		
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index < _indexArr.length) {
				return index + 1;
			} else {
				return 0;
			}
		}
		
		/**
		 * for文でまわすよう
		 * @param index
		 * @return 
		 * 
		 */		
		override flash_proxy function nextName(index:int):String {
			
			return _indexArr[index - 1];
		}
		
		
		/**
		 * for文でまわすよう
		 * @param index
		 * @return 
		 * 
		 */		
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
			var byte:ByteArray = new ByteArray();
			
			byte.writeObject(request);
			byte.position = 0;
			return byte.readObject();
		}
		
		
		/**
		 * 
		 * @param order
		 * @param origin
		 * @param delegator
		 * @param index
		 * 
		 */		
		protected function align(order:AbstOrder, origin:IRequest, delegator:Object, index:Array):void
		{
			var parent:AbstOrder;
			var clone:Object = clone(origin);
			
			for (var key:String in clone) {
				delegator[key] = new ResultProxy(order, key);
				index.push(key);
				
				//Orderが依存している他のOrderの子ノードとして登録
				parent = DILogic.getOrder(key);
				if (!parent) continue;
				parent.$variables.children.push(new Bottle(order, key));
				_delegator[key].from(parent);
				order.$variables.parents.push(parent);
			}

		}
		
		
		
		/**
		 * 
		 * @param origin
		 * 
		 */		
		public function RequestProxy(origin:IRequest, order:AbstOrder)
		{
			_origin = origin;
			_delegator = new Object;
			_indexArr = new Array();		
			align(order, origin, _delegator, _indexArr);
		}
		
	}
}