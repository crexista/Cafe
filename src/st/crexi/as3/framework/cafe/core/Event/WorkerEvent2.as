package st.crexi.as3.framework.cafe.core.Event
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.Worker;
	import st.crexi.as3.framework.cafe.core.Worker2;
	
	
	
	/**
	 * Workerの処理が終了したら投げられるEventです
	 * @author crexista
	 * 
	 */	
	public class WorkerEvent2 extends Event
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
		private var _worker:Worker2;
		
		
		/**
		 * コンストラクタです
		 * @param type
		 * @param worker
		 * 
		 */		
		public function WorkerEvent2(type:String, worker:Worker2)
		{
			_worker = worker;
			super(type);
		}
		
		
		/**
		 * このEventをなげたWorkerを返します
		 * @return 
		 * 
		 */		
		public function get worker():Worker2
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
			return new WorkerEvent2(type, worker);
		}
	}
}