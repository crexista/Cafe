package st.crexi.as3.framework.cafe.core
{
	import flash.events.Event;
	
	import st.crexi.as3.framework.cafe.core.errors.NonrecognitionUseError;
	import st.crexi.as3.framework.cafe.core.interfaces.IRecipe;
	import st.crexi.as3.framework.cafe.core.interfaces.IRequest2;

	public class AbstRequest2 extends RequestProxy
	{
		
		/**
		 * 
		 */		
		internal var $handler:Handler;
		
		/**
		 * Requestが起動したときに呼ばれます。
		 * @return 
		 * 
		 */		
		protected function onReady():IRecipe
		{
			throw new NonrecognitionUseError(this, NonrecognitionUseError.NOT_OVERRIDE_ERROR, "onReady");
		}
		
		
		
		/**
		 * Request成功時の処理です
		 * @param event
		 * 
		 */		
		protected function onSuccess(event:Event, waiter:Waiter, worker:Worker):void
		{
			throw new NonrecognitionUseError(this, NonrecognitionUseError.NOT_OVERRIDE_ERROR, "onSuccess");
		}
		
		
		
		/**
		 * Request失敗時の処理です
		 * @param event
		 * 
		 */		
		protected function onError(event:Event, waiter:Waiter, worker:Worker):void
		{
			throw new NonrecognitionUseError(this, NonrecognitionUseError.NOT_OVERRIDE_ERROR, "onError");
		}



		public function AbstRequest2()
		{
			$handler = new Handler(onReady, onSuccess, onError);
			IRequest2(this);
		}
	}
}


class Handler
{
	
	/**
	 * 
	 */	
	private var _onReady:Function;


	/**
	 * 
	 */	
	private var _onSuccess:Function;
	
	
	/**
	 * 
	 */	
	private var _onError:Function;
	
	
	/**
	 * 
	 * @return 
	 * 
	 */	
	public function get onReady():Function
	{
		return _onReady;
	}


	/**
	 * 
	 * @return 
	 * 
	 */	
	public function get onSuccess():Function
	{
		return _onSuccess;
	}


	/**
	 * 
	 * @return 
	 * 
	 */	
	public function get onError():Function
	{
		return _onError;
	}

	/**
	 * コンストラクタです
	 * @param onReady
	 * @param onSuccess
	 * @param onError
	 * 
	 */
	public function Handler(onReady:Function, onSuccess:Function, onError:Function):void
	{
		_onReady = onReady;
		_onSuccess = onSuccess;
		_onError = onError;
	}
}