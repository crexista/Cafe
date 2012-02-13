package st.crexi.as3.framework.cafe.core.interfaces
{
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.Waiter;
	import st.crexi.as3.framework.cafe.core.Worker;
	
	/**
	 * AspectとRequestの基底インターフェースです
	 * executeメソッドを持っている事がTaskの仕様です
	 * 
	 * @author crexista
	 * 
	 */	
	public interface ITask extends IProcess
	{
		

		
		/**
		 * ITaskオブジェクトを実行します
		 * 
		 */		
		function execute(waiter:Waiter):void
	}
}