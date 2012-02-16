package st.crexi.as3.framework.cafe.core
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;

	public class Kitchen
	{
		
		/**
		 * request
		 */		
		private var _requests:Dictionary;
		
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
		public function register(parent:IRequest, child:IRequest):void
		{
			if (!_requests[parent]) _requests[parent] = new Vector.<IRequest>
			_requests[parent].push(child);
		}
		
		
		/**
		 * requestをキーとしてTaskが詰まった配列を返します
		 * @param value
		 * @return 
		 * 
		 */		
		public function getTasks(value:IRequest):Vector.<IRequest>
		{
			return _requests[value];
		}
		
		
		/**
		 * コンストラクタ
		 * 
		 */		
		public function Kitchen(guard:Guard)
		{
			if (!guard) throw new IllegalOperationError("このクラスはnew できません");
			_requests = new Dictionary();
		}
	}
}

class Guard
{}