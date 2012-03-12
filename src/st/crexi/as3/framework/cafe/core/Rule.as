package st.crexi.as3.framework.cafe.core
{
	import st.crexi.as3.framework.cafe.core.interfaces.IClassKeyLogic;

	
	/**
	 * 
	 * @author kaoru_shibasaki
	 * 
	 */	
	public class Rule
	{
		
		/**
		 * 初期化済みかどうかのフラグです
		 */		
		private static var _isInited:Boolean = false;
		
		/**
		 * 命名規則クラスです
		 */		
		private static var _logic:IClassKeyLogic;
		
		
		private static var _orders:Object;
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		internal static function get logic():IClassKeyLogic
		{
			return _logic;
		}
		
		
		/**
		 * orderをもとにラベルを返します
		 * ただし、orderでwrapしているrequestがSingletonじゃない場合はnullを返します
		 * @param order
		 * @return 
		 * 
		 */		
		public static function getLabel(order:AbstOrder):String
		{
			if (!order.$request.isSingleTon) return null;
			if (!_orders)_orders = new Object;
			var label:String = _logic.exchange(order["constructor"]);
			_orders[label] = order;
			
			return label;
		}
		
		
		/**
		 * 
		 * @param label
		 * @return 
		 * 
		 */		
		public static function getOrder(label:String):AbstOrder
		{
			return _orders[label];
		}
		
		
		/**
		 * 
		 * @param logic
		 * 
		 */		
		public static function init(logic:IClassKeyLogic):void
		{
			if (_isInited) throw new Error("既に初期化図身です");
			_logic = logic;
		}



		/**
		 * コンストラクタです
		 * 呼び出すとエラーが還ります
		 * 
		 */		
		public function Rule()
		{
			throw new Error("呼び出すな");
		}
	}
}