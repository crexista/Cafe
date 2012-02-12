package st.crexi.as3.framework.cafe.core.interfaces
{
	
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.Worker;
	import st.crexi.as3.framework.cafe.utils.interfaces.IObserver;
	

	/**
	 * リクエスト処理に必要となるデータ群のインターフェースです
	 * 
	 * 
	 * @author crexista
	 * 
	 */	
	public interface IRecipe
	{
		/**
		 * 
		 * @return 
		 * 
		 */		
		function get observer():IObserver;
		
		
		
		/**
		 * 成功時に飛ぶEventのタイプです
		 * @return 
		 * 
		 */		
		function get successEventType():String;
		
		
		/**
		 * requestが失敗したときに飛ぶEventのタイプが詰まった配列です
		 * @return 
		 * 
		 */		
		function get errorEventTypes():Array;
		
		
		/**
		 * Request成功時の処理です
		 * @param event
		 * 
		 */		
		function onSuccess(event:Event, worker:Worker):void;
		
		
		
		/**
		 * Request失敗時の処理です
		 * @param event
		 * 
		 */		
		function onError(event:Event, worker:Worker):void;
		
	}
}