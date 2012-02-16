package st.crexi.as3.framework.cafe.utils
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import st.crexi.as3.framework.cafe.core.Event.ImmutableObjectEvent;
	
	
	/**
	 * Immutableなオブジェクトを作るためのUtilitiyです 
	 * @author kaoru_shibasaki
	 * 
	 */	
	dynamic public class ImmutableObjectProxy extends Proxy
	{
		
		/**
		 * 実際のObjectです
		 */		
		private var _obj:Object;
		
		private var _indexArr:Array;
		
		private var _notifier:IEventDispatcher;
		
		
		private var _target:* ;
		
		public function ImmutableObjectProxy(target:*, checkMethod:Function = null)
		{
			_obj = new Object;
			_indexArr = new Array();
			//_target = target;
			var hoge:Object = clone(target)
			_notifier = new EventDispatcher();
			
			for (var key:String in hoge) {
				if (checkMethod != null) {
					checkMethod.call(null, target[key]);
				}
				_obj[key] = target[key];
				_indexArr.push(key);
			}
			
		}
		
		
		public function get notifier():IEventDispatcher
		{
			return _notifier;
		}
		
		
		override flash_proxy function callProperty(name:*, ...parameters):*
		{
			_target[name]();
		}
		
		
		override flash_proxy function getProperty(name:*):*
		{
			return _obj[name]
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			if (_obj[name]) throw new Error("これ以上値を入れられません");
			_obj[name] = value;
			_notifier.dispatchEvent(new ImmutableObjectEvent(ImmutableObjectEvent.SET_IMMUTABLE_OBJECT, value));
		}
		
		
		override flash_proxy function nextNameIndex(index:int):int
		{	
			
			if (index < _indexArr.length) {
				return index + 1;
			} else {
				return 0;
			}
		}
			
		override flash_proxy function nextName(index:int):String {
			
			return _indexArr[index - 1];
		}
		
		
		override flash_proxy function nextValue(index:int):*
		{
			return _obj[_indexArr[index - 1]];
		}
		
		
		protected static function clone(arg:*):* {
			var b:ByteArray = new ByteArray();
			
			b.writeObject(arg);
			b.position = 0;
			return b.readObject();
		}
		
	}
}