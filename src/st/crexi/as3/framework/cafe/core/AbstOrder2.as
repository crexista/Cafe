package st.crexi.as3.framework.cafe.core
{
	import st.crexi.as3.framework.cafe.core.interfaces.IOrder;
	import st.crexi.as3.framework.cafe.core.interfaces.IOrder2;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;
	import st.crexi.as3.framework.cafe.utils.ImmutableObjectProxy;

	/**
	 * orderの抽象クラスです
	 * @author crexista
	 * 
	 */	
	public class AbstOrder2
	{
		

		private var _requests:*;
		
		
		private var _requestArr:Array;
		
		
		/**
		 * requestsのオブジェクトを配列形式で返します
		 * @return 
		 * 
		 */
		public function get asArray():Array
		{
			return _requestArr;
		}
		
		
		/**
		 * requestlistの結果をObject形式で返します。
		 * なので、for eachが使えます。
		 * また、AbstOrder2の派生クラスでset requestしてください
		 * @return 
		 * 
		 */		
		public function get requests():*
		{			
			return _requests;
		}
		
		
		
		
		public function start(argument:*):void
		{
			var klass:Class = IOrder2(this).requestListClass;
			var rowrequests:*;
			
			if (argument != null) {
				rowrequests = new klass(argument);
			}
			else {
				rowrequests = new klass();
			}
			
			_requestArr = new Array();
			_requests = new ImmutableObjectProxy(rowrequests);
			
			try {
				this["requests"] = _requests;
			}
			catch (error:Error) {
				//TODO Errorをきちんと書く
				throw new Error("set requestしてください");
			}
			
			for each(var request:IRequest2 in _requests) {
				_requestArr.push(request);
				//getterでdependenciesの初期化を行っている
				request.dependencies;
				request.setup(false, AbstRequest2(request).$invokeArg);
			}
			
			new Waiter2().start(_requestArr);
			
			
		}
		
		
		
		public function AbstOrder2()
		{
		}

		
	}
}