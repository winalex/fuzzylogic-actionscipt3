package winxalex.fuzzy 
{
	
	import winxalex.fuzzy.Token;
	/**
	 * ...
	 * @author alex winx
	 */
	public class  FuzzyOperator
	{
		/*public static const NOT:Function = fNOT;
		public static const MAX:Function = fMAX;
		public static const MIN:Function =fMIN;
		public static const VERY:Function = fVERY;
		public static const SOMEWHAT:Function = fSOMEWHAT;
		public static const PRODUCT:Function = fPRODUCT;
		public static const PROBSUM:Function = fPROBSUM;
		public static const SUM:Function = fSUM;*/
	
		
		
		   /**
		    * 
		    * @param	...args
		    * @return
		    */
		  public static function fMIN(...args):Number
		{
			var i:int = 1;
			var currentvalue:Number;
			var len:int = args.length;
			var min1:Number;
			var min2:Number;
			var pointer1:int;
			var pointer2:int;
			var npoint1:int;
			var npoint2:int;
			var calc1:Number;
			var calc2:Number;
			
			if (len == 2)  return Token(args[0]).value > Token(args[1]).value? Token(args[1]).value:Token(args[0]).value;
			if (len == 3)  return Token(args[0]).value > Token(args[1]).value? (Token(args[1]).value>Token(args[2]).value? Token(args[2]).value:Token(args[1]).value):Token(args[0]).value;
			
			
			pointer1 = 1;
			pointer2 = len - 2;
			
			min1 = Token(args[0]).value;
			min2 = Token(args[len-1]).value;
			
			while (pointer1  <= pointer2)
			{
				
				if (min1 > Token(args[pointer1]).value)
				min1 = Token(args[pointer1]).value;
				
			
				if (pointer1 <pointer2)
				{
				  if (min2 > Token(args[pointer2]).value)
				  min2 = Token(args[pointer2]).value;
				  pointer2 = pointer2 - 1;
				}
				
				
				
				pointer1 = pointer1 + 1;
				
				
				//trace(min1, min2);
				//trace("loop pass");
			  
			}
			
			
					return min1 > min2?min2:min1;
		
			}
		
		
		/**
		 * x*y
		 * @param	...args
		 * @return
		 */
		public static function fPRODUCT(...args):Number
		{
			var i:int = 1;
		
			var len:int = args.length;
			var prod1:Number;
			var prod2:Number;
			var pointer1:int;
			var pointer2:int;
		
			
			if (len == 2)  return Token(args[0]).value * Token(args[1]).value;
			if (len == 3)  return Token(args[0]).value * Token(args[1]).value * Token(args[2]).value ;
			if (len == 4)  return Token(args[0]).value * Token(args[1]).value * Token(args[2]).value * Token(args[3]).value ;
		   //...add more for speed or switch
			
			
			pointer1 = 1;
			pointer2 = len - 2;
			
			prod1 = Token(args[0]).value;
			prod2 = Token(args[len-1]).value;
			
			while (pointer1  <= pointer2)
			{
				
				
				prod1*= Token(args[pointer1]).value;
				
			
				if (pointer1 <pointer2)
				{
				 
				  prod2 *= Token(args[pointer2]).value;
				  pointer2 = pointer2 - 1;
				}
				
				
				
				pointer1 = pointer1 + 1;
				
				
				trace(prod1, prod2);
				//trace("loop pass");
			  
			}
			
			return prod1*prod2;
		}
		
		
		
	   /**
	    * x+y-xy
	    * @param	...args
	    * @return
	    */
		public static function fPROBSUM(...args):Number
		{
			var i:int = 1;
		    var prod1:Number;
			var prod2:Number;
			var pointer1:int;
			var pointer2:int;
			var len:int = args.length;
			
			
			if (len == 2)  return Token(args[0]).value + Token(args[1]).value- Token(args[0]).value * Token(args[1]).value;
			
			
			pointer1 = 1;
			pointer2 = len - 2;
			
			prod1 = Token(args[0]).value;
			prod2 = Token(args[len-1]).value;
			
			while (pointer1  <= pointer2)
			{
				
				
				prod1=prod1 + Token(args[pointer1]).value-prod1*Token(args[pointer1]).value;
				
			
				if (pointer1 <pointer2)
				{
				 
				 prod2=prod2 + Token(args[pointer2]).value-prod2*Token(args[pointer2]).value;
				  pointer2 = pointer2 - 1;
				}
				
				
				
				pointer1 = pointer1 + 1;
				
				
				trace(prod1, prod2);
				//trace("loop pass");
			  
			}
			
			return prod1+prod2-prod1*prod2;
			
		}
		
		
		/**
		 * min(x+y,1)
		 * @param	...args
		 * @return
		 */
		public static function fSUM(...args):Number
		{
			var i:int = 1;
			
			var len:int = args.length;
			var sum1:Number;
			var sum2:Number;
			var pointer1:int;
			var pointer2:int;
		
			
			if (len == 2) 
			{
				sum1=Token(args[0]).value + args[1].value
				return  sum1 > 1? 1: sum1;
			}
			
				if (len == 3)
				{ 
					sum1=Token(args[0]).value + args[1].value+args[2]
					return  sum1> 1? 1: sum1 ;
				}
		
			
			
			pointer1 = 1;
			pointer2 = len - 2;
			
			sum1 = Token(args[0]).value;
			sum2 = Token(args[len-1]).value;
			
			while (pointer1  <= pointer2)
			{
				
				
				sum1 += Token(args[pointer1]).value;
				
				if(sum1 > 1) return 1;
				
			
				if (pointer1 <pointer2)
				{
				 
				  sum2 += Token(args[pointer2]).value;
				  if (sum2 > 1) return 1;
				  pointer2 = pointer2 - 1;
				}
				
				
				
				pointer1 = pointer1 + 1;
				
				
				//trace(sum1, sum2);
				//trace("loop pass");
			  
			}
			sum1 += sum2;
			return sum1>1? 1:sum1;
		}
    
    

    
		
		/**
		 *     max
		* @param	...args
		 * @return
		 */
		public static function fMAX(...args):Number
		{
			var i:int = 1;
			var currentvalue:Number;
			var len:int = args.length;
			var max1:Number;
			var max2:Number;
			var pointer1:int;
			var pointer2:int;
		
			
			if (len == 2)  return Token(args[0]).value < Token(args[1]).value? Token(args[1]).value: Token(args[0]).value;
			if (len == 3)  return Token(args[0]).value < Token(args[1]).value? (Token(args[2]).value < Token(args[1]).value ? Token(args[1]).value:Token(args[2]).value ): Token(args[0]).value>Token(args[2]).value?Token(args[0]).value:Token(args[2]).value ;
			
		   	pointer1 = 1;
			pointer2 = len - 2;
			
			max1 = Token(args[0]).value;
			max2 = Token(args[len-1]).value;
			
			while (pointer1  <= pointer2)
			{
				
				if (max1 < Token(args[pointer1]).value)
				max1 = Token(args[pointer1]).value;
				
			
				if (pointer1 <pointer2)
				{
				  if (max2 < Token(args[pointer2]).value)
				  max2 = Token(args[pointer2]).value;
				  pointer2 = pointer2 - 1;
				}
				
				
				
				pointer1 = pointer1 + 1;
				
				
				//trace(min1, min2);
				//trace("loop pass");
			  
			}
			
			
			return max1>max2?max1:max2;
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

