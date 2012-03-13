package st.crexi.as3.framework.cafe.core
{
	public class AbstResult
	{
		
		private var _order:AbstOrder;
		
		internal function get $order():AbstOrder
		{
			return _order;
		}
		
		public function from(value:AbstOrder):void
		{
			_order = value;
		}
		
		public function AbstResult()
		{
		}
	}
}