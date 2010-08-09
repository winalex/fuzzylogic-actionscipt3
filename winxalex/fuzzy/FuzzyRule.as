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
		
		private var _isFired:Boolean = false;
		private var _faz:Fazzificatior;
		private var _antCompiledStek:Vector.<OperationNode>;
		private var _conCompiledStek:Vector.<OperationNode>; //operation OR,AND,NOT,VERY,SOMEWHAT
		
		
		
		
		/**
		 *  IF (Our_Health IS Near_Death) AND (Enemy_Health IS Near_Death) THEN (Aggressiveness IS Fight_Defensively) (optional)WEIGHT=1;
		 * @param	rule
		 */
		public function FuzzyRule(rule:String):void
		{
			var inx:int = rule.indexOf("THEN");
			//split("THEN");
			//reg
			
			this.consequence = rule.substr(inx + 4);
			this.antecedent = rule;
			
			_antCompiledStek = new Vector.<OperationNode>;
			_conCompiledStek = new Vector.<OperationNode>;
			
			
			
		}
	  
		public function compile(faz:Fazzificatior):void
		{
			
		}
	
		
		/**
		 * read comipled stack and evaluate
		 */
		public function evaluate():void
		{
          /* Fazzificatior.OR(antecedent, consequence).value
		   if(value of antecendt>0) 
		   _isFired = true;*/
		}
		
		private function evaluateSteak():Number
		{
			
		}
		
		public function get isFired():Boolean { return _isFired; }
		
	
		
	}

}