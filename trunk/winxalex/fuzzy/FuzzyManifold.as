package winxalex.fuzzy 
{
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyManifold//FuzzySurface
	{
		public var name:String;
		public var memberfunctions:Array;
		public var maxRange:Number = Number.MIN_VALUE;
		public var minRange:Number = Number.MAX_VALUE;
	    private var _fuzzificator:Fazzificatior = null;
		
		public function FuzzyManifold(name:String) 
		{
			this.name = name;
			memberfunctions = new Array();
		}
		
		public function addMember(funct:FuzzyMembershipFunction):void
		{
			memberfunctions[funct.linguisticTerm] = funct;
			memberfunctions.length = memberfunctions.length + 1;
			
			if (funct.leftOffset < minRange)
			minRange = funct.leftOffset;
			
			if (funct.rightOffset > maxRange)
			maxRange = funct.rightOffset;
			
			trace("Membership function <" + funct.linguisticTerm + "> added to manifold {" + this.name+"} range["+minRange+","+maxRange+"]");
			
		}
		
		
		internal function Fuzzify(value:Number):void
		{
		
			if (memberfunctions.length > 0)
			{
				
				
				if (value<=maxRange && value>=minRange)
				{
								 
					  for each (var func:IFuzzyMembershipFunction in  this.memberfunctions)
					  {
						    func.reset();
							func.calculateDOM(value);
							trace(this.name,FuzzyMembershipFunction(func).linguisticTerm,FuzzyMembershipFunction(func).degreeOfMembership);
					  }
				}
				else
				throw new Error("value :"+value+" out of range");
			}
			else
			{
				throw new Error("no membership function involved in manifold <"+this.name+">");
			}
		}
		
		public function toString():String
		{
			var s:String="";
			 for each (var func:IFuzzyMembershipFunction in  this.memberfunctions)
					  {
						  
						  s += func.toString()+"\n";
							
					  }
					  
					  return s;
		}
		
	}

}