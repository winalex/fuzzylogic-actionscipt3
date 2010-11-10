package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import winxalex.fuzzy.*;
	
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class TestReduceCombExample25 extends Sprite
	{
		
		public function TestReduceCombExample25() 
		{
			var fuz:Fuzzificator= new Fuzzificator();
			var factory:IFuzzyMembershipFunctionFactory = FuzzyMembershipFunctionFactory.getInstance();
			var manifold:FuzzyManifold;
			var func:FuzzyMembershipFunction;
			var rule:FuzzyRule;
			var ammoStatusInput:FuzzyInput;
			var distanceStatusInput:FuzzyInput;
			var fuzzyManifolds:Dictionary;
			
			ammoStatusInput = new FuzzyInput();
			distanceStatusInput = new FuzzyInput();
			
			manifold = new FuzzyManifold("AgeInYears");
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "YOUTHFUL", 0,20, 10 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "YOUNG", 10, 30, 15 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "MIDDLE_AGED", 15, 45, 15 );
			manifold.addMember(func);
			trace(func.toString());
			
					//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "MATURE", 15, 60, 10 );
			manifold.addMember(func);
			trace(func.toString());
				
				/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Undesirable", 10,70, 70 );
			manifold.addMember(func);
			trace(func.toString());
			
	
			
			
			
				fuz.addManifold(manifold);
				
			trace("-----------------------------------------------------------------------");
			
			
			manifold = new FuzzyManifold("HealthStatus");
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "POOR", 0,0, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "BELOW_AVERAGE", 2.25, 2.25, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "AVERAGE", 2.25, 0.5, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
			
					//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "GOOD", 2.25, 0.75, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
				
				/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "EXCELENT", 2.25,1.0, 1.0 );
			manifold.addMember(func);
			trace(func.toString());
			
			
			
			trace("-----------------------------------------------");
			
			manifold = new FuzzyManifold("Premium");
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "VERY_LOW", 0,0, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "LOW", 2.25, 2.25, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "MODERATLY_LOW", 2.25, 0.5, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "MODERATE", 2.25, 0.75, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "MODERATLY_HIGH", 2.25, 0.75, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "HIGH", 2.25, 0.75, 2.25 );
			manifold.addMember(func);
			trace(func.toString());
				
				/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "VERY_HIGH", 2.25,1.0, 1.0 );
			manifold.addMember(func);
			trace(func.toString());
			
			trace("----------------------------------------------------------------------------");
			
		
			
			/**/
			rule = new FuzzyRule( "IF Distance_to_Target IS Far AND Ammo_Status IS Loads THEN Desirability IS Desirable");
				fuz.addRule(rule);
				rule = new FuzzyRule( " IF Distance_to_Target IS Far AND Ammo_Status IS Okey THEN Desirability IS Undesirable");
					fuz.addRule(rule);
					rule = new FuzzyRule( " IF Distance_to_Target IS Far AND  Ammo_Status IS Low THEN Desirability IS Undesirable ");
						fuz.addRule(rule);
						rule = new FuzzyRule( "IF Distance_to_Target IS Medium AND Ammo_Status IS Loads THEN Desirability IS VeryDesirable ");
							fuz.addRule(rule);
							rule = new FuzzyRule( "IF Distance_to_Target IS Medium AND Ammo_Status IS Okey THEN  Desirability IS VeryDesirable ");
								fuz.addRule(rule);
								rule = new FuzzyRule( "IF Distance_to_Target IS Medium AND Ammo_Status IS Low THEN Desirability IS Desirable");
								fuz.addRule(rule);
									rule = new FuzzyRule( "IF Distance_to_Target IS Close AND Ammo_Status IS Loads THEN Desirability IS Undesirable");
									fuz.addRule(rule);
										rule = new FuzzyRule( "IF Distance_to_Target IS Close AND Ammo_Status IS Okey THEN  Desirability IS Undesirable ");
										fuz.addRule(rule);
									rule = new FuzzyRule( "IF Distance_to_Target IS Close AND Ammo_Status IS Low THEN  Desirability IS Undesirable");
									fuz.addRule(rule);
							
				
				//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3 AND W IS W1 OR Q IS Q1");
			
			//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3 AND W IS W1 OR Q IS Q1");
		//rule = new FuzzyRule("A IS A1 AND B IS B1 OR (B IS B2 AND C IS NOT C1) THEN V IS V3 AND W IS W1 OR Q IS Q1");
		//(A IS A1 AND B IS B1 THEN RESULT) AND (B IS B2 AND C IS NOT C1 THEN RESULT)
		//(A IS A1 THEN RESULT OR B IS B1 THEN RESULT) AND (B IS B2 THEN RESULT OR C IS NOT C1 THEN RESULT)
		//
		
		// fuz.addRule(rule);
		trace("--------------------Reduction SIMPLE_1---------------");
		 fuz.reduce(ReductionMethod.SIMPLE_1, false);
		trace( fuz.toString());
		 trace("----------------------------------------------------------");
/*		trace("--------------------Reduction SIMPLE_2---------------");
		 fuz.reduce(ReductionMethod.SIMPLE_2);
		  trace("----------------------------------------------------------");
			*/
/*		 
 --------------------Reduction SIMPLE_1---------------
rule=new Rule(Distance_to_Target IS Far THEN Desirability IS Undesirable)
rule=new Rule(Distance_to_Target IS Medium THEN Desirability IS VeryDesirable)
rule=new Rule(Ammo_Status IS Okey THEN Desirability IS Undesirable)
rule=new Rule(Ammo_Status IS Loads THEN Desirability IS Desirable)
rule=new Rule(Ammo_Status IS Low THEN Desirability IS Undesirable)
rule=new Rule(Distance_to_Target IS Close THEN Desirability IS Undesirable)
----------------------------------------------------------
--------------------Reduction SIMPLE_2---------------
rule=new Rule(Distance_to_Target IS Far THEN Desirability IS Undesirable)
rule=new Rule(Distance_to_Target IS Medium THEN Desirability IS VeryDesirable)
rule=new Rule(Ammo_Status IS Okey THEN Desirability IS Undesirable)
rule=new Rule(Ammo_Status IS Loads THEN Desirability IS Desirable)
rule=new Rule(Ammo_Status IS Low THEN Desirability IS Undesirable)
rule=new Rule(Distance_to_Target IS Close THEN Desirability IS Undesirable)
----------------------------------------------------------
*/
									
		
			
		}
		
	}

}