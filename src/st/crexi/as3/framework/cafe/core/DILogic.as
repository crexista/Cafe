package st.crexi.as3.framework.cafe.core
{
	import st.crexi.as3.framework.cafe.core.interfaces.IDIRule;
	import st.crexi.as3.framework.cafe.utils.DefaultRuleLogic;

	
	/**
	 * DIするための規則を決めるためのクラスです
	 * 
	 * @author kaora crexista
	 * 
	 */	
	public class DILogic
	{
		
		/**
		 * 初期化済みかどうかのフラグです
		 */		
		private static var _isInited:Boolean = false;
		
		/**
		 * 命名規則クラスです
		 */		
		private static var _logic:IDIRule = new DefaultRuleLogic;
		
		
		private static var _orders:Object;
		
		
		
		
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
		 * 上書きします
		 * @param logic
		 * 
		 */		
		public static function overwrite(rule:IDIRule):void
		{
			if (_isInited) throw new Error("既に初期化図身です");
			_logic = rule;
		}



		/**
		 * コンストラクタです
		 * 呼び出すとエラーが還ります
		 * 
		 */		
		public function DILogic()
		{
			throw new Error("呼び出すな");
		}
	}
}