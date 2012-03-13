package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.events.OrderEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.utils.OrderStatusType;

	/**
	 * Requestの持つrecipeを受け取り処理を行います
	 * 
	 * @author kaora crexista
	 * 
	 */	
	public class Worker
	{

		
		/**
		 * Workerで実行されているOrderです
		 */
		private var _order:AbstOrder;
		
		
		
		/**
		 *  
		 */		
		private var _waiter:Waiter
		
		
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
		public function get request():IRequest
		{
			return _order.$request;
		}
		
		/**
		 * 処理をスタートさせます
		 * 
		 */		
		internal function $start():void
		{
			
			_order.$variables.status = OrderStatusType.INVOKING;
			_recipe = this.request.recipe;
			this.request.setup(_order.$variables.argument);
			if (!_recipe) {
				this.request.onSuccess(new Draft(new Guard, _waiter, this, null));
				return;
			}

			if (!_recipe.eventTarget.hasEventListener(_recipe.successEventType)) {
				_recipe.eventTarget.addEventListener(_recipe.successEventType, onSuccess(_recipe.eventTarget, this.request));
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
		protected function onSuccess(target:IEventDispatcher, request:IRequest):Function
		{
			var worker:Worker = this;
			
			var callBack:Function = function (event:Event):void
			{				
				request.onSuccess(new Draft(new Guard, _waiter, worker, event));
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
				request.onError(new Draft(new Guard, _waiter, worker, event));
			};
			
			return callBack;
			
		}
		
		
		/**
		 * Requestの処理を終了させます。
		 * 
		 * @param value Requestの処理結果を入れます
		 * 
		 */		
		public function end(result:AbstResult = null):void
		{
			if (result != null) {
				_order.$variables.result = result;
				result.from(_order);
			}
			_order.$variables.status = OrderStatusType.END;
			
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
			if (value != null) _order.$variables.result = value;
			_order.$variables.status = OrderStatusType.END;
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

		
		/**
		 * コンストラクタです
		 * @param order
		 * @param waiter
		 * 
		 */		
		public function Worker(order:AbstOrder, waiter:Waiter)
		{			
			_order = order;
			_waiter = waiter;
		}
	}
}