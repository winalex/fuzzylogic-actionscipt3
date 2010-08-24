package winxalex.fuzzy 
{
		
	/**
	 * ...
	 * @author alex winx
	 */
	public interface IFuzzyMembershipFunction 
	{
		
		
		function calculateDOM(value:Number):Number
		
		function reset():void;
		
		function clipToLOC():void;
		
		function save():void;
	
			
		function toString():String;
	 
		function get averagePoint():Number;
		
		function get maximumPoint():Number
	 
	
		
		
		
	}
	
}