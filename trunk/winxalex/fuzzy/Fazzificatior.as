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
  
	 
	 //inputs
	 public var inputs:Dictionary;

 
	

  //a vector containing all the fuzzy rules
  private var fuzzyRules:Vector.<FuzzyRule>;
  
		
		
		public function Fazzificatior() 
		{
			fuzzymanifolds = new Dictionary(true);
			fuzzyRules = new Vector.<FuzzyRule>();
			inputs = new Dictionary(true);
			
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
			fuzzymanifolds[fm.name] = fm;
			inputs[input] = fm;
		}
		
		public function disconnecttInput(input:FuzzyInput):void
		{
			delete fuzzymanifolds[FuzzyManifold(inputs[input]).name] ;
			 
			delete inputs[input] ;
		}
		
		
		
		public function Fuzzify():void
		{
			var fm:FuzzyManifold;
			
			for (var input:* in inputs)
			{
				fm = inputs[input];
				fm.Fuzzify(input.value);
			}
			
			for each(var rule:FuzzyRule in fuzzyRules)
			{
				rule.evaluate();
			}
		}
		
		public function Defuzzify(method:uint):Number
		{
			//loop thru all manifolds that don't have inputs they are outputs
			switch(method)
			{
				case DefuzzificationMethod.CENTROID:
				break;
				case DefuzzificationMethod.MAX_AVERAGED:
				break;
				case DefuzzificationMethod.MEAN_OF_MAXIMUM:
				break;
				
			}
			return 1;
		}
		
	}

}