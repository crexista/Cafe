package st.crexi.as3.framework.cafe.core
{
	import flash.utils.Dictionary;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IDISingletonRule;
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
		private static var _logic:IDISingletonRule = new DefaultRuleLogic;
		
		
		/**
		 * label(String)をキーとしてOrderが格納された連想配列です
		 */		
		private static var _orders:Object;
		
		
		/**
		 * orderをキーとしてlabelが格納された連想配列です
		 */		
		private static var _labels:Dictionary;
		
		
		
		/**
		 * DILogicを初期化させます
		 */		
		private static var initialize:Function = function():void
		{
			_orders = new Object;
			_labels = new Dictionary;
			_isInited = true;
			initialize = function():void{};
		};
		
		
		
		
		/**
		 * orderをもとにラベルを返します
		 * ただし、orderでwrapしているrequestがSingletonじゃない場合はnullを返します
		 * @param order
		 * @return 
		 * 
		 */		
		public static function getLabel(order:AbstOrder):String
		{
			var label:String;
			
			initialize();
			
			if (!order.$request.isSingleTon) return null;
			
			//_labels辞書に既にlabelが登録されていたらそれを返しておしまい。
			if (_labels[order]) return _labels[order];
			
			//なければ登録してから返す
			label = _logic.exchange(order["constructor"]);
			
			_orders[label] = order;
			
			_labels[order] = label;
			
			return label;
		}
		
		
		/**
		 * labelからOrderオブジェクトを取得します.
		 * 何もなければnullを返します
		 * @param label
		 * @return 
		 * 
		 */		
		public static function getOrder(label:String):AbstOrder
		{
			initialize();
			return _orders[label];
		}
		

		
		/**
		 * DIされるパラメータの命名規則を上書きします。.<br/>
		 * ただし、getLabelとgetOrderを呼び出した後<br/>
		 * (waiterにOrderをいれてstartしたあと)<br/>
		 * に呼び出されるとErrorが飛びます<br/>
		 * 
		 * @param logic
		 * 
		 */		
		public static function overwrite(rule:IDISingletonRule):void
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