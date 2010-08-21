package winxalex.fuzzy 
{
	
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author alex winx
	 */
	public  class Fazzificatior
	{
		
	 //a map of all the fuzzy variables this module uses
     public  var fuzzymanifolds:Dictionary;
  
	 


 
	

  //a vector containing all the fuzzy rules
  private var fuzzyRules:Vector.<FuzzyRule>;
  
		
		
		public function Fazzificatior() 
		{
			fuzzymanifolds = new Dictionary(true);
			fuzzyRules = new Vector.<FuzzyRule>();
		
			
		}
		
		public function addManifold(manifold:FuzzyManifold):void
		{
			fuzzymanifolds[manifold.name] = manifold;
		}
	
		
		
	   //adds a rule to the fazificator
		public function addRule(rule:FuzzyRule):void
		{
			fuzzyRules[fuzzyRules.length] = rule;
			rule.compile(this);
			
		}
		
		
		
		public function connectInput(input:FuzzyInput,fm:FuzzyManifold):void
		{
			fm.input = input;
		
		}
		
		public function disconnecttInput(fm:FuzzyManifold):void
		{
			fm.input = null;
		}
		
		
		
		public function Fuzzify():void
		{
			var fm:FuzzyManifold;
			
			for each (fm in fuzzymanifolds)
			{
				if(fm.input)
				fm.Fuzzify(input.value);
			}
			
			for each(var rule:FuzzyRule in fuzzyRules)
			{
				rule.evaluate();
			}
		}
		
		public function Defuzzify(method:uint,...args):FuzzyOutput
		{
			//loop thru all manifolds that don't have inputs they are outputs
			switch(method)
			{
				case DefuzzificationMethod.CENTROID:
				return Centroid(args[0]);
				break;
				case DefuzzificationMethod.MAX_AVERAGED:
				return MaxAv();
				break;
				case DefuzzificationMethod.MEAN_OF_MAXIMUM:
				return MoM();
				break;
				
			}
			return 1;
		}
		
		
		private function MoM():Number
		{
			
		}
		
		/**
		 *    sum(input * xDOM(input))/sum of DOM(input)
		 * @param	precission
		 * @return
		 */
		private function Centroid(precission:uint=10):Number
		{
			var input:int = 0;
			var fm:FuzzyManifold;
			var currentDOM:Number;
			
			var s2:Number=0;
			var s1:Number=0;
			var sumDOMs:Number=0;
			
			for each (fm in fuzzymanifolds)
			{
				
				if (!fm.input)
				{
						//get delta
						delta = (fm.maxRange-fm.minRange) /precission;
						for (var input = fm.minRange; input<= fm.maxRange; input=input+delta)
						{
							sumDOMs=0
							for each(var func:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								sumDOMs+=func.calculateDOM(input);
							}
							
							s1 += input * sumDOMs;
							s2 += sumDOMs;
							
							
						}
				}
				
				
				fm.output = s1 / s2;
				
			}
			
			
		}
		
		private function MaxAv():Number
		{
			
		}
	}

}