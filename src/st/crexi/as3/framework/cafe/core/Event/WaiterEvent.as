package st.crexi.as3.framework.cafe.core.Event
{
	import flash.events.Event;
	
	/**
	 * waiterが投げるイベントです
	 * @author kaora crexista
	 * 
	 */	
	public class WaiterEvent extends Event
	{
		
		/**
		 * waiterに押し付けれたすべてのTaskが完了したら飛ぶイベントです
		 */		
		public static const ALL_COMPLETE:String = "allTaskCompleted";


		/**
		 * コンストラクタです
		 * @param type
		 * 
		 */
		public function WaiterEvent(type:String)
		{
			super(type);
		}
		
		
		/**
		 * eventのクローンです
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new WaiterEvent(type);
		}
	}
}