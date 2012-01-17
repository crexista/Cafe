package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.IEventDispatcher;
	
	/**
	 * AspectとRequestの基底インターフェースです
	 * executeメソッドを持っている事がTaskの仕様です
	 * 
	 * @author crexista
	 * 
	 */	
	public interface ITask
	{
		
		/**
		 * Taskの進行状況を伝えてくれるEventDispatcherです　
		 * @return 
		 * 
		 */		
		function get notifier():IEventDispatcher;
		
		
		/**
		 * 処理がスタートしているかどうかです
		 * @return 
		 * 
		 */		
		function get isStarted():Boolean;
		
		
		
		/**
		 * 処理が終わっているかどうかです
		 * @return 
		 * 
		 */		
		function get isEnded():Boolean
		
		/**
		 * このタスクが依存しているIRequestオブジェクトが格納されたVector
		 * 
		 * @return 
		 * 
		 */		
		function get dependencies():Vector.<IRequest>
		
		
		/**
		 * ITaskオブジェクトを実行します
		 * 
		 */		
		function execute():void
	}
}