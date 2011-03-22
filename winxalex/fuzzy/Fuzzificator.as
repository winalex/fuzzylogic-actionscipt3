package winxalex.fuzzy 
{
	
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author alex winx
	 * 
	 * 
	 * 
	 * 
	 * 
	 */
	public  class Fuzzificator
	{
		
	 //a map of all the fuzzy variables this module uses
     internal var inputFuzzymanifolds:AssociativeArray;   ///Dictionary;
	 internal var outputFuzzyManifolds:Dictionary;
  
	 
	 public var type:uint = FuzzificatorType.MAMDANI;
	 
	 /**
	  * default MIN, other popular PRODUCT,... see FuzzyOperator for other options
	  */
	 public var implication:Function = FuzzyOperator.fMIN;//implication, activation
	 
	 /**
	  *  default MAX, other popular SUM, PROBSUM
	  */
     public var aggregation:Function =FuzzyOperator.fMAX ;//combination
    
	 /**
	  *     default MIN, other popular PRODUCT
	  */
	 //private var _AND:FunctionProxy = //new FunctionProxy(FuzzyOperator.fMIN);
	 
	 /**
	  *  default MAX, other popular SUM
	  */
	 private var _OR:Function = FuzzyOperator.fMAX;
	 
	 
	 private var _AND:Function = FuzzyOperator.fMIN;
    
	
	internal function fAND(...args):Number
	 {
		 return _AND.apply(null, args);
	 }
	 
	 internal function fOR(...args):Number
	 {
		 return _OR.apply(null, args);
	 }


  //a list containing all the fuzzy rules
  private var fuzzyRules:SLinkedList;
  private var _ruleMatrix:Vector.<*> ; //Vector.<Vector.<Number>>;
  private var _nInputManifolds:int=0;
  private var _nOutputManifolds:int=0;
  
		
		
		public function Fuzzificator() 
		{
			inputFuzzymanifolds = new AssociativeArray();// new Dictionary(true);
			outputFuzzyManifolds = new Dictionary(true);
			fuzzyRules = new SLinkedList();
		
		}
		
		public function addManifold(manifold:FuzzyManifold):void
		{
			if (manifold.input)
			{
				inputFuzzymanifolds[manifold.name] = manifold;
				_nInputManifolds++;
			}
			else
			{
				outputFuzzyManifolds[manifold.name] = manifold;
				_nOutputManifolds++;
			}
			
		}
		
		public function getManifold(name:String):FuzzyManifold
		{
			var manifold:FuzzyManifold;
			manifold = inputFuzzymanifolds[name];
			if(!manifold)
			manifold=outputFuzzyManifolds[name];
			
			return manifold;
		}
	
		
		
	   //adds a rule to the fazificator
		public function addRule(rule:FuzzyRule,compile:Boolean=true):void
		{
			fuzzyRules.append(rule);
			
			
			//TODO create matrix at creation of rules
			///rule.antecedent.match
			
			if (compile)
			rule.compile(this);
			
			
			
		}
		
		/**
		 *  simple Comb1, simpleComb2, additivly separable or inseparable ///dumpOnly:Boolean
		 */
		public function reduce(method:uint=0,dump:Boolean=true):void
		{
			
			//trace("rules should have form A IS A1 AND B IS B1 THEN C IS C1");
		var  termsMatches:RegExp;
			var fm:FuzzyManifold;
			var inputMatches:Array;
			var outputMatches:Array;
			var currentMatch:String;
			var i:int = 0;
			var node:SListNode;
			var prev:SListNode;
			var rule:FuzzyRule;
			var membershipName:String;
			var manifoldName:String;
			var func:IFuzzyMembershipFunction;
			var manifoldRegExp:RegExp=FuzzyRule._manifoldRegExp;
			var membershipRegExp:RegExp =FuzzyRule._membershipRegExp;
			var rules:SLinkedList;
			var numNewRules:int = 0;
			var numRules:int = 0;
			var dict:Dictionary = new Dictionary(true);
			var element:FuzzyReductionElement;
			var newAverage:Number=NaN;
			
			//[p then (r and s)] is equivalent to [(p then r) and (p then s)] (5)
			numRules = fuzzyRules.size;
			
			termsMatches = FuzzyRule._termRegExp; ///\w+\s+IS\s+(NOT\s+)?((VERY|SOMEWHAT)\s+)?\w+/ig;
			
			node = fuzzyRules.head;
			
		
			
			
			
			while(node!=fuzzyRules.tail.next)
				{
					//get Rule
					rule = FuzzyRule(node.data);
					
				trace(rule.antecedent+rule.consequence);
					
					//get antecendents terms
					 inputMatches = rule.antecedent.match(termsMatches);
					 
					 //trace("in:"+inputMatches.join(','),rule.antecedent);
						
					 //get consequence terms
					outputMatches = rule.consequence.match(termsMatches);
					// trace("out:"+outputMatches.join(','),rule.consequence);
					
					//for every antecendents Terms
						for (i = 0; i < inputMatches.length; i++)
						{
							
							currentMatch = outputMatches[0];
							membershipName=currentMatch.match (membershipRegExp)[0];
							manifoldName = currentMatch.match(manifoldRegExp)[0];
							
						
							fm = FuzzyManifold(outputFuzzyManifolds[manifoldName]);
						
							currentMatch = inputMatches[i];
							
							//trace(currentMatch);
							
							//if "antecendents Term THEN concequent" Term exist => calculate
							if (dict[currentMatch])
							{
								element = FuzzyReductionElement(dict[currentMatch]);
								
								
								switch(method)
								{
									case ReductionMethod.SIMPLE_1:
									newAverage = IFuzzyMembershipFunction(fm.memberfunctions[membershipName]).averagePoint;
									trace("-----------------------------------------------");
									  trace(membershipName);
									trace(">"+element.data, newAverage);
										if (element.data!=newAverage)//element.average ^ newAverage)//element.average!=newAverage
										{
											
										trace("REDUCING>>" + currentMatch + " THEN " + membershipName + " Average between 2 average points:(" + newAverage + "-" + element.data + ")/2=" + ( (newAverage - element.data) / 2) + " new SUM:(" + element.data +"+"+ (newAverage - element.data) / 2+")="+(element.data+(newAverage - element.data) / 2));
								
										newAverage = (newAverage - element.data) / 2;
										//trace(newAverage);
										element.data += newAverage;// newAverage < 0 ? -newAverage:newAverage;
										//trace("Calc: "+currentMatch + " :" +element.average);
										
								
										}
									break;
									case ReductionMethod.SIMPLE_2:
									
									   // trace(fm.memberfunctions[membershipName].toString());
									   
									   trace(membershipName);
									
										newAverage = IFuzzyMembershipFunction(fm.memberfunctions[membershipName]).averagePoint;
										
									trace("REDUCING>>"+currentMatch + " THEN " + membershipName + " Average point sum:(" + element.data+"+"+newAverage+")="+(element.data +newAverage));
									
										element.data += newAverage;
									break;
								}
								
							
							
							}
							else
							{
								//trace(fm.name, membershipName);
								//trace('add');
								//trace(currentMatch,IFuzzyMembershipFunction(fm[membershipName]));
								trace("REDUCING >> INIT ");
								  trace(membershipName);
								//save found unique antescendent assocated with consequent fuzzyManifold and averagePoint
								dict[currentMatch] = new FuzzyReductionElement(fm, IFuzzyMembershipFunction(fm.memberfunctions[membershipName]).averagePoint);
								numNewRules++;
								
								// trace(fm.memberfunctions[membershipName].toString());
							}
						}
					
					node = node.next;
				}
				
				
				//trace("fuzzyRules", fuzzyRules);
				//trace("fuzzyRules", fuzzyRules.head);
					node = fuzzyRules.head;
			//trace("node", node.data);
				
				for (var key:String in dict)
				{
					
					
					element = FuzzyReductionElement(dict[key]);
				
					
					switch(method)
					{
						case ReductionMethod.SIMPLE_1:
						   if (dump)
						   {
							   	trace("REDUCED>>");
						   //	trace("average:"+element.average+"   rule:" +key + " THEN " + element.consequentManifold.name+" IS "+element.consequentManifold.getMaxDOMFunc(element.average).linguisticTerm);
		                  trace("rule=new Rule(" +key + " THEN " + element.consequentManifold.name+" IS "+element.consequentManifold.getMaxDOMFunc(element.data).linguisticTerm+")");
						   }
						  else
						   {
							   	trace("REDUCED>>");
							 /*  if (!node) 
									{
										this.addRule(new FuzzyRule("IF " + key + " THEN " + element.consequentManifold.name + " IS " + element.consequentManifold.getMaxDOMFunc(element.average).linguisticTerm),true);
									}
									else
									{*/
									
									
									
									if (!node) 
									throw new Error("Too few rules to make reduction. Insert every with every input combination rules");
									
									trace(key + " to AVERAGE POINTS SUM=" + element.data );
							
									
										rule = FuzzyRule(node.data);
										rule.antecedent = key;
										rule.consequence = element.consequentManifold.name + " IS " + element.consequentManifold.getMaxDOMFunc(element.data).linguisticTerm;
										 rule.rule = "IF "+rule.antecedent +" THEN "+ rule.consequence;
										rule.compile(this);
									//}
							
						   }
							
						break;
						
						case ReductionMethod.SIMPLE_2:
								if (dump)
								{
									
									//trace(element.consequentManifold.memberfunctions["VeryLow"].toString());
									trace("REDUCED>>" + key + " to AVERAGE POINTS SUM =" + element.data + "/" + element.consequentManifold.memberfunctions.length + "=" + (element.data / element.consequentManifold.memberfunctions.length));
							
								
								trace("rule=new Rule("+key + " THEN " + element.consequentManifold.name+" IS "+element.consequentManifold.getMaxDOMFunc(element.data/element.consequentManifold.memberfunctions.length).linguisticTerm+")");
								}
								else
								{
									
									trace("REDUCED>>");
									rule = FuzzyRule(node.data);
									/*if (!node) 
									{
									this.addRule(new FuzzyRule("IF "+key+" THEN "+element.consequentManifold.name + " IS " + element.consequentManifold.getMaxDOMFunc(element.average).linguisticTerm), true);
									
									}
									else
									{*/
									if (!node) 
									throw new Error("Too few rules to make reduction. Insert every with every input combination rules");
									
									trace(key + " to AVERAGE POINTS SUM=" + element.data + "/" + element.consequentManifold.memberfunctions.length + "=" + (element.data / element.consequentManifold.memberfunctions.length));
									rule.antecedent = key;
									rule.consequence = element.consequentManifold.name + " IS " +element.consequentManifold.getMaxDOMFunc(element.data/element.consequentManifold.memberfunctions.length).linguisticTerm;
							      	rule.rule = "IF "+rule.antecedent +" THEN "+ rule.consequence;
									rule.compile(this);
									//}
								}
												
						break;
					}
					
					
					
					prev = node;
					node = node.next;
					
					
				}
				
			
				if (!dump && prev)
					{
						fuzzyRules.sliceAfter(prev);
						
					}
				
				
		
				
		
	
		}
		
		
		
		public function Fuzzify():void
		{
			var fm:FuzzyManifold;
			var ouputManifolds:Vector.<FuzzyManifold> = new Vector.<FuzzyManifold>;
			var node:SListNode;
			var rule:FuzzyRule;
			
			trace(this.fuzzyRules.dump());
			
			
			if (!inputFuzzymanifolds.length)
			throw new Error("No input manifolds. Please add create FuzzyInputs and attach them to some manifolds");
			
			if (!outputFuzzyManifolds.length)
			throw new Error("No output manifolds. ");
			
			
			for each (fm in inputFuzzymanifolds)
			{
				
				fm.Fuzzify();//calculate DOM
				
			}
			
			//evaluate rules
			//for each(var rule:FuzzyRule in fuzzyRules)
			node = fuzzyRules.head;
			
			trace("Num of rules:"+fuzzyRules.size);
			while(node!=fuzzyRules.tail.next)
			{
				
				rule = FuzzyRule(node.data);
				rule.reset();
				rule.evaluate();
				node = node.next;
			}
			
		
			
			
		}
		
		public function Defuzzify(method:uint,...args):Dictionary
		{
			//loop thru all manifolds that don't have inputs they are outputs
			switch(method)
			{
				case DefuzzificationMethod.CENTAR_OF_SUM:
				if(args[0])
				CoS(outputFuzzyManifolds,args[0]);
				else
				CoS(outputFuzzyManifolds);
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod. AVERAGE_OF_MAXIMA:
				AVMAX(outputFuzzyManifolds);
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod.MEAN_OF_MAXIMUM:
				MoM(outputFuzzyManifolds);
				return outputFuzzyManifolds;
				break;
				case DefuzzificationMethod.CENTER_OF_AREA_CENTROID:
				if(args[0])
				CoA(outputFuzzyManifolds,args[0]);
				else
				CoA(outputFuzzyManifolds);
				return outputFuzzyManifolds;
				break;
				
			}
			
			
			throw new Error("Not supported Defuzzificaiton Method");
		}
		
		
		private static function MoM(outputFuzzyManifolds:Dictionary):void
		{
		    var fm:FuzzyManifold;
			
			var max:Number = 0;
			var avg:Number;
			var func:FuzzyMembershipFunction;
			
			for each (fm in outputFuzzyManifolds)
			{
				
				     
							
						/**/	
						/*for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
									func = FuzzyMembershipFunction( ifunc);
								   func.maximumDOM =   func.levelOfConfidence;
								 
								 trace(func.maximumDOM);
								  
								if (ifunc.maximumPoint > max)
								{
								max = ifunc.maximumPoint;
								avg = ifunc.averagePoint;
								}
								
								
								// func.reset();
								
							}*/
							
							
							fm.output = fm.getMOM();
			}
		}
		
		
		private static function CoA(outputFuzzyManifolds:Dictionary,step:Number = 0.1):void
		{
			var input:int = 0;
			var fm:FuzzyManifold;
			var currentDOM:Number;
			var delta:Number;
			var i:int;
			
			var s2:Number=0;
			var s1:Number=0;
			var max:Number = 0;
			var func:FuzzyMembershipFunction;
			var stepBoundary:Number = step * 100;
			
			for each (fm in outputFuzzyManifolds)
			{
				s1 = 0;
				s2 = 0;
				
				
				 
						//get delta
						delta = (fm.maxRange-fm.minRange) * step;
						input = fm.minRange+delta;
						
						for (i=1; i<=stepBoundary; i++)
						{
							
							
							max = 0;
							
						/*	
						for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								func = FuzzyMembershipFunction( ifunc);						
								  func.maximumDOM = func.levelOfConfidence;
								   currentDOM = ifunc.calculateDOM(input);
									if (max < currentDOM) max = currentDOM;
									 func.reset();
								
								
							}*/
							
							max = fm.getMaxDOM(input);
						
							//trace(input,"max:" + max);
							s1 += input * max;
							s2 += max;
							
							input = input + delta;
						}
				
				
				
				fm.output = s1 / s2;
				
			}
		}
		
		
	/*	private function todoX(step:Number = 10)
		{
			var input:int = 0;
			var fm:FuzzyManifold;
			var currentDOM:Number;
			var delta:Number;
			var i:int;
			
			var s2:Number=0;
			var s1:Number=0;
			var sumDOMs:Number = 0;//for input
			var func:FuzzyMembershipFunction;
			
			for each (fm in outputFuzzyManifolds)
			{
				s1 = 0;
				s2 = 0;
				
				
				 
						//get delta
						delta = (fm.maxRange-fm.minRange) / step;
						input = fm.minRange+delta;
						
						for (i=1; i<=step; i++)
						{
							sumDOMs = 0;
							
							for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								
							   currentDOM = ifunc.calculateDOM(input);
								s1 += func.weight *currentDOM;
											 
								s2 += currentDOM;
								
								
								
							}
							
						
							
							
						
							
							input = input + delta;
						}
				
				
				
				fm.output = s1 / s2;
				
			}
		}*/
		
		/**
		 *    sum(input * xDOM(input))/sum of DOM(input)  COG or CENTROID
		 * @param	step (0.1 is every 10th)
		 * @return
		 *///
		private static function CoS(outputFuzzyManifolds:Dictionary,step:Number=0.1):void
		{
			var input:int = 0;
			var fm:FuzzyManifold;
			var currentDOM:Number;
			var delta:Number;
			var i:int;
			
			var s2:Number=0;
			var s1:Number=0;
			var sumDOMs:Number = 0;//for input
			var func:FuzzyMembershipFunction;
			var stepBoundary:Number = step * 100;
			
			for each (fm in outputFuzzyManifolds)
			{
				s1 = 0;
				s2 = 0;
				
				
				 
						//get delta
						delta = (fm.maxRange-fm.minRange) * step;
						input = fm.minRange+delta;
						
						for (i=1; i<=stepBoundary; i++)
						{
							sumDOMs = 0;
							
						/*	
						for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								func = FuzzyMembershipFunction( ifunc);
							    func.maximumDOM =  func.levelOfConfidence;
								sumDOMs += ifunc.calculateDOM(input);
								 func.reset();
							}
							*/
							
							
							sumDOMs=fm.getSumDOM(input);
							
							
						
							
							s1 += input * sumDOMs;
							s2 += sumDOMs;
							
							input = input + delta;
						}
				
				
				
				fm.output = s1 / s2;
				
			}
			
			
		}
		
	/**
	 * 
	 * @param	outputFuzzyManifolds
	 * 
	 * sum(representative * LOC)/sum(LOC))
	 * The maximum or representative value of a fuzzy set is the value where membership in that set is 1
	 */
		private static function AVMAX(outputFuzzyManifolds:Dictionary):void
		{
			var fm:FuzzyManifold;
			var sumLOC:Number;
			var sumAvgMulLOC:Number;
			var levelOfConfidence:Number;
			var func:FuzzyMembershipFunction;
		
			
			for each (fm in outputFuzzyManifolds)
			{
				sumLOC = 0;
				sumAvgMulLOC = 0;
				
				
						
						/*	for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
							{
								func = FuzzyMembershipFunction( ifunc);
								if(func.maximumDOM<1)
								 func.maximumDOM = 1;//it is reset
								
								sumAvgMulLOC+= ifunc.maximumPoint *func.levelOfConfidence;
								
								sumLOC += func.levelOfConfidence;
								
							
							}*/
							
							
				
				fm.output = fm.getMaxAv();
				
				//fm.output = sumAvgMulLOC /sumLOC;
				
			}
		}
		
		public function get matrix():Vector.<*> //; Vector.<Vector.<Number>>
		{
			if (_ruleMatrix) return _ruleMatrix;
			//inputFuzzymanifolds
			var currentManifold:FuzzyManifold;
			var otherManifold:FuzzyManifold;
			var currentManifoldInx:int = inputFuzzymanifolds.length - 1;
			var manifoldsInx:Vector.<int>;
			var numMemberFunctions:int;
			var currentMatrix:*;
			var currentVector:Vector.<*> ; //Vector.<Vector.<Number>>;//=new Vector.<*>();
			var i:int = inputFuzzymanifolds.length-1;
			var j:int = 0;
			var k:int;
			
						
			    currentManifold = FuzzyManifold(inputFuzzymanifolds[i]);
				
				numMemberFunctions = currentManifold.memberfunctions.length;
				
				trace("i="+i,"numMemberFunctions="+numMemberFunctions);
				
			   currentMatrix= new Vector.<Number>(numMemberFunctions, true);
			
			//loop thru input manifolds
			for (i= inputFuzzymanifolds.length-2; i >-1; i--)
			{
				 currentManifold = FuzzyManifold(inputFuzzymanifolds[i]);
				
				numMemberFunctions = currentManifold.memberfunctions.length;
				
				trace("i="+i,"numMemberFunctions="+numMemberFunctions);
				
				currentVector = new Vector.<*>(numMemberFunctions,true) ; 
				
								
			
					for (k = 0; k < numMemberFunctions; k++)
					{
						//TODO Problem not creating copy of complex Vector or Vectors
						currentVector[k] = currentMatrix.slice(0);//make copy of vector x vector x vector
					}
					
					/*trace("i=" + i, currentVector[0]);
					trace("i=" + i, currentVector[1]);
					//if (currentVector[2])
					trace("i="+i,currentVector[2]);*/
					
					currentMatrix = currentVector;//.concat();
						
				
			}
			
			
			
			_ruleMatrix = currentMatrix;
			
			/*_ruleMatrix[1][1][1] = 0.1111;*/
			
			_ruleMatrix[0][0][0] = 0.11111;
			_ruleMatrix[0][0][1] = 0.22222;
			_ruleMatrix[1][0][0] = 0.11211;
			
			trace(_ruleMatrix[0][0][0]);
			trace(_ruleMatrix[0][0][1]);
			trace(_ruleMatrix[1][0][0] );
			
			/*currentManifoldInx = inputFuzzymanifolds.length-1;
			
			while (currentManifoldInx > -1)
			{
				
				FuzzyManifold(inputFuzzymanifolds[i]).memberfunctions[manifoldsInx[i]]
				
				_ruleMatrix[
				
				for (i = 0; i < currentManifold.memberfunctions.length; i++)
				{
					
					
					
				}
			}*/
			
			return _ruleMatrix;
			
		}
		
	/*	public function set matrix(mtx:Vector):void
		{
			_ruleMatrix = mtx;
		}
		*/
		public function get AND():Function { return _AND; }
		
		public function set AND(value:Function):void 
		{
			_AND = value;
		}
		
		public function get OR():Function { return _OR; }
		
		public function set OR(value:Function):void 
		{
			_OR = value;
		}
		
		public function toString():String
		{
			var node:SListNode;
			var s:String;
			var i:int;
			var j:int;
			var k:int;
			var m:int;
			var dimension:int;
			var dimensionVector:Vector.<uint>;
			var currentVector:*;
			node = fuzzyRules.head;
			
			s = "-------------------------- Fuzzificatior data -----------------------\n"
			
			if (_ruleMatrix)
			{
			s += "-------------------------- MATRIX -----------------------\n"
			
			if (_ruleMatrix.length > 0)
			{
				dimensionVector = new Vector.<uint>();
			
				currentVector = _ruleMatrix;
				while (currentVector)
				{
					dimensionVector[dimensionVector.length] = currentVector.length;
					if (currentVector[0] is Number) break;
					currentVector = currentVector[0];
				}
				
				switch(dimensionVector.length)
				{
					case 2:
					for (i = 0; i < dimensionVector[0]; i++)
					 for (j = 0; j < dimensionVector[1]; j++)
					 trace(FuzzyManifold(inputFuzzymanifolds[0]).memberfunctions[i].linguisticTerm,FuzzyManifold(inputFuzzymanifolds[1]).memberfunctions[j].linguisticTerm,"["+i,j+"]",_ruleMatrix[i][j]);
					break;
					
					case 3:
						for (i = 0; i < dimensionVector[0]; i++)
						 for (j = 0; j < dimensionVector[1]; j++)
							for (k= 0; k < dimensionVector[2]; k++)
									 trace(FuzzyManifold(inputFuzzymanifolds[0]).memberfunctions[i].linguisticTerm,FuzzyManifold(inputFuzzymanifolds[1]).memberfunctions[j].linguisticTerm,FuzzyManifold(inputFuzzymanifolds[2]).memberfunctions[k].linguisticTerm,"["+i,j,k+"]",_ruleMatrix[i][j][k]);
					break;
					
					case 4:
					for (i = 0; i < dimensionVector[0]; i++)
						 for (j = 0; j < dimensionVector[1]; j++)
							for (k = 0; j < dimensionVector[2]; k++)
								for (m= 0; m< dimensionVector[3]; m++)
								trace(_ruleMatrix[i][j][k][m]);
					break;
					
					
					default:
					//TODO make for any matrix
						/*while (dimensionVector[0]>-1)
				{
					currentVector = _ruleMatrix;
					for (i = 0; i < currentVector.length; i++)
					{
						currentVector[i]
						
						for
					}
				}*/
					trace(" Matrix isn't supported");
					
					
				}
			}
				
			
			}
			
			s="-------------------------- RULES -----------------------\n"
			while(node!=fuzzyRules.tail.next)
				{
					s += FuzzyRule(node.data).rule+'\n';// 
					node = node.next;
				}
			
			return s;
		}
		
		
		
		public function crateMatrix //edno dimeszionalna so offset
		
		
		
		
	}

}