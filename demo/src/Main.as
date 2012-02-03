package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import winxalex.fuzzy.Fuzzificator;
	import winxalex.fuzzy.FuzzyInput;
	import winxalex.fuzzy.FuzzyManifold;
	import winxalex.fuzzy.FuzzyRule;
	import winxalex.fuzzy.FuzzyMembershipFunction;
	import winxalex.fuzzy.FuzzyMembershipFunctionFactory;
	import winxalex.fuzzy.Token;
	import winxalex.fuzzy.FuzzyOperator;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Main extends Sprite
	{
		public var spawingTimer:Timer;
		public var targets:Array;
		
		public function Main():void
		{
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			targets = new Array();
			// entry point
			var hero:Hero = new Hero();
			//hero.fuzzificator = getFuzzificator();
			hero.y = stage.stageHeight * 0.5;
			//hero.addWeapon(new RocketLuncher(20));
			//hero.addWeapon(new Pistol(40));
			hero.addWeapon(new Knife(int.MAX_VALUE));
			addChild(hero);
			
			spawingTimer = new Timer(1000, 0);
			spawingTimer.addEventListener(TimerEvent.TIMER, onSpawnTime);
			spawingTimer.start();
		}
		
		private function getFuzzificator():Fuzzificator
		{
			var tempStek:Vector.<Token>;
    		var fuz:Fuzzificator = new Fuzzificator();
			var factory:FuzzyMembershipFunctionFactory = FuzzyMembershipFunctionFactory.getInstance();
			var manifold:FuzzyManifold;
			var func:FuzzyMembershipFunction;
			var rule:FuzzyRule;
			var ammoStatusInput:FuzzyInput;
			var distanceStatusInput:FuzzyInput;
			
			
			ammoStatusInput = new FuzzyInput();
			distanceStatusInput = new FuzzyInput();
			
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
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Close", 0, 25, 125); //[0 0 25 125]
			manifold.addMember(func);
			
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Medium", 25, 150, 300); // [25 150 300]
			manifold.addMember(func);
			
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Far", "150, 300,400", ","); //  [150 300 400 400]
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
			
			//Rule:IF Distance_to_Target IS Far AND Ammo_Status IS Okey THEN Desirability IS Undesirable has fired TRUE with result:0.3333333333333333
			//rule = new FuzzyRule(Distance_to_Target,Far,Ammo_Status
			
			rule = new FuzzyRule();
			tempStek = new Vector.<Token>(3, true);
			
			// creation antescendent(condition stek) stek like "Distance_to_Target IS Far AND Ammo_Status IS Okey"
			tempStek[0] = new Token(0, FuzzyOperator.fDOM, ["Distance_to_Target", "Far", fuz]);
			tempStek[1] = new Token(1, FuzzyOperator.fDOM, ["Ammo_Status", "Okey", fuz]);
			var result:Token = tempStek[2] = new Token(2, FuzzyOperator.fMIN, [tempStek[0], tempStek[1]]);
			rule.antCompiledStek = tempStek;
			
			// creation result stek like "Desirability IS Undesirable"
			tempStek = new Vector.<Token>(2, true);
			tempStek[0] = new Token(0, fuz.implication, [result, new Token(0, null, null, 1)]);
			tempStek[1] = new Token(1, FuzzyOperator.fAGGREGATE, ["Desirability", "Undesirable", fuz, rule.weight, tempStek[0]]);
			
			rule.conCompiledStek = tempStek;
			
			fuz.addRule(rule, false);
			/*
			   /*rule = new FuzzyRule( " IF Distance_to_Target IS Far AND Ammo_Status IS Okey THEN Desirability IS Undesirable");
			 fuz.addRule(rule);*/
			rule = new FuzzyRule(" IF Distance_to_Target IS Far AND  Ammo_Status IS Low THEN Desirability IS Undesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Loads THEN Desirability IS VeryDesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Okey THEN  Desirability IS VeryDesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Medium AND Ammo_Status IS Low THEN Desirability IS Desirable");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Loads THEN Desirability IS Undesirable");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Okey THEN  Desirability IS Undesirable ");
			fuz.addRule(rule);
			rule = new FuzzyRule("IF Distance_to_Target IS Close AND Ammo_Status IS Low THEN  Desirability IS Undesirable");
			fuz.addRule(rule);
			
			return fuz;
		}
		
		private function onSpawnTime(e:TimerEvent):void
		{
			var sol:Solder = new Solder();
			sol.y = this.stage.stageHeight * 0.5;
			sol.x = this.stage.stageWidth + sol.width;
			this.addChild(sol);
			targets.push(sol);
			spawingTimer.delay = 1000 + Math.random() * 3000;
		
		}
	
	}

}