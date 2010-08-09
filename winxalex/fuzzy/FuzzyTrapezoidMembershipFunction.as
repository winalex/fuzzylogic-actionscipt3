package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyTrapezoidMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		public var leftMidPoint:Number;
		public var rightPoint:Number;
		
		public function FuzzyTrapezoidMembershipFunction(linguisticQuantifier:String, leftMidPoint:Number = NaN,rightMidPoint:Number=NaN, leftOffset:Number = NaN, rightOffset:Number = NaN, ...args) 
		{
			
			
			this.leftMidPoint = leftMidPoint;
			
			
			super(linguisticQuantifier, rightMidPoint, leftOffset, rightOffset);
			
		}
		
		/* INTERFACE winxalex.fuzzy.IFuzzyMembershipFunction */
		
		public function calculateDOM(value:Number):void
		{
			throw new Error("Not yet implemented");
			var rightMidPoint:Number = peakPoint;
			
			var grad:Number;
				
								
					  //test for the case where the triangle's left or right offsets are zero
					  //(to prevent divide by zero errors below)
					  if ( (rightOffset==0 && peakPoint==value) || ( leftOffset==0 && peakPoint==value))
					  {
							degreeOfMembership= 1.0;
					  }

					  //find DOM if left of left mid point
					  if ( (value <= peakPoint) && (value >= (leftMidPoint - leftOffset)) )
					  {
						  grad = 1.0 / leftOffset;

						degreeOfMembership= grad * (value - (leftMidPoint - leftOffset));
					  }

					  //find DOM if right of center
					  else if ( (value > peakPoint) && (value < (rightMidPoint+ rightOffset)) )
					  {
						grad = 1.0 / -rightOffset;

						degreeOfMembership= grad * (value - rightMidPoint) + 1.0;
					  }
					  //between mid points
					  else if  (value >= leftMidPoint  && value <=rightMidPoint) 
					  {
						  degreeOfMembership = 1.0;
					  }

					  //out of range of this FLV, degreeOfMembership= zero
					  else
					  {
						degreeOfMembership= 0.0;
					  }
		}
		
		override public function toString():String
		{
			return  "Not yet implemented";
		}
		
	}

}