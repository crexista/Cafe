package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class AbstTask
	{
		/**
		 * requestがスタートしているか否か
		 */		
		internal var $isStarted:Boolean = false;
		
		
		/**
		 * requestが終わっているか否か
		 */		
		internal var $isEnded:Boolean = false;
		
		
		/**
		 * このタスクが依存しているタスクを列挙したクラスインスタンスです
		 */		
		internal var $dependencies:*
		
		
		private var _eventDispatcer:IEventDispatcher;
		
		
		final public function get notifier():IEventDispatcher
		{
			return _eventDispatcer;
		}
		
		
		/**
		 * 処理がすでに始まっているかどうかのチェックです
		 * 
		 * @return 
		 * 
		 */		
		final public function get isStarted():Boolean
		{
			return $isStarted;
		}
		
		
		/**
		 * 処理が既におわったあとかどうかのチェックです
		 * @return 
		 * 
		 */		
		final public function get isEnded():Boolean
		{
			return $isEnded;
		}
		
		
		/**
		 * このタスクが依存しているタスクを列挙したクラスインスタンスです
		 * @return 
		 * 
		 */		
		final public function get dependencies():*
		{
			return $dependencies;
		}
		
		
		public function AbstTask()
		{
			_eventDispatcer = new EventDispatcher;
		}
	}
}