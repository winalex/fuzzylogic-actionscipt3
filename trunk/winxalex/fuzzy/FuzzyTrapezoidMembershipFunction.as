package winxalex.fuzzy
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
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
				degreeOfMembership = levelOfConfidence; // levelOfConfidence;
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
			
			if (isScaled)
				return; //NO clipping
			
			//CLIPPING
			if (origLeftOffset != 0)
			{
				
				newOffset = levelOfConfidence * origLeftOffset;
				leftPeekPoint.x = origLeftDomain - origLeftOffset + newOffset;
				
				leftOffset = newOffset;
				
			}
			
			leftPeekPoint.y = levelOfConfidence;
			
			//CLIPPING
			if (origRightOffset != 0)
			{
				newOffset = levelOfConfidence * origRightOffset;
				rightPeekPoint.x = origRightDomain + origRightOffset - newOffset;
				
				rightOffset = newOffset;
				
			}
			
			rightPeekPoint.y = levelOfConfidence;
			
			//in non simetrical triangles(_rightOffset!=_leftOffset);
			if (rightPeekPoint.x != leftPeekPoint.x)
			{
				this.averageDomain = leftPeekPoint.x + (rightPeekPoint.x - leftPeekPoint.x) * 0.5; // / 2;
			}
		}
		
		/*override public function area():Number
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
		 }*/
		
		/**
		 * fill cut area (show DOM);
		 * @param	container
		 * @param	scaleX
		 * @param	scaleY
		 */
		override public function fillArea(container:Graphics, scaleX:uint = 1, scaleY:uint = 50):void
		{
			if (!degreeOfMembership && !levelOfConfidence)
				return;
			
			container.lineStyle(2, 0, 0);
			container.beginFill(0xFF00FF);
			
			container.drawPath(Vector.<int>([1, 2, 2, 2]), Vector.<Number>([leftPoint.x * scaleX, -leftPoint.y * scaleY, leftPeekPoint.x * scaleX, -leftPeekPoint.y * scaleY, rightPeekPoint.x * scaleX, -rightPeekPoint.y * scaleY, rightPoint.x * scaleX, -rightPoint.y * scaleY]));
			
			container.endFill();
		}
		
		/**
		 * drawing function in designated container
		 * @param	container
		 * @param	scaleX
		 * @param	scaleY
		 */
		override public function draw(container:Graphics, scaleX:uint = 1, scaleY:uint = 50):void
		{
			
			container.lineStyle(2);
			
			container.drawPath(Vector.<int>([1, 2, 2, 2]), Vector.<Number>([leftPoint.x * scaleX, -leftPoint.y * scaleY, leftPeekPoint.x * scaleX, -leftPeekPoint.y * scaleY, rightPeekPoint.x * scaleX, -rightPeekPoint.y * scaleY, rightPoint.x * scaleX, -rightPoint.y * scaleY]));
		}
		
		override public function get maximumDomain():Number
		{
			if (areBoundariesDIRTY)
			recalcBoundaries();
			
			return averageDomain;
		}
	
	}

}