package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.utils.interfaces.IObserver;

	/**
	 * Requestのインターフェースです
	 * recipeに基づき、処理を生成します
	 * 実際の処理実行自体はWorkerクラスで行います
	 * 
	 *  
	 * @author crexista
	 * 
	 */	
	public interface IRequest extends IProcess
	{
		


		
		/**
		 * このrequestが実行される際に必要となるデータ群です
		 * 実装する側でsettterを用意してOverrideしてください
		 * 
		 * public function set recipe(value:IRecipe):void{};
		 *  
		 * @return 
		 * 
		 */		
		function get recipe():IRecipe;
		
		
		
		/**
		 * requestの結果です
		 * @return 
		 * 
		 */		
		function get result():*;
		
		
		/**
		 * 
		 * 
		 */		
		function execute():void;
	}
}