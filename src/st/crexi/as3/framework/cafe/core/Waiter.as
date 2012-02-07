package st.crexi.as3.framework.cafe.core
{
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IOrder;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.core.interfaces.ITask;

	/**
	 * Orderを受けとり, Orderにリストアップされたrequestをすべて実行します<br/>
	 * その際、Requestに依存したAspectをRequestをキーとした_tasksの辞書にいれ<br/>
	 * requestが終了したら、実行していきます
	 * 
	 * やる事は<br/>
	 * <li> コンストラクタでOrderを代入 </li>
	 * <li> startでOrder内すべてのrequestを実行 </li>
	 * <li> startでOrder内すべてのrequest実行状況を監視する</li>
	 * <li> onCompleteメソッドでrequestが終了したときのチェックを行う </li>
	 * <li> requestを元に_tasksからITaskオブジェクトを取得して実行する </li>
	 * 
	 * <p>start()</p>
	 * <p>onComplete()</p>
	 * 
	 * @author crexista
	 * 
	 */
	public class Waiter
	{

		
		/**
		 * 入れられたOrderです
		 */		
		private var _order:IOrder;
		
		
		
		/**
		 * Waiterが入れられたOrderの実行をスタートします
		 * 
		 */		
		public function start():void
		{
			var obj:Object = _order.requestList;
			for each(var task:ITask in _order.requestList) {				
				var isWait:Boolean = false;
				
				if (AbstTask(task).$isStarted) continue;
				
				for each(var request:IRequest in task.dependencies) {
					if (!request.isEnded) isWait = true;
					if (isWait) break;
				}
				
				if (isWait) continue;
				task.notifier.addEventListener(RequestEvent.COMPLETE, onComplete);
				task.execute();
				AbstTask(task).$isStarted = true;

			}
		}
		
		
		protected function onComplete(event:RequestEvent):void
		{
			var tasks:Vector.<ITask> = Kitchen.instance.getTasks(event.request);
			var isWait:Boolean = false;
			
			
			
			for each(var task:ITask in tasks) {
				isWait = false;
				for each(var request:IRequest in task.dependencies) {
					if (!request.isEnded) isWait = true;
					if (isWait) break;
				}
				if (isWait) continue;
				
				if (!task.notifier.hasEventListener(RequestEvent.COMPLETE)) {
					task.notifier.addEventListener(RequestEvent.COMPLETE, onComplete);
				}
				
				task.execute();
				AbstTask(task).$isStarted = true;
			}
		}
		
		
		/**
		 * requestの終了時に行われるTaskを追加する
		 * @param request
		 * @param task
		 * 
		 */		
		public function append(request:IRequest, task:ITask):void
		{			
			Kitchen.instance.register(request, task);
		}


		/**
		 * Requestに付随するTaskを配列に変換する
		 * 
		 * @param request
		 * @return 
		 * 
		 */		
		protected function analyzeRequest(request:ITask):Vector.<ITask>
		{			
			var tasks:Vector.<ITask> = new Vector.<ITask>;			
			
			if (request.dependencies) {
				for each(var task:ITask in request.dependencies) {
					Kitchen.instance.register(request, task);
				}
			}
			
			return tasks;
		}
		
		
		/**
		 * コンストラクタです。
		 *
		 * @param order
		 * 
		 */		
		public function Waiter(order:IOrder)
		{			
			_order = order;

			for each(var request:ITask in order.requestList) {
				analyzeRequest(request);
			}
		}

	}
}