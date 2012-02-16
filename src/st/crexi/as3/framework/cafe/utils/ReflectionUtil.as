package st.crexi.as3.framework.cafe.utils
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	/**
	 * ReflectionのUtilクラスです
	 * @author crexista
	 * 
	 */
	public class ReflectionUtil
	{
		
		/**
		 * シングルトンを返す関数です
		 * 
		 */		
		private static var _singleTon:Function = function():ReflectionUtil
		{
			var instace:ReflectionUtil = new ReflectionUtil(new Guard);			
			
			_singleTon = function():ReflectionUtil
			{
				return instace;
			};
			
			return _singleTon();
		};
		
		
		
		/**
		 * このクラスのインスタンスを取得します
		 * @return 
		 * 
		 */		
		public static function get instance():ReflectionUtil
		{
			return _singleTon();
		}
		
		
		
		/**
		 * instanceをキーとしてdescribeTypの結果のXMLを入れたDictionaryです
		 */		
		private var _instanceDic:Dictionary;
		
		
		
		/**
		 * 突っ込まれたクラスインスタンスをfor eachできるようにObjectにへんかんします 
		 * @param instance
		 * @return 
		 * 
		 */		
		public function getEnumbleInstanceObject(instance:Object, key:String = "variable"):Object
		{
			var enum:Object = new Object;
			
			var xml:XML;
			
			if (!_instanceDic[instance]) {
				xml = describeType(instance);
				_instanceDic[instance] = xml;
			}
			
			xml = _instanceDic[instance];
			trace(xml);
			
			var props:XMLList = xml[key] as XMLList;
			
			for each(xml in props) {				
				enum[String(xml.@name)] = instance[String(xml.@name)];
			}
			
			return enum; 
		}
		
		
		public function ReflectionUtil(guard:Guard)
		{
			_instanceDic = new Dictionary;		
		}
	}
}

class Guard
{}