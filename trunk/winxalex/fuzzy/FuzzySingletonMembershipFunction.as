package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzySingletonMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		
		public function FuzzySingletonMembershipFunction(linguisticQuantifier:String, peakPoint:Number = NaN, leftOffset:Number = NaN, rightOffset:Number = NaN, ...args) 
		{
			super(linguisticQuantifier, peakPoint, leftOffset, rightOffset);
			
		}
		
		/* INTERFACE winxalex.fuzzy.IFuzzyMembershipFunction */
		
		public function calculateDOM(value:Number):void
		{
			throw new Error("Not yet implemented");
		}
		
		public function toString():String
		{
			return "Not yet implemented";
		}
		
	}

}