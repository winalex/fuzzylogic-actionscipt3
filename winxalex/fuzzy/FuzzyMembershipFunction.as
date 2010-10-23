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
		
		
		/**
		 * level of confidence (firing strenght)
		 */
		private var _levelOfConfidence:Number = 0;
		private var _maximumDOM:Number=0;
		private var _degreeOfMembership:Number = 0;
		
		
		
		
		public var linguisticTerm:String;
		
		
		
		
		public var  rightMidPoint:Number;
		public var  leftOffset:Number;
        public var rightOffset:Number;
		public var leftMidPoint:Number;
		public var isScaled:Boolean = false;
		
		
		public var  _rightMidPoint:Number;
		public var  _leftOffset:Number;
        public var _rightOffset:Number;
		public var _leftMidPoint:Number;
		
		public var isLOCReseted:Boolean = false;

		
		
		
		public function FuzzyMembershipFunction(linguisticTerm:String,leftOffset:Number=NaN,leftMidPoint:Number=NaN,rightMidPoint:Number=NaN,rightOffset:Number=NaN,...args) :void
		{
			this.linguisticTerm = linguisticTerm;
			
			_rightMidPoint= rightMidPoint;
			_rightOffset = rightOffset;
			_leftOffset = leftOffset;
			_leftMidPoint = leftMidPoint;
			
			maximumDOM = 1;
		}
		
	
		
		public function reset():void
		{
			maximumDOM = 1;
			
			_degreeOfMembership = 0;
					
			isLOCReseted = false;
			
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
		
		internal function get maximumDOM():Number { return _maximumDOM; }
		internal function set maximumDOM(value:Number):void
		{
			
		    _maximumDOM = value;
			
			
			if (_maximumDOM == 1)//restore
			{
			    this.rightMidPoint= _rightMidPoint;
				this.rightOffset = _rightOffset;
				this.leftOffset = _leftOffset;
				this.leftMidPoint = _leftMidPoint;
			}
		}
		
		
		
		
		
		
		
		
	
	
	
		
		public function toString():String 
		{
			
			var s:String = "linguisticTerm=" + linguisticTerm + " DOM:" + _degreeOfMembership +" LOC="+_levelOfConfidence+" leftOffset=" + leftOffset+  " leftMidPoint=" + leftMidPoint + " rightMidPoint=" + rightMidPoint + " rightOffset=" + rightOffset;
			return  s;
		}
		
	}

}