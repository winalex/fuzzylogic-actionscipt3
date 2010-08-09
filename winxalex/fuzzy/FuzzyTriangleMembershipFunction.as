package winxalex.fuzzy 
{
	import winxalex.fuzzy.FuzzyMembershipFunction;
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyTriangleMembershipFunction extends FuzzyMembershipFunction implements  IFuzzyMembershipFunction //extends FuzzyMembershipFunction
	{
		
			
		public function FuzzyTriangleMembershipFunction(linguisticQuantifier:String,peakPoint:Number=NaN,leftOffset:Number=NaN,rightOffset:Number=NaN) :void
		{
			super(linguisticQuantifier, peakPoint, leftOffset, rightOffset);
		}
		
		public function calculateDOM(value:Number):void
		{
			    var grad:Number;
				
								
					  //test for the case where the triangle's left or right offsets are zero
					  //(to prevent divide by zero errors below)
					  if ( (rightOffset==0 && peakPoint==value) || ( leftOffset==0 && peakPoint==value))
					  {
							degreeOfMembership= 1.0;
					  }

					  //find DOM if left of center
					  if ( (value <= peakPoint) && (value >= (peakPoint - leftOffset)) )
					  {
						  grad = 1.0 / leftOffset;

						degreeOfMembership= grad * (value - (peakPoint - leftOffset));
					  }

					  //find DOM if right of center
					  else if ( (value > peakPoint) && (value < (peakPoint + rightOffset)) )
					  {
						grad = 1.0 / -rightOffset;

						degreeOfMembership= grad * (value - peakPoint) + 1.0;
					  }

					  //out of range of this FLV, degreeOfMembership= zero
					  else
					  {
						degreeOfMembership= 0.0;
					  }

		}
		
	}

}