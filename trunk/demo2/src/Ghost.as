package
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Ghost extends MovieClip
	{
		
		private var _size:Number;
		private var _speed:int = 5;
		private var _changeDirTimer:Timer;
		private var _direction:uint ;
		private var _limitUpX:Number;
		private var _limitUpY:Number;
		private var _limitDownX:Number;
		private var _limitDownY:Number;
		
		public function Ghost(size:Number, color:uint)
		{
			_size = size;
			
			this.scaleX = this.scaleY = _size;
			
		    _direction = Math.round(Math.random());
			
			drawBackground(color, background.graphics);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			

			
			_changeDirTimer = new Timer(1000, 0);
			_changeDirTimer.addEventListener(TimerEvent.TIMER, onChangeDir);
		}
		
		private function onChangeDir(e:TimerEvent):void
		{
			_changeDirTimer.delay = 1000 + Math.random() * 4000;
			_direction = Math.round(Math.random());//0 to 1
			_speed = (1 + ( -2) * Math.round(Math.random()))*_speed;//-1 to 1
		}
		
		private function drawBackground(color:uint, g:Graphics):void
		{
			g.beginFill(color);
			g.drawRect(-this.width*0.5, -this.height*0.5, this.width, this.height);
			g.endFill();
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_limitUpY = stage.stageHeight -this.height*0.5;
			_limitUpX = stage.stageWidth - this.width*0.5;
			_limitDownX = this.width * 0.5;
			_limitDownY = this.height * 0.5;
			
			
			this.x = this.width + Math.random() * (stage.stageWidth - 2*this.width);
		    this.y = this.height + Math.random() * (stage.stageHeight- 2*this.height);
			
			trace(x,y);
			_changeDirTimer.start();
		}
		
		private function onEnterFrame(e:Event):void
		{
			var delta:int;
			var limitUp:Number;
			var limitDown:Number;
			var dir:String;
			var frame:uint;
			var dim:Number;
			
			if (_direction) //X
			{
				dir = "x";
				frame = 3;
				limitUp = _limitUpX;
				limitDown = _limitDownX;
				dim = this.width;
				delta = this[dir]+ _speed;
			}
			else //Y
			{
				dir = "y";
				frame = 1;
				limitDown = _limitDownY;
				limitUp = _limitUpY;
				delta = this[dir] +_speed;
				
			}
			
			
			
				
				if (delta < limitUp && delta > limitDown)
				{
					this[dir] = delta;
				}
				else
				{
					//change direction
					_speed = -_speed;
					this[dir] += _speed;
				}
				
				trace("x",this.x,"y",this.y,"dir:",dir, "sp:", _speed,"delta:",delta,_limitDownX,":",_limitUpX,_limitDownY,":",_limitUpY);
				
			   
			  if (_speed < 0)
			  {
				 gotoAndStop(frame);
			  }
			  else 
			  {
				gotoAndStop(frame+1);  
			  }
		
		}
		
		public function getScared():void
		{
			_speed = 10;
			gotoAndPlay("ScaredAni");
		}
		
		public function get size():Number
		{
			return _size;
		}
	
	}

}