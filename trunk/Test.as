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
			var manifold:FuzzyManifold;
			var func:FuzzyMembershipFunction;
			
			manifold = new FuzzyManifold("Desirability");
			//manifold.addMember(factory.create(FuzzyMembershipFunction.TRIANGLE, "Very Desirable", 230, 120, 320));
			
			
			//factory.create(FuzzyMembershipFunction.LEFT_SHOULDER,"bla", 230, 120, 320);
			
			/*//left0ffset,peakPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Very Desirable", 25, 75 ).calculateDOM(75);
			manifold.addMember(func);
			trace(func.degreeOfMembership);
			
			//peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "UnDesirable", 25, 25 ).calculateDOM(75);
			manifold.addMember(func);
			trace(func.degreeOfMembership);
			
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Desirable", 25, 50, 25 ).calculateDOM(75);
			manifold.addMember(func);
			trace(func.degreeOfMembership);*/
			
			manifold = new FuzzyManifold("Distance to Target");
			//left0ffset,peakPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Far", 150, 300 )  ;
			IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			trace("Far:"+func.degreeOfMembership);
			
			//peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Close", 25, 125 );
			IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			trace("Close:"+func.degreeOfMembership);
			
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Medium", 125, 150, 150 );
			IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			trace("Medium:" + func.degreeOfMembership);
			
			trace("-----------------------------------------------");
			
			manifold = new FuzzyManifold("Ammo Status");
			//left0ffset,peakPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Loads", 10, 20 ); 
			IFuzzyMembershipFunction(func).calculateDOM(8);
			manifold.addMember(func);
			trace(func.linguisticTerm+":"+func.degreeOfMembership);
			trace(func.toString());
			//peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Low", 0, 10 );
			IFuzzyMembershipFunction(func).calculateDOM(8);
			manifold.addMember(func);
			trace(func.linguisticTerm+":"+func.degreeOfMembership);
			trace(func.toString());
			
			//leftOffset,peakPoint,rightOffset
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Okey", 10, 10, 20 );
			IFuzzyMembershipFunction(func).calculateDOM(8);
			trace(func.linguisticTerm+":"+func.degreeOfMembership);
			trace(func.toString());
			
		/*	Rule 1. IF Target_Far AND Ammo_Loads THEN Desirable 

			Rule 2. IF Target_Far AND Ammo_Okay THEN Undesirable 

			Rule 3. IF Target_Far AND Ammo_Low THEN Undesirable 

			Rule 4. IF Target_Medium AND Ammo_Loads THEN VeryDesirable 

			Rule 5. IF Target_Medium AND Ammo_Okay THEN VeryDesirable 

			Rule 6. IF Target_Medium AND Ammo_Low THEN Desirable 

			Rule 7. IF Target_Close AND Ammo_Loads THEN Undesirable 

			Rule 8. IF Target_Close AND Ammo_Okay THEN Undesirable 

			Rule 9. IF Target_Close AND Ammo_Low THEN Undesirable*/

			//var rule:FuzzyRule;
			//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3");
			//faz.addRule(rule);
			//var result:Number = rule.evaluate();
			
			//trace(result);
			
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
			//trace(func.toString());
			
			
			
			
		}
		
	}

}