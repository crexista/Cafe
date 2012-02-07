package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	
	import st.crexi.as3.framework.cafe.core.Event.RequestEvent;
	import st.crexi.as3.framework.cafe.core.Event.WorkerEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	
	
	/**
	 * RequestのAbstractクラスです<br/>
	 * このクラス自体は処理そのものを行う事はしません<br/>
	 * workerにRequestの処理内容のRecipeを受け渡し<br/>
	 * workerを実行します
	 * 
	 * workerが完了したら
	 *
	 * 
	 * @author crexista
	 * 
	 */	
	public class AbstRequest extends AbstTask
	{
		
		
		/**
		 * リクエストの結果がはいります　
		 */		
		private var _result:*;
		
		
		/**
		 * 終了した事を伝えます
		 */		
		private var _eventSender:IEventDispatcher;
		
		
	
		/**
		 * 実際にrequest処理を行うWorkerです
		 */		
		private var _worker:Worker


		
		
		/**
		 * Requestの結果を返します
		 * @return 
		 * 
		 */		
		public function get result():*
		{
			return _result;
		}
		
		

		
				
		/**
		 * request処理を実行します
		 * 
		 */		
		final public function execute():void
		{
			if (_worker) {
				_worker.notifier.removeEventListener(WorkerEvent.COMPLETE, onComplete);
				_worker = null;
			}
			_worker = new Worker(IRequest(this).recipe);
			_worker.notifier.addEventListener(WorkerEvent.COMPLETE, onComplete);
			_worker.start();
		}

				
		
		protected function onComplete(event:Event):void
		{
			_result = WorkerEvent(event).worker.result;
			this.$isEnded = true;
			this.notifier.dispatchEvent(new RequestEvent(RequestEvent.COMPLETE, IRequest(this)));
		}

		
		
		/**
		 * コンストラクタです
		 * 
		 */		
		public function AbstRequest()
		{
			_eventSender = new EventDispatcher();
		}		
		

	}
}