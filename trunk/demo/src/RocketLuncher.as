package  
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class RocketLuncher extends Weapon 
	{
		
		public function RocketLuncher() 
		{
			
		}
		
		override public function shoot():void
		{
			var missile:DisplayObject = this.parent.addChild(new Rocket());
			missile.x = 47;
		   missile.y = 12;
			
		}
		
	}

}