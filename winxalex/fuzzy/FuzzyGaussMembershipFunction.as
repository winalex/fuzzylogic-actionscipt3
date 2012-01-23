package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author ...
	 */
	public class FuzzyGaussMembershipFunction extends FuzzyMembershipFunction 
	{
		//			
		//	f(x)=a*Math.pow(Math.E,-Math.pow((x-b),2)/2*Math.pow(c,2));
		
		//area under is c* Math.Sqrt(Math.PI);
		//e ≈ 2.718281828
		//The parameter a is the height of the curve's peak,  a=1 always in our case
		//b is the position of the centre of the peak, 
		//and c controls the width of the "bell".
		
		private var _width:Number=NaN;
		
		
		public function FuzzyGaussMembershipFunction(linguisticTerm:String, type:String, peekDomain:Number = NaN, width:Number = NaN)
		{
			
			super(linguisticTerm, type, peekDomain - width * 0.5, peekDomain, peekDomain, peekDomain + width * 0.5);
			
			_width = width;
		}
	
		override internal function get maximumDOM():Number 
		{
			return super.maximumDOM;
		}
		
		override internal function set maximumDOM(value:Number):void 
		{
			if (value == super.maximumDOM)
				return;
			
			super.maximumDOM = value;
			
			//all values are reseted including average point 
			if (value == 1)
			return;
			
			//solved by UNKNOWN  => 2 solutions
			// value=Math.pow(Math.E, -Math.pow((UNKNOWN-averageDomain), 2) / (2 * Math.pow(width, 2)));
			
			//CLIPPING
			if (origLeftOffset != 0)
			{
				
				//leftPeekPoint=
				
			}
			
			//CLIPPING
			if (origRightOffset != 0)
			{
				
				//rightPeekPoint=
			}
			
		
		}
		
		override public function recalcBoundaries():void 
		{
			super.recalcBoundaries();
		}
		
		override public function calculateDOM(value:Number):Number 
		{
			degreeOfMembership=levelOfConfidence*Math.pow(Math.E, -Math.pow((value-averageDomain), 2) / (2 * Math.pow(width, 2)));
			
			return degreeOfMembership;
		}
		
	}

}