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
	 * @author kaoru_shibasaki
	 * 
	 */	
	public interface IRequest extends ITask
	{
		

		
		
		
		/**
		 * Requestを実行する際に引数、パラメータが必要となる場合は
		 * このインターフェースを実装する際に[Bindable]タグをつけたsetterを用意し、
		 * そのsetter内で処理を書きます
		 * 
		 * @return 
		 * 
		 */		
		function set arguments(value:*):void;
		


		
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
		function get result():*
	}
}