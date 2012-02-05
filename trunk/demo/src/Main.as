package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import winxalex.fuzzy.Fuzzificator;
	import winxalex.fuzzy.FuzzyInput;
	import winxalex.fuzzy.FuzzyManifold;
	import winxalex.fuzzy.FuzzyRule;
	import winxalex.fuzzy.FuzzyMembershipFunction;
	import winxalex.fuzzy.FuzzyMembershipFunctionFactory;
	import winxalex.fuzzy.Token;
	import winxalex.fuzzy.FuzzyOperator;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Main extends Sprite
	{
		public var spawingTimer:Timer;
		public var targets:Array;
		
		public function Main():void
		{
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			targets = new Array();
			// entry point
			var hero:Hero = new Hero();
			hero.y = stage.stageHeight * 0.5;
			hero.addWeapon(new Knife());
	        //hero.addWeapon(new RocketLuncher(20));
			hero.addWeapon(new ShotGun(10));
			hero.addWeapon(new Pistol(30));
			
			addChild(hero);
			
			spawingTimer = new Timer(1000, 0);
			spawingTimer.addEventListener(TimerEvent.TIMER, onSpawnTime);
			spawingTimer.start();
		}
		
		
		
		private function onSpawnTime(e:TimerEvent):void
		{
			var sol:Solder = new Solder();
			sol.y = this.stage.stageHeight * 0.5;
			sol.x = this.stage.stageWidth + sol.width;
			this.addChild(sol);
			targets.push(sol);
			spawingTimer.delay = 500 + Math.random();// * 1000;
		
		}
	
	}

}