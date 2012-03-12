package st.crexi.as3.framework.cafe.core.Event
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.AbstOrder;
	
	public class OrderEvent extends Event
	{		
		
		/**
		 * requestが完了したときに飛びます
		 */		
		public static const COMPLETE:String = "orderComplete";
		
		
		/**
		 *
		 */		
		public static const ABORT:String = "orderFail";
		
		
		/**
		 * このイベントを飛ばす事になるrequestです
		 */		
		private var _order:AbstOrder
		
		
		/**
		 * 
		 * @param type
		 * @param order
		 * 
		 */		
		public function OrderEvent(type:String, order:AbstOrder)
		{
			super(type);
			_order = order;
		}
		
		
		/**
		 * イベントの飛ばし元です
		 * @return 
		 * 
		 */		
		public function get order():AbstOrder
		{
			return _order;
		}
		
		
		
		override public function clone():Event
		{
			return new OrderEvent(type, _order);
		}
	}
}