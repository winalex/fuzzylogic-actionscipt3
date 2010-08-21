package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyLeftShoulderMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		
		public function FuzzyLeftShoulderMembershipFunction(linguisticTerm:String,leftOffset:Number,peakPoint:Number,rightOffset:Number) :void
		{
			super(linguisticTerm,leftOffset,peakPoint,peakPoint,  rightOffset);
		}
		
		public function calculateDOM(value:Number):void
		{
			var grad:Number;
			var peakPoint:Number = leftMidPoint;
			
			
			
			 //find DOM if left of center
				if ( (value <= peakPoint)  )
				  {
					degreeOfMembership= 1.0;
				  }
			 
			  else  //find DOM if right of center
			  {
			    grad = value-(peakPoint + rightOffset);
				
				
				  if ( (value > peakPoint) && (grad <0 ) )
				  {
					
						
					degreeOfMembership = -grad / rightOffset;
				  }
				  //out of range of this FLV, degreeOfMembership= zero
				  else
				  {
					degreeOfMembership= 0.0;
				  }
			  }
		}
		
	}

}