package st.crexi.as3.framework.cafe.utils
{
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Worker;
	import st.crexi.as3.framework.cafe.core.interfaces.ITask;
	import st.crexi.as3.framework.cafe.utils.interfaces.IObserver;
	
	public class TaskObserver extends AbstObserver implements IObserver
	{
		private var _worker:Worker;
		
		private var _task:ITask;
		
		
		/**
		 * 
		 * @param worker
		 * @param task
		 * 
		 */		
		public function TaskObserver(worker:Worker, task:ITask) 
		{
			_worker = worker;
			_task = task;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get eventTarget():IEventDispatcher
		{
			return _worker.notifier;
		}
		
		
		/**
		 * workerをスタートさせます
		 * 
		 */		
		public function start():void
		{
			//_task.execute(_worker);
		}
	}
}