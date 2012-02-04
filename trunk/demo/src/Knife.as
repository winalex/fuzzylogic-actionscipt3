package
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Knife extends Weapon
	{
		
		public function Knife(ammo:uint):void
		{
			super(ammo);
		}
		
		override public function prepShoot():void 
		{
			gotoAndPlay("SHOOT_ANI");
		}
		
		override public function shoot():void
		{
			
		}
	
	}

}