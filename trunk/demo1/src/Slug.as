package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Slug extends Missile 
	{
		
		public function Slug(speed:int=7) 
		{
			
			this.speed = speed;
			super();
		}
		
		override public function get hitEvent():Event 
		{
			return new Event("MISSILE_HIT");
		}
		
	
		
	}

}