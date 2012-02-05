package
{
	import flash.display.MovieClip;
	import winxalex.fuzzy.Fuzzificator;
	import winxalex.fuzzy.FuzzyInput;
	import winxalex.fuzzy.FuzzyManifold;
	import winxalex.fuzzy.DefuzzificationMethod;
	
	/**
	 * ...
	 * @author alex winx (winx@winx.ws)
	 */
	public class Weapon extends MovieClip
	{
		
		public var ammo:uint;
		private var _fuzzificator:Fuzzificator;
		private var _desirability:Number;
		private var _ammoStatusInput:FuzzyInput;
		private var _distanceStatusInput:FuzzyInput;
		private var _maxRange:Number;
		private var _minRange:Number;
		public var target:Solder;
		
		public function Weapon(ammo:uint):void
		{
			var manifold:FuzzyManifold;
			
			this.ammo = ammo;
			
			_ammoStatusInput = new FuzzyInput();
			_distanceStatusInput = new FuzzyInput();
			
			_fuzzificator = getFuzzificator();
			
			manifold = _fuzzificator.getManifold("Distance_to_Target");
			
			_minRange = manifold.minRange;
			_maxRange = manifold.maxRange;
		}
		
		public function getDesirability(distance:Number):Number
		{
			
			var manifold:FuzzyManifold;
			
			if (ammo > 0)
			{
				manifold = _fuzzificator.getManifold("Desirability");
				
				if (distance < _minRange || distance > _maxRange)
					return 0;
				
				ammoStatusInput.value = ammo;
				distanceStatusInput.value = distance;
				
				_fuzzificator.Fuzzify();
				
				_fuzzificator.Defuzzify(DefuzzificationMethod.AVERAGE_OF_MAXIMA);
				
				return manifold.output;
			}
			
			return 0;
		
		}
		
		protected function getFuzzificator():Fuzzificator
		{
			return null;
		}
		
		public function prepShoot():void
		{
			var ammoStatus:uint;
			
			ammoStatus = ammo - 1;
			if (ammoStatus > -1)
			{
				ammo = ammoStatus;
				gotoAndPlay("SHOOT_ANI");
			}
			else
				ammo = 0;
		
		}
		
		public function shoot():void
		{
		
		}
		
		public function get ammoStatusInput():FuzzyInput
		{
			return _ammoStatusInput;
		}
		
		public function get distanceStatusInput():FuzzyInput
		{
			return _distanceStatusInput;
		}
		
		public function get maxRange():Number
		{
			return _maxRange;
		}
	
	}

}