package winxalex.fuzzy 
{
	
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author alex winx
	 * 
	 * 
	 * 
	 * 
	 * 
	 */
	public  class Fuzzificator
	{
		
	 //a map of all the fuzzy variables this module uses
     internal var inputFuzzymanifolds:Dictionary;
	 internal var outputFuzzyManifolds:Dictionary;
  
	 
	 /**
	  * default MIN, other popular PRODUCT,... see FuzzyOperator for other options
	  */
	 public var implication:Function = FuzzyOperator.fMIN;//implication, activation
	 
	 /**
	  *  default MAX, other popular SUM, PROBSUM
	  */
     public var aggregation:Function =FuzzyOperator.fMAX ;//combination
    
	 /**
	  *     default MIN, other popular PRODUCT
	  */
	 public var AND:Function =FuzzyOperator.fMIN;
	 
	 /**
	  *  default MAX, other popular SUM
	  */
	 public var OR:Function = FuzzyOperator.fMAX;
    
	


  //a list containing all the fuzzy rules
  private var fuzzyRules:SLinkedList;
  
		
		
		public function Fuzzificator() 
		{
			inputFuzzymanifolds = new Dictionary(true);
			outputFuzzyManifolds = new Dictionary(true);
			fuzzyRules = new SLinkedList();
		
		}
		
		public function addManifold(manifold:FuzzyManifold):void
		{
			if(manifold.input)
				inputFuzzymanifolds[manifold.name] = manifold;
			else
				outputFuzzyManifolds[manifold.name] = manifold;
			
		}
		
		public function getManifold(name:String):FuzzyManifold
		{
			var manifold:FuzzyManifold;
			manifold = inputFuzzymanifolds[name];
			if(!manifold)
			manifold=outputFuzzyManifolds[name];
			
			return manifold;
		}
	
		
		
	   //adds a rule to the fazificator
		public function addRule(rule:FuzzyRule):void
		{
			fuzzyRules.append(rule);
			rule.compile(this);
			
		}
		
		/**
		 *  simple Comb, additivly separable or inseparable
		 */
		public function reduce():void
		{
			//var  termsMatches:RegExp;
			//var fm:FuzzyManifold;
			//var inputMatches:Array;
			//var outputMatches:Array;
			//var currentMatch:String;
			//var i:int = 0;
			//var node:SListNode;
			//var rule:FuzzyRule;
			//var membershipName:String;
			//var manifoldName:String;
			//var fm:FuzzyManifold;
			//var func:IFuzzyMembershipFunction;
			//var manifoldRegExp:RegExp=/^(\w+)/gi;
			//var membershipRegExp:RegExp = /(\w+)$/gi;
			//var rules:SLinkedList;
			//var numNewRules:int=0;
			//
			//[p then (r and s)] is equivalent to [(p then r) and (p then s)] (5)
			//numRules = fuzzyRules.size;
			//
			//termsMatches =/\w+\s+IS\s+(NOT\s+)?((VERY|SOMEWHAT)\s+)?\w+/ig;
			//
			//node = fuzzyRules.head;
			//
			//while(node!=fuzzyRules.tail)
				//{
					//rule = FuzzyRule(node.data);
						//
				        //inputMatches = rule.antecedent.match(termsMatches);
						//
						//outputMatches=rule.consequence.match(termsMatches);
						//
						//
						//for (i = 0; i < inputMatches.length; i++)
						//{
							//currentMatch = inputMatches[i];
							//
							//membershipName = currentMatch.match(membershipRegExp)[0];
							//manifoldName = currentMatch(manifoldRegExp)[0];
							//
							//fm = FuzzyManifold(inputFuzzymanifolds[manifoldName]);
							//func = FuzzyMembershipFunction(fm[membershipName]);
							//
							//currentMatch = outputMatches[0];
							//membershipName.currentMatch.match (membershipRegExp)[0];
							//manifoldName = currentMatch(manifoldRegExp)[0];
							//fm = FuzzyManifold(outputFuzzyManifolds[manifoldName]);
							//
							//func.tendence += IFuzzyMembershipFunction(fm[membershipName]).averagePoint
							//func.numTendences++;
							//func.currentMatch
							//func.data.tendence
							//func.data.
							//
							//
						//}
						//
					//node = node.next;
				//}
				//
				//
				//node = fuzzyRules.head;
				//for each(fm in inputFuzzymanifolds)
				//{
					//for each(func in fm.memberfunctions)
					//{
					   //rule = node.data;
					   //rule.antecedent=
					   //node = node.next;
					   //
					   //numNewRules++;
					//}
				//}
				//
				//memberfunctions.length
				//while (fuzzyRules.size != numNewRules)
				//{
					//fuzzyRules.removeTail();
				//}
	
		}
		
		
		
		public function Fuzzify():void
		{
			var fm:FuzzyManifold;
			var ouputManifolds:Vector.<FuzzyManifold> = new Vector.<FuzzyManifold>;
			var node:SListNode;
			var rule:FuzzyRule;
			
			for each (fm in inputFuzzymanifolds)
			{
				
				fm.Fuzzify();//calculate DOM
				
			}
			
			//evaluate rules
			//for each(var rule:FuzzyRule in fuzzyRules)
			node = fuzzyRules.head;
			while(node!=fuzzyRules.tail)
			{
				rule = FuzzyRule(node.data);
				rule.reset();
				rule.evaluate();
				node = node.next;
			}
			
		
			
			
		}
		
		public function Defuzzify(method:uint,...args):Dictionary
		{
			//loop thru all manifolds that don't have inputs they are outputs
			switch(method)
			{
				case DefuzzificationMethod.CENTAR_OF_SUM:
				if(args[0])
				CoS(outputFuzzyManifolds,args[0]);
				else
				CoS(outputFuzzyManifolds);
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod. AVERAGE_OF_MAXIMA:
				AVMAX(outputFuzzyManifolds);
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod.MEAN_OF_MAXIMUM:
				MoM(outputFuzzyManifolds);
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod.CENTER_OF_AREA_CENTROID:
				if(args[0])
				CoA(outputFuzzyManifolds,args[0]);
				else
				CoA(outputFuzzyManifolds);
				return outputFuzzyManifolds;
				break;
				
			}
			
			
			throw new Error("Not supported Defuzzificaiton Method");
		}
		
		
		private static function MoM(outputFuzzyManifolds:Dictionary):void
		{
		    var fm:FuzzyManifold;
			
			var max:Number = 0;
			var avg:Number;
			var func:FuzzyMembershipFunction;
			
			for each (fm in outputFuzzyManifolds)
			{
				
				
							
							for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
									func = FuzzyMembershipFunction( ifunc);
								   func.maximumDOM =   func.levelOfConfidence;
								  
								if (ifunc.maximumPoint > max)
								{
								max = ifunc.maximumPoint;
								avg = ifunc.averagePoint;
								}
								
								
								 func.reset();
								
							}
							
							
							fm.output = avg;
			}
		}
		
		
		private static function CoA(outputFuzzyManifolds:Dictionary,step:Number = 0.1):void
		{
			var input:int = 0;
			var fm:FuzzyManifold;
			var currentDOM:Number;
			var delta:Number;
			var i:int;
			
			var s2:Number=0;
			var s1:Number=0;
			var max:Number = 0;
			var func:FuzzyMembershipFunction;
			var stepBoundary:Number = step * 100;
			
			for each (fm in outputFuzzyManifolds)
			{
				s1 = 0;
				s2 = 0;
				
				
				 
						//get delta
						delta = (fm.maxRange-fm.minRange) * step;
						input = fm.minRange+delta;
						
						for (i=1; i<=stepBoundary; i++)
						{
							
							
							max = 0;
							
							for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								func = FuzzyMembershipFunction( ifunc);						
								  func.maximumDOM = func.levelOfConfidence;
								   currentDOM = ifunc.calculateDOM(input);
									if (max < currentDOM) max = currentDOM;
									 func.reset();
								
								
							}
							
						
							
							s1 += input * max;
							s2 += max;
							
							input = input + delta;
						}
				
				
				
				fm.output = s1 / s2;
				
			}
		}
		
		
	/*	private function todoX(step:Number = 10)
		{
			var input:int = 0;
			var fm:FuzzyManifold;
			var currentDOM:Number;
			var delta:Number;
			var i:int;
			
			var s2:Number=0;
			var s1:Number=0;
			var sumDOMs:Number = 0;//for input
			var func:FuzzyMembershipFunction;
			
			for each (fm in outputFuzzyManifolds)
			{
				s1 = 0;
				s2 = 0;
				
				
				 
						//get delta
						delta = (fm.maxRange-fm.minRange) / step;
						input = fm.minRange+delta;
						
						for (i=1; i<=step; i++)
						{
							sumDOMs = 0;
							
							for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								
							   currentDOM = ifunc.calculateDOM(input);
								s1 += func.weight *currentDOM;
											 
								s2 += currentDOM;
								
								
								
							}
							
						
							
							
						
							
							input = input + delta;
						}
				
				
				
				fm.output = s1 / s2;
				
			}
		}*/
		
		/**
		 *    sum(input * xDOM(input))/sum of DOM(input)  COG or CENTROID
		 * @param	step (0.1 is every 10th)
		 * @return
		 *///
		private static function CoS(outputFuzzyManifolds:Dictionary,step:Number=0.1):void
		{
			var input:int = 0;
			var fm:FuzzyManifold;
			var currentDOM:Number;
			var delta:Number;
			var i:int;
			
			var s2:Number=0;
			var s1:Number=0;
			var sumDOMs:Number = 0;//for input
			var func:FuzzyMembershipFunction;
			var stepBoundary:Number = step * 100;
			
			for each (fm in outputFuzzyManifolds)
			{
				s1 = 0;
				s2 = 0;
				
				
				 
						//get delta
						delta = (fm.maxRange-fm.minRange) * step;
						input = fm.minRange+delta;
						
						for (i=1; i<=stepBoundary; i++)
						{
							sumDOMs = 0;
							
							for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								func = FuzzyMembershipFunction( ifunc);
							    func.maximumDOM =  func.levelOfConfidence;
								sumDOMs += ifunc.calculateDOM(input);
								  func.reset();
								 
								  
								
								
								
							}
							
						
							
							s1 += input * sumDOMs;
							s2 += sumDOMs;
							
							input = input + delta;
						}
				
				
				
				fm.output = s1 / s2;
				
			}
			
			
		}
		
		/**
		 * 
		 */
		private static function AVMAX(outputFuzzyManifolds:Dictionary):void
		{
			var fm:FuzzyManifold;
			var sumLOC:Number;
			var sumAvgMulLOC:Number;
			var levelOfConfidence:Number;
			var func:FuzzyMembershipFunction;
		
			
			for each (fm in outputFuzzyManifolds)
			{
				sumLOC = 0;
				sumAvgMulLOC = 0;
				
				
						
							for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								func = FuzzyMembershipFunction( ifunc);
								if(func.maximumDOM<1)
								 func.maximumDOM = 1;//it is reset
								
								sumAvgMulLOC+= ifunc.averagePoint *func.levelOfConfidence;
								
								sumLOC += func.levelOfConfidence;
								
							
							}
							
							
				
				
				
				fm.output = sumAvgMulLOC /sumLOC;
				
			}
		}
	}

}