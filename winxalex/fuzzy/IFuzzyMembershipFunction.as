package winxalex.fuzzy 
{
	import flash.geom.Point;
		
	/**
	 * ...
	 * @author alex winx
	 */
	public interface IFuzzyMembershipFunction 
	{
		
		
		function calculateDOM(value:Number):Number
		
		function reset():void;
		
					
		function toString():String;
	 
		function get averageDomain():Number;
		function set averageDomain(value:Number):void;
		
		//point in which DOM is MAX =1
		function get maximumDomain():Number
		function set maximumDomain(value:Number):void;
		
		
	 
	
		
		
		
	}
	
}