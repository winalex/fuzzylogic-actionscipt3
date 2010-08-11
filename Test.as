package
{
	import flash.display.Sprite;
	import winxalex.fuzzy.*;
	
	
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
			var rule:FuzzyRule;
			rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3");
			faz.addRule(rule);
			var result:Number = rule.evaluate();
			
			trace(result);
			
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