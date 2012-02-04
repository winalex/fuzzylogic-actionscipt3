package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import winxalex.fuzzy.Fuzzificator;
	import winxalex.fuzzy.FuzzyInput;
	import winxalex.fuzzy.DefuzzificationMethod;
	import winxalex.fuzzy.FuzzyManifold;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Hero extends MovieClip
	{
		
		private var _weapons:Vector.<Weapon>;
		
		private var _currentWeapon:Weapon;
		private var _fuzzificator:Fuzzificator;
		private var ammoStatusInput:FuzzyInput;
		private var distanceStatusInput:FuzzyInput;
		private var _target:Solder;
		private const HERO_WIDTH:int = 25;
		private var distanceMaxRange:Number;
		
		public function Hero():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_weapons = new Vector.<Weapon>();
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
		
		}
		
		private function findTarget():Solder
		{
			var target:DisplayObject;
			var len:int = this.parent.numChildren;
			//not the best way to find target
			for (var i:int = 0; i < len; i++)
			{
				target = this.parent.getChildAt(i);
				
				if (target is Solder && !Solder(target).incomingMissile && target.x-HERO_WIDTH < distanceMaxRange && Solder(target).health > 0)
				{
					if (_currentWeapon is Knife)
					{
						//trace(target.x,this.width);
						if (target.x - HERO_WIDTH < 5)
							return target as Solder;
						else
							return null;
					}
					else
						return target as Solder;
				}
			}
			
			return null;
		}
		
		private function onEnterFrame(e:Event):void
		{
			//find target start  switch if needed shooting ani
			
			if (_target)
				return;
			_target = findTarget();
			
			if (_target)
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				selectWeapon(_target);
				
				shoot();
				
				this._currentWeapon.addEventListener("WEAPON_FIRED", onWeapondReady);
			}
		
		}
		
		private function shoot():void
		{
			this._currentWeapon.prepShoot();
		}
		
		private function onWeapondReady(e:Event):void
		{
			
			if (this._currentWeapon is Knife)
				_target.dispatchEvent(new Event("KNIFE_HIT"));
			
			_currentWeapon.addEventListener("END_SHOOT", onEndShoot);
			_currentWeapon.shoot();
		}
		
		private function onEndShoot(e:Event):void
		{
			_currentWeapon.removeEventListener("END_SHOOT", onEndShoot);
			_target.incomingMissile = true;
			_target = null;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function selectWeapon(target:Solder):void
		{
			var len:int = _weapons.length;
			var weapon:Weapon;
			var nextWeapon:Weapon;
			var desirability:Number;
			var bestDisarability:Number = Number.MIN_VALUE;
			var distance:Number = target.x - HERO_WIDTH;// Math.sqrt((target.x - this.x) * (target.x - this.x) + (target.y - this.y) * (target.y - this.y));
			
			for (var i:int = 0; i < len; i++)
			{
				
				weapon = _weapons[i];
				
				trace("I", i);
				
				if (!weapon.ammo)
					continue;
				
				ammoStatusInput.value = weapon.ammo;
				distanceStatusInput.value = distance;
				
				_fuzzificator.Fuzzify();
				
				desirability = FuzzyManifold(_fuzzificator.Defuzzify(DefuzzificationMethod.CENTROID)["Desirability"]).output;
				trace("COG CORRECTION: ", desirability);
				desirability = FuzzyManifold(_fuzzificator.Defuzzify(DefuzzificationMethod. AVERAGE_OF_MAXIMA)["Desirability"]).output;
				
				trace(">>>>>>>>>>WEAPON>>>>>", weapon, " DISTANCE :", distanceStatusInput.value, " AMMO:", ammoStatusInput.value, "DES>>", bestDisarability, desirability);
				
				if (bestDisarability < desirability)
				{
					trace("CHANGE:", bestDisarability, desirability);
					bestDisarability = desirability;
					nextWeapon = weapon;
					
				}
			}
			
			if (nextWeapon)
				if (_currentWeapon != nextWeapon)
					currentWeapon = nextWeapon;
		
		}
		
		public function get currentWeapon():Weapon
		{
			return _currentWeapon;
		}
		
		public function set currentWeapon(value:Weapon):void
		{
			if (_currentWeapon)
				this.removeChild(_currentWeapon);
			_currentWeapon = value;
			
			this.addChild(_currentWeapon);
		}
		
		public function set fuzzificator(value:Fuzzificator):void
		{
			_fuzzificator = value;
			
			ammoStatusInput = _fuzzificator.getManifold("Ammo_Status").input;
			distanceStatusInput = _fuzzificator.getManifold("Distance_to_Target").input;
			
			distanceMaxRange = FuzzyManifold(_fuzzificator.getManifold("Distance_to_Target")).maxRange;
		}
	
	}

}