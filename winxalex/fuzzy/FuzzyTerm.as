package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyTerm
	{
		public var terms:Vector.<String>;
		private var _value:Number=NaN;
		
		public function FuzzyTerm(...args) 
		{
			
		}
		
		public function get value():Number { return _value }
		
		public function set value(value:Number):void 
		{
			_value = value;
		}
		
	}

}