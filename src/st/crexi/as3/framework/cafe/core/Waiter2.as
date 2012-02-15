package st.crexi.as3.framework.cafe.core
{
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent2;
	import st.crexi.as3.framework.cafe.core.Event.WorkerEvent2;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;

	public class Waiter2
	{
		
		private var _requests:Array;
		
		
		/**
		 * 処理をスタートさせます
		 * 
		 */		
		public function start(requests:Array):void
		{
			_requests = requests;
			//requestのdependencieを探索して、依存しているクラスがないor依存しているrequestの処理が
			//終わっている場合は実行します

			for each(var request:IRequest2 in _requests) {
								
				var	args:*;
				var worker:Worker2;
				var isWait:Boolean = hasWaiting(request);
				if (isWait) continue;
				
				if (!request.isInitialized) args = AbstRequest2(request).$invokeArg;

				
				if (!request.notifier.hasEventListener(RequestEvent2.COMPLETE)) {
					request.notifier.addEventListener(RequestEvent2.COMPLETE, onComplete);
				}
				worker = new Worker2(request, this);				
			}
		}
		
		
		protected function onComplete(requestEvent:RequestEvent2):void
		{			
			var requests:Vector.<IRequest2> = Kitchen2.instance.getTasks(requestEvent.request);
			for each(var request:IRequest2 in requests) {
				
				var worker:Worker2;
				var isWait:Boolean = hasWaiting(request);
				if (isWait) continue;
				
				
				if (!request.notifier.hasEventListener(RequestEvent.COMPLETE)) {
					request.notifier.addEventListener(RequestEvent.COMPLETE, onComplete);
				}
				worker = new Worker2(request, this);				

			}

		}
		
		
		/**
		 * requestの実行を待つ必要があるかを返します
		 * @param request
		 * @return 
		 * 
		 */		
		protected function hasWaiting(request:IRequest2):Boolean
		{
			var isWait:Boolean = false;
			for each(var dependency:IRequest2 in request.dependencies) {
				if (dependency.status != RequestStatusType.END) isWait = true;
				if (isWait) break;
			}
			
			return isWait;
		}
		
		/**
		 * 
		 * @param requests
		 * 
		 */		
		public function Waiter2()
		{
		}
	}
}