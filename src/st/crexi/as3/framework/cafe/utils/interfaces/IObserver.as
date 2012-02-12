package st.crexi.as3.framework.cafe.utils.interfaces
{
	import flash.events.IEventDispatcher;

	/**
	 * Observerのインターフェースです 
	 * @author crexista
	 * 
	 */	
	public interface IObserver
	{
		/**
		 * 
		 * @param type
		 * @param callBack
		 * 
		 */
		function setHandler(type:String, handler:Function = null, propertyChain:Array = null):IObserver;

		
		/**
		 * 実際にEventを投げるオブジェクトです
		 * @return 
		 * 
		 */		
		function get eventTarget():IEventDispatcher;




		/**
		 * 
		 * @return 
		 * 
		 */		
		function start():void;
		
		
		
		/**
		 * すべての監視しているEventを捨てる
		 * 
		 */		
		function reset():void;
		
		
		
		/**
		 * イベントの監視を辞める
		 * @param type
		 * @param callBack
		 * 
		 */		
		function remove(type:String):void
	}
}