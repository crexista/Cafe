package st.crexi.as3.framework.cafe.core.errors
{
	import flash.errors.IllegalOperationError;
	
	public class HogeError extends IllegalOperationError
	{
		public static const NOT_EXTENDS_ERROR:int = 0;
		
		public function HogeError(instance:*, id:int=0)
		{
			super(message, id);
		}
	}
}