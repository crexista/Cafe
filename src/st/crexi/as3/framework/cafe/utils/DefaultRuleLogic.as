package st.crexi.as3.framework.cafe.utils
{
	import flash.utils.getQualifiedClassName;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IDIRule;
	
	public class DefaultRuleLogic implements IDIRule
	{		
		public function exchange(orderClass:Class):String
		{
			var className:String = getQualifiedClassName(orderClass);
			
			var num:uint = className.lastIndexOf("::");
			var head:String = className.substr(num+2, 1)
			className = className.substr(num+2).slice(1);
			
			className = head.toLowerCase() + className;
			className = className.replace("Order", "Result");
			return className;
		}
	}
}