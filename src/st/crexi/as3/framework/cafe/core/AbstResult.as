package st.crexi.as3.framework.cafe.core
{
	
	
	/**
	 * Requestの結果の抽象クラスです。.<br>
	 * Requestクラスから生成されたResultなのかをしているfromメソッドのみです<br/>
	 * 
	 * また、抽象クラスなのでこのまま起動させるとErrorが飛びます
	 * 
	 * @author kaora crexista
	 * 
	 */
	public class AbstResult
	{
		
		
		/**
		 * このRequestを生成したOrder
		 */		
		private var _order:AbstOrder;
		
		
		/**
		 * orderをセットします
		 */		
		private var _setOrder:Function = function (value:AbstOrder):void
		{
			_setOrder = function(value2:AbstOrder):void
			{
				//TODO あとでErrorきちんと
				throw new Error("既にsetされています");
			};
			
			_order = value
		}
		
		
		/**
		 * fromでsetされたorderを返します
		 * @return 
		 * 
		 */		
		internal function get $order():AbstOrder
		{
			return _order;
		}
		
		
		/**
		 * どのorderから生成されたかをsetします。.<br/>
		 * Order, Requestクラス内部では呼ばないでください。Errorが飛びます<br/>
		 * 
		 * @param value
		 * 
		 */		
		public function from(value:AbstOrder):void
		{
			_setOrder(value);
		}
		
		
		/**
		 * コンストラクタです.<br/>
		 * newして使うとErrorが飛びます
		 * 
		 */		
		public function AbstResult()
		{
			
		}
	}
}