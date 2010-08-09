package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzySquareMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		
		public function FuzzySquareMembershipFunction(linguisticQuantifier:String,peakPoint:Number=NaN,leftOffset:Number=NaN,rightOffset:Number=NaN) :void
		{
			super(linguisticQuantifier);
		}
		
		public function calculateDOM(value:Number):void
		{
			throw new Error("Not yet Implemented");
		}
		
		public function toString():String
		{
			return "";
		}
		
		
		
	}

}