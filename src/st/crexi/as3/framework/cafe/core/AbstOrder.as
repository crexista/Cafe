package st.crexi.as3.framework.cafe.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import st.crexi.as3.framework.cafe.core.errors.NonrecognitionUseError;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.utils.Bottle;
	import st.crexi.as3.framework.cafe.utils.OrderStatusType;
	
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
		private var _request:IRequest;
		
		
		
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
		 * internalで他のAbst系クラスからしようされる変数
		 * 
		 */		
		internal var $variables:Variables;
		
		
		
		
		/**
		 * initRequest経由からでは最初の1回のみ_argumentを設定するようにしてる
		 */		
		private var _initFunc:Function = function(value:*):void
		{
			_initFunc = function(value2:*):void
			{
				throw new Error("このメソッドがよべるのは1度だけです");
			};
			
			$variables.argument = value;
		}
		
		
		/**
		 * requestを返します
		 * @return 
		 * 
		 */		
		internal function get $request():IRequest
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
			_initFunc(value);
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
			DILogic.getLabel(this);			
			_notifier = new EventDispatcher; 
			$variables = new Variables;
			$variables.parents = new Vector.<AbstOrder>;
			$variables.children = new Vector.<Bottle>;
			_requestProxy = new RequestProxy(_request, this);
			
		}
	}
}


import st.crexi.as3.framework.cafe.core.AbstOrder;
import st.crexi.as3.framework.cafe.utils.Bottle;
import st.crexi.as3.framework.cafe.utils.OrderStatusType;


class Variables
{
	/**
	 * 
	 */
	public var argument:Object;
	
	
	/**
	 * このOrderが依存しているRequestです
	 */		
	public var parents:Vector.<AbstOrder>;
	
	
	/**
	 * Orderの進行状況です
	 */		
	public var status:String = OrderStatusType.IDLE;
	
	
	/**
	 * このOrderに依存しているRequestです
	 */		
	public var children:Vector.<Bottle>;
	
	
	/**
	 * このOrderの結果です
	 */		
	public var result:*
}