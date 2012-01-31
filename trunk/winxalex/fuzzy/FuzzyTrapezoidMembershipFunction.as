package winxalex.fuzzy
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyTrapezoidMembershipFunction extends FuzzyMembershipFunction // implements IFuzzyMembershipFunction
	{
		
		public function FuzzyTrapezoidMembershipFunction(linguisticTerm:String, type:String, leftDomain:Number = NaN, leftPeekDomain:Number = NaN, rightPeekDomain:Number = NaN, rightDomain:Number = NaN, ... args)
		{
			
			super(linguisticTerm, type, leftDomain, leftPeekDomain, rightPeekDomain, rightDomain);
		
		}
		
		/* INTERFACE winxalex.fuzzy.IFuzzyMembershipFunction */
		
		override public function calculateDOM(value:Number):Number
		{
			
			var grad:Number;
			
			super.calculateDOM(value);
			
			//between mid points
			if (value >= leftPeekPoint.x && value <= rightPeekPoint.x)
			{
				degreeOfMembership = levelOfConfidence;
			}
			else
			{ //  //find DOM if left of center
				
				grad = value - leftPeekPoint.x + leftOffset; //value - (leftMidPoint - leftOffset)
				
				//find DOM if left of left mid point
				if ((value < leftPeekPoint.x) && grad > 0)
				{
					
					degreeOfMembership = grad * levelOfConfidence / leftOffset;
				}
				
				else //find DOM if right of center
				{
					grad = (rightPeekPoint.x + rightOffset) - value;
					
					if ((value > rightPeekPoint.x) && (grad > 0))
					{
						
						degreeOfMembership = grad * levelOfConfidence / rightOffset;
					}
					else //out of range of this FLV, degreeOfMembership= zero
					{
						degreeOfMembership = 0;
					}
				}
			}
			
			return degreeOfMembership;
		}
		
		override public function recalcBoundaries():void
		{
			var newOffset:Number;
			
			areBoundariesDIRTY = false;
			
			
			
			if (levelOfConfidence == 1)
			{
				super.recalcBoundaries();
				return;
			}
			
			if (isScaled)
				return; //NO clipping
			
			//CLIPPING
			if (origLeftOffset != 0)
			{
				
				newOffset = levelOfConfidence * origLeftOffset;
				leftPeekPoint.x = origLeftDomain - origLeftOffset + newOffset;
				leftPeekPoint.y = levelOfConfidence;
				leftOffset = newOffset;
				
			}
			
			//CLIPPING
			if (origRightOffset != 0)
			{
				newOffset = levelOfConfidence * origRightOffset;
				rightPeekPoint.x = origRightDomain + origRightOffset - newOffset;
				rightPeekPoint.y = levelOfConfidence;
				rightOffset = newOffset;
				
			}
			
			//in non simetrical triangles(_rightOffset!=_leftOffset);
			if (rightPeekPoint.x != leftPeekPoint.x)
			{
				this.averageDomain = leftPeekPoint.x + (rightPeekPoint.x - leftPeekPoint.x) * 0.5; // / 2;
			}
		}
		
	
		override public function area():Number 
		{
			var areaSize:Number = 0;
			var value:Number = 0;
			
			
			if (leftPoint.x != leftPeekPoint.x)
			{
				//Math.abs((a.getX()-c.getX())*(b.getY()-a.getY())-(a.getX()-b.getX())*(c.getY()-a.getY()))*0.5;
				//a.y=0 b.y=0
				value= (leftPoint.x - leftPeekPoint.x) * ( -leftPoint.x) * (leftPoint.x - leftPeekPoint.x) * (leftPeekPoint.y) * 0.5;
				if (value < 0) 
					areaSize = -value;
				else
				   areaSize = value;
			}
			
			
			
			if (leftPeekPoint.x != rightPeekPoint.x) {
				value = (leftPeekPoint.x - rightPeekPoint.x) * (leftPeekPoint.y - rightPeekPoint.y);
				if (value < 0) 
					areaSize += -value;
				else
					areaSize += value;
			}
			
			
			return areaSize;
		}
		
		override public function get maximumDomain():Number
		{
			return averageDomain;
		}
	
	}

}