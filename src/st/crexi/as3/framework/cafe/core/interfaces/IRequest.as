package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.Draft;
	import st.crexi.as3.framework.cafe.core.Waiter;
	import st.crexi.as3.framework.cafe.core.Worker;

	
	/**
	 * 
	 * @author kaoru_shibasaki
	 * 
	 */		
	public interface IRequest
	{
		
		/**
		 * このリクエストクラスがSingleTonかどうかです
		 * @return 
		 * 
		 */		
		function get isSingleTon():Boolean;
		
		
		
		
		/**
		 * Requestそのものの内容です
		 * フレームワークからよばれます。直接呼び出すとErrorが飛びます
		 * 
		 */		
		function get recipe():IRecipe

		
		
		
		/**
		 * Requestが実行される呼ばれます
		 * @param value このRequestの実行に必要な引数です
		 * フレームワークからよばれます。直接呼び出すとErrorが飛びます
		 * 
		 */		
		function setup(value:*):void;
		
		
		
		/**
		 * Request成功時の処理です。.<br/>
		 * フレームワークからよばれます。直接呼び出すとErrorが飛びます
		 * @param event
		 * 
		 */		
		function onSuccess(draft:Draft):void;
		
		
		
		/**
		 * Request失敗時の処理です
		 * フレームワークからよばれます。直接呼び出すとErrorが飛びます
		 * @param event
		 * 
		 */		
		function onError(draft:Draft):void;
	}
}