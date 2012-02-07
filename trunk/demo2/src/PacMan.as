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
		private var _weightDistance:uint;
		private var _weightSize:uint;
		
		private var _distanceMembershipFunction:FuzzyMembershipFunction;
		private var _sizeMembershiptFunction:FuzzyMembershipFunction;
		//MovingAni
		//EatingAni
		public function PacMan() 
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
			
						
			//!!! Warning make them sorted  by X so CENTROID won't work
			
			_distanceMembershipFunction = new FuzzyCustomMembershipFunction(...);
			
		
			trace("-----------------------------------------------");
			
			
			_sizeMembershiptFunction = new FuzzyCustomMembershipFunction(...);
					
			
			trace("----------------------------------------------------------------------------");
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (target) {
				//move x,y
				checkDistance();
			}
			
			var target:Cap = findTarget();
			if (target) 
			{
				target.addEventListener("EatEnd", eatEnd);
			}
			
		}
		
		private function eatEnd(e:Event):void 
		{
			//remove target after it
			target = null;
		}
		
		private function checkDistance():void 
		{
			//if at close distance 
			//start eating ani and 
			
			if (distance<15)
			{
				gotoAndPlay("EatingAni");
			}
		}
		
		private function findTarget():Cap
		{
			var target:DisplayObject;
			var len:int = this.parent.numChildren;//use Quad Tree
			var decision:int = 0;
			var bestDesirability:Number = 0;
			var desirability:Number;
			var distance:Number;
			
			for (var i:int = 1; i < len; i++)
			{
				target = this.parent.getChildAt(i);
				
				distance=Math.sqrt((target.x-this.x)*(target.x-this.x)+(target.y-this.y)*(target.y-this.y))
				desirability = weightDistance * _distanceMembershipFunction.calculateDOM(distance) + weightSize * _;
				
				if (bestDesirability > desirability)
				{
					bestDesirability = desirability;
					decision = i;
				}
				
			}
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
		
	}

}