package st.crexi.as3.framework.cafe.core
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.utils.Bottle;

	/**
	 * 
	 * @author crexista
	 * 
	 */	
	internal dynamic class ResultProxy extends Proxy
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
		public function ResultProxy(order:AbstOrder, name:String)
		{
			_order = order;
			_name = name;
		}
		
		
		
		override flash_proxy function callProperty(name:*, ...parameters):*
		{			
			var func:Function = this.protected::[name.localName];
			
			func.call(null, parameters[0]);
		}
		
		
		/**
		 * 
		 * @param request
		 * 
		 */		
		protected function from(order:AbstOrder):void
		{
			order.$variables.children.push(new Bottle(_order, _name));
			_order.$variables.parents.push(order);
		}
	}
}