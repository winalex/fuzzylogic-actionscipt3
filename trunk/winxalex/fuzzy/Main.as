package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class Main extends Sprite 
	{
		
		public static const NOT:uint = 0;
		public static const OR:uint = 1;
		public static const AND:uint = 2;
		public static const VERY:uint = 3;
		public static const SOMEWHAT:uint = 4;
		
		private var operationStek:Vector.<OperationNode>;
		public var operatorsFunctions:Vector.<Function>=new Vector.<Function>;
		private var rule:String;
		
		public function Main():void 
		{
			
		    operatorsFunctions[0] = fNOT;
			operatorsFunctions[1] = fOR;
			operatorsFunctions[2] = fAND;
			operatorsFunctions[3] = fVERY;
			operatorsFunctions[4] = fSOMEWHAT;
			
			
			/*if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			var input:CharStream = new ANTLRStringStream("import flash.display.Sprite;");
	       
										//new ANTLRFileStream();//File.applicationDirectory.resolvePath("input")
				var lex:myGrammar = new myGrammar(input);
				
				var tokens:CommonTokenStream = new CommonTokenStream(lex);
				trace(tokens.toString());
				trace("aloooo");*/
				
				//defult weight=1 or weight=0
				//var input:String = "IF (Our_Health IS Near_Death AND Enemy_Health IS Near_Death AND (Enemy_Health IS Near_Death AND Enemy_Health IS Death OR Our_Health IS NOT VERY Death) OR Our_Health IS Good THEN (Aggressiveness IS Fight_Defensively) WEIGHT=0.3"
				rule = "A IS A1 AND B IS B1 AND E IS E2 AND (B IS B2 AND C IS NOT C1 OR D IS VERY D1 OR ( E IS VERY E1 OR F IS E2 AND H IS NOT VERY H1 ) OR M IS SOMEWHAT M1) AND ((G IS G1 OR K IS K1) OR M IS M3)";
				
				compile();
				
				//var antecedent:String =
				//var con
				//faz.fuzzymanifolds[Our_Health].memberfunctions[Near_Death]
				//function,args
				//public function getDOM(Our_Health,Near_Death)
				//{ return .fuzzymanifolds[Our_Health].memberfunctions[Near_Death] }
				
				//exit();	
			
		}
		
		private function compile():void
		{
			var matches:Array;
			var node:OperationNode;
			var currentmatch:String;
			var manifold:String;
			var memberFunction:String;
			var i:int;
			var len:int;
			var tempRegExp:RegExp = new RegExp("", "ig");
			var traceString:String;
			
			   operationStek = new Vector.<OperationNode>;
			   
			   //check for numbers (avoided for speed)
			   //tempRegExp =/(\b\d+)?/ig;
			   // matches = rule.match(tempRegExp);
			
			    //A IS A1
				tempRegExp =/\w+\s+IS\s+(NOT\s+)?((VERY|SOMEWHAT)\s+)?\w+/ig;
				 matches = rule.match(tempRegExp);
				 
				 if (!matches.length)
				 {
					 throw new Error (" Not any <Manfold> IS <Memeberfuction> found in:"+rule);
				 }
				 
								 
				 len = matches.length;
				 
				 for (i=0; i < len; i++)
				 {
					currentmatch = String(matches[i]);
					
					
					
					traceString = "";
					 
					 tempRegExp = /^(\w+)/gi;
					
					 try
					 {
					 manifold = currentmatch.match(tempRegExp)[0];
					 }
					 catch(e:Error)
					 {
						 throw new Error("Cant find <Manifold> in :" + currentmatch);
					 }
					 
					  tempRegExp = /(\w+)$/gi;
					 
					  try
					 {
					     memberFunction = currentmatch.match(tempRegExp)[0];
						 
					 }
					 catch(e:Error)
					 {
						 throw new Error("Cant find <memberfunction> in :" + currentmatch);
					 }
					 
					 //improve this
				 if (!manifold || !memberFunction || manifold == "IS" || memberFunction == "NOT" || memberFunction == "VERY" || memberFunction == "SOMEWHAT")
				  throw new Error("Erroruos rule: " +currentmatch);
					 
				   
					  operationStek[operationStek.length] = new OperationNode(operationStek.length,getDOM, [manifold, memberFunction]);
					  
						  
					  traceString = "DOM("+manifold +"," + memberFunction+")";
					  
					
					 if (hasOperator(currentmatch,"VERY"))
					 {
						 operationStek[operationStek.length] = new OperationNode(operationStek.length,operatorsFunctions[3], [operationStek[operationStek.length - 1]]);
						 traceString = "VERY," + traceString;
					 }
					 else
					 {
						 
						   if (hasOperator(currentmatch, "SOMEWHAT"))
						   {
							    operationStek[operationStek.length] = new OperationNode(operationStek.length,operatorsFunctions[4],[operationStek [operationStek.length - 1]]);
								 traceString = "SOMEWHAT," + traceString;
						   }
						 
					 }
					 
					
					 if (hasOperator(currentmatch,"NOT"))
					 {
						 operationStek[operationStek.length] = new OperationNode(operationStek.length,operatorsFunctions[0],[operationStek [operationStek.length - 1]]);
						  traceString = "NOT," + traceString;
					 }
					 
					 rule= rule.replace(currentmatch, operationStek.length-1);
					 
					  trace(traceString);
					 
				 }
				 
				trace("RULE:(after member stage):" +rule);
				
				//( A AND B OR C)
				tempRegExp=/\((\s*\w+\s*)+\)/ig;
				  matches = rule.match(tempRegExp);
				  
				  //while there are braces
				  while (matches.length)
				  {
					   len = matches.length;
					   
					 for (i=0; i < len; i++)
				     {
					   traceString = "";
					   currentmatch = String(matches[i]);
					   
					     trace("bracket match" +currentmatch);
					   
					   
						matchOperation(  matchOperation( currentmatch, "AND",operationStek), "OR",operationStek);
						
						rule = rule.replace(currentmatch, operationStek.length - 1);
						
						  trace("RULE: after bracket: " +rule);
					 }
					 
					 
					  
					  matches = rule.match(tempRegExp); 
					  
					  
				  }
				
			
				 
				matchOperation(  matchOperation( rule, "AND",operationStek), "OR",operationStek);
			
				 
			
				 
				   stekToString(operationStek);
				 
				  trace("result:"+ evaluateStek(operationStek));
			
		}
		
		private function matchOperation(text:String,operation:String,stek:Vector.<OperationNode>):String
		{
			
			 var matches:Array;
			 var args:Array;
			 var len:int;
			 var i:int;
			 var j:int
			 var currentmatch:String;
				var tempRegExp:RegExp = new RegExp("\\d+(\\s+" + operation + "\\s+\\d+)+", "ig");
				
				 matches = text.match(tempRegExp);
				 
				 len = matches.length;
				 
				 for (i=0; i < len; i++)
				 {
					
					currentmatch = String(matches[i]);
			     	  
				   text = text.replace(currentmatch, stek.length);
				   
				   args = currentmatch.split(operation);
				   
				   for (j = 0; j < args.length; j++) { args[j] = stek[int(args[j])] };
				   
				   stek[stek.length] = new OperationNode(stek.length,operatorsFunctions[Main[operation]],args );
				   
				  
					 
				   trace(text);
				 }
				 
				 return text;
		}
		
		private function hasOperator(text:String,operator:String):Boolean
		{
			var regExp:RegExp = new RegExp("\\b" + operator, "ig");
			return regExp.test(text);
		}
		
		private function stekToString(stek:Vector.<OperationNode>):void
		{
			var i:int = 0;
			var j:int ;
			var len:int = stek.length;
			var args:Array;
			var str:String;
			for (; i < len; i++)
			{
				args = stek[i].args;
				
				str = "";
				
				for (j = 0; j < args.length; j++) 
				{
					if	(args[j] is OperationNode)
						str += args[j].id ;
					else
						str +=  args[j] ;
						
						if (j+1 < args.length)
						str+= ",";
				}
				trace("("+i+")"+functionToString(stek[i].func) + " (" + str+ ") value: " + stek[i].value);
			}
		}
		
		private function functionToString(f:Function):String
		{
			switch (f)
			{
				case getDOM:
				return "DOM";
				break;
				
				case fOR:
				return "OR";
				break;
				
				case fAND:
				return "AND";
				break;
				
				case fNOT:
				return "NOT";
				break;
				
				case fVERY:
				return "VERY";
				
				case fSOMEWHAT:
				return "SOMEWHAT";
				
				
				default:
				return "";
				
			}
		}
		
		private function evaluateStek(stek:Vector.<OperationNode>):Number
		{
			var i:int = 0;
			var j:int;
			var len:int = 0;
			var str:String;
			var opNode:OperationNode;
		    var args:Array;
			
			len =stek.length;
			
			for (; i < len; i++)
			{
				opNode = stek[i];
				
				opNode.value = opNode.func.apply(null, opNode.args );
				
				str = "";
				args = opNode.args;
				for (j = 0; j < args.length; j++) 
				{
					if	(args[j] is OperationNode)
						str += args[j].id ;
					else
						str +=  args[j] ;
						
						if (j+1 < args.length)
						str+= ",";
				}
				
				trace("(" + i + ") "+functionToString(opNode.func)+"( "+str+")="+opNode.value);
			}
			
			return opNode.value;
		}
		
		
	
		
		
		private function getDOM(manifold:String,memberfunction:String):Number
		{
			/*var memberfunction:FuzzyMemberfunction;
			var manifold:FuzzyManifold;
			
			manifold = fuzzymanifolds[args[1]];
			memberfunction=memberfunctions[args[0]];
			return memberfunction.getDOM();*/
			//return 3;
			return Math.random();
		}
		
		
		
	     private function fAND(...args):Number
		{
			var i:int = 1;
			var currentvalue:Number;
			var len:int = args.length;
			var min:Number = OperationNode(args[0]).value;
			
			
			for (; i < len; i++)
			{
				currentvalue = OperationNode(args[i]).value;
				
				if (currentvalue < min)
				min =currentvalue;
				
			}
			
			return min;
		}
		
		private function fOR(...args):Number
		{
			var i:int = 1;
			var currentvalue:Number;
			var len:int = args.length;
			var max:Number =OperationNode(args[0]).value;
			
			
			for (; i < len; i++)
			{
				currentvalue = args[i].value;
								
				if (currentvalue> max)
				max = currentvalue;
				
			}
			
			return max;
		}
		
		private function fVERY(...args):Number
		{
			var currentvalue:Number = args[0].value;
				
			return currentvalue*currentvalue;
		}
		
		private function fSOMEWHAT(...args):Number
		{
			var currentvalue:Number = args[0].value;
				
			return Math.sqrt(currentvalue);
		}
		
		private function fNOT(...args):Number
		{
			var currentvalue:Number = args[0].value;
				
			return 1 - currentvalue;
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}