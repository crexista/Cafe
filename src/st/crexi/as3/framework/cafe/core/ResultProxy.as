package st.crexi.as3.framework.cafe.core
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;

	/**
	 * 
	 * @author crexista
	 * 
	 */	
	public class ResultProxy extends Proxy
	{
		
		/**
		 * 
		 */		
		private var _order:AbstOrder;
		
		
		/**
		 * 
		 */		
		private var _name:String;

		/**
		 * コンストラクタです
		 * @param order
		 * 
		 */		
		public function ResultProxy(order:AbstOrder, name:String = null)
		{
			_order = order;
			_name = name;
		}
		
		
		
		override flash_proxy function callProperty(name:*, ...parameters):*
		{
			this.protected::[name](parameters[0]);
		}
		
		
		/**
		 * 
		 * @param request
		 * 
		 */		
		protected function from(order:AbstOrder):void
		{
			order.$children.push(_order);
			_order.$parents.push(order);
		}
	}
}