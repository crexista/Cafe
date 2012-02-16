package st.crexi.as3.framework.cafe.core.errors
{
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	
	
	/**
	 * 許可されていない方法でフレームワークを使った時のErrorです
	 * @author kaora crexista
	 * 
	 */	
	public class NonrecognitionUseError extends IllegalOperationError
	{
		
		/**
		 * 継承して使うAbstクラスをそのまま呼び出した
		 */		
		public static const NOT_EXTENDS_ERROR:int = 0;
		
		
		/**
		 * setterを容易すべきなのにされてない
		 */		
		public static const NOT_EQUIP_SETTER:int = 1;
		
		
		/**
		 * immutableなオブジェクトを変更しようとした
		 */		
		public static const SET_IMMUTABLE_AGAIN:int = 2;
		
		
		/**
		 * エラーメッセージを生成するメソッドです
		 * @param id
		 * @param className
		 * @param option
		 * @return 
		 * 
		 */		
		protected function generateMessage(id:int, className:String, option:String=null):String
		{
			var message:String;
			
			switch(id) {
				case NOT_EXTENDS_ERROR:
					message = className + " は継承しないと使えません、継承して使ってください" ; 
					break;
				
				case NOT_EQUIP_SETTER:
					message = className + " では、" + option +"のからのsetterを描いてください\nこんな感じです\nset dependencies(value:[dependenciesClassの型]):void{}" ; 
					
					break;
				
				case SET_IMMUTABLE_AGAIN:
					message = className + " のvariableはimmutableなので代入しないでください" ; 
					break;
				
				default:
					
					message = className + " で、エラーが起きてます"
					break;
			}
			
			return message;
		}
		
		
		/**
		 * コンストラクタです
		 * @param instance
		 * @param id
		 * @param name
		 * 
		 */
		public function NonrecognitionUseError(instance:*, id:int=0, name:String = null)
		{
			var message:String = generateMessage(id, getQualifiedClassName(instance), name);
			super(message, id);
		}
	}
}