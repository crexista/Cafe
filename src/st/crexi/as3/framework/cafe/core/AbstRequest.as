package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.PropertyChangeEvent;
	
	import st.crexi.as3.framework.cafe.core.Event.ImmutableObjectEvent;
	import st.crexi.as3.framework.cafe.core.errors.NonrecognitionUseError;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest;
	import st.crexi.as3.framework.cafe.utils.ImmutableObjectProxy;
	
	
	/**
	 * Requestの抽象クラスです
	 * @author kaora crexista
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
			
			try {
				this["dependencies"] = $dependencies
			}
			catch(error:Error) {
				
				//TODO errorクラスをきちんと描く				
				throw new NonrecognitionUseError(this, NonrecognitionUseError.NOT_EQUIP_SETTER, "dependencies");
			}
		}
		
		
		
		/**
		 * dependenciesのメンバーに変更が有ったときに呼ばれます
		 * @param event
		 * 
		 */		
		protected function onSetDependency(event:ImmutableObjectEvent):void
		{			
			Kitchen.instance.register(event.newValue, IRequest(this));
		}
		
		/**
		 * エラーチェックをします
		 * 
		 * 
		 */		
		protected function filter():void
		{
			if (getQualifiedClassName(this) == "st.crexi.as3.framework.cafe.core::AbstRequest2") throw new NonrecognitionUseError(this, NonrecognitionUseError.NOT_EXTENDS_ERROR);
		}
		
		
		
		/**
		 * コンストラクタです
		 * このクラスを直接呼ぶとerrorが発生します
		 * 
		 */
		public function AbstRequest()
		{
			filter();
			
			
			_notifier = new EventDispatcher();
			$status = RequestStatusType.IDLE;
		}

		
	}
}