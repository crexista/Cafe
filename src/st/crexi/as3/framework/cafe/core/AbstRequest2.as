package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.PropertyChangeEvent;
	
	import st.crexi.as3.framework.cafe.core.Event.ImmutableObjectEvent;
	import st.crexi.as3.framework.cafe.core.errors.HogeError;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe2;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;
	import st.crexi.as3.framework.cafe.utils.ImmutableObjectProxy;
	
	
	/**
	 * Requestの抽象クラスです
	 * @author kaoru_shibasaki
	 * 
	 */
	public class AbstRequest2
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
		private var _result:*;
		
		
		private var _notifier:IEventDispatcher

		/**
		 * 初期化済みかどうかを返します
		 * @return 
		 * 
		 */		
		public function get isInitialized():Boolean
		{			
			return $isInitialized;
		}

		
		/**
		 * Requestの結果を返します
		 * @return 
		 * 
		 */		
		public function get result():*
		{
			return _result;
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get dependencies():*
		{
			initialize();
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
		final public function constructor(value:*):IRequest2
		{
			$invokeArg = value;
			return IRequest2(this);
		}
		
		
		
		/**
		 * Requestの準備を行います
		 * 主にdependenciesのセットアップを行います
		 * 
		 */		
		final protected function initialize():void
		{
			if (!IRequest2(this).dependenciesClass || this.$dependencies) return;
			
			this.$dependencies = new ImmutableObjectProxy(new (IRequest2(this).dependenciesClass)());
			$dependencies.notifier.addEventListener(ImmutableObjectEvent.SET_IMMUTABLE_OBJECT, onSetDependency);
			
			for each(var dependency:IRequest2 in this.dependencies) {
				Kitchen2.instance.register(dependency, IRequest2(this));
			}
		}
		
		
		protected function onSetDependency(event:ImmutableObjectEvent):void
		{			
			Kitchen2.instance.register(event.newValue, IRequest2(this));
		}
		
		
		protected function onResult(event:PropertyChangeEvent):void
		{
			if (event.property != "result") return;
			_result = event.newValue;
		}
		
		
		/**
		 * コンストラクタです
		 * このクラスを直接呼ぶとerrorが発生します
		 * 
		 */
		public function AbstRequest2()
		{
			if (getQualifiedClassName(this) == "st.crexi.as3.framework.cafe.core::AbstRequest2") throw new HogeError(this, HogeError.NOT_EXTENDS_ERROR);
			
			try {
				IEventDispatcher(this).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onResult);
			}
			catch (error:Error) {
				//TODO 後できちんとErrorクラスを作る
				throw new HogeError(this, HogeError.NOT_EXTENDS_ERROR);
			}
			
			_notifier = new EventDispatcher();
		}

		
	}
}