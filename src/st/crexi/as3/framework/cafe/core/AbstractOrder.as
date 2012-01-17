package st.crexi.as3.framework.cafe.core
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IOrder;
	import st.crexi.as3.framework.cafe.utils.ReflectionUtil;

	/**
	 * OrderはRequestのリストクラスです
	 * メソッド的なものを持たずRequestが入った変数のみを持ちます
	 * 
	 * @author crexista
	 * 
	 */	
	public class AbstractOrder
	{


		/**
		 * requestクラスをキーとしてrequestそのものをかえす関数です
		 * 
		 */
		private static var _getRequests:Function = function(klass:Class):Object
		{
		
			var requestListDic:Dictionary = new Dictionary;
			
			_getRequests = function(krass:Class):Object
			{
				if (!requestListDic[krass]) {
					requestListDic[krass] = new krass();
					
				}
				
				return requestListDic[krass];
			};

			return _getRequests(klass);
		};
		
		
		/**
		 * requestListの実態です
		 */		
		private var _requests:*;
		
		
		/**
		 * requestをObject化してEnumでとれる様にします
		 * 
		 */		
		private var _requestList:Object;
		
		
		/**
		 * このorderを担当するWaiterオブジェクトです 
		 */		
		private var _waiter:Waiter;
		
		
		
		/**
		 * requestのリストをかえす
		 * @return 
		 * 
		 */		
		final public function get requestList():Object
		{
			return _requestList;
		}
		
		
		
		/**
		 * requestをまとめたlistインスタンスです
		 * @return 
		 * 
		 */		
		final public function get requests():*
		{
			return _requests;
		}
		
		
		/**
		 * orderをスタートさせます
		 * 
		 */		
		final public function start():void
		{
			
			_waiter.start();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		protected function requestAnalyze():void
		{
			var iOrder:IOrder = this as IOrder;
			var props:Object;
			_requests = _getRequests(iOrder.requestListClass);
			_requestList = new Object;
			props = ReflectionUtil.instance.getEnumbleInstanceObject(_requests);
			
			for (var name:String in props) {
				_requestList[name] = _requests[name];
			}

			_waiter = new Waiter(IOrder(this));
		}
		
		
		
		/**
		 * コンストラクタです
		 * waiterを起動させ、Orderの処理をwaiterに任せます
		 * 
		 */		
		public function AbstractOrder()
		{
			requestAnalyze();
		}
	}
}