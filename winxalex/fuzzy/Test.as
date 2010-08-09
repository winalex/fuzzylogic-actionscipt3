package winxalex.fuzzy 
{
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class Test extends Sprite
	{
		
		public function Test() 
		{
			var faz:Fazzificatior = new Fazzificatior();
			var factory:IFuzzyMembershipFunctionFactory = FuzzyMembershipFunctionFactory.getInstance();
			var func:IFuzzyMembershipFunction=factory.create(FuzzyMembershipFunction.TRIANGLE,"bla", 230, 120, 320);
			factory.create(FuzzyMembershipFunction.LEFT_SHOULDER,"bla", 230, 120, 320);
			factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "bla", 230, 120, 320);
			//faz.fuzzymanifolds[
			//faz.fuzzymanifolds[
			

			//factory.create(
			//var func:FuzzyTrianlgeMembershipFunction;
			/*
			var manifold:FuzzyManifold
			
			faz.addRule(new FuzzyRule());
			
			manifold = new FuzzyManifold("");
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			
			manifold = new FuzzyManifold("");
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			faz.addManifold(manifold);
			
			faz.Fuzzify(*/
			trace(func.toString());
			
			
			
			
		}
		
	}

}