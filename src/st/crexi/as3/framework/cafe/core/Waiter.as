package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.Event.WaiterEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.utils.Stock;

	public class Waiter
	{
		
		private var _stock:Stock;
		
		private var _requests:Array;
		
		private var _eventDispatcher:IEventDispatcher;
		
		
		private var _isStop:Boolean = false;
		
		private var _isSync:uint = 0;
		
		private var _isOnCompleteSync:uint = 0;
		
		internal static var $reqDic:Dictionary;
		
		
		/**
		 * 処理をスタートさせます
		 * 
		 */		
		public function start(requests:Array):void
		{
			_requests = requests;
			//requestのdependencieを探索して、依存しているクラスがないor依存しているrequestの処理が
			//終わっている場合は実行します
			reloadChildren(Vector.<IRequest>(_requests));
			for each(var request:IRequest in _requests) {

				var worker:Worker;

				var isWait:Boolean = hasWaiting(request);
				if (isWait) continue;

				
				if (!request.notifier.hasEventListener(RequestEvent.COMPLETE)) {
					request.notifier.addEventListener(RequestEvent.COMPLETE, onComplete);
				}
				_stock.add(request, worker);
				_isSync++;
				
				worker = new Worker(request, this);
				_isSync--;
				if (_stock.length == 0 && !_isSync)  {					
					_eventDispatcher.dispatchEvent(new WaiterEvent(WaiterEvent.ALL_COMPLETE));
				}				
			}
		}
		
		
		/**
		 * 複数のrequestの子供のrequestを取得してstatusをIDLEに変えて今動いている処理を捨て去る
		 * TODO アルゴリズムがあまりにもあんまりなので、あとで見直し
		 * @param requestsArr
		 * 
		 */		
		protected function reloadChildren(requestsArr:Vector.<IRequest>):void
		{
			for each(var request:IRequest in requestsArr) {
				var requests:Vector.<IRequest> = Kitchen.instance.getTasks(request);
				if ($reqDic[request]) $reqDic[request].dispose();
				if (!_isStop) AbstRequest(request).$status = RequestStatusType.IDLE;
				
				for each(request in requests) {
					
					if (!_isStop) AbstRequest(request).$status = RequestStatusType.IDLE;
				
					if ($reqDic[request]) $reqDic[request].dispose();
					
					if (Kitchen.instance.getTasks(request) != null) reloadChildren(requests);
				}
			}
		}
		
		
		
		
		/**
		 * このwaiterにひもづけられたすべてのRequestをストップさせます
		 * 
		 */		
		public function stop():void		
		{
			_isStop = true;
			for each(var request:IRequest in _requests) {
				if ($reqDic[request]) $reqDic[request].dispose();
			}
		}
		
		
		
		public function get notifier():IEventDispatcher
		{
			return _eventDispatcher;
		}
		
		
		protected function onComplete(requestEvent:RequestEvent):void
		{			
			var requests:Vector.<IRequest> = Kitchen.instance.getTasks(requestEvent.request);
			
			_stock.del(requestEvent.request);
			for each(var request:IRequest in requests) {

				var worker:Worker;
				var isWait:Boolean = hasWaiting(request);
				if (isWait) continue;
				
				
				if (!request.notifier.hasEventListener(RequestEvent.COMPLETE)) {
					request.notifier.addEventListener(RequestEvent.COMPLETE, onComplete);
				}
				_stock.add(request, worker);
				
				//再起処理には入ってしまっているかのチェック
				_isOnCompleteSync++;
				worker = new Worker(request, this);
				_isOnCompleteSync--;
				
			}
			
			if (_stock.length == 0 && _isSync == 0 && _isOnCompleteSync == 0)  {				
				_eventDispatcher.dispatchEvent(new WaiterEvent(WaiterEvent.ALL_COMPLETE));
			}

		}
		
		
		/**
		 * requestの実行を待つ必要があるかを返します
		 * @param request
		 * @return 
		 * 
		 */		
		protected function hasWaiting(request:IRequest):Boolean
		{
			var isWait:Boolean = false;
			
			
			if (request.status != RequestStatusType.IDLE) return true
			
			for each(var dependency:IRequest in request.dependencies) {
				

				if (dependency.status != RequestStatusType.END) isWait = true;
				if (isWait) break;
			}
			
			return isWait;
		}
		
		/**
		 * 
		 * @param requests
		 * 
		 */		
		public function Waiter()
		{
			if (!$reqDic) $reqDic = new Dictionary();
			_stock = new Stock();
			_eventDispatcher = new EventDispatcher();
		}
	}
}