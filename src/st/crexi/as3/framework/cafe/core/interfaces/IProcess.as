package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.IEventDispatcher;

	/**
	 * workerが行う処理のinterfaceです
	 * @author kaora_crexista
	 * 
	 */	
	public interface IProcess
	{
		/**
		 * Taskの進行状況を伝えてくれるEventDispatcherです　
		 * @return 
		 * 
		 */		
		function get notifier():IEventDispatcher;
		
		
		/**
		 * Processを初期化します
		 * 
		 */		
		function initialize():void;
		
		
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
		function get isEnded():Boolean;
		
		
		/**
		 * このタスクが依存している他タスクを列挙したIDependencyの実装クラスのインスタンスです
		 * 実装側で[Bindable] pulic function set dependencies(value:Dependacy):void{}とやる必要があります
		 * 
		 * @return 
		 * 
		 */		
		function get dependencies():*;
		
		
		
		/**
		 * このタスクが依存している他タスクを列挙したIDependencyの実装クラスのオブジェクトです
		 * @return 
		 * 
		 */		
		function get dependencyClass():Class;
		
	}
}