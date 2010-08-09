package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyMembershipFunctionProduct
	{
		
		public function getFunction(linguisticQuantifier:String,peakPoint:Number=NaN,leftOffset:Number=NaN,rightOffset:Number=NaN) :FuzzyMembershipFunction
		{
			throw new Error ("should be overrided");
			return null;
		}
		
	}

}