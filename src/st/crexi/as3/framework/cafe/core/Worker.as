package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;

	
	/**
	 * worker
	 * @author kaora crexista
	 * 
	 */	
	public class Worker
	{
		
		/**
		 * 
		 */		
		private const RESULT:String = "result";
		
		
		
		/**
		 * 
		 */		
		private var _request:IRequest;
		
		
		private var _recipe:IRecipe;
		
		
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
		private var _waiter:Waiter;
		
		
		
		public static function runArg(request:IRequest, argument:*):RequestArg
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
		public function get request():IRequest
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
			
			
			AbstRequest(_request).$status = RequestStatusType.INVOKING;
			AbstRequest(_request).$isInitialized = true;
			_recipe = _request.onReady();
			if (!_recipe) {
				_request.onSuccess(null, _waiter, this);
				return;
			}
			if (!_recipe.eventTarget.hasEventListener(_recipe.successEventType)) {
				_recipe.eventTarget.addEventListener(_recipe.successEventType, onSuccess(_recipe.eventTarget, _request));
			}
			
			_recipe.start();
		
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
		protected function onSuccess(target:IEventDispatcher, request:IRequest):Function
		{
			var worker:Worker = this;
			
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
		protected function onError(target:IEventDispatcher, request:IRequest):Function
		{			
			var worker:Worker = this;			
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
			if (value != null) AbstRequest(_request).$result = value;
			AbstRequest(_request).$status = RequestStatusType.END;
			if (_recipe) _recipe.eventTarget.removeEventListener(_recipe.successEventType, _callBack);
			_request.notifier.dispatchEvent(new RequestEvent(RequestEvent.COMPLETE, _request));
		}
		
		
		
		/**
		 * requestが失敗したときに呼ばれるメソッドです
		 * @param value
		 * @return 
		 * 
		 */		
		public function abort(value:* = null):void
		{
			if (value != null) AbstRequest(_request).$result = value;
			AbstRequest(_request).$status = RequestStatusType.END;
			if (_recipe) _recipe.eventTarget.removeEventListener(_recipe.successEventType, _callBack);
			_request.notifier.dispatchEvent(new RequestEvent(RequestEvent.ABORT, _request));
			
		}
		
		
		public function dispose():void
		{
			if (_recipe) _recipe.eventTarget.removeEventListener(_recipe.successEventType, _callBack);			
		}


		/**
		 * コンストラクタです
		 * @param request
		 * 
		 */
		public function Worker(request:IRequest, waiter:Waiter)
		{
			_waiter = waiter;
			_notifier = new EventDispatcher();
			_request = request;
			run();
		}
	}
}




import st.crexi.as3.framework.cafe.core.interfaces.IRequest;


class RequestArg
{
	
	/**
	 * 
	 */	
	private var _request:IRequest;
	
	/**
	 * 
	 */	
	private var _argument:*;
	

	/**
	 * 
	 * @return 
	 * 
	 */
	public function get request():IRequest
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
	
	
	public function RequestArg(request:IRequest, argument:*) 
	{
		_request = request;
		_argument = argument;
	}
}