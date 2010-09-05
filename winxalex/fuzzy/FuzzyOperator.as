package winxalex.fuzzy 
{
	
	import winxalex.fuzzy.Token;
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
			var min:Number = Token(args[0]).value;
			
			if (len == 2)  return min > Token(args[1]).value? Token(args[1]).value:min;
			
			for (; i < len; i++)
			{
				currentvalue = Token(args[i]).value;
				
				if (currentvalue < min)
				min =currentvalue;
				
			}
			
			return min;
		}
		
		
		public static function fPRODUCT(...args):Number
		{
			var i:int = 1;
			var currentvalue:Number=Token(args[0]).value;
			var len:int = args.length;
		
			
			if (len == 2)  return currentvalue * Token(args[1]).value;
			if (len == 3)  return currentvalue* Token(args[1]).value*Token(args[2]).value ;
			
			for (; i < len; i++)
			{
				currentvalue *= Token(args[i]).value;
				
				
			}
			
			return currentvalue;
		}
		
		
		
	   /**
	    * x+y-xy
	    * @param	...args
	    * @return
	    */
		public static function fPROBOR(...args):Number
		{
			var i:int = 1;
		
			var len:int = args.length;
			var currentvalue:Number = Token(args[0]).value;//args[0] is Number?args[0]:args[0].value
			
			if (len == 2)  return currentvalue + Token(args[1]).value-currentvalue * Token(args[1]).value;
			
			
			for (; i < len; i++)
			{
				currentvalue = currentvalue + Token(args[i]).value-currentvalue * Token(args[i]).value;
				
			}
			
			return currentvalue;
			
		}
		
		public static function fSUM(...args):Number
		{
			var i:int = 1;
			
			var len:int = args.length;
			var currentvalue:Number =Token(args[0]).value;//args[0] is Number?args[0]:args[0].value
			
			if (len == 2)  return currentvalue + args[1].value > 1? 1: currentvalue + args[1].value;
			
			
			for (; i < len; i++)
			{
				currentvalue+= Token(args[i]).value;
								
				
				
			}
			
			return currentvalue>1 ? 1:currentvalue;
		}
    
    

    
		
		/**
		 *     *
		* @param	...args
		 * @return
		 */
		public static function fOR(...args):Number
		{
			var i:int = 1;
			var currentvalue:Number;
			var len:int = args.length;
			var max:Number = Token(args[0]).value;//args[0] is Number?args[0]:args[0].value
			
			if (len == 2)  return max < Token(args[1]).value? Token(args[1]).value:max;
			
			
			for (; i < len; i++)
			{
				currentvalue = Token(args[i]).value;//args[0] is Number?args[0]:args[0].value
								
				if (currentvalue> max)
				max = currentvalue;
				
			}
			
			return max;
		}
		
		public static function fVERY(...args):Number
		{
			var currentvalue:Number = Token(args[0]).value;//args[0] is Number?args[0]:args[0].value
				
			return currentvalue*currentvalue;
		}
		
		public static function fSOMEWHAT(...args):Number
		{
			var currentvalue:Number = Token(args[0]).value;//args[0] is Number?args[0]:args[0].value
				
			return Math.sqrt(currentvalue);
		}
		
		public static function fNOT(...args):Number
		{
			var currentvalue:Number = Token(args[0]).value;//args[0] is Number?args[0]:args[0].value
				
			return 1 - currentvalue;
		}
		
		
		
		
		
	
		}
		
}
