package st.crexi.as3.framework.cafe.core
{
	internal class Container
	{
		
		private var _main:AbstOrder;
		
		
		private var _label:String;
		
		public function get main():AbstOrder
		{
			return _main;
		}
		
		
		public function get lable():String
		{
			return _label;
		}
		
		
		public function Container(main:AbstOrder, lable:String)
		{
			_label = lable;
			_main = main;
		}
	}
}