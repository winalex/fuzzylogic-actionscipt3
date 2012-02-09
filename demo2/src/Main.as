package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Main extends Sprite
	{
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}
		
		private function init():void
		{
			var ghost:Ghost;
			
			for (var i:int = 0; i < 3; i++)
			{
				ghost = new Ghost(0.5 + Math.random() * 2,Math.random()*0xFF0000);
				ghost = addChild(ghost) as Ghost;
				
				
			}
		}
	
	}

}