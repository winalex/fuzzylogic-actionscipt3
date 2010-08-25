package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class  FuzzyOperator
	{
		public static const NOT:Function = fNOT;
		public static const OR:Function = fOR;
		public static const AND:Function =fAND;
		public static const VERY:Function = fVERY;
		public static const SOMEWHAT:Function = fSOMEWHAT;
		
		  public static function fAND(...args):Number
		{
			var i:int = 1;
			var currentvalue:Number;
			var len:int = args.length;
			var min:Number = args[0].value;
			
			
			for (; i < len; i++)
			{
				currentvalue = args[i].value;
				
				if (currentvalue < min)
				min =currentvalue;
				
			}
			
			return min;
		}
		
		public static function fOR(...args):Number
		{
			var i:int = 1;
			var currentvalue:Number;
			var len:int = args.length;
			var max:Number = args[0].value;//args[0] is Number?args[0]:args[0].value
			
			
			for (; i < len; i++)
			{
				currentvalue = args[i].value;//args[0] is Number?args[0]:args[0].value
								
				if (currentvalue> max)
				max = currentvalue;
				
			}
			
			return max;
		}
		
		public static function fVERY(...args):Number
		{
			var currentvalue:Number = args[0].value;//args[0] is Number?args[0]:args[0].value
				
			return currentvalue*currentvalue;
		}
		
		public static function fSOMEWHAT(...args):Number
		{
			var currentvalue:Number = args[0].value;//args[0] is Number?args[0]:args[0].value
				
			return Math.sqrt(currentvalue);
		}
		
		public static function fNOT(...args):Number
		{
			var currentvalue:Number = args[0].value;//args[0] is Number?args[0]:args[0].value
				
			return 1 - currentvalue;
		}
		
		
		
		
		
	
		}
		
}

