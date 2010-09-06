package  
{
	import flash.display.Sprite;
	import winxalex.fuzzy.FuzzyOperator;
	import winxalex.fuzzy.Token;
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class TestOperator extends Sprite
	{
		
		public function TestOperator() 
		{
			var t1:Token = new Token();
			var t2:Token = new Token();
			var t3:Token = new Token();
			var t4:Token = new Token();
			var t5:Token = new Token();
			var t6:Token = new Token();
			
			t1.value = 0.19;
			t2.value = 0.23443;
			t3.value = 0.1
			t4.value = 0.09;
			t5.value = 0.2;
			t6.value=0.019
			
			trace("MIN:"+FuzzyOperator.fMIN(t1, t2, t3, t4, t5, t6));	
			trace("PRODUCT:" + FuzzyOperator.fPRODUCT(t1, t2, t3, t4, t5,t6));
			trace("MAX:" + FuzzyOperator.fMAX(t1, t2, t3, t4, t5, t6));
			trace("PROBSUM:" + FuzzyOperator.fPROBSUM(t1, t2, t3, t4, t5, t6));
			trace("SUM:" + FuzzyOperator.fSUM(t1, t2, t3, t4, t5));
			
			/*MAX:0.9
			PROBSUM:0.9699845214160001
			SUM:1*/
		
			
			
		}
		
	}

}