package  winxalex.fuzzy
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class Token
	{
		
		public var func:Function;
		public var args:Array;
		public var value:Number = NaN;
		public var id:int;
		
		public function Token(id:int=-1,func:Function = null, args:Array = null) 
		{
			this.id = id;
			this.args = args;
			this.func = func;
		}
		
		
		
	}

}