package winxalex.fuzzy 
{
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author alex winx
	 */
	public  class Fazzificatior
	{
		
	 //a map of all the fuzzy variables this module uses
     public  var fuzzymanifolds:Vector.<FuzzyManifold>;
  
	 
	 //inputs
	 public var inputs:Dictionary;

 

  //a vector containing all the fuzzy rules
  private var fuzzyRules:Vector.<FuzzyRule>;
  

 
 
  
          

  //this method calls the Fuzzify method of the named FLV
 //  Fuzzify(const std::string& NameOfFLV, double val);


 
		
		
		public function Fazzificatior() 
		{
			fuzzymanifolds = new Vector.<FuzzyManifold>();
			fuzzyRules = new Vector.<FuzzyRule>();
			inputs = new Dictionary(true);
			
		}
		
	/*	public  static function AND(...args):FuzzyTerm
		{
		
			var i:int = 0;
			var len:int = args.length;
			
			for (; i < len; i++)
			{
				
			}
		}
		
		//fm.AddRule(FzOR(FzAND(a1,a2), FzAND(FzNOT(a3), FzVery(a4))), FzAND(c1, c2));


		public static function OR(...args):FuzzyTerm
		{
			
		}*/
		
		
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
			
			//FuzzyManifold(fuzzymanifolds[manifold]).Fuzzify(value);
			for each(var input:FuzzyInput in inputs)
			{
				fm = inputs[input];
				fm.Fuzzify(input.value);
				
			}
		}
		
		public function Defuzzify():Number
		{
			return 1;
		}
		
	}

}