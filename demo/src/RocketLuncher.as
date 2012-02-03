package  
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class RocketLuncher extends Weapon 
	{
		
		public function RocketLuncher(ammo:uint):void
		{
			super(ammo);
		}
		
		override public function shoot():void
		{
			var missile:DisplayObject = new Rocket(); 
			 missile.x = this.parent.x+87;
		     missile.y = this.parent.y+23;
			this.parent.parent.addChild(missile);
		}
		
	}

}