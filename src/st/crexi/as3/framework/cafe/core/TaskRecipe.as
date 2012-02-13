package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.Event.WorkerEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	import st.crexi.as3.framework.cafe.core.interfaces.ITask;
	import st.crexi.as3.framework.cafe.utils.TaskObserver;
	import st.crexi.as3.framework.cafe.utils.interfaces.IObserver;
	
	internal class TaskRecipe implements IRecipe
	{
		
		private var _observer:TaskObserver;
		
		
		public function initialize(worker:Worker, task:ITask):void
		{
			_observer = new TaskObserver(worker, task);
		}
		
		public function get observer():IObserver
		{
			return _observer;
		}
		
		public function get successEventType():String
		{
			return WorkerEvent.COMPLETE;
		}
		
		public function get errorEventTypes():Array
		{
			return [WorkerEvent.ABORT];
		}
		
		public function onSuccess(event:Event, worker:Worker):void
		{
			worker.end();
		}
		
		public function onError(event:Event, worker:Worker):void
		{
		}
	}
}