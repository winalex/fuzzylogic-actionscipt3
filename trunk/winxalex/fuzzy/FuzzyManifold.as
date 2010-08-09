package winxalex.fuzzy 
{
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyManifold//FuzzySurface
	{
		public var name:String;
		public var memberfunctions:Vector.<FuzzyMembershipFunction>;
		public var maxRange:Number = Number.MIN_VALUE;
		public var minRange:Number = Number.MAX_VALUE;
	    private var _fazzificator:Fazzificatior = null;
		
		public function FuzzyManifold(name:String) 
		{
			this.name = name;
		}
		
		public function addMember(funct:FuzzyMembershipFunction):void
		{
			memberfunctions[funct.linguisticQuantifier] = funct;
			
			if (funct.leftOffset < minRange)
			minRange = funct.leftOffset;
			
			if (funct.rightOffset > maxRange)
			minRange = funct.leftOffset;
			
		}
		
		
		internal function Fuzzify(value:Number):void
		{
			if (!_fazzificator)
			{
				throw new Error("Add Manifold to the Fazzificator and use Fazzificator.Fuzzyfy");
			}
			
			if (memberfunctions.length > 0)
			{
			
				if (value<=maxRange && value>=minRange)
				{
								 
					  for each (var func:IFuzzyMembershipFunction in  this.memberfunctions)
					  {
						    func.reset();
							func.calculateDOM(value);
					  }
				}
				else
				throw new Error("value out of range");
			}
			else
			{
				throw new Error("no membership function involved in manifold");
			}
		}
		
	}

}