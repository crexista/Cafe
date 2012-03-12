package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.errors.NonrecognitionUseError;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;
	
	/**
	 * IRequestの実装クラスのwrapperクラスです
	 * @author crexista
	 * 
	 */	
	public class AbstOrder
	{
		
		/**
		 * requestClassでnewされたreqeustです
		 */		
		private var _request:IRequest2;
		
		
		
		/**
		 * Orderの進行状況をつたえるEventDispatcherです
		 */		
		private var _notifier:IEventDispatcher;
		
		
		/**
		 * requestのProxyです.<br>
		 * get requestではこのオブジェクトを返し、IRequestのメソッドをよびだそうとしたらErrorを飛ばすようにします 
		 */		
		private var _requestProxy:RequestProxy

		
		/**
		 * 
		 */
		internal var $argument:Object;
		
		
		/**
		 * このOrderが依存しているRequestです
		 */		
		internal var $parents:Vector.<IRequest2>;
		
		
		/**
		 * Orderの進行状況です
		 */		
		internal var $status:String;
		
		
		/**
		 * このOrderに依存しているRequestです
		 */		
		internal var $children:Vector.<Container>;
		
		
		/**
		 * このOrderの結果です
		 */		
		internal var $result:*
		
		
		
		
		/**
		 * initRequest経由からでは最初の1回のみ_argumentを設定するようにしてる
		 */		
		private var _initFunc:Function = function(value:*):void
		{
			_initFunc = function(value2:*):void
			{
				throw new Error("このメソッドがよべるのは1度だけです");
			};
			
			$argument = value;
		}
		
		
		/**
		 * requestを返します
		 * @return 
		 * 
		 */		
		internal function get $request():IRequest2
		{			
			return _request;
		}
		
		
		
		
		/**
		 * requestのproxyを返します
		 * このAbstOrderの継承クラスでsetterを用意してください(optional)
		 * @return 
		 * 
		 */		
		final public function get request():*
		{
			return _requestProxy
		}
		
		
		final public function get notifier():IEventDispatcher
		{
			return _notifier;
		}
		
		
		
		/**
		 * requestをsetupする引数を入れます。.<br>
		 * このメソッドをよべるのは1回だけです。それ以上呼ぶとerrorが飛びます
		 * @param value
		 * 
		 */		
		final public function initRequest(value:*=null):*
		{
			_initFunc();
			return this;
		}
		
		
		/**
		 * requestクラスそのものを返します.<br>
		 * overrideをしないとErrorが飛びます
		 * @return 
		 * 
		 */		
		protected function get requestClass():Class
		{
			throw new NonrecognitionUseError(this, NonrecognitionUseError.NOT_OVERRIDE_ERROR, "requestClass");
		}
		
		
		
		/**
		 * コンストラクタです。.<br>
		 * 
		 */
		public function AbstOrder()
		{
			_request = new requestClass();
			Rule.getLabel(this);
			_requestProxy = new RequestProxy(_request, this);
			_notifier = new EventDispatcher; 
		}
	}
}