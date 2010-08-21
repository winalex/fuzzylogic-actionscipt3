package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyMembershipFunction 
	{
		public static const TRIANGLE:uint = 0;
		public static const LEFT_SHOULDER:uint = 1;
		public static const RIGHT_SHOULDER:uint = 2;
		public static const TRAPEZOID:uint = 3;
		public static const QUADRIC:uint = 4;
		public static const SQUARE:uint = 5;
		
		
		
		private var _levelOfConfidence:Number=0;
		private var _degreeOfMembership:Number = 0.0;
		
		
		
		public var linguisticTerm:String;
		public var  rightMidPoint:Number;
		public var  leftOffset:Number;
        public var rightOffset:Number;
		public var leftMidPoint:Number;

		
		
		
		public function FuzzyMembershipFunction(linguisticTerm:String,leftOffset:Number=NaN,leftMidPoint:Number=NaN,rightMidPoint:Number=NaN,rightOffset:Number=NaN,...args) :void
		{
			this.linguisticTerm = linguisticTerm;
			this.rightMidPoint= rightMidPoint;
			this.rightOffset = rightOffset;
			this.leftOffset = leftOffset;
			this.leftMidPoint = leftMidPoint;
		}
		
			
		public function get degreeOfMembership():Number { return _degreeOfMembership; }
		
		public function set degreeOfMembership(value:Number):void 
		{
			_degreeOfMembership = value;
		}
		
		public function get levelOfConfidence():Number { return _levelOfConfidence; }
		
		public function set levelOfConfidence(value:Number):void 
		{
			_levelOfConfidence = value;
		}
		
		public function get maximum():Number { return _maximum; }
		
		public function set maximum(value:Number):void 
		{
			_maximum = value;
		}
		
		
	
		
		public function reset():void
		{
			_degreeOfMembership = 0;
		}
	
		
		public function toString():String 
		{
			
			var s:String = "linguisticTerm=" + linguisticTerm + " DOM:" + _degreeOfMembership +" leftOffset=" + leftOffset+  " leftMidPoint=" + leftMidPoint + " rightMidPoint=" + rightMidPoint + " rightOffset=" + rightOffset;
			return  s;
		}
		
	}

}