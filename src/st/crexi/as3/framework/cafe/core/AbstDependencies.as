package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IDependencies;
	import st.crexi.as3.framework.cafe.utils.ReflectionUtil;
	
	/**
	 * taskクラスが依存している別タスクを列挙するクラスの抽象クラスです
	 * @author crexista
	 * 
	 */	
	public class AbstDependencies
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
		 */		
		internal var $order:*;
		
		/**
		 * 
		 * 
		 */		
		public function AbstDependencies()
		{

		}
		
		internal function $initialize():void
		{
			var props:Object;
			
			IDependencies(this).initialize();
			_taskList = new Object;
			_tasks = new Array();
			props = ReflectionUtil.instance.getEnumbleInstanceObject(this);
			
			for (var name:String in props) {
				_taskList[name] = this[name];
				_tasks.push(this[name]);
			}
			
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		final public function get order():*
		{
			return $order;
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		final protected function onChange(event:PropertyChangeEvent):void
		{
			if (event.oldValue) throw new Error("既にtaskクラスは初期化されています");
			
			if (event.property == "order"){
				$order = event.newValue;
				return;
			}				
			_taskList[event.property] = event.newValue;
			_tasks.push(event.newValue);
		}
		
		
		/**
		 * 依存しているtaskを配列形式で返します 
		 * @return 
		 * 
		 */		
		public function get tasks():Array
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