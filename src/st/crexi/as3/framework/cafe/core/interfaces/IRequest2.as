package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.Waiter;
	import st.crexi.as3.framework.cafe.core.Worker;

	
	/**
	 * 
	 * @author kaoru_shibasaki
	 * 
	 */	
	public interface IRequest2
	{
		
		/**
		 * このリクエストクラスがSingleTonかどうかです
		 * @return 
		 * 
		 */		
		function get isSingleTon():Boolean;
		
		
		
		/**
		 * このリクエストが依存しているすべてのリクエストが解決したときに毎回呼ばれます
		 * 
		 */		
		function onReady():IRecipe;
		
		/**
		 * Request成功時の処理です
		 * @param event
		 * 
		 */		
		function onSuccess(event:Event, waiter:Waiter, worker:Worker):void;
		
		
		
		/**
		 * Request失敗時の処理です
		 * @param event
		 * 
		 */		
		function onError(event:Event, waiter:Waiter, worker:Worker):void;
	}
}