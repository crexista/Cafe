package st.crexi.as3.framework.cafe.core
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IClassKeyLogic;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;

	public class Kitchen
	{

		private var _sigleTonRequest:Object;

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
		 * 
		 * @param request
		 * 
		 */		
		public function addhoge(request:IRequest2, logic:IClassKeyLogic):void
		{
			if (!request.isSingleTon) return;
			var className:String = logic.exchange(request);
			_sigleTonRequest[className] = request;
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