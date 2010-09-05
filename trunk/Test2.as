package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import winxalex.fuzzy.*;
	
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class Test2 extends Sprite
	{
		
		public function Test2() 
		{
			var fuz:Fuzzificator= new Fuzzificator();
			var factory:IFuzzyMembershipFunctionFactory = FuzzyMembershipFunctionFactory.getInstance();
			var manifold:FuzzyManifold;
			var func:FuzzyMembershipFunction;
			var rule:FuzzyRule;
			var speedStatusInput:FuzzyInput;
			var distanceStatusInput:FuzzyInput;
			
			speedStatusInput = new FuzzyInput();
			distanceStatusInput = new FuzzyInput();
			
			manifold = new FuzzyManifold("BreakForce");
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "VeryLight", 0,0, 25 );
			manifold.addMember(func);
			trace(func.toString());
			
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Light", 25, 25, 25 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Normal", 25, 50, 25 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Heavy", 25, 75, 25 );
			manifold.addMember(func);
			trace(func.toString());
				
			/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "VeryHeavy", 25, 75,75 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			
			
			
				fuz.addManifold(manifold);
				
			trace("-----------------------------------------------------------------------");
			
			
			manifold = new FuzzyManifold("DistanceToObstical");
			manifold.input = distanceStatusInput;
			//left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Long", 50, 100,100 )  ;
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Far:"+func.degreeOfMembership);
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Short", 0,0, 50 );
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Close:"+func.degreeOfMembership);
			
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Normal", 50, 50, 50 );
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Medium:" + func.degreeOfMembership);
			
			
			fuz.addManifold(manifold);
			
			
			
			trace("-----------------------------------------------");
			
			manifold = new FuzzyManifold("CarSpeed");
			manifold.input = speedStatusInput;
			
			//left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Big", 60, 120,120 ); 
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			manifold.addMember(func);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			//lleftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Low", 0,0, 60 );
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			manifold.addMember(func);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Normal", 60, 60, 60 );
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			manifold.addMember(func);
			
			fuz.addManifold(manifold);
			
			trace("----------------------------------------------------------------------------");
			
		
			
			/**/
			rule = new FuzzyRule( "IF DistanceToObstical IS Short AND CarSpeed IS Low THEN BreakForce IS Normal");
				fuz.addRule(rule);
				rule = new FuzzyRule( " IF DistanceToObstical IS Short AND CarSpeed IS Normal THEN BreakForce IS Heavy");
					fuz.addRule(rule);
					rule = new FuzzyRule( " IF DistanceToObstical IS Short AND  CarSpeed IS Big THEN BreakForce IS VeryHeavy ");
						fuz.addRule(rule);
						rule = new FuzzyRule( "IF DistanceToObstical IS Normal AND CarSpeed IS Low THEN BreakForce IS  Light");
							fuz.addRule(rule);
							rule = new FuzzyRule( "IF DistanceToObstical IS Normal AND CarSpeed IS Normal THEN  BreakForce IS Normal ");
								fuz.addRule(rule);
								rule = new FuzzyRule( "IF DistanceToObstical IS Normal AND CarSpeed IS Big THEN BreakForce IS Heavy");
								fuz.addRule(rule);
									rule = new FuzzyRule( "IF DistanceToObstical IS Long AND CarSpeed IS Low THEN BreakForce IS VeryLight");
									fuz.addRule(rule);
										rule = new FuzzyRule( "IF DistanceToObstical IS Long AND CarSpeed IS Normal THEN  BreakForce IS Light ");
										fuz.addRule(rule);
									rule = new FuzzyRule( "IF DistanceToObstical IS Long AND CarSpeed IS Big THEN  BreakForce IS Normal");
									fuz.addRule(rule);
												
			
			
			trace(fuz.getManifold("BreakForce").toString());
			
		
			speedStatusInput.value = 95
			distanceStatusInput.value = 35
			
			
			
			fuz.Fuzzify();
			
			
			
		
			
			var fuzzyManifolds:Dictionary = fuz.Defuzzify(DefuzzificationMethod.MEAN_OF_MAXIMUM);
			
			trace("OUTPUT MOM:" + FuzzyManifold(fuzzyManifolds["BreakForce"]).output);
				
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTAR_OF_SUM);
			
			trace("OUTPUT COS:" + FuzzyManifold(fuzzyManifolds["BreakForce"]).output);
			
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.MAX_AVERAGED);
			
			trace("OUTPUT MAXAV:" + FuzzyManifold(fuzzyManifolds["BreakForce"]).output);
			
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTER_OF_AREA_CENTROID);
			
			trace("CENTROID:" + FuzzyManifold(fuzzyManifolds["BreakForce"]).output);
			
			
			
			trace(fuz.getManifold("BreakForce").toString());
			
			/*OUTPUT MOM:75
			OUTPUT COS:63.794466403162055
			OUTPUT MAXAV:66.98717948717949
			CENTROID:63.646408839779006
			linguisticTerm=VeryLight DOM:0 LOC=0 leftOffset=0 leftMidPoint=0 rightMidPoint=0 rightOffset=25
			linguisticTerm=Normal DOM:0 LOC=0.4166666666666667 leftOffset=25 leftMidPoint=50 rightMidPoint=50 rightOffset=25
			linguisticTerm=VeryHeavy DOM:0 LOC=0.3 leftOffset=25 leftMidPoint=75 rightMidPoint=75 rightOffset=0
			linguisticTerm=Light DOM:0 LOC=0 leftOffset=25 leftMidPoint=25 rightMidPoint=25 rightOffset=25
			linguisticTerm=Heavy DOM:0 LOC=0.5833333333333334 leftOffset=25 leftMidPoint=75 rightMidPoint=75 rightOffset=25*/
			
		}
		
	}

}