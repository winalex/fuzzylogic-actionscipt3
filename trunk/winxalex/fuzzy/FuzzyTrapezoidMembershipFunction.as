package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyTrapezoidMembershipFunction extends FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		
		public var rightPoint:Number;
		
	
		
		//domain value at the middle of
		private var _averagePoint:Number=0;
		
		public function FuzzyTrapezoidMembershipFunction(linguisticTerm:String, leftOffset:Number = NaN,leftMidPoint:Number = NaN,rightMidPoint:Number=NaN, rightOffset:Number = NaN, ...args) 
		{
					
			super(linguisticTerm, leftOffset, leftMidPoint,rightMidPoint, rightOffset);
			
		}
		
		
		
		/* INTERFACE winxalex.fuzzy.IFuzzyMembershipFunction */
		
		public function calculateDOM(value:Number):Number
		{
					
			var grad:Number;
			
						
						//between mid points
						   if  (value >= leftMidPoint  && value <=rightMidPoint) 
						  {
							  degreeOfMembership = maximumDOM;
						  }		
					    else
						{//  //find DOM if left of center
					  
								  grad = value - leftMidPoint + leftOffset;//value - (leftMidPoint - leftOffset)
								  
								  

									  //find DOM if left of left mid point
									  if ( (value < leftMidPoint) && grad>0 )
									  {
										 
										
										degreeOfMembership= grad*maximumDOM/leftOffset;
									  }

									  else //find DOM if right of center
									  {
											  grad = (rightMidPoint + rightOffset) - value;
										  
											  if ( (value > rightMidPoint) && ( grad>0 ) )
											  {
												
												
												degreeOfMembership= grad*maximumDOM /rightOffset;
											  } 
											  else //out of range of this FLV, degreeOfMembership= zero
											  {
												degreeOfMembership = 0;
											  }
									  }
						}
						
						return degreeOfMembership;
		}
		
		public function get averagePoint():Number { return leftMidPoint+(rightMidPoint-leftMidPoint)/2; }
		
		public function set averagePoint(value:Number):void 
		{
			_averagePoint = value;
		}
		
		public function get maximumPoint():Number { return rightMidPoint+rightOffset; }
		
		
		
	}

}