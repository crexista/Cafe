package st.crexi.as3.framework.cafe.core
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.core.interfaces.ITask;

	/**
	 * Waiterがrequestを登録します
	 * このクラスはシングルトンです
	 * 
	 * @author crexista
	 * 
	 */	
	public class Kitchen
	{
		
		private var _tasks:Dictionary;
		
		
		/**
		 *ほげ 
		 */		
		private static var _singleTon:Function = function():Kitchen
		{
			var instance:Kitchen = new Kitchen(new Guard);
			
			_singleTon = function():Kitchen
			{
				return instance;
			};
			
			return _singleTon();
		}
		
			
		/**
		 * SingleTonオブジェクトを返します
		 * @return 
		 * 
		 */			
		internal static function get instance():Kitchen
		{
			return _singleTon();
		}



		/**
		 * requestとtaskを登録します
		 * @param request
		 * @param task
		 * 
		 */		
		public function register(request:IRequest, task:ITask):void
		{
			if (!_tasks[request]) _tasks[request] = new Vector.<ITask>;
			_tasks[request].push(task);
		}
		
		
		/**
		 * requestをキーとしてTaskが詰まった配列を返します
		 * @param value
		 * @return 
		 * 
		 */		
		public function getTasks(value:IRequest):Vector.<ITask>
		{
			return _tasks[value];
		}
		
		
		/**
		 * コンストラクタです
		 * 
		 * @param guard
		 * 
		 */		
		public function Kitchen(guard:Guard)
		{
			if (!guard) throw IllegalOperationError("このクラスはnewできません");
			_tasks = new Dictionary();
		}
	}
}



class Guard
{}