package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import winxalex.fuzzy.*;
	
	
	/**
	 * ...
	 * @author alex winx
	 * 
	 * desirablity to choose rocket luncher weapon depending of ammo and distance to enemy
	 */
	public class Test1OOPRules extends Sprite
	{
		
		public function Test1OOPRules():void
		{
			var tempStek:Vector.<Token>;
			var tf:TextField;
			var fuz:Fuzzificator= new Fuzzificator();
			var factory:IFuzzyMembershipFunctionFactory = FuzzyMembershipFunctionFactory.getInstance();
			var manifold:FuzzyManifold;
			var func:FuzzyMembershipFunction;
			var rule:FuzzyRule;
			var ammoStatusInput:FuzzyInput;
			var distanceStatusInput:FuzzyInput;
			var fuzzyManifolds:Dictionary;
			var container1:Sprite;
			
			ammoStatusInput = new FuzzyInput();
			distanceStatusInput = new FuzzyInput();
			
			manifold = new FuzzyManifold("Desirability");
			
			
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Undesirable", 0,25, 50 ); //[0 0 25 50]
			manifold.addMember(func);
			trace(func.toString());
			
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Desirable", [25, 50, 75] );//  [25 50 75]
			manifold.addMember(func);
			trace(func.toString());
				
			/**///left0ffset,leftMidPoint,rightMidPoint
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "VeryDesirable", 50, 75,100 );// [50 75 100 100]
			manifold.addMember(func);
			trace(func.toString());
			
			
			container1 = new Sprite();
			container1.y = 60;
			container1.x = 5;
			addChild(container1);
			tf = new TextField();
			tf.y = 10;
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.text = manifold.name;
			container1.addChild(tf);
			manifold.draw(container1.graphics,5);
			
			
			
				fuz.addManifold(manifold);
				
			trace("-----------------------------------------------------------------------");
			
			
			manifold = new FuzzyManifold("Distance_to_Target");
			manifold.input = distanceStatusInput;
			
			//!!! Warning make them sorted  by X so CENTROID won't fail 
			
			func = factory.create(FuzzyMembershipFunction.LEFT_SHOULDER, "Close", 0,25, 125 );//[0 0 25 125]
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Close:"+func.degreeOfMembership);
			
			
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Medium", 25, 150, 300 );// [25 150 300]
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Medium:" + func.degreeOfMembership);
			
			
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Far", "150, 300,400","," )  ;//  [150 300 400 400]
			//IFuzzyMembershipFunction(func).calculateDOM(200);
			manifold.addMember(func);
			//trace("Far:"+func.degreeOfMembership);
			
			var container2:Sprite = new Sprite();
			container2.y = 140;
			container2.x = 5;
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.text = manifold.name;
			container2.addChild(tf);
			tf.y = 10;
			addChild(container2);
			manifold.draw(container2.graphics);
			
			fuz.addManifold(manifold);
			
			
			
			trace("-----------------------------------------------");
			
			manifold = new FuzzyManifold("Ammo_Status");
			manifold.input = ammoStatusInput;
			
			
			func = factory.create(FuzzyMembershipFunction.RIGHT_SHOULDER, "Loads", 10,30, 40 ); // [10 30 40 40]
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			manifold.addMember(func);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Low",  0, 0, 10);// [0 0 0 10]
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			manifold.addMember(func);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			
			func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Okey", 0, 10, 30 );// [0 10 30]
			//IFuzzyMembershipFunction(func).calculateDOM(8);
			//trace(func.linguisticTerm+":"+func.degreeOfMembership);
			//trace(func.toString());
			manifold.addMember(func);
			
			var container3:Sprite = new Sprite();
			container3.y = 250;
			container3.x = 5;
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.text = manifold.name;
			tf.y = 10;
			container3.addChild(tf);
			addChild(container3);
			manifold.draw(container3.graphics,10);
			
			fuz.addManifold(manifold);
			
			trace("----------------------------------------------------------------------------");
			
		
			
			/**/
			rule = new FuzzyRule( "IF Distance_to_Target IS Far AND Ammo_Status IS Loads THEN Desirability IS Desirable");
				fuz.addRule(rule);
				
				//Rule:IF Distance_to_Target IS Far AND Ammo_Status IS Okey THEN Desirability IS Undesirable has fired TRUE with result:0.3333333333333333
				//rule = new FuzzyRule(Distance_to_Target,Far,Ammo_Status
				
				rule = new FuzzyRule();
				tempStek = new Vector.<Token>(3,true);
				
				// creation antescendent(condition stek) stek like "Distance_to_Target IS Far AND Ammo_Status IS Okey"
				/*v 1.0.1 implemenation
				 tempStek[0] = new Token(0, FuzzyOperator.fDOM, ["Distance_to_Target", "Far", fuz]);
				tempStek[1] = new Token(1, FuzzyOperator.fDOM, ["Ammo_Status", "Okey", fuz]);*/
				 tempStek[0] = new Token(0, FuzzyOperator.fDOM, [fuz.inputFuzzymanifolds.Distance_to_Target.memberfunctions.Far]);
				tempStek[1] = new Token(1, FuzzyOperator.fDOM, [fuz.getManifold("Ammo_Status").memberfunctions.Okey]);
			
				var result:Token=tempStek[2] = new Token(2, FuzzyOperator.fMIN, [tempStek[0], tempStek[1]]);
				rule.antCompiledStek = tempStek;
				
				// creation result stek like "Desirability IS Undesirable"
				tempStek = new Vector.<Token>(2,true);
				tempStek[0] = new Token(0, fuz.implication, [result,new Token(0,null,null,1)]);
				tempStek[1] = new Token(1, FuzzyOperator.fAGGREGATE, [fuz.outputFuzzyManifolds.Desirability.memberfunctions.Undesirable,fuz,rule.weight,tempStek[0]]);
				
				
			
				rule.conCompiledStek = tempStek;
				
				fuz.addRule(rule, false);
				
				
				
			/*
				/*rule = new FuzzyRule( " IF Distance_to_Target IS Far AND Ammo_Status IS Okey THEN Desirability IS Undesirable");
					fuz.addRule(rule);*/
					
								
	rule = new FuzzyRule(
						function():Number 
						{
							//IF MEDIUM AND LOW
							return	fuz.AND.call(null,
										   fuz.inputFuzzymanifolds.Distance_to_Target.memberfunctions.Far.degreeOfMembership,
											
											fuz.inputFuzzymanifolds.Ammo_Status.memberfunctions.Low.degreeOfMembership
										)
								 
						},//THEN UNDESIRABLE
						fuz.outputFuzzyManifolds.Desirability.memberfunctions.Undesirable
				      );
					  
		 fuz.addRule(rule,false);
					
			/*	rule = new FuzzyRule( " IF Distance_to_Target IS Far AND  Ammo_Status IS Low THEN Desirability IS Undesirable ");
						fuz.addRule(rule);*/
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
												
									
			
								/*if (
									and{
									fuz.inputFuzzymanifolds.Distance_to_Target.membershipfunction.Close;  
									fuz.inputFuzzymanifolds.Ammo_Status.membershipfunction.Low;
									}
								)
								{
									fuz.inputFuzzymanifolds.Desirability.membershipfunction.Undesirable;
								}*/
			
			trace(fuz.getManifold("Desirability").toString());
			
		
			
			ammoStatusInput.value = 8;
			distanceStatusInput.value = 200
			/**/
			/*
			ammoStatusInput.value = 1;
			distanceStatusInput.value = 398.85;*/
			
			/*ammoStatusInput.value = 30;
			distanceStatusInput.value = 398.85;*/
			
			/*ammoStatusInput.value = 30;
			distanceStatusInput.value = 398.85;*/
			
			/*
			ammoStatusInput.value = 17;
			distanceStatusInput.value = 397;*/
			
			
			
			trace("INPUT> ammo:" + ammoStatusInput.value + " distance:" + distanceStatusInput.value);
			
			fuz.Fuzzify();
			
			
			/*fuz.getManifold("Distance_to_Target").fillArea();
			fuz.getManifold("Ammo_Status").fillArea();
			
	    	fuz.getManifold("Desirability").fillArea();*/
			
			
			//can draw dots of the bounding shape (for debug uncomment  drawAreaShapePoints);
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTROID);
			
			trace("OUTPUT COG:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			/*						
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.MEAN_OF_MAXIMUM);
			//fuz.getManifold("Desirability").reset();
			trace("OUTPUT MOM:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			
			//fuz.getManifold("Desirability").reset();
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTAR_OF_SUM);
			
			trace("OUTPUT COS:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);*/
			
			//	fuz.getManifold("Desirability").reset();
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod. AVERAGE_OF_MAXIMA);
			
			trace("OUTPUT MAXAV:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			/*	//fuz.getManifold("Desirability").reset();
				fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTER_OF_AREA);
			
			trace("OUTPUT COA:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);*/
			
					
			trace(fuz.getManifold("Desirability").toString());
			return;
			
			
			 ammoStatusInput.value = 15;
			distanceStatusInput.value = 100;
			
			trace("INPUT> ammo:" + ammoStatusInput.value + " distance:" + distanceStatusInput.value);
			
			//use reset before new Fuzzification
			//fuz.getManifold("Desirability").reset();
			fuz.Fuzzify();
			

			trace(fuz.getManifold("Desirability").toString());
		
				
			fuzzyManifolds= fuz.Defuzzify(DefuzzificationMethod.MEAN_OF_MAXIMUM);
			
			trace("OUTPUT MOM:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			//fuz.getManifold("Desirability").reset();
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod. AVERAGE_OF_MAXIMA);
			
			trace("OUTPUT MAXAV:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			//fuz.getManifold("Desirability").reset();
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTER_OF_AREA);
			
			trace("OUTPUT COA:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTROID);
			
			trace("OUTPUT COG:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			
			
			
			ammoStatusInput.value = 8;
			distanceStatusInput.value = 200;
			
			//fuz.getManifold("Desirability").reset();
			
			fuz.Fuzzify();
			
			
			
			trace(fuz.getManifold("Desirability").toString());
		
			
			fuzzyManifolds= fuz.Defuzzify(DefuzzificationMethod.MEAN_OF_MAXIMUM);
			
			trace("OUTPUT MOM:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			//fuz.getManifold("Desirability").reset();
		
			fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTAR_OF_SUM);
			
			trace("OUTPUT COS:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			
				//fuz.getManifold("Desirability").reset();
				
		 	fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod. AVERAGE_OF_MAXIMA);
			
			trace("OUTPUT MAXAV:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
			
			
				//	fuz.getManifold("Desirability").reset();
			
				fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTER_OF_AREA);
			
			trace("CENTROID:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);
		
			
		
			
		/*	

Distance_to_Target Close 0
Distance_to_Target Far 0.3333333333333333
Distance_to_Target Medium 0.6666666666666666
Ammo_Status Low 0.2
Ammo_Status Loads 0
Ammo_Status Okey 0.8
OUTPUT MOM:83.33333333333333
OUTPUT COS:61.85185185185184
OUTPUT MAXAV:60.41666666666667
OUTPUT COA:63.913043478260875




10 max:0.3333333333333333
20 max:0.3333333333333333
30 max:0.3333333333333333
40 max:0.3333333333333333
50 max:0.2
60 max:0.40000000000000036
70 max:0.6666666666666666
80 max:0.6666666666666666
90 max:0.6666666666666666
100 max:0.6666666666666666
		
		
			//var rule:FuzzyRule;
			//rule = new FuzzyRule("A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3) THEN V IS V3");
			//fuz.addRule(rule);
			//var result:Number = rule.evaluate();
			
			//trace(result);
			
		*/
			
			
			
			
		}
		
		
		public function OR(...args):Number
		{
			trace("OR");
			/*return function(...args):void
			{
				
			}*/
			
			return 0;
		}
		
		public function AND(...args):Number
		{
			
			trace("AND");
			/*return function(...args):void
			{
				
			}*/
			
			return 0;
		}
		
		
		
	}

}