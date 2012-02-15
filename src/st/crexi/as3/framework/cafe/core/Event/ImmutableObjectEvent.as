package st.crexi.as3.framework.cafe.core.Event
{
	import flash.events.Event;
	
	public class ImmutableObjectEvent extends Event
	{
		
		public static const SET_IMMUTABLE_OBJECT:String = "set_immutable_value";
		
		
		private var _newValue:*;
		
		public function ImmutableObjectEvent(type:String, newValue:*):void
		{

			super(type);
			_newValue = newValue;
		}
		
		public function get newValue():*
		{
			return _newValue;
		}
		
		
		override public function clone():Event
		{
			return new ImmutableObjectEvent(type, newValue);
		}
	}
}