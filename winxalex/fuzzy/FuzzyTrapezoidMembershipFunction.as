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
		
		public function FuzzyTrapezoidMembershipFunction(linguisticTerm:String, leftMidPoint:Number = NaN,rightMidPoint:Number=NaN, leftOffset:Number = NaN, rightOffset:Number = NaN, ...args) 
		{
			
			
			super(linguisticTerm, leftOffset, leftMidPoint,rightMidPoint, rightOffset);
			
		}
		
		/* INTERFACE winxalex.fuzzy.IFuzzyMembershipFunction */
		
		public function calculateDOM(value:Number):void
		{
					
			var grad:Number;
			
				
						//between mid points
						   if  (value >= leftMidPoint  && value <=rightMidPoint) 
						  {
							  degreeOfMembership = 1.0;
						  }		
					    else
						{
					  
					  grad = value - leftMidPoint + leftOffset;//value - (leftMidPoint - leftOffset)

						  //find DOM if left of left mid point
						  if ( (value < leftMidPoint) && grad>0 )
						  {
							 
                              
							degreeOfMembership= grad/leftOffset;
						  }

						  //find DOM if right of center
						  else
						  {
							  grad = value-(rightMidPoint + rightOffset);
						  
							  if ( (value > rightMidPoint) && ( grad<0 ) )
							  {
								
                                
								degreeOfMembership= -grad /rightOffset;
							  }
							  

							  //out of range of this FLV, degreeOfMembership= zero
							  else
							  {
								degreeOfMembership= 0.0;
							  }
						  }
						}
		}
		
		public function get averagePoint():Number { return rightMidPoint+(rightMidPoint-leftMidPoint)/2; }
		
		public function set averagePoint(value:Number):void 
		{
			_averagePoint = value;
		}
		
		
		
	}

}