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
		 * 
		 * 
		 */		
		public function Rule()
		{
			throw new Error("呼び出すな");
		}
	}
}