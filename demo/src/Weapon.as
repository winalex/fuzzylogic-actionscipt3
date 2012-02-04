package
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Weapon extends MovieClip
	{
			
		public var ammo:uint;
		
		public function Weapon(ammo:uint):void
		{
			this.ammo = ammo;
			
			super();
		}
		
		
		public function prepShoot():void 
		{
			var ammoStatus:uint;
			
			ammoStatus = ammo - 1;
			if (ammoStatus > 0) 
			{
				ammo = ammoStatus;
				gotoAndPlay("SHOOT_ANI");
			}
			else
			ammo = 0;
			
			trace("ammo", ammo);
			
		}
		
		public function shoot():void
		{
			
		}
	
	}

}