package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.PropertyChangeEvent;
	
	import st.crexi.as3.framework.cafe.core.Event.ImmutableObjectEvent;
	import st.crexi.as3.framework.cafe.core.errors.HogeError;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.utils.ImmutableObjectProxy;
	
	
	/**
	 * Requestの抽象クラスです
	 * @author kaoru_shibasaki
	 * 
	 */
	public class AbstRequest
	{
		
		/**
		 * 
		 */		
		internal var $isInitialized:Boolean = false;
		
		/**
		 * 
		 */		
		internal var $invokeArg:*;
		
		
		/**
		 * 
		 */		
		internal var $dependencies:*;
		
		
		/**
		 * 
		 */		
		internal var $status:String;
		
		
		/**
		 * 
		 */		
		internal var $result:*;
		
		
		private var _notifier:IEventDispatcher
		
		
		private var _isInitialize:Boolean;


		
		/**
		 * Requestの結果を返します
		 * @return 
		 * 
		 */		
		public function get result():*
		{
			return $result;
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get dependencies():*
		{
			startup();
			return $dependencies;
		}
		
		
		/**
		 * 処理の進行状況を返します
		 * @return 
		 * 
		 */		
		public function get status():String
		{
			return $status;
		}
		
		
		final public function get notifier():IEventDispatcher
		{
			return _notifier;
		}
		
		
		/**
		 * このクラスのコンストラクタ代わりです.
		 * newする時以外に呼ぶとerrorが飛びます
		 * 
		 * @param value
		 * @return 
		 * 
		 */		
		final public function constructor(value:*):IRequest
		{
			$invokeArg = value;
			return IRequest(this);
		}
		
		
		
		
		
		/**
		 * Requestの準備を行います
		 * 主にdependenciesのセットアップを行います
		 * 
		 */		
		final protected function startup():void
		{
			if (!IRequest(this).dependenciesClass || this.$dependencies) return;
			
			this.$dependencies = new ImmutableObjectProxy(new (IRequest(this).dependenciesClass)());
			$dependencies.notifier.addEventListener(ImmutableObjectEvent.SET_IMMUTABLE_OBJECT, onSetDependency);
			
			for each(var dependency:IRequest in this.dependencies) {
				Kitchen.instance.register(dependency, IRequest(this));
			}
		}
		
		
		protected function onSetDependency(event:ImmutableObjectEvent):void
		{			
			Kitchen.instance.register(event.newValue, IRequest(this));
		}
		
		
		
		/**
		 * コンストラクタです
		 * このクラスを直接呼ぶとerrorが発生します
		 * 
		 */
		public function AbstRequest()
		{
			if (getQualifiedClassName(this) == "st.crexi.as3.framework.cafe.core::AbstRequest2") throw new HogeError(this, HogeError.NOT_EXTENDS_ERROR);
			
			_notifier = new EventDispatcher();
			$status = RequestStatusType.IDLE;
		}

		
	}
}