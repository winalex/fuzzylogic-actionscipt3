package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import winxalex.fuzzy.*;
	
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class Test3ReduceComb extends Sprite
	{
		
		public function Test3ReduceComb() 
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
							
									
							
				
				//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3 AND W IS W1 OR Q IS Q1");
			
			//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3 AND W IS W1 OR Q IS Q1");
		//rule = new FuzzyRule("A IS A1 AND B IS B1 OR (B IS B2 AND C IS NOT C1) THEN V IS V3 AND W IS W1 OR Q IS Q1");
		//(A IS A1 AND B IS B1 THEN RESULT) AND (B IS B2 AND C IS NOT C1 THEN RESULT)
		//(A IS A1 THEN RESULT OR B IS B1 THEN RESULT) AND (B IS B2 THEN RESULT OR C IS NOT C1 THEN RESULT)
		//
		
		// fuz.addRule(rule);
		 fuz.reduce(true);
			// rule.compile(fuz);
									
		
			
		}
		
	}

}