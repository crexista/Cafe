package st.crexi.as3.framework.cafe.core.Event
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;
	
	
	/**
	 * Requestがかんりょうしたり、reloadされたりした場合に飛ぶRequestEventです
	 * @author crexista
	 * 
	 */	
	public class RequestEvent2 extends Event
	{
		
		/**
		 * requestが完了したときに飛びます
		 */		
		public static const COMPLETE:String = "requestComplete";
		
		
		/**
		 * requestがreloadされたときに飛びます
		 */		
		public static const RELOAD:String = "requestReload";
		
		
		/**
		 * このイベントを飛ばす事になるrequestです
		 */		
		private var _request:IRequest2
		
		
		/**
		 * コンストラクタです
		 * @param type
		 * @param request
		 * 
		 */
		public function RequestEvent2(type:String, request:IRequest2)
		{
			_request = request;
			super(type);
		}
		
		
		/**
		 * このイベントを飛ばしたrequestそのものです
		 * @return 
		 * 
		 */		
		public function get request():IRequest2
		{
			return _request;
		}
		
		
		override public function clone():Event
		{
			return new RequestEvent2(type, this.request);
		}
		
	}
}