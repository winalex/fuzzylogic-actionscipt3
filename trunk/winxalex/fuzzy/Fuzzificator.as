package winxalex.fuzzy 
{
	
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author alex winx
	 */
	public  class Fuzzificator
	{
		
	 //a map of all the fuzzy variables this module uses
     internal var inputFuzzymanifolds:Dictionary;
	 internal var outputFuzzyManifolds:Dictionary;
  
	 


 
	

  //a vector containing all the fuzzy rules
  private var fuzzyRules:Vector.<FuzzyRule>;
  
		
		
		public function Fuzzificator() 
		{
			inputFuzzymanifolds = new Dictionary(true);
			outputFuzzyManifolds = new Dictionary(true);
			fuzzyRules = new Vector.<FuzzyRule>();
		
			
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
			fuzzyRules[fuzzyRules.length] = rule;
			rule.compile(this);
			
		}
		
		
		
		
		
		
		public function Fuzzify():void
		{
			var fm:FuzzyManifold;
			var ouputManifolds:Vector.<FuzzyManifold> = new Vector.<FuzzyManifold>;
			
			for each (fm in inputFuzzymanifolds)
			{
				
				fm.Fuzzify();//calculate DOM
				
			}
			
			//evaluate rules
			for each(var rule:FuzzyRule in fuzzyRules)
			{
				rule.reset();
				rule.evaluate();
			}
			
		
			
			
		}
		
		public function Defuzzify(method:uint,...args):Dictionary
		{
			//loop thru all manifolds that don't have inputs they are outputs
			switch(method)
			{
				case DefuzzificationMethod.CENTAR_OF_SUM:
				if(args[0])
				CoS(args[0]);
				else
				CoS();
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod.MAX_AVERAGED:
				MaV();
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod.MEAN_OF_MAXIMUM:
				MoM();
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod.CENTER_OF_AREA_CENTROID:
				if(args[0])
				CoA(args[0]);
				else
				CoA();
				return outputFuzzyManifolds;
				break;
				
			}
			
			
			throw new Error("Not supported Defuzzificaiton Method");
		}
		
		
		private function MoM():void
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
		
		
		private function CoA(step:uint = 10):void
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
			
			for each (fm in outputFuzzyManifolds)
			{
				s1 = 0;
				s2 = 0;
				
				
				 
						//get delta
						delta = (fm.maxRange-fm.minRange) / step;
						input = fm.minRange+delta;
						
						for (i=1; i<=step; i++)
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
		
		/**
		 *    sum(input * xDOM(input))/sum of DOM(input)
		 * @param	step
		 * @return
		 *///
		private function CoS(step:uint=10):void
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
		private function MaV():void
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
								 func.maximumDOM = 1;
								
								sumAvgMulLOC+= ifunc.averagePoint *func.levelOfConfidence;
								
								sumLOC += func.levelOfConfidence;
								
							
							}
							
							
				
				
				
				fm.output = sumAvgMulLOC /sumLOC;
				
			}
		}
	}

}