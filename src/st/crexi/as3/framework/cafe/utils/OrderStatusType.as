package st.crexi.as3.framework.cafe.utils
{
	
	/**
	 * Orderがとりうるstatusのタイプを定義しているクラスです
	 * 
	 * @author kaora crexista
	 * 
	 */
	public class OrderStatusType
	{
		
		/**
		 * 何もしていないときのstatusです
		 */		
		public static const IDLE:String = "idle";
		
		/**
		 * 終了時のstatusです
		 */		
		public static const END:String = "end";
		
		
		/**
		 * 起動中のstatusです
		 */		
		public static const INVOKING:String = "invoking";
		

	}
}