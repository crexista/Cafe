package st.crexi.as3.framework.cafe.utils
{
	import flash.utils.Dictionary;
	
	/**
	 * そのDictionaryをラップしたデータ構造です。.
	 * Dictionaryは自分にどれだけのデータがはいっているかを返すことができないため、
	 * lengthメソッドで取得できるようになっています
	 * 
	 * @author kaoru_shibasaki
	 * 
	 */	
	public class Stock
	{
		
		/**
		 * queそのものを入れている辞書クラスインスタンスです
		 */
		private var _queDictionary:Dictionary = new Dictionary();
		
		/**
		 * queの数です
		 */		
		private var _queNum:int = 0;
		
		/**
		 *_queDictionaryのきーです 
		 */		
		private var _keys:Array = new Array();
		
		/**
		 * Dictionaryにkeyを削除します<br>
		 * 
		 * @param key Dictionaryのkeyとなるオブジェクトです
		 * @return 成功した場合はtrue<br>削除したいkeyが存在していない場合はfalseを返し何もしません <br>
		 * @author Kaoru Shibasaki
		 */
		public function del(key:Object):Boolean
		{		
			if (!_queDictionary[key]) return false;
			_queNum--;
			delete _queDictionary[key];		
			return true;
		}
		
		/**
		 * Dictionaryにkeyをセットします<br>
		 * addと違うのは既にkeyが存在していたとしても何も返さず上書きをするところです<br>
		 * 
		 * @param key Dictionaryのkeyとなるオブジェクトです
		 * @param obj 実際に入れる値です
		 */
		public function set(key:Object, obj:Object):void 
		{
			if (!_queDictionary[key]) {
				_queNum++;
			}
			if (obj === null) obj = new NullObject();
			_queDictionary[key] = obj;
		}
		
		/**
		 * Dictionaryにkeyを追加します<br>
		 * 
		 * @param key Dictionaryのkeyとなるオブジェクトです
		 * @param obj 実際に入れる値です
		 * @return 成功した場合はtrue<br>既にkeyが存在していた場合はfalseを返し何もしません <br>
		 * @author Kaoru Shibasaki
		 */
		public function add(key:Object, obj:Object):Boolean
		{
			if (_queDictionary[key]) return false;
			
			_queNum++;
			if (obj === null) obj = new NullObject();
			_queDictionary[key] = obj;
			return true;
		}
		
		
		
		/**
		 * keyに入っている値をupdateさせます。もし、keyが存在していなかった場合は何もせず、falseを返します
		 * 
		 * @param key
		 * @param obj
		 * @return 
		 * 
		 */
		public function update(key:Object, obj:Object):Boolean
		{
			if (!_queDictionary[key]) return false;
			if (obj === null) obj = new NullObject();
			_queDictionary[key] = obj;
			return true;
		}
		
		
		/**
		 * 内部のDictionaryからobjectを取得します。
		 * 何も入っていなかった場合は、Errorを飛ばしますので、
		 * 使用する際はtry catchを使ってください
		 * 
		 * @param key
		 * @return 
		 * 
		 */
		public function get(key:Object):*
		{
			if (!_queDictionary) throw new ReferenceError("まだ何も入っていません");
			if (!_queDictionary[key]) throw new ReferenceError("指定のキーは存在しません");
			if (_queDictionary[key] is NullObject) return null;
			
			return _queDictionary[key];
		}
		
		
		/**
		 * 全てのkeyとそれに紐付くデータを削除します
		 * 
		 */
		public function reset():void
		{
			_queDictionary = null;
			_queDictionary = new Dictionary();
			_queNum = 0;
			
		}
		
		/**
		 * Dictionaryに入っているkeyの数を返します
		 * @return Dictionaryに入っているkeyの数
		 * @author Kaoru Shibasaki<kaoru_shibasaki@dwango.co.jp>
		 */
		public function get length():int
		{
			return _queNum;
		}
		
	}
}

class NullObject
{}