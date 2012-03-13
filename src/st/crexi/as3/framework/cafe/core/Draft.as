package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	
	import mx.controls.Menu;
	
	import st.crexi.as3.framework.cafe.utils.OrderStatusType;
	
	/**
	 * recipeに書かれた結果を処理し、その途中結果のクラスです。.<br/>
	 * フレームワークを使用する際はこのクラスはnew出来ません
	 * @author kaoru_shibasaki
	 * 
	 */	
	public class Draft
	{
		
		/**
		 * Requestの処理を終了させるために必要となるworkerです
		 */		
		private var _woker:Worker;
		
		
		/**
		 * 依存している処理をreloadさせる為に必要となるためのwaiterです
		 */		
		private var _waiter:Waiter;
		
		
		/**
		 * Requestが用意したrecipeに書かれた処理が終わったときに飛ぶイベントですdesu 
		 * 
		 */		
		private var _event:Event;
		
		
		
		/**
		 * Requestが用意したrecipeに書かれた処理が終わったときに飛ぶイベントです<br/>
		 * Requestのrecipeがnullの場合、これの返り値もnullです
		 * @return 
		 * 
		 */		
		public function get event():Event
		{
			return _event;
		}
		
		
		/**
		 * reacquireに必要なmenuクラスインスタンスを返します
		 * 
		 * @param result 
		 * @param argument
		 * @return 
		 * 
		 */		
		public function menu(result:AbstResult, argument:*):Menu
		{
			return new Menu(result, argument);
		}
		
		

		/**
		 * 結果の再取得を行います<br/>
		 * 
		 * getMenuメソッドを使って生成したmenuインスタンスを入れてください。
		 * menuインスタンスを用いて入れられたresultを生成したrequestの処理が再度実行されます
		 * 
		 * @param menus menuクラスのインスタンスのみを入れてください。それ以外を入れるとErrorが飛びます
		 * 
		 */		
		public function reacquire(...menus):void
		{
			var order:AbstOrder;
			var orders:Array = new Array;
			
			for each(var menu:Menu in menus) {
				order = menu.result.$order;
				order.$variables.argument = menu.argument;
				orders.push(order);
				order.$variables.status = OrderStatusType.IDLE;
				_waiter.$reloadChildren(order);
			}
			_waiter.start(orders);
		}
		
		
		/**
		 * 
		 * @param result
		 * 
		 */		
		public function complete(result:AbstResult):void
		{
			_woker.end(result);
		}
		
		/**
		 * 初期化を行います。.<br/>
		 * GuardがnullだとErrorを飛ばします
		 * @param guard
		 * 
		 */		
		protected function init(guard:Guard):void
		{
			if (!guard) throw new Error("不正な呼び出しがされました");
		}
		
		
		/**
		 * コンストラクタです.<br>
		 * guardがnullだとErrorが飛びます
		 * 
		 * @param guard
		 * @param waiter
		 * @param worker
		 * @param event
		 * 
		 */
		public function Draft(guard:Guard, waiter:Waiter, worker:Worker, event:Event)
		{
			init(guard);
			_waiter = waiter;
			_woker = worker;
			_event = event;
		}
	}
}



import st.crexi.as3.framework.cafe.core.AbstResult;

/**
 * 
 * @author kaora crexista
 * 
 */
class Menu
{
	
	/**
	 * 結果を返します
	 */	
	private var _result:AbstResult;
	
	
	/**
	 * AbstRequestのsetupの際に必要となる引数です
	 */	
	private var _argument:*;
	
	
	/**
	 * 結果を返します
	 * @return 
	 * 
	 */	
	public function get result():AbstResult
	{
		return _result;
	}
	
	
	/**
	 * AbstRequestのsetupの際に必要となる引数を返します
	 * @return 
	 * 
	 */	
	public function get argument():*
	{
		return _argument
	}

	
	/**
	 * コンストラクタです
	 * @param result
	 * @param argument
	 * 
	 */	
	public function Menu(result:AbstResult, argument:*) 
	{
		_result = result;
		_argument = argument;
	}
}