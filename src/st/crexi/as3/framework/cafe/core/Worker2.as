package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent2;
	import st.crexi.as3.framework.cafe.core.Event.WorkerEvent;
	import st.crexi.as3.framework.cafe.core.Event.WorkerEvent2;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;

	
	/**
	 * worker
	 * @author kaora crexista
	 * 
	 */	
	public class Worker2
	{
		
		/**
		 * 
		 */		
		private const RESULT:String = "result";
		
		
		/**
		 * 
		 */		
		private var _request:IRequest2;
		
		
		/**
		 * 
		 */		
		private var _notifier:IEventDispatcher;
		
		
		/**
		 * 
		 */		
		private var _callBack:Function;
		
		
		/**
		 * 
		 */		
		private var _waiter:Waiter2;
		
		
		
		public static function runArg(request:IRequest2, argument:*):RequestArg
		{
			return new RequestArg(request, argument);
		}
		
		
		
		/**
		 * Requestの処理が終わったりしたらEventをなげるEventDispatcherです
		 * @return 
		 * 
		 */		
		public function get notifier():IEventDispatcher
		{
			return _notifier;
		}
		
		
		/**
		 * このworkerが担当しているrequestです
		 * @return 
		 * 
		 */		
		public function get request():IRequest2
		{
			return _request;
		}
		
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		protected function run():void
		{
			
			AbstRequest2(_request).$status = RequestStatusType.INVOKING;
			AbstRequest2(_request).$isInitialized = true;
			
			if (!_request.recipe.eventTarget.hasEventListener(_request.recipe.successEventType)) {
				_request.recipe.eventTarget.addEventListener(_request.recipe.successEventType, onSuccess(_request.recipe.eventTarget, _request));
			}
			
			_request.recipe.start();
		
		}
		
		
		
		public function runWith(value:Vector.<RequestArg>):void
		{
			for each(var reqArg:RequestArg in value) {
				//run(reqArg.request, reqArg.argument);
			}
		}
		
		
		/**
		 * recipeに描いてある予定通りsuccessEventが帰ってきたときに実行されるメソッドです
		 * @param target
		 * @param request
		 * @return 
		 * 
		 */		
		protected function onSuccess(target:IEventDispatcher, request:IRequest2):Function
		{
			var worker:Worker2 = this;
			
			var callBack:Function = function (event:Event):void
			{
				request.onSuccess(event, _waiter, worker);
			};
			_callBack = callBack;
			return callBack;

		}
		

		/**
		 * recipeに描いてある予定通りerrorEventが帰ってきたときに実行されるメソッドです
		 * @param target
		 * @param request
		 * @return 
		 * 
		 */		
		protected function onError(target:IEventDispatcher, request:IRequest2):Function
		{			
			var worker:Worker2 = this;			
			var callBack:Function = function (event:Event):void
			{
				request.onError(event, _waiter, worker);
			};
			
			return callBack;

		}

		/**
		 * 
		 * @param value
		 * 
		 */		
		public function end(value:*=null):void
		{
			if (value != null) _request[RESULT] = value;
			AbstRequest2(_request).$status = RequestStatusType.END;
			_request.recipe.eventTarget.removeEventListener(_request.recipe.successEventType, _callBack);
			_request.notifier.dispatchEvent(new RequestEvent2(RequestEvent2.COMPLETE, _request));
		}


		/**
		 * コンストラクタです
		 * @param request
		 * 
		 */
		public function Worker2(request:IRequest2, waiter:Waiter2)
		{
			_waiter = waiter;
			_notifier = new EventDispatcher();
			_request = request;
			run();
		}
	}
}




import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;


class RequestArg
{
	
	/**
	 * 
	 */	
	private var _request:IRequest2;
	
	/**
	 * 
	 */	
	private var _argument:*;
	

	/**
	 * 
	 * @return 
	 * 
	 */
	public function get request():IRequest2
	{
		return _request;
	}
	
	
	/**
	 * 
	 * @return 
	 * 
	 */	
	public function get argument():*
	{
		return _argument;
	}
	
	
	public function RequestArg(request:IRequest2, argument:*) 
	{
		_request = request;
		_argument = argument;
	}
}