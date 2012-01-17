package st.crexi.as3.framework.cafe.core.interfaces
{
	
	/**
	 * 
	 * @author kaoru_shibasaki
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
		 * requestをまとめたリクエストクラスの暮らすオブジェクトです
		 * @return 
		 * 
		 */		
		function get requestListClass():Class
	}
}