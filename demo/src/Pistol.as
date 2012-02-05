package
{
	import flash.display.DisplayObject;
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
	public class Pistol extends Weapon
	{
		
		public function Pistol(ammo:uint):void
		{
			super(ammo);
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
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Close", 20, 80, 120); //[0 0 25 125]
			manifold.addMember(func);
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Medium", 80, 150, 300); // [25 150 300]
			manifold.addMember(func);
			
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Far", 150,300,400, ","); //  [150 300 400 400]
			manifold.addMember(func);
			
			fuz.addManifold(manifold);
			
			trace("-----------------------------------------------");
			
			manifold = new FuzzyManifold("Ammo_Status");
			manifold.input = ammoStatusInput;
			
			//leftPoint,leftPeakPoint,rightPeakPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Loads", 10, 30, 40); // [10 30 40 40]
			manifold.addMember(func);
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Low", 0, 0, 10); // [0 0 0 10]
			manifold.addMember(func);
			
			//leftPoint,peakPoint,rightPoint
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Okey", 0, 10, 30); // [0 10 30]
			
			manifold.addMember(func);
			
			fuz.addManifold(manifold);
			
			trace("----------------------------------------------------------------------------");
			
			/**/
			rule = new FuzzyRule("IF Distance_to_Target IS Far AND Ammo_Status IS Loads THEN Desirability IS Desirable");
			fuz.addRule(rule);
			rule = new FuzzyRule(" IF Distance_to_Target IS Far AND Ammo_Status IS Okey THEN Desirability IS Undesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule(" IF Distance_to_Target IS Far AND  Ammo_Status IS Low THEN Desirability IS Undesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Loads THEN Desirability IS VeryDesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Okey THEN  Desirability IS VeryDesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Low THEN Desirability IS VeryDesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Loads THEN Desirability IS Desirable");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Okey THEN  Desirability IS Undesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Low THEN  Desirability IS Undesirable");
			fuz.addRule(rule);
			
			return fuz;
		}
		
		override public function shoot():void
		{
			
			var missile:DisplayObject = new Bullet();
			missile.x = this.parent.x + 87;
			missile.y = this.parent.y + 23;
			this.parent.parent.addChild(missile);
		
		}
	
	}

}