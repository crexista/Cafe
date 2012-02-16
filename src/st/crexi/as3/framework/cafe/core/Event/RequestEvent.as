package st.crexi.as3.framework.cafe.core.Event
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	
	
	/**
	 * Requestがかんりょうしたり、reloadされたりした場合に飛ぶRequestEventです
	 * @author crexista
	 * 
	 */	
	public class RequestEvent extends Event
	{
		
		/**
		 * requestが完了したときに飛びます
		 */		
		public static const COMPLETE:String = "requestComplete";
		
		
		/**
		 * requestがreloadされたときに飛びます
		 */		
		public static const ABORT:String = "requestFail";
		
		
		/**
		 * このイベントを飛ばす事になるrequestです
		 */		
		private var _request:IRequest
		
		
		/**
		 * コンストラクタです
		 * @param type
		 * @param request
		 * 
		 */
		public function RequestEvent(type:String, request:IRequest)
		{
			_request = request;
			super(type);
		}
		
		
		/**
		 * このイベントを飛ばしたrequestそのものです
		 * @return 
		 * 
		 */		
		public function get request():IRequest
		{
			return _request;
		}
		
		
		override public function clone():Event
		{
			return new RequestEvent(type, this.request);
		}
		
	}
}