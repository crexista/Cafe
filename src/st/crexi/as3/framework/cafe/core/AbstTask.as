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
		
		
		public function AbstTask()
		{
			_eventDispatcer = new EventDispatcher;
		}
	}
}