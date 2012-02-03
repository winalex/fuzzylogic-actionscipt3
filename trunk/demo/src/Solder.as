package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Solder extends MovieClip 
	{
		
		private var _health:Number = 100;
		
		public function Solder() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			this.addEventListener("KNIFE_HIT", onKnifeHit);
			this.addEventListener("MISSILE_HIT", onMissleHit);
			this.addEventListener("DIE", onDie);
			
		}
		
		private function onKnifeHit(e:Event):void 
		{
			_health = 0;
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.gotoAndPlay("DieKnife");
		}
		
		private function onMissleHit(e:Event):void 
		{
			_health = 0;
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.gotoAndPlay("DieMissile");
		}
		
		private function onEnterFrame(e:Event):void 
		{
			this.x = this.x - 4;
			
			if (this.x < -this.width)
			onDie();
			
		}
		
	
		
		private function onDie(e:Event=null):void {
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.parent.removeChild(this);
		}
		
		public function get health():Number 
		{
			return _health;
		}
		
	
		
	}

}