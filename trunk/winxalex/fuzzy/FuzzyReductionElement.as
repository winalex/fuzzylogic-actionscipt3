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
		public var data:Number;
		
		
		
		public function FuzzyReductionElement(/*memberFunction:FuzzyMembershipFunction,antecendent:String,*/consequentManifold:FuzzyManifold,data:Number) 
		{
			/*this.memberFunction = memberFunction;*/
			/*this.antecendent = antecendent;*/
			this.consequentManifold = consequentManifold;
			this.data = data;
		}
		
		public function toString():String 
		{
			return "average:"+data.toString();
		}
		
	}

}