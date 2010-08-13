package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyRightShoulderMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		
		public function FuzzyRightShoulderMembershipFunction(linguisticTerm:String,leftOffset:Number=NaN,peakPoint:Number=NaN) :void//,rightOffset:Number=NaN
		{
			super(linguisticTerm,  leftOffset,peakPoint);
		}
		
		public function calculateDOM(value:Number):void 
		{
			
			var grad:Number;
			var peakPoint:Number = leftMidPoint;
			
				if ( value >= peakPoint )// && (value <= peakPoint + rightOffset) )
				 {
							degreeOfMembership= 1.0;
				 }
				else
				{
					  grad = value-peakPoint + leftOffset;// value - (peakPoint - leftOffset))
					   if ( (value < peakPoint) && grad>0 )
					  {
						   degreeOfMembership =  grad/leftOffset;
					  }
					  //find DOM if right of center and less than center + right offset
					  else
						  {
							degreeOfMembership= 0;
						  }
					  
				  }
		}
		
	}

}