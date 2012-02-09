package
{
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import winxalex.fuzzy.FuzzyManifold;
	import winxalex.fuzzy.FuzzyMembershipFunction;
	
	/**
	 * ...
	 * @author alex@winx.ws
	 */
	public class PacMan extends MovieClip
	{
		private var _weightDistance:uint = 1;
		private var _weightSize:uint = 1;
		private var _size:Number;
		private var _target:Ghost;
		
		private var _distanceMembershipFunction:FuzzyMembershipFunction;
		private var _sizeMembershiptFunction:FuzzyMembershipFunction;
		
		//MovingAni
		//EatingAni
		public function PacMan(size:Number):void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		}
		
		private function initFuzzy():void
		{
			var manifold:FuzzyManifold;
			var func:FuzzyMembershipFunction;
			
			trace("-----------------------------------------------------------------------");
			
			_distanceMembershipFunction = new FuzzyCustomMembershipFunction("Distance", "MyFunction", 0, 0, 250, 250);
			
			trace("-----------------------------------------------");
			
			_sizeMembershiptFunction = new FuzzyCustomMembershipFunction("Size", "MyFunction", 0, 0, 16, 16);
			
			trace("----------------------------------------------------------------------------");
		}
		
		private function onEnterFrame(e:Event):void
		{
		/*	if (target) {
		   //move x,y
		   checkDistance();
		   }
		
		   var target:Ghost = findTarget();
		   if (target)
		   {
		   target.addEventListener("EatEnd", eatEnd);
		 }*/
		
		}
		
		private function eatEnd(e:Event):void
		{
			//remove target after it
			_target = null;
		}
		
		private function checkDistance():void
		{
			//if at close distance 
			//start eating ani and 
		
		/*if (distance<15)
		   {
		   gotoAndPlay("EatingAni");
		 }*/
		}
		
		private function findTarget():Ghost
		{
			var child:DisplayObject;
			var len:int = this.parent.numChildren; //use Quad Tree
			var target:Ghost = null;
			var bestDesirability:Number = 0;
			var desirability:Number;
			var distance:Number;
			
			for (var i:int = 1; i < len; i++)
			{
				child = this.parent.getChildAt(i);
				
				if (child is Ghost)
				{
					distance = Math.sqrt((child.x - this.x) * (child.x - this.x) + (child.y - this.y) * (child.y - this.y))
					desirability = _weightDistance * _distanceMembershipFunction.calculateDOM(distance) + _weightSize * _sizeMembershiptFunction.calculateDOM(Ghost(child).size * 0.5 - this.size);
					
					if (bestDesirability > desirability)
					{
						bestDesirability = desirability;
						target = child as Ghost;
					}
				}
				
			}
			
			return target;
		
		}
		
		public function get weightDistance():uint
		{
			return _weightDistance;
		}
		
		public function set weightDistance(value:uint):void
		{
			_weightDistance = value;
		}
		
		public function get weightSize():uint
		{
			return _weightSize;
		}
		
		public function set weightSize(value:uint):void
		{
			_weightSize = value;
		}
		
		public function get size():Number
		{
			return _size;
		}
	
	}

}