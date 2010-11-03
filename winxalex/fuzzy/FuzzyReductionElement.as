package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyReductionElement
	{
		//public var memberFunction:FuzzyMembershipFunction;
		//public var antecendent:String;
		public var consequentManifold:FuzzyManifold;
		public var average:Number;
		
		
		public function FuzzyReductionElement(/*memberFunction:FuzzyMembershipFunction,antecendent:String,*/consequentManifold:FuzzyManifold,average:Number) 
		{
			/*this.memberFunction = memberFunction;*/
			/*this.antecendent = antecendent;*/
			this.consequentManifold = consequentManifold;
			this.average = average;
		}
		
		public function toString():String 
		{
			return "average:"+average.toString();
		}
		
	}

}