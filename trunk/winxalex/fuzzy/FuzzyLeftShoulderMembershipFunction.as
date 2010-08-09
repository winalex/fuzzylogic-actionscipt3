package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyLeftShoulderMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		
		public function FuzzyLeftShoulderMembershipFunction(linguisticQuantifier:String,peakPoint:Number=NaN,leftOffset:Number=NaN,rightOffset:Number=NaN) :void
		{
			super(linguisticQuantifier, peakPoint, leftOffset, rightOffset);
		}
		
		public function calculateDOM(value:Number):void
		{
			var grad:Number;
			
			 //test for the case where the left or right offsets are zero
			  //(to prevent divide by zero errors below)
			  if (( rightOffset==0.0  && peakPoint ==value) ||   (leftOffset==0.0 && peakPoint==value) )
			  {
				degreeOfMembership= 1.0;
			  }

			  //find DOM if right of center
			  else if ( (value >= peakPoint) && (value < (peakPoint + rightOffset)) )
			  {
				grad= 1.0 / -rightOffset;

				degreeOfMembership= grad * (value - peakPoint) + 1.0;
			  }

			  //find DOM if left of center
			  else if ( (value < peakPoint) && (value >= peakPoint-leftOffset) )
			  {
				degreeOfMembership= 1.0;
			  }

			  //out of range of this FLV, degreeOfMembership= zero
			  else
			  {
				degreeOfMembership= 0.0;
			  }
		}
		
	}

}