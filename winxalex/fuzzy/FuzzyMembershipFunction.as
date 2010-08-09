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
		
		
		
		
		private var _degreeOfMembership:Number = 0.0;
		
		public var linguisticQuantifier:String;
		public var   peakPoint:Number;
		public var  leftOffset:Number;
        public var rightOffset:Number;

		
		
		
		public function FuzzyMembershipFunction(linguisticQuantifier:String,peakPoint:Number=NaN,leftOffset:Number=NaN,rightOffset:Number=NaN,...args) :void
		{
			this.linguisticQuantifier = linguisticQuantifier;
			this.peakPoint = peakPoint;
			this.rightOffset = rightOffset;
			this.leftOffset = leftOffset;
		}
		
			
		public function get degreeOfMembership():Number { return _degreeOfMembership; }
		
		public function set degreeOfMembership(value:Number):void 
		{
			_degreeOfMembership = value;
		}
		
		public function reset():void
		{
			_degreeOfMembership = 0;
		}
	
		
		public function toString():String 
		{
			
			var s:String = "linguisticQuantifier=" + linguisticQuantifier + " DOM:"+_degreeOfMembership+  " peakPoint =" + peakPoint + "rightOffset=" + rightOffset +"leftOffset=" + leftOffset;
			return  s;
		}
		
	}

}