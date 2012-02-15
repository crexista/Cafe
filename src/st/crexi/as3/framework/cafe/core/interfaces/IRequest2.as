package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Waiter2;
	import st.crexi.as3.framework.cafe.core.Worker2;
	
	/**
	 * request処理の結果をハンドリングするinterfaceです
	 * @author kaora_crexista
	 * 
	 */
	public interface IRequest2
	{
		
		/**
		 * initializeを一回だけ行うか否かを決定します
		 * @return 
		 * 
		 */		
		function get initOnlyOnce():Boolean;
		
		
		
		/**
		 * このtransactionが扱うrequestです
		 * @return 
		 * 
		 */		
		function get recipe():IRecipe2;
		
		
		
		
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
		 * newの代わりに呼び出すメソッドです
		 * @param value
		 * @return 
		 * 
		 */		
		function constructor(value:*):IRequest2;
		
		
		
		
		/**
		 * 初期化を行うメソッドです。このメソッドはロールバックするたびに呼ばれます 
		 * @param isInitialized : このメソッドが初めて呼ばれたか否かです
		 * @param value constructorで入れられた引数が入ります
		 * 
		 */
		function get initialize():*;
		
		function set initialize(value:*):void;
		
		
		/**
		 * Request成功時の処理です
		 * @param event
		 * 
		 */		
		function onSuccess(event:Event, waiter:Waiter2, worker:Worker2):void;
		
		
		
		/**
		 * Request失敗時の処理です
		 * @param event
		 * 
		 */		
		function onError(event:Event, waiter:Waiter2, worker:Worker2):void;
	}
}