package winxalex.fuzzy {
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * Associative array with access to items thru name or
	 * index
	 */
	dynamic public class AssociativeArray extends Proxy {
		
		//memberValueHash.name1=value
		//contains the value of AssociativeArray items
		private var memberValueHash:Object = new Object();
		
		//memberIndexHash.name1=0
		//contains the index of the AssociativeArray items
		private var memberIndexHash:Object = new Object();
		
		// memberNameArray[0]="name1"
		//contains the names of the AssociativeArray items 
		private var memberNameArray:Array = new Array();
			
		/**
		 * returns Array length
		 */
		public function get length():uint {
			return memberNameArray.length;
		}
		
		/**
		 * set property to value (Array[name]=value)
		 * @param	name
		 * @param	value
		 */
		override flash_proxy function setProperty(name:*, value:*):void {
			
			//if AssociativeArray with that name not already exists put new item
			if (name in memberValueHash == false) 
			{
				var last:uint = memberNameArray.length;
				memberIndexHash[name] = last;
				memberNameArray[last] = name;
			}
			
			memberValueHash[name] = value;
		}
		
		/**
		 * 
		 * @param	name
		 * @return value of the Array by name
		 */
		override flash_proxy function getProperty(name:*):* {
			var num:Number = Number(name.toString());
			//if name is NaN
			if (isNaN(num))
			  	return memberValueHash[name]; //return valu thru name
			else
				if(num is uint)
				  return this.memberValueHash[memberNameArray[num]]; //return value thru index
				else
				  trace("not valid array param");
			
		}
		
		
		public function getIndex(name:String):uint
		{
			return this.memberIndexHash[name];
		}
		
		public function getName(inx:uint):String
		{
			return this.memberNameArray[inx];
		}
		
		/**
		 * 
		 * @param	name
		 * @param	...rest
		 * @return
		 */
		override flash_proxy function callProperty(name:*, ...rest):* {
			
			var num:Number = parseInt(name.toString());
			//if name is NaN
			if (isNaN(num))
			{
				//if we have function as item of array => exec function
				if (memberValueHash[name] is Function)
					//return memberValueHash[name].apply(null, arguments);
					return memberValueHash[name].apply(null, rest);

				
			}//is number
			else
			{
				if (memberValueHash[memberNameArray[num]] is Function)
				return memberValueHash[memberNameArray[num]].apply(null, rest);
			}
			
			
			//memberNameArray.[name.toString()].apply(null, rest);

			return null;
		}
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		override flash_proxy function hasProperty(name:*):Boolean {
			return name in memberValueHash;
		}
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		override flash_proxy function deleteProperty(name:*):Boolean {
			if (name in memberValueHash){
				var index:int = memberIndexHash[name];
				memberNameArray.splice(index, 1);
				var last:uint = memberNameArray.length;
				while(index < last){
					memberIndexHash[memberNameArray[index]]--;
					index++;
				}
				delete memberValueHash[name];
				delete memberIndexHash[name];
				return true;
			}
			return false;
		}
		
		/**
		 * 
		 * @param	index
		 * @return
		 */
		override flash_proxy function nextNameIndex(index:int):int {
			return (index < memberNameArray.length) ? index + 1 : 0;
		}
		
		/**
		
		 * @param	index
		 * @return
		 */
		override flash_proxy function nextName(index:int):String {
			return memberNameArray[index - 1];
		}
		
		/**
		 * 
		 * @param	index
		 * @return
		 */
		override flash_proxy function nextValue(index:int):* 
		{
			return memberValueHash[memberNameArray[index - 1]];
		}
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		override flash_proxy function getDescendants(name:*):* {
			return null;
		}
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		override flash_proxy function isAttribute(name:*):Boolean {
			return false;
		}
	}
}

