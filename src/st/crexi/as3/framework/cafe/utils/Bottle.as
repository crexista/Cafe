package st.crexi.as3.framework.cafe.utils
{
	import st.crexi.as3.framework.cafe.core.AbstOrder;

	/**
	 * Orderに依存しているその他のOrderを格納します
	 * @author kaora crexista
	 * 
	 */
	[ExcludeClass]
	public class Bottle
	{
	
		/**
		 * orderそのもの
		 */		
		private var _main:AbstOrder;
		
		
		/**
		 * そのorderに付けられたvariableの名称です
		 */		
		private var _label:String;

		
		/**
		 * orderを返します
		 * @return 
		 * 
		 */		
		public function get main():AbstOrder
		{
			return _main;
		}
		
		
		/**
		 * orderに付けられたvaribleの名称を返します
		 * @return 
		 * 
		 */		
		public function get label():String
		{
			return _label;
		}
		
		
		
		/**
		 * コンストラクタです
		 * @param main Orderです
		 * @param lable Orderに付けられたラベル名称です
		 * 
		 */
		public function Bottle(main:AbstOrder, label:String)
		{
			_label = label;
			_main = main;
		}
	}
}