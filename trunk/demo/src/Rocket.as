package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Rocket extends Missile 
	{
		
		public function Rocket(speed:int=15) 
		{
			this.speed = speed;
		}
		
		override public function get hitEvent():Event 
		{
			return new Event("MISSILE_HIT");
		}
		
	}

}