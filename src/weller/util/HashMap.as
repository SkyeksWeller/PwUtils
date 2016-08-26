/**
 * Created with IntelliJ IDEA.
 * User: pengwei
 * Date: 15-3-13
 * Time: 下午5:47
 * To change this template use File | Settings | File Templates.
 */
package weller.util  {

	import flash.utils.Dictionary;

	/**
	 * 哈希表结构，用于双向引用
	 */
	public class HashMap  {

		//值列表
		private var _values:Array;

		//键列表
		private var _keys:Dictionary;

		public function HashMap(values:Array = null,keys:Dictionary = null) {
			_values = (values == null)?[]:values;
			_keys = (keys == null)?new Dictionary():keys;
		}

		/**
		 * 通过键获取值
		 * @param key
		 * @return
		 */
		public function getValueByKey(key:*):*
		{
			if(_keys[key] == undefined)return null;
			return getValueByIndex(_keys[key]);
		}


		/**
		 * 通过索引获取值
		 * @param index
		 * @return
		 */
		public function getValueByIndex(index:int):*
		{
			return _values[index];
		}

		/**
		 * 通过键获取索引
		 * @param key
		 * @return
		 */
		public function getIndexByKey(key:*):int
		{
			return (_keys[key]!=undefined)?_keys[key]:-1;
		}


		/**
		 * 通过值获取索引
		 * @param value
		 * @return
		 */
		public function getIndexByValue(value:*):int
		{
			for(var i:int = 0;i<_values.length;i++)
			{
				if(_values[i] == value)return i;
			}
			return -1;
		}

		/**
		 * 通过键列表获取索引
		 * @param keys
		 * @return
		 */
		public function getIndexByKeys(keys:Array):int
		{
			if(keys == null || keys.length == 0)return -1;
			var index:int = -1;
			var key:*;
			for(var i:int = 0;i<keys.length;i++){
				key = keys[i];
				if(_keys[key] == undefined)return -1;

				if(index!=-1){
					if(_keys[key]!=index)return -1;
				}else{
					index = _keys[key];
				}
			}
			return index;
		}

		/**
		 * 通过索引获得键列表
		 * @param index
		 * @return
		 */
		public function getKeysByIndex(index:uint):Array
		{
			var keys:Array = [];
			for(var key:* in _keys)
			{
				if(_keys[key] == index) keys.push(key);
			}
			return keys;
		}

		/**
		 * 通过索引设置值
		 * @param index
		 * @param value
		 */
		public function setValueByIndex(index:int,value:*):void
		{
			_values[index] = value;
		}

		/**
		 * 通过键设置值
		 * @param key
		 * @param value
		 */
		public function setValueByKey(key:*,value:*):void
		{
			if(_keys[key]!=undefined)setValueByIndex(_keys[key],value);
		}

		/**
		 * 值列表
		 * @param value
		 */
		public function set values(value:Array):void
		{
			_values = value;
		}
		public function get values():Array
		{
			return _values;
		}

		/**
		 * 与值对应的键列表
		 * @param value
		 */
		public function set keys(value:Dictionary):void
		{
			_keys = value;
		}
		public function get keys():Dictionary
		{
			return _keys;
		}

		/**
		 * 移除键值关系
		 * @param key
		 */
		public function removeKey(key:*):void
		{
			delete _keys[key];
		}

		/**
		 * 通过键移除对应的键值
		 * @param key
		 */
		public function removeByKey(key:*):void
		{
			if(_keys[key]!=undefined)removeByIndex(_keys[key]);
		}

		/**
		 * 通过索引移除对应的键值
		 * @param index
		 */
		public function removeByIndex(index:uint):void
		{
			_values.splice(index,1);

			//克隆一份_keys进行for in 操作，直接对_keys进行操作将会导致for in 无序
			var key:*;
			var keys:Dictionary = new Dictionary();
			for(key in _keys)keys[key] = _keys[key];

			//检查key
			for(key in keys)
			{
				//移除相关的key
				if(_keys[key] == index)
				{
					delete _keys[key];
				}
				//后面的索引递减一次
				else if(_keys[key]>index)
				{
					_keys[key]--;
				}
			}
		}

		/**
		 * 添加一个值，以及对应的键列表，并返回该值的索引
		 * @param value
		 * @param keys
		 * @return
		 */
		public function add(value:*,...keys):uint
		{
			var index:int = _values.length;
			_values.push(value);
			for(var i:int = 0;i<keys.length;i++)_keys[keys[i]]=index;
			return index;
		}

        public function addWithArray(value:*,keys:Array):uint
        {
            var index:int = _values.length;
            _values.push(value);
            for(var i:int = 0;i<keys.length;i++)_keys[keys[i]]=index;
            return index;
        }

		/**
		 * 添加一个值到开头，以及对应的键列表，返回该值索引
		 * @param value
		 * @param keys
		 * @return
		 */
		public function unshift(value:*,...keys):uint
		{
			var index:int = 0;
			_values.unshift(value);
			for(var i:int = 0;i<keys.length;i++)_keys[keys[i]]==index;
			return index;
		}

		/**
		 * 清空
		 */
		public function clear():void
		{
			_values = [];
			_keys = new Dictionary();
		}

		/**
		 * 克隆
		 * @return
		 */
		public function clone():HashMap
		{
			var keys:Dictionary = new Dictionary();
			for(var key:* in _keys)keys[key] = _keys[key];
			return new HashMap(_values.concat(),keys);
		}

		/**
		 * 值的数量
		 */
		public function get length():uint
		{
			return _values.length;
		}

		public function foreach(handler:Function):void
		{
			var i:int;
			for(i = 0;i<length;i++)
			{
				handler(_values[i]);
			}
		}
	}
}
