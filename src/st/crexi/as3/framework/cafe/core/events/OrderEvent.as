package st.crexi.as3.framework.cafe.core.events
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.AbstOrder;
	
	
	/**
	 * Orderのステータス変更時に飛ぶイベントデス
	 * @author kaora crexista
	 * 
	 */
	public class OrderEvent extends Event
	{		
		
		/**
		 * order内部のrequestが完了したときに飛びます
		 */		
		public static const COMPLETE:String = "orderComplete";
		
		
		/**
		 * oreder内部のrequestが中断されたときに飛ぶイベントタイプです
		 * 
		 */		
		public static const ABORT:String = "orderFail";
		
		
		/**
		 * このイベントを飛ばす事になるorder
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
		
		
		
		/**
		 * @inheritDoc
		 * @return 
		 * 
		 */
		override public function clone():Event
		{
			return new OrderEvent(type, _order);
		}
	}
}