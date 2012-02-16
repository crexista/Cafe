package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Waiter;
	import st.crexi.as3.framework.cafe.core.Worker;
	
	/**
	 * request処理の結果をハンドリングするinterfaceです
	 * @author kaora_crexista
	 * 
	 */
	public interface IRequest
	{
		
		/**
		 * このtransactionの結果です
		 * @return 
		 * 
		 */		
		function get result():*;
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		function get notifier():IEventDispatcher;
		
		
		
		/**
		 * status
		 * @return 
		 * 
		 */		
		function get status():String;
		
		
		
		/**
		 * 依存しているtaskのリストオブジェクトを返します 
		 * @return 
		 * 
		 */		
		function get dependencies():*;
		
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		function get dependenciesClass():Class;
		
		
		
		
		/**
		 * reloadの前に行うメソッドです。
		 * ここで引数等を代入したりreload前の処理を行ったりします
		 * @param isInitialized : このメソッドが初めて呼ばれたか否かです
		 * @param value constructorで入れられた引数が入ります
		 * 
		 */
		function preReload(value:* = null):void;
		
		
		
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