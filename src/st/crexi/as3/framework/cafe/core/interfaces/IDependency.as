package st.crexi.as3.framework.cafe.core.interfaces
{
	/**
	 * 依存しているリクエストを列挙するためのインターフェースです
	 * @author crexista
	 * 
	 */	
	public interface IDependency
	{

		/**
		 * dependencyクラスに列挙されたvariableを初期化します<br/>
		 * このメソッドないでこのクラスのvariableの値を初期化します<br/>
		 * 
		 */		
		function initialize():void;
		
		
		function get tasks():Array;
		
		function get taskList():Object;
	}
}