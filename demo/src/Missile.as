package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Missile extends MovieClip
	{
		public var speed:int = 5;
		private var _hitEvent:Event;
		
		public function Missile():void
		{
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		}
		
		
		private function findTarget():Solder {
			var boundingRect:Rectangle;
			var target:DisplayObject;
			//not the best way to find target
			for (var i:int = 0; i<this.parent.numChildren; i++) {
				target = this.parent.getChildAt(i);
				
				if ( target is Solder && Solder(target).health>0) {
					if (target.hitTestPoint(this.x, this.y))
					{
						return target as Solder;
					}
				}
			}
			
			return null;
		}
		
		
		public function onEnterFrame(e:Event):void
		{
			var target:Solder;
			
				target = findTarget();
				
			if (target) {
				
				target.dispatchEvent(hitEvent);
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				this.parent.removeChild(this);
				return;
			}
			
			//move missle
			this.x += speed;
			
			if (this.x > this.stage.stageWidth + this.width) {
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				this.parent.removeChild(this);
			}
		}
		
		public function get hitEvent():Event 
		{
			return _hitEvent;
		}
	
	}

}