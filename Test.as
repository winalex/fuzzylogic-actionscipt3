package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import winxalex.fuzzy.*;
	
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class Test extends Sprite
	{
		
		public function Test() 
		{
			var fuz:Fazzificatior = new Fazzificatior();
			var factory:IFuzzyMembershipFunctionFactory = FuzzyMembershipFunctionFactory.getInstance();
			var manifold:FuzzyManifold;
			var func:FuzzyMembershipFunction;
			var rule:FuzzyRule;
			var ammoStatusInput:FuzzyInput;
			var distanceStatusInput:FuzzyInput;
			
			ammoStatusInput = new FuzzyInput();
			distanceStatusInput = new FuzzyInput();
			
			manifold = new FuzzyManifold("Desirability");
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Desirable", 25, 50, 25 );
			manifold.addMember(func);
			trace(func.toString());
				
			/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "VeryDesirable", 25, 75,100 );
			manifold.addMember(func);
			trace(func.toString());
			
			//leftMidPoint,rightMidPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Undesirable", 0,25, 25 );
			manifold.addMember(func);
			trace(func.toString());
			
			
			
			
				fuz.addManifold(manifold);
				
			trace("-----------------------------------------------------------------------");
			
			
			manifold = new FuzzyManifold("Distance_to_Target");
			manifold.input = distanceStatusInput;
			//left0ffset,peakPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Far", 150, 300,400 )  ;
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Far:"+func.degreeOfMembership);
			
			//peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Close", 0,25, 125 );
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Close:"+func.degreeOfMembership);
			
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Medium", 125, 150, 150 );
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Medium:" + func.degreeOfMembership);
			
			
			fuz.addManifold(manifold);
			
			
			
			trace("-----------------------------------------------");
			
			manifold = new FuzzyManifold("Ammo_Status");
			manifold.input = ammoStatusInput;
			
			//left0ffset,peakPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Loads", 10, 20,40 ); 
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			manifold.addMember(func);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			//peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Low", 0,0, 10 );
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			manifold.addMember(func);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Okey", 10, 10, 20 );
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			manifold.addMember(func);
			
			fuz.addManifold(manifold);
			
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
												
			
			
			
			
		
			ammoStatusInput.value = 8;
			distanceStatusInput.value = 200
			
			
			
			fuz.Fuzzify();
			
			
			
		
			
			var fuzzyManifolds:Dictionary = fuz.Defuzzify(DefuzzificationMethod.MEAN_OF_MAXIMUM);
			
			trace("OUTPUT MOM:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.MAX_AVERAGED);
			
			trace("OUTPUT MAXAV:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTAR_OF_SUM);
			
			trace("OUTPUT CENTROID:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			/*
			 * 
			 * ammoStatusInput.value = 8;
			distanceStatusInput.value = 200
			
			
			
			fuz.Fuzzify();
			
			
			trace(fuz.getManifold("Desirability").toString());
		
			
			var fuzzyManifolds:Dictionary = fuz.Defuzzify(DefuzzificationMethod.MEAN_OF_MAXIMUM);
			
			trace("OUTPUT MOM:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.MAX_AVERAGED);
			
			trace("OUTPUT MAXAV:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTROID);
			
			trace("OUTPUT CENTROID:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			*/
			//trace(fuz.getManifold("Desirability").toString());
			
			//TODO check with new input how would rule evaluate react.
			
			//TODO						FuzzyMembershipFunction(func).levelOfConfidence = 0;
			
		/*	

			//var rule:FuzzyRule;
			//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3");
			//fuz.addRule(rule);
			//var result:Number = rule.evaluate();
			
			//trace(result);
			
			//fuz.fuzzymanifolds[
			//fuz.fuzzymanifolds[
			

			//factory.create(
			//var func:FuzzyTrianlgeMembershipFunction;
			/*
			var manifold:FuzzyManifold
			
			fuz.addRule(new FuzzyRule());
			
			manifold = new FuzzyManifold("");
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			
			manifold = new FuzzyManifold("");
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			manifold.addMember(new FuzzyTrianlgeMembershipFunction(
			fuz.addManifold(manifold);
			
			fuz.Fuzzify(*/
			//trace(func.toString());
			
			
			
			
		}
		
	}

}