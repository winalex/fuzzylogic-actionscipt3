package winxalex.fuzzy 
{
	/**
	 * ...
	 * @author alex winx
	 */
	public class ReductionMethod
	{
		//Note: average point is point in which memeberfunciton has maximum value
		
		//makes average of maximum values of consequents(two by two=average by third ...so on) for every antescendent 
		//2. final value is used to find consequent memeberfunction (func. getMaxDOM) with max DOM
		public static const SIMPLE_1:uint = 0;
		
		
		
		//sum/average of  maximum values of consequents for every antescendent 
		//2. final value is used to find consequent memeberfunction (func. getMaxDOM) with max DOM
		public static const SIMPLE_2:uint = 1;
		
	
		
	}

}