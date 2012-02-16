package st.crexi.as3.framework.cafe.core.Event
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.Worker;
	
	
	
	/**
	 * Workerの処理が終了したら投げられるEventです
	 * @author kaora crexista
	 * 
	 */	
	public class WorkerEvent extends Event
	{
		
		/**
		 * 内部で行われているRequest処理が終了するときに投げられます
		 */		
		public static const COMPLETE:String = "workeComplete";
		
		
		/**
		 * 内部で行われているRequest処理がreloadされる際に投げられます
		 */		
		public static const RELOAD:String = "reload";
		
		
		/**
		 * 内部で行われているRequest処理が中断されたときに投げられます
		 */		
		public static const ABORT:String = "abort";
		
		
		/**
		 * このWorkerEventを投げるWorkerです
		 */		
		private var _worker:Worker;
		
		
		/**
		 * コンストラクタです
		 * @param type
		 * @param worker
		 * 
		 */		
		public function WorkerEvent(type:String, worker:Worker)
		{
			_worker = worker;
			super(type);
		}
		
		
		/**
		 * このEventをなげたWorkerを返します
		 * @return 
		 * 
		 */		
		public function get worker():Worker
		{
			return _worker;
		}
		
		
		/**
		 * clone
		 * @return 
		 * 
		 */
		override public function clone():Event
		{
			return new WorkerEvent(type, worker);
		}
	}
}