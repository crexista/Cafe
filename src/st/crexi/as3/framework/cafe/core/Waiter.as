package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.Event.WaiterEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IDependencies;
	import st.crexi.as3.framework.cafe.core.interfaces.IOrder;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.core.interfaces.ITask;
	import st.crexi.as3.framework.cafe.utils.Stock;

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
		 * taskが入った配列です
		 */		
		private var _tasks:Array;
		
		
		/**
		 * waiterの進行状況を教えるIEventDispatcherです
		 */		
		private var _notifier:IEventDispatcher
		
		/**
		 * 
		 */		
		private var _stock:Stock;
		
		/**
		 * Waiterが入れられたOrderの実行をスタートします
		 * 
		 */		
		public function start():void
		{
			
			for each(var task:ITask in _tasks) {
				var isWait:Boolean = false;
				
				if (AbstTask(task).$isStarted) continue;
				if (task.dependencies) {
					for each(var request:IRequest in IDependencies(task.dependencies).tasks) {
						if (!request.isEnded) isWait = true;
						if (isWait) break;
					}
				}
				
				if (isWait) continue;
				task.notifier.addEventListener(RequestEvent.COMPLETE, onComplete);
				_stock.add(task, task);
				task.execute();
				AbstTask(task).$isStarted = true;

			}
		}
		
		
		/**
		 * 一つ一つのTaskが終了したら呼ばれます
		 * @param event
		 * 
		 */		
		protected function onComplete(event:RequestEvent):void
		{
			var tasks:Vector.<ITask> = Kitchen.instance.getTasks(event.request);
			var isWait:Boolean = false;
			
			
			for each(var task:ITask in tasks) {
				isWait = false;
				for each(var request:IRequest in task.dependencies) {
					if (!request.isEnded) isWait = true;
					if (isWait) break;
					_stock.del(task);
				}
				if (isWait) continue;
				
				if (!task.notifier.hasEventListener(RequestEvent.COMPLETE)) {
					task.notifier.addEventListener(RequestEvent.COMPLETE, onComplete);
				}
				
				task.execute();
				AbstTask(task).$isStarted = true;
			}
			
			if (_stock.length == 0) notifier.dispatchEvent(new WaiterEvent(WaiterEvent.ALL_COMPLETE));
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get notifier():IEventDispatcher
		{
			return _notifier;
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
			
			if (request.dependencyClass && !request.dependencies) {
				AbstTask(request).$dependencies = new request.dependencyClass();
				if (_order) IDependencies(AbstTask(request).$dependencies)["_order"] = _order;				
				AbstTask(request).$dependencies.initialize();
			}
			if (request.dependencies) {
				for each(var task:ITask in IDependencies(request.dependencies).taskList) {
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
		public function Waiter(tasks:Array, order:IOrder = null)
		{			
			_order = order;
			_tasks = tasks;
			_stock = new Stock;
			
			_notifier = new EventDispatcher();
			for each(var request:ITask in tasks) {
				analyzeRequest(request);
			}
		}

	}
}