package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	
	/**
	 * taskクラスが依存している別タスクを列挙するクラスの抽象クラスです
	 * @author crexista
	 * 
	 */	
	public class AbstDependency
	{
		
		/**
		 * taskのリストです
		 */		
		private var _taskList:Object;
		
		/**
		 * taskが入った配列です
		 */		
		private var _tasks:Array;
		
		/**
		 * 
		 * 
		 */		
		public function AbstDependency()
		{			
			try {
				this["addEventListener"](PropertyChangeEvent.PROPERTY_CHANGE, onChange)
			}
			catch (error:Error) {
				throw new Error("このクラスはBindableを使ってください");
			}
			_taskList = new Object();
			_tasks = new Array();
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		final protected function onChange(event:PropertyChangeEvent):void
		{
			if (event.oldValue) throw new Error("既にtaskクラスは初期化されています");
			_taskList[event.property] = event.newValue;
			_tasks.push(event.newValue);
		}
		
		
		/**
		 * 依存しているtaskを配列形式で返します 
		 * @return 
		 * 
		 */		
		final public function get tasks():Array
		{
			return _tasks;
		}
		
		
		/**
		 * 依存しているtaskをlist形式で返します
		 * @return 
		 * 
		 */		
		final public function get taskList():Object
		{
			return _taskList;
		}
	}
}