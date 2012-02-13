package st.crexi.as3.framework.cafe.core.interfaces
{
	import st.crexi.as3.framework.cafe.core.Worker;

	/**
	 * 同期実行される処理のInterfaceです
	 * @author kaora_crexista
	 * 
	 */	
	public interface ISyncProcess
	{
		
		/**
		 * 処理を実行します
		 * @param worker
		 * 
		 */		
		function execute(worker:Worker):void;
	}
}