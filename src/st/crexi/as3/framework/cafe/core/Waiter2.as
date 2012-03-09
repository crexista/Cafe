package st.crexi.as3.framework.cafe.core
{
	import flash.utils.ByteArray;
	
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	
	/**
	 * Requestを受け取って処理を行うクラスです
	 * @author kaoru_shibasaki
	 * 
	 */	
	public class Waiter2
	{
		
		/**
		 * このWaiterが処理するRequestの配列です
		 */		
		private var _requests:Array;
		
		
		/**
		 * 突っ込まれたRequestの処理をスタートさせます
		 * @param requests
		 * 
		 */		
		public function start(requests:Array):void
		{
			_requests = requests;
			//requestのdependencieを探索して、依存しているクラスがないor依存しているrequestの処理が
			//終わっている場合は実行します
			//reloadChildren(Vector.<IRequest>(_requests));
			for each(var request:AbstRequest2 in _requests) {
				
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
		
		
		protected function hasWaiting(request:AbstRequest2):Boolean
		{
			return false;
		}
		
		
		
		/**
		 * オブジェクトをcloneします
		 * @param arg
		 * @return 
		 * 
		 */		
		protected function clone(arg:*):* {
			var b:ByteArray = new ByteArray();
			
			b.writeObject(arg);
			b.position = 0;
			return b.readObject();
		}
		public function Waiter2()
		{
		}
	}
}