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
			gotoAndPlay("SHOOT_ANI");
		}
		
		public function shoot():void
		{
			
		}
	
	}

}