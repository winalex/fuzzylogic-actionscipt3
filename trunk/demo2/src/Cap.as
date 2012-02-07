package  
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Cap extends MovieClip 
	{
		
		private var _size:Number;
		
		public function Cap(size:Number,color:uint) 
		{
			_size = size;
			
			this.scaleX = this.scaleY = _size;
			drawBackground(color,background.graphics);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function drawBackground(color:uint,g:Graphics):void 
		{
			g.beginFill(color);
			g.drawRect(0, 0, 30.5, 30.5);
			g.endFill();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			//move x,y
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
	}

}