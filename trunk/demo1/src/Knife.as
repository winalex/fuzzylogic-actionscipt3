package
{
	import flash.events.Event;
	
	import winxalex.fuzzy.Fuzzificator;
	import winxalex.fuzzy.Fuzzificator;
	import winxalex.fuzzy.FuzzyInput;
	import winxalex.fuzzy.FuzzyManifold;
	import winxalex.fuzzy.FuzzyMembershipFunction;
	import winxalex.fuzzy.FuzzyMembershipFunctionFactory;
	import winxalex.fuzzy.FuzzyRule;
	import winxalex.fuzzy.Token;
	import winxalex.fuzzy.FuzzyOperator;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Knife extends Weapon
	{
		
		public function Knife():void
		{
			super(uint.MAX_VALUE);
		}
		
		override protected function getFuzzificator():Fuzzificator
		{
			var tempStek:Vector.<Token>;
			var fuz:Fuzzificator = new Fuzzificator();
			var factory:FuzzyMembershipFunctionFactory = FuzzyMembershipFunctionFactory.getInstance();
			var manifold:FuzzyManifold;
			var func:FuzzyMembershipFunction;
			var rule:FuzzyRule;
			
			
			manifold = new FuzzyManifold("Desirability");
			
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Undesirable", 0, 25, 50); //[0 0 25 50]
			manifold.addMember(func);
			trace(func.toString());
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Desirable", [25, 50, 75]); //  [25 50 75]
			manifold.addMember(func);
			trace(func.toString());
			
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "VeryDesirable", 50, 75, 100); // [50 75 100 100]
			manifold.addMember(func);
			trace(func.toString());
			
			fuz.addManifold(manifold);
			
			trace("-----------------------------------------------------------------------");
			
			manifold = new FuzzyManifold("Distance_to_Target");
			manifold.input = distanceStatusInput;
			
			//!!! Warning make them sorted  by X so CENTROID won't work
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Close", 0, 5, 7.25); //
			manifold.addMember(func);
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Medium", 5, 7.5, 10); // 
			manifold.addMember(func);
			
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Far",7.5,10,20); //  
			manifold.addMember(func);
			
			fuz.addManifold(manifold);
			
		
			
			trace("----------------------------------------------------------------------------");
			
			rule = new FuzzyRule("IF Distance_to_Target IS Far THEN Desirability IS Undesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule(" IF Distance_to_Target IS Medium  THEN Desirability IS Undesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule(" IF Distance_to_Target IS Close  THEN Desirability IS SOMEWHAT VeryDesirable ");
			fuz.addRule(rule);
			
			
			/*
			rule = new FuzzyRule("IF Distance_to_Target IS Far AND Ammo_Status IS Loads THEN Desirability IS Undesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule(" IF Distance_to_Target IS Far AND Ammo_Status IS Okey THEN Desirability IS Undesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule(" IF Distance_to_Target IS Far AND  Ammo_Status IS Low THEN Desirability IS Undesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Loads THEN Desirability IS Undesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Okey THEN  Desirability IS Undesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Low THEN Desirability IS Undesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Loads THEN Desirability IS VeryDesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Okey THEN  Desirability IS VeryDesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Low THEN  Desirability IS VeryDesirable");
			fuz.addRule(rule);*/
			
			return fuz;
		}
		
		override public function prepShoot():void
		{
			gotoAndPlay("SHOOT_ANI");
		}
		
		override public function shoot():void
		{
		
		}
	
	}

}