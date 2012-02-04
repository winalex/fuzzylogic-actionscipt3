package winxalex.fuzzy
{
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyRule
	{
		public var antecedent:String;
		public var consequence:String;
		private var _weight:Number;
		
		private var _isFired:Boolean = false;
		private var _fuzzificator:Fuzzificator;
		private var _antCompiledStek:Vector.<Token> = null;
		private var _conCompiledStek:Vector.<Token> = null; //operation OR,AND,NOT,VERY,SOMEWHAT
		private var _rule:String;
		private var _result:Number = 0;
		private var _prevAggregation:Token = new Token();
		private var _nextAggregation:Token = new Token();
		public static const _termRegExp:RegExp = /\w+\s+(IS)\s+((NOT)\s+)?((VERY|SOMEWHAT)\s+)?\w+/ig;
		public static const _manifoldRegExp:RegExp = /^(\w+)/gi;
		public static const _membershipRegExp:RegExp = /(\w+)$/gi;
		private static const _weightRegExp:RegExp = /(WEIGHT|W)=\d+(\.?\d+)?/gi;
		
		private static const _andCaseRegExp:RegExp = /And/ig;
		private static const _orCaseRegExp:RegExp = /Or/ig;
		private static const _andOperationTermRegExp:RegExp = /\d+(\s+AND\s+\d+)+/ig;
		private static const _orOperationTermRegExp:RegExp = /\d+(\s+OR\s+\d+)+/ig;
		private static const _trimRegExp:RegExp = /^\s+|\s+$/gs;
		//	private static const _notCaseRegExp:RegExp =/(Not|not)/g;
		
		private static const _thenCaseRegExp:RegExp = /\s+Then\s+/ig;
		private static const _punctuationCaseRegExp:RegExp = /(,|\.|;)/g;
		
		/**
		 *  IF (Our_Health IS Near_Death) AND (Enemy_Health IS Near_Death) THEN (Aggressiveness IS Fight_Defensively) (optional)WEIGHT=1;
		 * @param	rule
		 */
		public function FuzzyRule(rule:String=""):void
		{
			var match:Array;
			
			if (!rule.length) return;
			
			rule = cleanCase(rule);
			
			match = rule.split(_thenCaseRegExp, 2);
			
			if (!match.length || match.length > 2)
				throw(new Error(" Rule Error: 'Then' not found in the rule or more then one 'Then' "));
			
			_rule = rule;
			_fuzzificator = null;
			
			this.consequence = match[1];
			this.antecedent = match[0];
		
			//trace(this.consequence, this.antecedent);
		
		}
		
		/**
		 *
		 */
		public function compile(fuzz:Fuzzificator):void
		{
			_fuzzificator = fuzz;
			
			setWeight();
			
			_antCompiledStek = compileString(this.antecedent, FuzzyOperator.fDOM);
			//_antCompiledStek = compileString(this.antecedent, getDOM);
			_conCompiledStek = compileString(this.consequence, fuzz.implication); 
			
					
		
			// trace("COMPILED:"+toString(_antCompiledStek));
		}
		
		/**
		 * parse consequence to find weight
		 */
		private function setWeight():void
		{
			var match:Array = this.consequence.match(FuzzyRule._weightRegExp);
			if (match.length == 1)
			{
				_weight = Number(String(match[0]).split("=")[1]);
				
				//remove
				this.consequence = this.consequence.replace(match, "");
			}
			else
			{
				_weight = 1;
			}
		}
		
		/**
		 *
		 * @param	rule
		 * @return
		 */
		private function compileString(rule:String, termFunction:Function):Vector.<Token>
		{
			var matches:Array;
			var node:Token;
			var currentmatch:String;
			var manifold:String;
			var memberFunction:String;
			var i:int;
			var len:int;
			var termRegExp:RegExp = FuzzyRule._termRegExp;
			//var traceString:String;
			var stek:Vector.<Token> = new Vector.<Token>;
			var manifoldRegExp:RegExp = FuzzyRule._manifoldRegExp;
			var membershipRegExp:RegExp = FuzzyRule._membershipRegExp;
			
			//check for numbers (avoided for speed)
			//termRegExp =/(\b\d+)?/ig;
			// matches = rule.match(termRegExp);
			
			stek = new Vector.<Token>;
			
			//A IS A1
			
			matches = rule.match(termRegExp);
			
			if (!matches.length)
			{
				throw new Error(" Not any <Manfold> IS <Memeberfuction> found in:" + rule);
			}
			
			len = matches.length;
			
			for (i = 0; i < len; i++)
			{
				currentmatch = String(matches[i]);
				
				//traceString = "";
				
				//remove try for speed
				try
				{
					manifold = currentmatch.match(manifoldRegExp)[0];
				}
				catch (e:Error)
				{
					throw new Error("Cant find <Manifold> in :" + currentmatch);
				}
				
				try
				{
					memberFunction = currentmatch.match(membershipRegExp)[0];
					
				}
				catch (e:Error)
				{
					throw new Error("Cant find <memberfunction> in :" + currentmatch);
				}
				
				//improve this
				if (!manifold || !memberFunction || manifold == "IS" || memberFunction == "NOT" || memberFunction == "VERY" || memberFunction == "SOMEWHAT")
					throw new Error("Erroruos rule: " + currentmatch);
				
				// stek[stek.length] = new Token(stek.length,getDOM, [manifold, memberFunction]);
				//stek[stek.length] = new Token(stek.length, termFunction, [manifold, memberFunction]);
				
				if (_fuzzificator.implication == termFunction)
				{
				  stek[stek.length]= new Token(0, _fuzzificator.implication, [_antCompiledStek[_antCompiledStek.length-1],new Token(0,null,null,1)]);
				  stek[stek.length] = new Token(1, FuzzyOperator.fAGGREGATE, [manifold,memberFunction,_fuzzificator,_weight,stek[stek.length-1]]);
				}
				else
				  stek[stek.length] = new Token(stek.length, termFunction, [manifold, memberFunction, _fuzzificator]);
				
				//traceString = "DOM("+manifold +"," + memberFunction+")";
				
				if (hasOperator(currentmatch, "VERY"))
				{
					// stek[stek.length] = new Token(stek.length,FuzzyOperator.VERY, [stek.length - 1]);
					stek[stek.length] = new Token(stek.length, FuzzyOperator.fVERY, [stek[stek.length - 1]]);
						//traceString = "VERY," + //traceString;
				}
				else
				{
					
					if (hasOperator(currentmatch, "SOMEWHAT"))
					{
						//stek[stek.length] = new Token(stek.length,FuzzyOperator.SOMEWHAT,[stek.length - 1]);
						stek[stek.length] = new Token(stek.length, FuzzyOperator.fSOMEWHAT, [stek[stek.length - 1]]);
							//traceString = "SOMEWHAT," + //traceString;
					}
					
				}
				
				if (hasOperator(currentmatch, "NOT"))
				{
					//stek[stek.length] = new Token(stek.length, FuzzyOperator.NOT, [stek.length - 1]);
					stek[stek.length] = new Token(stek.length, FuzzyOperator.fNOT, [stek[stek.length - 1]]);
						//traceString = "NOT," + //traceString;
				}
				
				rule = rule.replace(currentmatch, stek.length - 1);
				
					//trace(//traceString);
				
			}
			
			//trace("RULE:(after member stage):" +rule);
			
			//( A AND B OR C)
			termRegExp = /\((\s*\w+\s*)+\)/ig;
			matches = rule.match(termRegExp);
			
			// trace( toString(stek));
			
			//while there are braces
			while (matches.length)
			{
				len = matches.length;
				
				for (i = 0; i < len; i++)
				{
					//traceString = "";
					currentmatch = String(matches[i]);
					
					//trace("bracket match" +currentmatch);
					
					//matchOperation(  matchOperation( currentmatch, "AND",stek), "OR",stek);
					//matchOperation(  matchOperation( currentmatch, "AND|And|and", stek, _fuzzificator.fAND), "OR|Or|or", stek, _fuzzificator.fOR);
					matchOperation(matchOperation(rule, FuzzyRule._andOperationTermRegExp, FuzzyRule._andCaseRegExp, stek, _fuzzificator.fAND), FuzzyRule._orOperationTermRegExp, FuzzyRule._orCaseRegExp, stek, _fuzzificator.fOR);
					
					rule = rule.replace(currentmatch, stek.length - 1);
					
						//trace("RULE: after bracket: " +rule);
				}
				
				matches = rule.match(termRegExp);
				
			}
			
			matchOperation(matchOperation(rule, FuzzyRule._andOperationTermRegExp, FuzzyRule._andCaseRegExp, stek, _fuzzificator.fAND), FuzzyRule._orOperationTermRegExp, FuzzyRule._orCaseRegExp, stek, _fuzzificator.fOR);
			
			return stek;
		
		}
		
		/**
		 *
		 * @param	text
		 * @param	operation
		 * @param	stek
		 * @return
		 */
		private function matchOperation(text:String, operationTermRegExp:RegExp, operationSpliter:RegExp, stek:Vector.<Token>, operatorFunc:Function):String
		{
			
			var matches:Array;
			var args:Array;
			var len:int;
			var i:int;
			var j:int
			var currentmatch:String;
			
			//operation=operation.toUpperCase();
			
			//var termRegExp:RegExp = new RegExp("\\d+(\\s+" + operation + "\\s+\\d+)+", "ig");
			
			matches = text.match(operationTermRegExp);
			
			len = matches.length;
			
			// trace("matchOperation>opperation:"+ operation);
			
			for (i = 0; i < len; i++)
			{
				
				currentmatch = String(matches[i]);
				
				//trace("matchOperation>currentmatch:" + currentmatch);
				
				//replace ex. 0 and 1(ref0 <opperation> ref1 => ref2) in the steak with reference/pointers
				
				text = text.replace(currentmatch, stek.length);
				
				//trace(text);
				args = currentmatch.split(operationSpliter);
				
				//trace(args.join(','));
				
				//token only version (change numbers to Token pointers/references)
				for (j = 0; j < args.length; j++)
				{
					args[j] = stek[Number(args[j])];
				}
				
				stek[stek.length] = new Token(stek.length, operatorFunc, args);
				
					//trace(text);
			}
			
			return text;
		}
		
		/**
		 *
		 * @param	text
		 * @param	operator
		 * @return
		 */
		private function hasOperator(text:String, operator:String):Boolean
		{
			var regExp:RegExp = new RegExp("\\b" + operator + "\\b", "ig");
			return regExp.test(text);
		}
		
		/**
		 *
		 * @param	stek
		 */
		public function dump(stek:Vector.<Token>):String
		{
			var i:int = 0;
			var j:int;
			var len:int = stek.length;
			var args:Array;
			var str:String;
			var s:String = "";
			for (; i < len; i++)
			{
				args = stek[i].args;
				
				str = "";
				
				for (j = 0; j < args.length; j++)
				{
					//trace(args[j]);
					if (args[j] is Token)
						str += args[j].id;
					else
						str += args[j];
					
					if (j + 1 < args.length)
						str += ",";
				}
				s = s + "\n(?" + i + ")" + functionToString(stek[i].func) + " (" + str + ") value: " + stek[i].value;
			}
			
			return s;
		}
		
		/**
		 *
		 * @param	f
		 * @return
		 */
		private function functionToString(f:Function):String
		{
			switch (f)
			{
				case FuzzyOperator.fDOM:
				//case getDOM: 
					return "DOM";
					break;
				
				case FuzzyOperator.fPROBSUM: 
				case FuzzyOperator.fMIN: 
				case FuzzyOperator.fSUM: 
					return "OR";
					break;
				
				case FuzzyOperator.fMAX: 
				case FuzzyOperator.fPRODUCT: 
					return "AND";
					break;
				
				case FuzzyOperator.fNOT: 
					return "NOT";
					break;
				
				case FuzzyOperator.fVERY: 
					return "VERY";
				
				case FuzzyOperator.fSOMEWHAT: 
					return "SOMEWHAT";
				
				default: 
					return "";
			
			}
		}
		
		/**
		 *
		 * @param	stek
		 * @return
		 */
		private function evaluateStek(stek:Vector.<Token>):Number
		{
			var i:int = 0;
			var j:int;
			var len:int = 0;
			
			var str:String;
			var token:Token;
			var args:Array;
			var tokenArgs:Array;
			var argsLen:int;
			
			len = stek.length;
			
			for (; i < len; i++)
			{
				token = stek[i];
				
				tokenArgs = token.args;
				
				//trace("(" + i + ") " + functionToString(token.func) + "( " + tokenArgs.join() + ")=" );
				
				token.value = token.func.apply(null, tokenArgs); //stek[Number(args[j])].value
				
					//trace(token.value);
				
			}
			
			return token.value;
		}
		
		/**
		 *
		 * @return
		 */
		public function evaluate():Number
		{
			//evaluate condition term1 operator term2...
			_result = evaluateStek(_antCompiledStek);
			
			//trace("EVALUATED:"+toString(_antCompiledStek));
			
			//result steak
			evaluateStek(_conCompiledStek);
			
			if (_result)
			{
				_isFired = true;
			}
			else
				_isFired = false;
			
			//trace("Rule:" + this.rule + " has fired " + _isFired.toString().toLocaleUpperCase() + " with result:" + _result);
			
			return _result;
		}
		
		private function cleanCase(rule:String):String
		{
			
			//rule = rule.replace(_andCaseRegExp, "AND");
			//trace(rule);
			//rule = rule.replace(_orCaseRegExp, "OR");
			//trace(rule);
			rule = rule.replace(_punctuationCaseRegExp, "");
			rule = rule.replace(_trimRegExp, "");
			//trace(rule);
			
			return rule;
		}
		
		public function reset():void
		{
			_isFired = false;
			_result = 0;
		}
		
		public function clone():FuzzyRule
		{
			var fr:FuzzyRule = new FuzzyRule(this._rule);
			
			if (this._antCompiledStek) //if its compiled
			{
				//get reference to 
				fr.antCompiledStek = this._antCompiledStek; // this._antCompiledStek.concat();
				fr.conCompiledStek = this._conCompiledStek; // this._conCompiledStek.concat();
			}
			
			return fr;
		}
		
		/*public function implicate(manifoldName:String, memberfunctionName:String,fuzzificator:Fuzzificator):void
		{
			var memberfunction:FuzzyMembershipFunction;
			var manifold:FuzzyManifold;
			
			manifold = fuzzificator.outputFuzzyManifolds[manifoldName];
			//if(_fuzzificator.type==FuzzificatorType.SUGENO)
			
			if (manifold)
			{
				memberfunction = manifold.memberfunctions[memberfunctionName];
				
				if (memberfunction)
				{
					if (_isFired) //result is ready
					{
											
						if (!memberfunction.areBoundariesDIRTY)//boundaries are dirty when LOC is changed from default value=1
						{
							memberfunction.levelOfConfidence= _result;
						  // memberfunction.levelOfConfidence = _result;
						}
						else
						{
							_nextAggregation.value = _result * this.weight;
							_prevAggregation.value = memberfunction.levelOfConfidence;
						
							memberfunction.levelOfConfidence= _fuzzificator.aggregation(_prevAggregation, _nextAggregation);
							if (_fuzzificator.implication == FuzzyOperator.fPRODUCT)
								memberfunction.isScaled = true;
							
						}
						
					}
					
				}
				else
					throw new Error(this.rule + " has not existing memeber function  <" + memberfunctionName + "> in manifold <" + manifoldName + ">");
				
			}
			else
			{
				throw new Error(this.rule + " has not existing manifold " + manifoldName);
			}
		
		}*/
		
		/*private function getDOM(manifoldName:String, memberfunctionName:String):Number
		{
			var memberfunction:FuzzyMembershipFunction;
			var manifold:FuzzyManifold;
			var currentDOM:Number;
			
			manifold = _fuzzificator.inputFuzzymanifolds[manifoldName]
			
			if (manifold)
			{
				memberfunction = manifold.memberfunctions[memberfunctionName];
				if (memberfunction)
				{
					
					return memberfunction.degreeOfMembership;
				}
				else
					throw new Error(this.rule + " has not existing memeber function  <" + memberfunctionName + "> in manifold <" + manifoldName + ">");
				
			}
			else
			{
				throw new Error(this.rule + " has not existing manifold " + manifoldName);
			}
		
		}*/
		
		public function toString():String
		{
			return "Fuzzy Rule:<" + this._rule + ">";
		}
		
		public function get isFired():Boolean
		{
			return _isFired;
		}
		
		public function get antCompiledStek():Vector.<Token>
		{
			return _antCompiledStek;
		}
		
		public function set antCompiledStek(value:Vector.<Token>):void
		{
			_antCompiledStek = value;
		}
		
		public function get conCompiledStek():Vector.<Token>
		{
			return _conCompiledStek;
		}
		
		public function set conCompiledStek(value:Vector.<Token>):void
		{
			_conCompiledStek = value;
		}
		
		public function get rule():String
		{
			return _rule;
		}
		
		public function set rule(value:String):void
		{
			_rule = cleanCase(value);
		}
		
		public function get result():Number
		{
			return _result;
		}
		
		public function get weight():Number
		{
			return _weight;
		}
	
	}

}