package
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Pistol extends Weapon
	{
		
		public function Pistol(ammo:uint):void
		{
			super(ammo);
		}
		
		
			
		override public function shoot():void
		{
			
			
			
				var missile:DisplayObject = new Bullet();
				missile.x = this.parent.x + 87;
				missile.y = this.parent.y + 23;
				this.parent.parent.addChild(missile);
		
		}
	
	}

}