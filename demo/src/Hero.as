package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Hero extends MovieClip 
	{
		
		private var _weapons:Vector.<Weapon>;
		private var _bestDisarability:Number=0;
		private var _currentWeapon:Weapon;
		private var _fuzzificator:Fuzzificator;
		private var ammoStatusInput:FuzzyInput;
		private var distanceStatusInput:FuzzyInput;
		private var target:Solder;
		
		
		public function Hero() :void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function addWeapon(weapon:Weapon):void 
		{
			_weapons.push(weapon);
			currentWeapon = weapon;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener("END_SHOOT", onEndShoot);
		}
		
		
		
		
		private function findTarget():Solder 
		{
			var target:DisplayObject;
			//not the best way to find target
			for (var i:int = 0; this.parent.numChildren; i++)
			{
				target = this.parent.getChildAt(i);
				if (target is Solder && target.health > 0) {
					return target;
				}
			}
			
			return null;
		}
		
		private function onEnterFrame(e:Event):void 
		{
			//find target start  switch if needed shooting ani
			
			target = findTarget();
			
			if (target) {
				selectWeapon(target);
				this.removeEventListener(Event.ENTER_FRAME);
				this.addEventListener("WEAPON_FIRED",onWeapondReady);
			}
			
		}
		
		private function shoot():void 
		{
			this.gotoAndPlay("SHOOT_ANI");
		}
		
		private function onWeapondReady():void {
			
			 target.dispatchEvent(new Event("KNIFE_HIT"));
			 _currentWeapon.shoot();
		}
		
		private function onEndShoot(e:Event):void 
		{
			
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function selectWeapon(target:Solder):void 
		{
			var len:int = _weapons.length;
			var weapon:Weapon;
			var desirability:Number;
			var distance:Number = Math.sqrt((target.x - this.x)*(target.x - this.x) + (target.y - this.y)*(target.y - this.y));
			
			for (var i:int = 0; i < len; i++) {
				
				weapon = _weapons[i];
				
				ammoStatusInput.value = weapon.ammo;
			    distanceStatusInput.value = distance;
				
				fuzzificator.Fuzzify();
				desirability = fuzzificator.Defuzzify(DefuzzificationMethod. AVERAGE_OF_MAXIMA);
				
				
				
				if (_bestDisarability < desirability) {
					_bestDisarability = desirability;
					currentWeapon = weapon;
				}
			}
		}
		
		public function get currentWeapon():Weapon 
		{
			return _currentWeapon;
		}
		
		public function set currentWeapon(value:Weapon):void 
		{
			if (_currentWeapon) this.removeChild(_currentWeapon);
			_currentWeapon = value;
			
			this.addChild(_currentWeapon);
		}
		
		public function set fuzzificator(value:Fuzzificator):void 
		{
			_fuzzificator = value;
			
			_fuzzificator.getManifold("Distance_to_Target").input = ammoStatusInput;
			_fuzzificator.getManifold("Ammo_Status").input = distanceStatusInput;
			
		}
		
	}

}