package winxalex.fuzzy 
{
		
	/**
	 * ...
	 * @author alex winx
	 */
	public interface IFuzzyMembershipFunction 
	{
		
		
		function calculateDOM(value:Number,clipping:Boolean=false):Number
		
		function reset():void;
		
					
		function toString():String;
	 
		function get averagePoint():Number;
		function set averagePoint(value:Number):void;
		
		//point in which DOM is MAX
		function get maximumPoint():Number
		function set maximumPoint(value:Number):void;
	 
	
		
		
		
	}
	
}