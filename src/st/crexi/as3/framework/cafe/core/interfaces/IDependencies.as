package st.crexi.as3.framework.cafe.core.interfaces
{
	/**
	 * 依存しているリクエストを列挙するためのインターフェースです
	 * @author crexista
	 * 
	 */	
	public interface IDependencies
	{

		/**
		 * dependencyクラスに列挙されたvariableを初期化します<br/>
		 * このメソッドないでこのクラスのvariableの値を初期化します<br/>
		 * 
		 */		
		function initialize():void;
		
		/**
		 * このdependenciesを呼んでいるrequestもしくはtaskクラスが列挙されているorderクラスが入ります
		 * 実装側で[Bindable] pulic function set dependencies(value:Dependacy):void{}とやる必要があります
		 * ただ、このdependenciesを呼んでいるrequestもしくはtaskクラスが列挙されているorderクラスがない場合はsetterを書く必要は有りません
		 * @return 
		 * 
		 */		
		function get order():*;
		
		
		/**
		 * 
		 * @return 
		 * 
		 */			
		function get tasks():Array;
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		function get taskList():Object;
	}
}