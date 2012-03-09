package st.crexi.as3.framework.cafe.core.interfaces
{
	public interface IRequest2
	{
		
		/**
		 * このリクエストクラスがSingleTonかどうかです
		 * @return 
		 * 
		 */		
		function get isSingleTon():Boolean;
		
		
		/**
		 * Requestの結果を返します
		 * @return 
		 * 
		 */		
		function get result():*;
	}
}