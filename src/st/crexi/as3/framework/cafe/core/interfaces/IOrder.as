package st.crexi.as3.framework.cafe.core.interfaces
{
	
	/**
	 * 
	 * @author crexista
	 * 
	 */	
	public interface IOrder
	{
		
		/**
		 * requestのListを取得します
		 * @return 
		 * 
		 */		
		function get requests():*;
		
		

		
		/**
		 * requestをfor eachでとれる様にObject形式で返します
		 * @return 
		 * 
		 */
		function get requestList():Object;
		
		
		/**
		 * reqestリストを配列形式にして返します
		 * @return 
		 * 
		 */		
		function get requestArray():Array;

		
		/**
		 * requestをまとめたリクエストクラスの暮らすオブジェクトです
		 * @return 
		 * 
		 */		
		function get requestListClass():Class;
		
		
		
		/**
		 * このクラスがインスタンスがsingletonかどうかです.<br>
		 * このパラメータがtrueの時、このクラスをnewしても内部のrequestlistオブジェクトの単一性は保証されます
		 * @return 
		 * 
		 */		
		function get isSingleton():Boolean;
		
		
		
		/**
		 * 
		 * 
		 */		
		function start():void;
			
	}
}