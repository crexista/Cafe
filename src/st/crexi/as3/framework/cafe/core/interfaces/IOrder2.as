package st.crexi.as3.framework.cafe.core.interfaces
{
	public interface IOrder2
	{
		/**
		 * requestのListを取得します
		 * @return 
		 * 
		 */		
		function get requests():*;
		
				
		
		/**
		 * reqestリストを配列形式にして返します
		 * @return 
		 * 
		 */		
		function get asArray():Array;
		
		
		/**
		 * requestをまとめたリクエストクラスの暮らすオブジェクトです
		 * @return 
		 * 
		 */		
		function get requestListClass():Class;
		
		
		
		/**
		 * Orderをスタートさせます
		 * @param argument
		 * 
		 */		
		function start(argument:*):void;
	}
}