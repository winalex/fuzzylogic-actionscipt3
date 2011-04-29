package
{
	import flash.display.Sprite;
	import flash.geom.Matrix3D;
	import flash.utils.Dictionary;
	import winxalex.fuzzy.*;
	
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class TestReduceYamExample5 extends Sprite
	{
		
		public function TestReduceYamExample5() 
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
			
			manifold = new FuzzyManifold("X");
			manifold.input = ageInput;
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Pos1", -5,-5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Pos2", 2.5, -2.5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Pos3", 2.5, 0, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Pos4", 2.5, 2.5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
				
			//left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Pos5", 2.5,5.0, 5.0 );
			manifold.addMember(func);
			trace(func.toString());/*	*/
			
	
			
			
			
				fuz.addManifold(manifold);
				
			trace("-----------------------------------------------------------------------");
			
			
			manifold = new FuzzyManifold("Y");
			manifold.input = healthInput;
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Pos1", -5,-5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Pos2", 2.5, -2.5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Pos3", 2.5, 0, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
					//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Pos4", 2.5, 2.5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
				
			//left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Pos5", 2.5,5, 5 );
			manifold.addMember(func);
			trace(func.toString());
			
				/**/
			
			fuz.addManifold(manifold);
			
			trace("-----------------------------------------------");
			
			
				trace("-----------------------------------------------------------------------");
			
			
			/*manifold = new FuzzyManifold("Test");
			manifold.input = healthInput;
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Pos1", -5,-5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Pos2", 2.5, -2.5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Pos3", 2.5, 0, 2.5 );
			manifold.addMember(func);
			trace(func.toString());*/
			
	
			
				fuz.addManifold(manifold);
			
			trace("-----------------------------------------------");
			
			manifold = new FuzzyManifold("Z");
			
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Z1", -10,-10, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
		
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Z2", 2.5, -7.5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Z3", 2.5, -5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Z4", 2.5, -2.5,2.5  );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Z5", 2.5, 0, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Z6", 2.5, 2.5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
			
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Z7", 2.5, 5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
				
				//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Z8", 2.5, 7.5, 2.5 );
			manifold.addMember(func);
			trace(func.toString());
				
				
				/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Z9", 2.5,10, 10 );
			manifold.addMember(func);
			trace(func.toString());
			
			fuz.addManifold(manifold);
			
			trace("----------------------------------------------------------------------------");
			
		
			
			/*test of removing ,;...*/
			rule = new FuzzyRule( "IF X is Pos1 ,;and Y is, Pos1 Then..; Z is Z1 ");
				fuz.addRule(rule);
				rule = new FuzzyRule( "IF X is Pos1 and Y is Pos2, THEN Z is Z2 ");
					fuz.addRule(rule);
					rule = new FuzzyRule( "IF X is Pos1 and Y is Pos3 THEN Z is Z3 ");
						fuz.addRule(rule);
						rule = new FuzzyRule( "IF X is Pos1 and Y is Pos4 THEN Z is Z4 ");
							fuz.addRule(rule);
							rule = new FuzzyRule( "IF X is Pos1 and Y is Pos5 THEN Z is Z5");
								fuz.addRule(rule);
								
								
											
								
									rule = new FuzzyRule( "IF X is Pos2 ,;and Y is, Pos1 Then..; Z is Z2");
										fuz.addRule(rule);
										rule = new FuzzyRule( "IF X is Pos2 and Y is Pos2, THEN Z is Z3");
											fuz.addRule(rule);
											rule = new FuzzyRule( "IF X is Pos2 and Y is Pos3 THEN Z is Z4");
												fuz.addRule(rule);
												rule = new FuzzyRule( "IF X is Pos2 and Y is Pos4 THEN Z is Z5");
													fuz.addRule(rule);
													rule = new FuzzyRule( "IF X is Pos2 and Y is Pos5 THEN Z is Z6");
														fuz.addRule(rule);
														
														rule = new FuzzyRule( "IF X is Pos3 ,;and Y is, Pos1 Then..; Z is Z3");
														fuz.addRule(rule);
														rule = new FuzzyRule( "IF X is Pos3 and Y is Pos2, THEN Z is Z4");
															fuz.addRule(rule);
															rule = new FuzzyRule( "IF X is Pos3 and Y is Pos3 THEN Z is Z5");
																fuz.addRule(rule);
																rule = new FuzzyRule( "IF X is Pos3 and Y is Pos4 THEN Z is Z6");
																	fuz.addRule(rule);
																	rule = new FuzzyRule( "IF X is Pos3 and Y is Pos5 THEN Z is Z7");
																		fuz.addRule(rule);
																		
																		
																			rule = new FuzzyRule( "IF X is Pos4 ,;and Y is, Pos1 Then..; Z is Z4");
																			fuz.addRule(rule);
																			rule = new FuzzyRule( "IF X is Pos4 and Y is Pos2, THEN Z is Z5");
																				fuz.addRule(rule);
																				rule = new FuzzyRule( "IF X is Pos4 and Y is Pos3 THEN Z is Z6");
																					fuz.addRule(rule);
																					rule = new FuzzyRule( "IF X is Pos4 and Y is Pos4 THEN Z is Z7");
																						fuz.addRule(rule);
																						rule = new FuzzyRule( "IF X is Pos4 and Y is Pos5 THEN Z is Z8");
																							fuz.addRule(rule);
																							
																								rule = new FuzzyRule( "IF X is Pos5 ,;and Y is, Pos1 Then..; Z is Z5");
																								fuz.addRule(rule);
																								rule = new FuzzyRule( "IF X is Pos5 and Y is Pos2, THEN Z is Z6");
																									fuz.addRule(rule);
																									rule = new FuzzyRule( "IF X is Pos5 and Y is Pos3 THEN Z is Z7");
																										fuz.addRule(rule);
																										rule = new FuzzyRule( "IF X is Pos5 and Y is Pos4 THEN Z is Z8");
																											fuz.addRule(rule);
																											rule = new FuzzyRule( "IF X is Pos5 and Y is Pos5 THEN Z is Z9");
																												fuz.addRule(rule);
						
						
					
									
							
				
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
		trace("--------------------Reduction SIMPLE_2---------------");
		 fuz.reduce(ReductionMethod.SIMPLE_2,false);
		  trace( fuz.toString());
		  trace("----------------------------------------------------------");*/	
		
		 
		 
		 
		 	trace(	fuz.toString());
	/*	  trace("--------------------Reduction SVD---------------");
		 fuz.reduce(ReductionMethod.SVD,false);
		  trace( fuz.toString());
		  trace("----------------------------------------------------------");*/
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