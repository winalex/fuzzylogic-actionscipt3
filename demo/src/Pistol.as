package  
{
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Pistol extends Weapon 
	{
		
		public function Pistol() 
		{
			
		}
		
		override public function shoot():Missile 
		{
		   var missile:DisplayObject = this.parent.addChild(new Bullet());
		   missile.x = 47;
		   missile.y = 12;
		}
		
	}

}