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
		private var ammoStatusInput:FuzzyInput;
		private var distanceStatusInput:FuzzyInput;
		private var _target:Solder;
		private const HERO_WIDTH:int = 25;
		
		private var _targetMaxRange:Number = Number.MIN_VALUE;
		
		public function Hero():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_weapons = new Vector.<Weapon>();
		}
		
		public function addWeapon(weapon:Weapon):void
		{
			_weapons.push(weapon);
			currentWeapon = weapon;
			
			if (weapon.maxRange > _targetMaxRange)
				_targetMaxRange = weapon.maxRange;
		
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
				
							//
				if (target is Solder && target.x>HERO_WIDTH && target.x - HERO_WIDTH <_targetMaxRange  && !Solder(target).incomingMissile && Solder(target).health > 0)
				{
						return target as Solder;
				}
			}
			
			return null;
		}
		
		private function onEnterFrame(e:Event):void
		{
			//find target start  switch if needed shooting ani
			
			var weapon:Weapon;
			
			_target = findTarget();
			
			if (_target)
			{
				weapon=selectWeapon(_target);
				
				if (weapon)
				{
					if (_currentWeapon != weapon)
					{
						currentWeapon = weapon;
						
					}
					
					this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					this._currentWeapon.addEventListener("WEAPON_FIRED", onWeapondReady);
					shoot();
				}
					
				
				
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
			//trace("End shot");
		}
		
		private function selectWeapon(target:Solder):Weapon
		{
			var len:int = _weapons.length;
			var weapon:Weapon;
			var nextWeapon:Weapon=null;
			var desirability:Number;
			var bestDisarability:Number = 0;
			var distance:Number; // Math.sqrt((target.x - this.x) * (target.x - this.x) + (target.y - this.y) * (target.y - this.y));
			
			distance = target.x - HERO_WIDTH;
			
				for (var i:int = 0; i < len; i++)
				{
					
					weapon = _weapons[i];
					
					
					if (!weapon.ammo || weapon.maxRange < distance)
						continue;
					
					desirability = weapon.getDesirability(distance);
					
					trace(">>>WEAPON:",weapon,"HAS DESIRABILITY:",desirability,"at DISTANCE", distance,"AMMO:", weapon.ammo,"tgt:",target.x);
					
					if (bestDisarability < desirability)
					{
						trace("CHANGE FROM:", bestDisarability,"TO:", desirability);
						bestDisarability = desirability;
						nextWeapon = weapon;
						
					}
				}
				
				return nextWeapon;
				
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
		
		}
	
	}