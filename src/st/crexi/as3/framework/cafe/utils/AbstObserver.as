package st.crexi.as3.framework.cafe.utils
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.utils.interfaces.IObserver;

	/**
	 * ObserverのBaseとなるクラスです
	 * 
	 * @author crexista
	 * 
	 */	
	public class AbstObserver
	{
		
		
		/**
		 * setHandlerで追加されたcallバックメソッドが格納されたDictionaryです
		 */
		private var _handlers:Object;
		
		
		
		/**
		 * Eventを
		 * @param type
		 * @param callBack
		 * @return 
		 * 
		 */		
		public function setHandler(type:String, handler:Function = null, propertyChain:Array = null):IObserver
		{
			var iObserver:IObserver = this as IObserver;
			if (propertyChain) {
			for (var i:int = 0; i < propertyChain.length; i++) {
				propertyChain[i];
			}
			}
			
			_handlers[type] = handler;
			
			iObserver.eventTarget.addEventListener(type, dummyHandler);

			return this as IObserver
		}
		
		
		private function dummyHandler(event:Event):void
		{
			var method:Function = _handlers[event.type]; 
			method.call(null, event);
		}
		
		
		/**
		 * ひも付けされたイベントをすべて削除します
		 * 
		 */		
		public function reset():void
		{
			_handlers = null;
			_handlers = new Object;
		}
		
		
		/**
		 * EventType指定でhandlerを削除島sう
		 * @param type
		 * 
		 */		
		public function remove(type:String):void
		{
			_handlers[type] = null;
			delete _handlers[type];
		}
		

		
		/**
		 * コンストラクタです
		 * 
		 */		
		public function AbstObserver() 
		{
			_handlers = new Object;
		}
	}
}