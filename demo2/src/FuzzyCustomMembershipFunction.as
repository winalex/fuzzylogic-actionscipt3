package  
{
	import winxalex.fuzzy.FuzzyMembershipFunction;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FuzzyCustomMembershipFunction extends FuzzyMembershipFunction 
	{
		
		public function FuzzyCustomMembershipFunction(lingusiticTerm:String,typeName:String,leftDomain:Number, leftPeekDomain:Number, rightPeekPoint:Number, rightDomain:Number) 
		{
			super(linguisticTerm, typeName, leftDomain, leftPeekDomain, rightPeekPoint, rightDomain);
		}
		
		override public function calculateDOM(value:Number):Number 
		{
			value /= origRightDomain;
			value = 1-value;
			
			return value * value;
		}
		
	}

}