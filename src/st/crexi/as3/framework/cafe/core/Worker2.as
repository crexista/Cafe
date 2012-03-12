package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Event.OrderEvent;
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;

	public class Worker2
	{
		
		/**
		 * workerで実行するrequestです
		 */		
		private var _request:IRequest2
		
		
		/**
		 * Workerで実行されているOrderです
		 */
		private var _order:AbstOrder;
		
		
		
		private var _waiter:Waiter2
		
		
		/**
		 * 
		 */		
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
		 * 処理をスタートさせます
		 * 
		 */		
		public function $start():void
		{
			
			_order.$status = RequestStatusType.INVOKING;
			_recipe = _request.recipe;
			
			if (!_recipe) {
				_request.onSuccess(null, _waiter, this);
				return;
			}

			if (!_recipe.eventTarget.hasEventListener(_recipe.successEventType)) {
				_recipe.eventTarget.addEventListener(_recipe.successEventType, onSuccess(_recipe.eventTarget, _request));
			}
			
			_recipe.start();
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
			if (value != null) _order.$result = value;
			_order.$status = RequestStatusType.END;
			
			if (_recipe) _recipe.eventTarget.removeEventListener(_recipe.successEventType, _callBack);
			
			_order.notifier.dispatchEvent(new OrderEvent(OrderEvent.COMPLETE, _order));
		}
		
		
		
		/**
		 * requestが失敗したときに呼ばれるメソッドです
		 * @param value
		 * @return 
		 * 
		 */		
		public function abort(value:* = null):void
		{
			if (value != null) _order.$result = value;
			_order.$status = RequestStatusType.END;
			if (_recipe) _recipe.eventTarget.removeEventListener(_recipe.successEventType, _callBack);
			_order.notifier.dispatchEvent(new OrderEvent(OrderEvent.ABORT, _order));
			
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function dispose():void
		{
			if (_recipe) _recipe.eventTarget.removeEventListener(_recipe.successEventType, _callBack);
		}

		
		public function Worker2(order:AbstOrder)
		{
			order.$request
		}
	}
}