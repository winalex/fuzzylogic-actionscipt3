package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzySquareRootMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		
		public function FuzzySquareRootMembershipFunction(linguisticQuantifier:String, peakPoint:Number = NaN, leftOffset:Number = NaN, rightOffset:Number = NaN, ...args) 
		{
			super(linguisticQuantifier, peakPoint, leftOffset, rightOffset);
			
		}
		
		/* INTERFACE winxalex.fuzzy.IFuzzyMembershipFunction */
		
		public function calculateDOM(value:Number):void
		{
			
		}
		
		public function toString():String
		{
			
		}
		
	}

}