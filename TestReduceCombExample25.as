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
			var ageInput :FuzzyInput;
			var healthInput :FuzzyInput;
			var fuzzyManifolds:Dictionary;
			
			ageInput = new FuzzyInput();
			healthInput = new FuzzyInput();
			
			manifold = new FuzzyManifold("AgeInYears");
			manifold.input = ageInput;
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Youthful", 0,20, 10 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Young", 10, 30, 15 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "MiddleAged", 15, 45, 15 );
			manifold.addMember(func);
			trace(func.toString());
			
					//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Mature", 15, 60, 10 );
			manifold.addMember(func);
			trace(func.toString());
				
				/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Old", 10,70, 70 );
			manifold.addMember(func);
			trace(func.toString());
			
	
			
			
			
				fuz.addManifold(manifold);
				
			trace("-----------------------------------------------------------------------");
			
			
			manifold = new FuzzyManifold("HealthStatus");
			manifold.input = healthInput;
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Poor", 0,0, 0.25 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "BelowAverage", 0.25, 0.25, 0.25 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Average", 0.25, 0.5, 0.25 );
			manifold.addMember(func);
			trace(func.toString());
			
					//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Good", 0.25, 0.75, 0.25 );
			manifold.addMember(func);
			trace(func.toString());
				
				/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Excelent", 0.25,1.0, 1.0 );
			manifold.addMember(func);
			trace(func.toString());
			
				fuz.addManifold(manifold);
			
			trace("-----------------------------------------------");
			
			manifold = new FuzzyManifold("Premium");
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "VeryLow", 0,0, 0.166 );
			manifold.addMember(func);
			trace(func.toString());
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Low", 0.166, 0.166, 0.166 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "ModeratelyLow", 0.166, 0.33, 0.166 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Moderate", 0.166, 0.5,0.166  );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "ModeratelyHigh", 0.166, 0.666, 0.166 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "High", 0.166, 0.833, 0.166 );
			manifold.addMember(func);
			trace(func.toString());
				
				/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "VeryHigh", 0.166,1.0, 1.0 );
			manifold.addMember(func);
			trace(func.toString());
			
			fuz.addManifold(manifold);
			
			trace("----------------------------------------------------------------------------");
			
		
			
			/*test of removing ,;...*/
			/*rule = new FuzzyRule( "IF AgeInYears is Youthful ,;and Health is, Excellent Then..; Premium is VeryLow");
				fuz.addRule(rule);
				rule = new FuzzyRule( "IF AgeInYears is Youthful and Health is Good, THEN Premium is Low");
					fuz.addRule(rule);
					rule = new FuzzyRule( "IF AgeInYears is Youthful and Health is Average THEN Premium is ModeratelyLow");
						fuz.addRule(rule);
						rule = new FuzzyRule( "IF AgeInYears is Youthful and Health is Below Average THEN Premium is ModeratelyLow");
							fuz.addRule(rule);
							rule = new FuzzyRule( "IF AgeInYears is Youthful and Health is Poor THEN Premium is Moderate ");
								fuz.addRule(rule);*/
								
									rule = new FuzzyRule( "IF AgeInYears is Youthful  Then..; Premium is VeryLow");
									fuz.addRule(rule);
									rule = new FuzzyRule( "IF AgeInYears is Youthful THEN Premium is Low");
										fuz.addRule(rule);
										rule = new FuzzyRule( "IF AgeInYears is Youthful  THEN Premium is ModeratelyLow");
											fuz.addRule(rule);
											rule = new FuzzyRule( "IF AgeInYears is Youthful  THEN Premium is ModeratelyLow");
												fuz.addRule(rule);
												rule = new FuzzyRule( "IF AgeInYears is Youthful  THEN Premium is Moderate ");
												fuz.addRule(rule);
												
												
											rule = new FuzzyRule( "IF AgeInYears is Young Then..; Premium is Low");
										fuz.addRule(rule);
										rule = new FuzzyRule( "IF AgeInYears is YoungTHEN Premium is ModeratelyLow");
											fuz.addRule(rule);
											rule = new FuzzyRule( "IF AgeInYears is Young  THEN Premium is ModeratelyLow");
												fuz.addRule(rule);
												rule = new FuzzyRule( "IF AgeInYears is Young THEN Premium is Moderate");
													fuz.addRule(rule);
													rule = new FuzzyRule( "IF AgeInYears is Young  THEN Premium is ModeratelyHigh");
														fuz.addRule(rule);
														
														
																	rule = new FuzzyRule( "IF AgeInYears is MiddleAged Then..; Premium is ModeratelyLow");
														fuz.addRule(rule);
														rule = new FuzzyRule( "IF AgeInYears is MiddleAged, THEN Premium is ModeratelyLow");
															fuz.addRule(rule);
															rule = new FuzzyRule( "IF AgeInYears is MiddleAged  THEN Premium is Moderate");
																fuz.addRule(rule);
																rule = new FuzzyRule( "IF AgeInYears is MiddleAged  THEN Premium is ModeratelyHigh");
																	fuz.addRule(rule);
																	rule = new FuzzyRule( "IF AgeInYears is MiddleAged THEN Premium is ModeratelyHigh");
																		fuz.addRule(rule);	/**/
											
								
								/*	rule = new FuzzyRule( "IF AgeInYears is Young ,;and Health is, Excellent Then..; Premium is Low");
										fuz.addRule(rule);
										rule = new FuzzyRule( "IF AgeInYears is Young and Health is Good, THEN Premium is ModeratelyLow");
											fuz.addRule(rule);
											rule = new FuzzyRule( "IF AgeInYears is Young and Health is Average THEN Premium is ModeratelyLow");
												fuz.addRule(rule);
												rule = new FuzzyRule( "IF AgeInYears is Young and Health is Below Average THEN Premium is Moderate");
													fuz.addRule(rule);
													rule = new FuzzyRule( "IF AgeInYears is Young and Health is Poor THEN Premium is ModeratelyHigh");
														fuz.addRule(rule);
														
														rule = new FuzzyRule( "IF AgeInYears is MiddleAged ,;and Health is, Excellent Then..; Premium is ModeratelyLow");
														fuz.addRule(rule);
														rule = new FuzzyRule( "IF AgeInYears is MiddleAged and Health is Good, THEN Premium is ModeratelyLow");
															fuz.addRule(rule);
															rule = new FuzzyRule( "IF AgeInYears is MiddleAged and Health is Average THEN Premium is Moderate");
																fuz.addRule(rule);
																rule = new FuzzyRule( "IF AgeInYears is MiddleAged and Health is Below Average THEN Premium is ModeratelyHigh");
																	fuz.addRule(rule);
																	rule = new FuzzyRule( "IF AgeInYears is MiddleAged and Health is Poor THEN Premium is ModeratelyHigh");
																		fuz.addRule(rule);
																		
																		
																			rule = new FuzzyRule( "IF AgeInYears is Mature ,;and Health is, Excellent Then..; Premium is ModeratelyLow");
																			fuz.addRule(rule);
																			rule = new FuzzyRule( "IF AgeInYears is Mature and Health is Good, THEN Premium is Moderate");
																				fuz.addRule(rule);
																				rule = new FuzzyRule( "IF AgeInYears is Mature and Health is Average THEN Premium is ModeratelyHigh");
																					fuz.addRule(rule);
																					rule = new FuzzyRule( "IF AgeInYears is Mature and Health is Below Average THEN Premium is ModeratelyHigh");
																						fuz.addRule(rule);
																						rule = new FuzzyRule( "IF AgeInYears is Mature and Health is Poor THEN Premium is High");
																							fuz.addRule(rule);
																							
																								rule = new FuzzyRule( "IF AgeInYears is Old ,;and Health is, Excellent Then..; Premium is ModeratelyLow");
																								fuz.addRule(rule);
																								rule = new FuzzyRule( "IF AgeInYears is Old and Health is Good, THEN Premium is Moderate");
																									fuz.addRule(rule);
																									rule = new FuzzyRule( "IF AgeInYears is Old and Health is Average THEN Premium is ModeratelyHigh");
																										fuz.addRule(rule);
																										rule = new FuzzyRule( "IF AgeInYears is Old and Health is Below Average THEN Premium is ModeratelyHigh");
																											fuz.addRule(rule);
																											rule = new FuzzyRule( "IF AgeInYears is Old and Health is Poor THEN Premium is High");
																												fuz.addRule(rule);*/
						
								fuz.toString();
					
									
							
				
				//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3 AND W IS W1 OR Q IS Q1");
			
			//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3 AND W IS W1 OR Q IS Q1");
		//rule = new FuzzyRule("A IS A1 AND B IS B1 OR (B IS B2 AND C IS NOT C1) THEN V IS V3 AND W IS W1 OR Q IS Q1");
		//(A IS A1 AND B IS B1 THEN RESULT) AND (B IS B2 AND C IS NOT C1 THEN RESULT)
		//(A IS A1 THEN RESULT OR B IS B1 THEN RESULT) AND (B IS B2 THEN RESULT OR C IS NOT C1 THEN RESULT)
		//
		
		
		/*trace( fuz.toString());
		// fuz.addRule(rule);
		trace("--------------------Reduction SIMPLE_1---------------");
		 fuz.reduce(ReductionMethod.SIMPLE_1, false);
		 
		 trace( fuz.toString());	*/
	
	/* trace("----------------------------------------------------------");
		trace("--------------------Reduction SIMPLE_2---------------");*/
		 fuz.reduce(ReductionMethod.SIMPLE_2,false);
		  trace( fuz.toString());
		  trace("----------------------------------------------------------");	
			
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