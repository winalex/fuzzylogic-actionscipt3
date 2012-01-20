package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyMembershipFunction implements IFuzzyMembershipFunction 
	{
		public static const TRIANGLE:uint = 0;
		public static const LEFT_SHOULDER:uint = 1;
		public static const RIGHT_SHOULDER:uint = 2;
		public static const TRAPEZOID:uint = 3;
	    /*public static const INV_TRAPEZOID:uint = 2;
		public static const RIGHT_TRAPEZOID:uint = 2;
		public static const INV_C_TRAPEZOID:uint = 3;
		public static const LEFT_TRAPEZOID:uint = 4;*/
		
		
		
		/**
		 * level of confidence (firing strenght)
		 */
		private var _levelOfConfidence:Number = 0;
		private var _maximumDOM:Number=0;
		private var _degreeOfMembership:Number = 0;
		
		
		
		
		public var linguisticTerm:String;
		
		
		
		private var _type:String;
		
		public var rightPoint:Number=NaN;
		public var rightMidPoint:Number;
		public var rightOffset:Number;
		
       	public var leftPoint:Number=NaN;
		public var leftMidPoint:Number;
		public var leftOffset:Number;
		
		public var isScaled:Boolean = false;
		
		
		public var  _rightMidPoint:Number;
		public var  _leftOffset:Number;
        public var _rightOffset:Number;
		public var _leftMidPoint:Number;
		
		public var isLOCReseted:Boolean = false;

		//domain value at the middle of function range
		private var _averagePoint:Number = NaN;
		
		private var _maximumPoint:Number=NaN;
		
		
		public function FuzzyMembershipFunction(linguisticTerm:String,type:String,leftPoint:Number=NaN,leftMidPoint:Number=NaN,rightMidPoint:Number=NaN,rightPoint:Number=NaN,...args) :void
		{
			this.linguisticTerm = linguisticTerm;
			this._type = type;
			
			_rightMidPoint= rightMidPoint;
			_rightOffset = rightPoint-rightMidPoint;
			_leftOffset = leftMidPoint-leftPoint;
			_leftMidPoint = leftMidPoint;
			this.leftPoint = leftPoint;
			this.rightPoint = rightPoint;
			
			_maximumPoint = _rightMidPoint;
			
			if(_rightMidPoint!=leftMidPoint)
				_averagePoint = leftMidPoint + (rightMidPoint - leftMidPoint) * 0.5
			else
			   _averagePoint = leftMidPoint;
			
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
		
		public function calculateDOM(value:Number,clipping:Boolean=false):Number
		{
			throw new Error("Should be overrided");
			return 0;
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
		
		public function get averagePoint():Number { return _averagePoint; }
		
		public function set averagePoint(value:Number):void 
		{
			value = _averagePoint;
		}
		
		public function get maximumPoint():Number {  return _maximumPoint;  }
		
		public function set maximumPoint(value:Number):void
		{
			_maximumPoint = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		
		
		
		
		
		
		
	
	
	
		
		public function toString():String 
		{
			
			var s:String = "linguisticTerm=" + linguisticTerm + " DOM:" + _degreeOfMembership +" LOC="+_levelOfConfidence+" leftPoint=" + leftPoint+  " leftMidPoint=" + leftMidPoint + " rightMidPoint=" + rightMidPoint + " rightPoint=" + rightPoint+" >OFFSETS: rightOffset:"+rightOffset+" leftOffset:"+leftOffset;
			return  s;
		}
		
	}

}