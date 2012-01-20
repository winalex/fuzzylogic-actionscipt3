package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyTrapezoidMembershipFunction extends FuzzyMembershipFunction// implements IFuzzyMembershipFunction
	{
		
		
		
	
		
	
		
		
		public function FuzzyTrapezoidMembershipFunction(linguisticTerm:String,type:String, leftPoint:Number = NaN,leftMidPoint:Number = NaN,rightMidPoint:Number=NaN, rightPoint:Number = NaN, ...args) 
		{
					
			super(linguisticTerm,type, leftPoint, leftMidPoint,rightMidPoint, rightPoint);
			
		}
		
		
		
		/* INTERFACE winxalex.fuzzy.IFuzzyMembershipFunction */
		
		override public function calculateDOM(value:Number,clipping:Boolean=false):Number
		{
					
			var grad:Number;
			
			if (clipping)
			{
						maximumDOM = levelOfConfidence;
			}
			
		
			  
			    
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
		
		override internal function get maximumDOM():Number { return super.maximumDOM; }
		
		override internal function set maximumDOM(value:Number):void 
		{
			
			var newOffset:Number;
			
			if (value == super.maximumDOM) return;
			
			super.maximumDOM = value; 
			
			
			
			if (super.maximumDOM == 1)//restore
			{
				
			   /* 
				this.rightMidPoint= _rightMidPoint;
				this.rightOffset = _rightOffset;
				this.leftOffset = _leftOffset;
				this.leftMidPoint = _leftMidPoint;
				*/
				
				
				//in non simetrical triangles (_rightOffset!=_leftOffset)
				if (_rightOffset != _leftOffset)
			   	this.averagePoint = leftMidPoint + (rightMidPoint - leftMidPoint) * 0.5;// / 2;
				//this.maximumPoint = this.averagePoint ;// leftMidPoint + (rightMidPoint - leftMidPoint) / 2;
			    return;
			}
			
			
			
			//not have meaning if value!=1
			this.maximumPoint = NaN;
			
		    if (isScaled) return;//NO clipping
			
		
			
			//CLIPPING
			if (_leftOffset != 0 )
			{
			
				newOffset =  super.maximumDOM * _leftOffset;
				leftMidPoint = _leftMidPoint - _leftOffset + newOffset;
				leftOffset = newOffset;
				
			}
			
			//CLIPPING
			if (_rightOffset != 0)
			{
			
				newOffset =  super.maximumDOM * _rightOffset;
				rightMidPoint = _rightMidPoint + _rightOffset - newOffset;
				rightOffset = newOffset;
				maximumPoint = rightMidPoint;
			}
			
			
			//in non simetrical triangles(_rightOffset!=_leftOffset);
			if (_rightOffset != _leftOffset)
			this.averagePoint = leftMidPoint + (rightMidPoint - leftMidPoint) * 0.5;// / 2;
		}
		
	
	
		
		override public function get maximumPoint():Number { return super.maximumPoint;  }
		
		override public function set maximumPoint(value:Number):void
		{
			value = super.maximumPoint;
		}
		
		
		
	}

}