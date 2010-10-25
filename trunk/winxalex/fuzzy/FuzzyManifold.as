package winxalex.fuzzy 
{
	
	
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyManifold//FuzzySurface
	{
		public var name:String;
		public var memberfunctions:AssociativeArray;
		public var maxRange:Number = Number.MIN_VALUE;
		public var minRange:Number = Number.MAX_VALUE;
		
		
		public var input:FuzzyInput;
		private var _output:Number ;
		
	    private var _fuzzificator:Fuzzificator = null;
		
		public function FuzzyManifold(name:String) 
		{
			this.name = name;
			memberfunctions = new AssociativeArray();// Array();
		}
		
		
		/******************************************
		 * 						 getMaxDOM
		 * @param	input
		 * @return
		 ******************************************/
		public function getMaxDOM(input:Number):Number
		{
			//same principal as in fMax
		/*	func = FuzzyMembershipFunction( ifunc);						
								  func.maximumDOM = func.levelOfConfidence;
								   currentDOM = ifunc.calculateDOM(input);
									if (max < currentDOM) max = currentDOM;
									 func.reset();*/
									 
			var len:int = memberfunctions.length;
			var max1:Number;
			var max2:Number;
			var max3:Number;
			var pointer1:int;
			var pointer2:int;
			
			if (len == 2)
			{
				max1 = IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input,true);
				max2 = IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input,true);
				
				return max1 > max2? max1 : max2;
			}
			if (len == 3)
			{
				max1 = IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input,true);
				max2 = IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input,true);
				max3 = IFuzzyMembershipFunction(memberfunctions[2]).calculateDOM(input, true);
				
				//trace(max1, max2, max3);
				
				return max1 > max2 ? max1 > max3? max1:max3 :max2 > max3 ? max2 : max3 ;
			}
			
			
			pointer1 = 1;
			pointer2 = len - 2;
			
			max1 =  IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input,true);
			max2 = IFuzzyMembershipFunction(memberfunctions[len-1]).calculateDOM(input,true);
			
			while (pointer1  <= pointer2)
			{
				
				if (max1 <  IFuzzyMembershipFunction(memberfunctions[pointer1]).calculateDOM(input,true))
				max1 = FuzzyMembershipFunction(memberfunctions[pointer1]).degreeOfMembership;
				
			
				if (pointer1 <pointer2)
				{
				  if (max2 < IFuzzyMembershipFunction(memberfunctions[pointer2]).calculateDOM(input,true))
				  max2 = FuzzyMembershipFunction(memberfunctions[pointer2]).degreeOfMembership;
				  pointer2 = pointer2 - 1;
				}
				
				
				
				pointer1 = pointer1 + 1;
				
				
				//trace(max1, max2);
				//trace("loop pass");
			  
			}
			
		return max1>max2?max1:max2;
									 
									 
	
		}
		
		/******************************************
		 * 			 getSumDom(input:Number)
		 * @param	input
		 * @return
		 ******************************************/
		public  function getSumDOM(input:Number):Number
		{
			//same principal as in fSum
			
					/*func = FuzzyMembershipFunction( ifunc);
							    func.maximumDOM =  func.levelOfConfidence;
								sumDOMs += ifunc.calculateDOM(input);
								  func.reset();*/
			var len:int = memberfunctions.length;
			var pointer1:int;
			var pointer2:int;
			var sum1:Number;
			var sum2:Number;
			
			if (len == 2) return IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input,true)+ IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input,true)
			if (len == 3)	return  IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input,true) + IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input,true) + IFuzzyMembershipFunction(memberfunctions[2]).calculateDOM(input,true);	  
			if (len == 4) return IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input,true) + IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input,true) + IFuzzyMembershipFunction(memberfunctions[2]).calculateDOM(input,true) + IFuzzyMembershipFunction(memberfunctions[3]).calculateDOM(input,true);	
			
			//TODO test sum of 5 and more
			pointer1 = 1;
			pointer2 = len - 2;
			
			sum1 = IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input,true);// Token(args[0]).value;
			sum2 = IFuzzyMembershipFunction(memberfunctions[len - 1]).calculateDOM(input,true);// Token(args[len - 1]).value;
			
			while (pointer1  <= pointer2)
			{
				
				
				sum1 += IFuzzyMembershipFunction(memberfunctions[pointer1]).calculateDOM(input,true);// Token(args[pointer1]).value;
				
				if(sum1 > 1) return 1;
				
			
				if (pointer1 <pointer2)
				{
				 
				  sum2 +=  IFuzzyMembershipFunction(memberfunctions[pointer2]).calculateDOM(input,true);//Token(args[pointer2]).value;
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
		
		
		public function getMOM():Number
		{
			
				/*for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
									func = FuzzyMembershipFunction( ifunc);
								   func.maximumDOM =   func.levelOfConfidence;
								 
								 trace(func.maximumDOM);
								  
								if (ifunc.maximumPoint > max)
								{
								max = ifunc.maximumPoint;
								avg = ifunc.averagePoint;
								}
								
								
								// func.reset();
								
							}*/
			
			var len:int = memberfunctions.length;
			var max1:Number;
			var max2:Number;
			var max3:Number;
			
			var pointer1:int;
			var pointer2:int;
			
			
			var func1:IFuzzyMembershipFunction;
			var func2:IFuzzyMembershipFunction;
			var func3:IFuzzyMembershipFunction;
			
			
			if (len == 2)
			{
				
			
			   max1 =  FuzzyMembershipFunction(memberfunctions[0]).levelOfConfidence;
			  FuzzyMembershipFunction(memberfunctions[0]).maximumDOM = max1;
			
			    max2 =  FuzzyMembershipFunction(memberfunctions[1]).levelOfConfidence;
				 FuzzyMembershipFunction(memberfunctions[1]).maximumDOM = max2;
					
				return max1 > max2? IFuzzyMembershipFunction(memberfunctions[0]).averagePoint:IFuzzyMembershipFunction(memberfunctions[1]).averagePoint;
			}
			
			
			if (len == 3)
			{
				
					
			    max1 = FuzzyMembershipFunction(memberfunctions[0]).levelOfConfidence;
			   FuzzyMembershipFunction(memberfunctions[0]).maximumDOM = max1;
			
			   
			    max2 = FuzzyMembershipFunction(memberfunctions[1]).levelOfConfidence;
				 FuzzyMembershipFunction(memberfunctions[1]).maximumDOM = max2;
				
			    max3 =  FuzzyMembershipFunction(memberfunctions[2]).levelOfConfidence;
				 FuzzyMembershipFunction(memberfunctions[2]).maximumDOM = max3;
			
								
				return max1 > max2? (max1>max3? IFuzzyMembershipFunction(memberfunctions[0]).averagePoint: IFuzzyMembershipFunction(memberfunctions[2]).averagePoint)     :        (max2 > max3?IFuzzyMembershipFunction(memberfunctions[1]).averagePoint:IFuzzyMembershipFunction(memberfunctions[2]).averagePoint);
			}
			
			
			
			//TODO make and test MOM for 4 and more functions
			throw(new Error(" MOM for 4 and more not yet implemented"));
			
			return NaN;
			
	
		}
		
		
		public function getMaxAv():Number
		{
				
						/*	for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								func = FuzzyMembershipFunction( ifunc);
								if(func.maximumDOM<1)
								 func.maximumDOM = 1;//it is reset
								
								sumAvgMulLOC+= ifunc.maximumPoint *func.levelOfConfidence;
								
								sumLOC += func.levelOfConfidence;
								
							
							}*/
							
			var len:int = memberfunctions.length;
			var func1:FuzzyMembershipFunction;
			var func2:FuzzyMembershipFunction;
			var func3:FuzzyMembershipFunction;
			var func4:FuzzyMembershipFunction;
			
			if (len == 2)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				
				return (func1.levelOfConfidence * IFuzzyMembershipFunction(func1).maximumPoint + func2.levelOfConfidence * IFuzzyMembershipFunction(func2).maximumPoint) / (func1.levelOfConfidence + func2.levelOfConfidence);
			
				
			}
			
			
			if (len == 3)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				func3=FuzzyMembershipFunction(memberfunctions[2]);
				
					return (func1.levelOfConfidence * IFuzzyMembershipFunction(func1).maximumPoint + func2.levelOfConfidence * IFuzzyMembershipFunction(func2).maximumPoint+func3.levelOfConfidence*IFuzzyMembershipFunction(func3).maximumPoint) / (func1.levelOfConfidence + func2.levelOfConfidence+func3.levelOfConfidence);
			}
			
			if (len == 4)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				func3 = FuzzyMembershipFunction(memberfunctions[2]);
				func4 = FuzzyMembershipFunction(memberfunctions[3]);
				
					return (func1.levelOfConfidence * IFuzzyMembershipFunction(func1).maximumPoint + func2.levelOfConfidence * IFuzzyMembershipFunction(func2).maximumPoint+func3.levelOfConfidence*IFuzzyMembershipFunction(func3).maximumPoint+func4.levelOfConfidence*IFuzzyMembershipFunction(func4).maximumPoint) / (func1.levelOfConfidence + func2.levelOfConfidence+func3.levelOfConfidence+func4.levelOfConfidence);
			
			}
			
			///TODO implement for more then 4 functions
			throw(new Error("For more then 5 function not yet implemented"));
			
			
		}
		
		public function getMaxDOMFunc(input:Number):FuzzyMembershipFunction
		{
			var len:int = memberfunctions.length;
			var max1:Number;
			var max2:Number;
			var max3:Number;
			
			var pointer1:int;
			var pointer2:int;
			
			
			var func1:IFuzzyMembershipFunction;
			var func2:IFuzzyMembershipFunction;
			var func3:IFuzzyMembershipFunction;
			
	
			
			if (len == 2)
			{
				
			
			   max1 =  IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input);
			
			
			    max2 =  IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input);
					
				return max1 > max2? memberfunctions[0]:memberfunctions[1];
			}
			if (len == 3)
			{
				
					
			    max1 = IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input);
			
			
			   
			    max2 =IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input);
				
				
			    max3 =  IFuzzyMembershipFunction(memberfunctions[2]).calculateDOM(input);
			
								
				return max1 > max2? (max1 > max3? FuzzyMembershipFunction(memberfunctions[0]): FuzzyMembershipFunction(memberfunctions[2]) )     :    (max2 > max3? FuzzyMembershipFunction(memberfunctions[1]):FuzzyMembershipFunction(memberfunctions[2]));
			}
			
			//TODO Test for more then 3 function
			pointer1 = 1;
			pointer2 = len - 2;
			
			func1 = IFuzzyMembershipFunction(memberfunctions[0]);
			max1 = func1.calculateDOM(input,true);
			
			
			func2=IFuzzyMembershipFunction(memberfunctions[len - 1]);
			max2 = func2.calculateDOM(input,true);
			
			while (pointer1  <= pointer2)
			{
				
				
				if (max1 <  IFuzzyMembershipFunction(memberfunctions[pointer1]).calculateDOM(input,true))
				{
				func1 = memberfunctions[pointer1];
				max1 = FuzzyMembershipFunction(func1).degreeOfMembership;
				
				}
				
			
				if (pointer1 <pointer2)
				{
					
				  if (max2 < IFuzzyMembershipFunction(memberfunctions[pointer2]).calculateDOM(input,true))
				  {
					  func2 = memberfunctions[pointer2];
					  max2 = FuzzyMembershipFunction(func2).degreeOfMembership;
				  }
				  
				  
				  pointer2 = pointer2 - 1;
				}
				
				
				
				pointer1 = pointer1 + 1;
				
				
				//trace(max1, max2);
				//trace("loop pass");
			  
			}
			
			
			return max1>max2?FuzzyMembershipFunction(func1):FuzzyMembershipFunction(func2);
			
			
				
		}
	
		
		public function addMember(func:FuzzyMembershipFunction):void
		{
			memberfunctions[func.linguisticTerm] = func;
			//memberfunctions.length = memberfunctions.length + 1;
			
			if (func.leftMidPoint-func.leftOffset < minRange)
			minRange = func.leftMidPoint-func.leftOffset;
			
			if (func.rightMidPoint+func.rightOffset > maxRange)
			maxRange = func.rightMidPoint+func.rightOffset;
			
			trace("Membership function <" + func.linguisticTerm + "> added to manifold {" + this.name+"} range["+minRange+","+maxRange+"]");
			
		}
		
		
		
		/*************************
		 *    			FUZZIFY
		 *************************/
		internal function Fuzzify():void
		{
		
			if (memberfunctions.length > 0)
			{
				
				
				if (input.value<=maxRange && input.value>=minRange)
				{
								 
					  for each (var func:IFuzzyMembershipFunction in  this.memberfunctions)
					  {
						    func.reset();
							func.calculateDOM(input.value);
							trace(this.name,FuzzyMembershipFunction(func).linguisticTerm,FuzzyMembershipFunction(func).degreeOfMembership);
					  }
				}
				else
				throw new Error("value :"+input.value+" out of range");
			}
			else
			{
				throw new Error("no membership function involved in manifold <"+this.name+">");
			}
		}
		
		
		/**************************
		 * 
		 * @return
		 **************************/
		public function toString():String
		{
			var s:String = "";
			
			 for each (var func:IFuzzyMembershipFunction in  this.memberfunctions)
					  {
						  
						  s += func.toString()+"\n";
							
					  }
					  
					  return s;
		}
		
		public function reset():void
		{
			 for each (var func:IFuzzyMembershipFunction in  this.memberfunctions)
					  {
						  
							func.reset();
							
					  }
		}
		
		public function get output():Number { return _output; }
		
		public function set output(value:Number):void 
		{
			_output = value;
		}
		
	}

}