package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.IEventDispatcher;

	/**
	 * APIへの接続ロジックをまとめたインターフェースです
	 * @author kaora crexista
	 * 
	 */	
	public interface IRecipe2
	{
		
		/**
		 * 非同期処理が成功した時にeventTargetから飛んでくるEventTypeです
		 * @return 
		 * 
		 */		
		function get successEventType():String;
		
		
		/**
		 * 非同期処理が失敗したときにeventTargetから飛んでくるEventのtypeです.
		 * errorEventTargetがnullでないときはerrorEventTargetから飛んでくるものを監視します
		 * @return 
		 * 
		 */
		function get errorEventTypes():Array;
		
		
		/**
		 * 非同期処理を行った際に、その経過を飛ばすeventTargetです
		 * @return 
		 * 
		 */		
		function get eventTarget():IEventDispatcher;
		
		
		
		/**
		 * 非同期処理を行った際に、その経過がErrorだったときにErrorのイベントを飛ばすeventTargetです 
		 * @return 
		 * 
		 */		
		function get errorEventTarget():IEventDispatcher;

		
		
		/**
		 * 処理をスタートさせるメソッドです
		 * @param value
		 * 
		 */		
		function start():void;
	}
}