package st.crexi.as3.framework.cafe.core
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;

	public class Kitchen2
	{
		
		/**
		 * request
		 */		
		private var _requests:Dictionary;
		
		/**
		 *ほげ 
		 */		
		private static var _singleTon:Function = function():Kitchen2
		{
			var instance:Kitchen2 = new Kitchen2(new Guard);
			
			_singleTon = function():Kitchen2
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
		internal static function get instance():Kitchen2
		{
			return _singleTon();
		}
		
		
		
		/**
		 * requestとtaskを登録します
		 * @param request
		 * @param task
		 * 
		 */		
		public function register(parent:IRequest2, child:IRequest2):void
		{
			if (!_requests[parent]) _requests[parent] = new Vector.<IRequest2>
			_requests[parent].push(child);
		}
		
		
		/**
		 * requestをキーとしてTaskが詰まった配列を返します
		 * @param value
		 * @return 
		 * 
		 */		
		public function getTasks(value:IRequest2):Vector.<IRequest2>
		{
			return _requests[value];
		}
		
		
		/**
		 * コンストラクタ
		 * 
		 */		
		public function Kitchen2(guard:Guard)
		{
			if (!guard) throw new IllegalOperationError("このクラスはnew できません");
			_requests = new Dictionary();
		}
	}
}

class Guard
{}