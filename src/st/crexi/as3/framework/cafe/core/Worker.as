package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Event.WorkerEvent;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	
	/**
	 * Requestによって起動されるクラスです<br/>
	 * RequestからRecipeを受け取り、それに従ってイベント処理を行います<br>
	 * 
	 * @author crexista
	 * 
	 */	
	public class Worker
	{
		
		/**
		 * Workerの進行状況を伝えるEventDispatcherです
		 * 
		 */		
		private var _info:IEventDispatcher;
		
		
		/**
		 * workerによって実行されるrequestです
		 * 
		 */		
		private var _recipe:IRecipe;
		
		
		
		/**
		 * workerの処理の結果です
		 */		
		private var _result:*;
		
		
		
		/**
		 * このworkerが既に動いているかどうかです
		 * 
		 */		
		internal var $isStarted:Boolean = false;
		
		
		/**
		 * このworkerの処理がすでに終わって止まっているかどうかです 
		 */		
		internal var $isEnded:Boolean = false;
		
		
		/**
		 * Workerの進行状況を伝えるEventDispatcherのgetterです
		 * @return 
		 * 
		 */		
		public function get notifier():IEventDispatcher
		{
			return _info;
		}
		
		
		/**
		 * 処理の内容を返します
		 * @return 
		 * 
		 */		
		public function get recipe():IRecipe
		{
			return _recipe;
		}
		
		
		/**
		 * 処理の結果を返します
		 * @return 
		 * 
		 */		
		public function get result():*
		{
			return _result;
		}

		
		
		
		/**
		 * requestから取得したrecipeを元に処理を行います
		 * 
		 */		
		public function start():void
		{
			_recipe.observer.setHandler(_recipe.successEventType, onSuccess);
			for each(var type:String in _recipe.errorEventTypes) {
				_recipe.observer.setHandler(type, onError);
			}
			
			_recipe.observer.start();
			
		}
		
		
		
		/**
		 * 処理を終了させて、requestのステータスを終了にするためのメソッドです
		 * 
		 * 
		 * @param result 処理の結果です
		 * 
		 */		
		final public function end(result:* = null):void
		{
			_result = result;
			this.notifier.dispatchEvent(new WorkerEvent(WorkerEvent.COMPLETE, this));
		}
		
		
		
		/**
		 * このタスクに続く処理を拒否します
		 * 
		 */		
		final public function cancel():void
		{
			
		}

		
		
		/**
		 * 処理が成功したときに呼ばれます
		 * @param event
		 * 
		 */		
		protected function onSuccess(event:Event):void
		{
			_recipe.onSuccess(event, this);
		}
		
		
		/**
		 * 処理が失敗したときに呼ばれます
		 * @param event
		 * 
		 */		
		protected function onError(event:Event):void
		{			
			_recipe.onError(event, this);
		}

		
		
		/**
		 * コンストラクタです 
		 * 
		 */		
		public function Worker(recipe:IRecipe)
		{
			_info = new EventDispatcher();
			_recipe = recipe;
		}
	}
}