package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyRightShoulderMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		
		public function FuzzyRightShoulderMembershipFunction(linguisticQuantifier:String,peakPoint:Number=NaN,leftOffset:Number=NaN,rightOffset:Number=NaN) :void
		{
			super(linguisticQuantifier, peakPoint, leftOffset, rightOffset);
		}
		
		public function calculateDOM(value:Number):void 
		{
			var grad:Number;
			
				//test for the case where the left or right offsets are zero
				  //(to prevent divide by zero errors below)
				  if (( rightOffset==0.0 && peakPoint==value) ||   (leftOffset==0.0 && peakPoint, value) )
				  {
					degreeOfMembership= 1.0;
				  }
				  
				  //find DOM if left of center
				  else if ( (value <= peakPoint) && (value > (peakPoint - leftOffset)) )
				  {
					 grad = 1.0 / leftOffset;

					degreeOfMembership= grad * (value - (peakPoint - leftOffset));
				  }
				  //find DOM if right of center and less than center + right offset
				  else if ( (value > peakPoint) && (value <= peakPoint+rightOffset) )
				  {
					degreeOfMembership= 1.0;
				  }

				  else
				  {
					degreeOfMembership= 0;
				  }
		}
		
	}

}