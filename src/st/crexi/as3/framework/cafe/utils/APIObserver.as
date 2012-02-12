package st.crexi.as3.framework.cafe.utils
{
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import st.crexi.as3.framework.cafe.utils.interfaces.IObserver;
	
	
	
	/**
	 * webAPIを叩いたさいのObserverです
	 * @author crexista
	 * 
	 */
	public class APIObserver extends AbstObserver implements IObserver
	{
		private var _urlLoader:URLLoader;
		private var _urlReq:URLRequest;
		private var _urlVariable:URLVariables;
		
		public function APIObserver()
		{
			_urlLoader = new URLLoader;
			_urlReq = new URLRequest;
			_urlVariable = new URLVariables;
			
		}
		
		public function get eventTarget():IEventDispatcher
		{
			return _urlLoader;
		}
		
		
		public function set requestMethod(value:String):void
		{
			_urlReq.method = value;
		}
		
		
		public function set variables(value:URLVariables):void
		{
			_urlReq.data = value;

		}
		
		public function set url(value:String):void
		{
			_urlReq.url = value;
		}
		
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set paramater(value:*):void
		{
			
		}
		
		public function start():void
		{
			_urlLoader.load(_urlReq);
		}
	}
}