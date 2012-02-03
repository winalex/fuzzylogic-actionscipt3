package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Main extends Sprite 
	{
		public var spawingTimer:Timer;
		
		public function Main():void 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var hero:Hero = new Hero();
			hero.y = stage.stageHeight * 0.5;
			hero.addWeapon(new RocketLuncher());
			addChild(hero);
			
			spawingTimer = new Timer(1000, 0);
			spawingTimer.addEventListener(TimerEvent.TIMER, onSpawnTime);
			spawingTimer.start();
		}
		
		private function onSpawnTime(e:TimerEvent):void 
		{
			var sol:Solder = new Solder();
			sol.y = this.stage.stageHeight  * 0.5;
			sol.x = this.stage.stageWidth+ sol.width;
			this.addChild(sol);
			
			spawingTimer.delay = 1000 + Math.random() * 3000;
			
		}
		
	}
	
}