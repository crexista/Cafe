package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * Requestのベースとなるクラスです
	 * @author kaoru_shibasaki
	 * 
	 */	
	internal class RequestBase
	{
		
		/**
		 * Requestの結果が入ります
		 */		
		internal var $result:*;
		
		
		/**
		 * 
		 */		
		internal var $notifier:IEventDispatcher;
		
		
		
		/**
		 * requestのgetterです
		 * @return 
		 * 
		 */		
		final public function get result():*
		{
			return $result;
		}
		
		
		/**
		 * Requestの進行状況を伝えるIEventDispatcherです
		 * @return 
		 * 
		 */		
		final public function get notifier():IEventDispatcher
		{
			return $notifier
		}
		
		
		public function RequestBase() 
		{
			$notifier = new EventDispatcher();
			//ここでRequestがSingletonオブ設定されているかをチェック
			//もしシングルトンならRegisterに登録
			
			//cloneしてこのクラスのvaribleを取得
		}
	}
}