package  winxalex.fuzzy.data
{
	import flash.system.ApplicationDomain;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author alex winx
	 */
	public class VectorEx extends Proxy
	{
		private var _vector:*;// Vector.<*>;
		
		private var _unimatrixDimObjects:Vector.<VectorEx>;
		private var _length:int = 1;
		
		private var _dimensionArray:Array;
		private var _argsVector:Vector.<int>;
		
		private var _index:uint = 0;
		private var _elemInx:uint = 0;
		private static var _mtx:VectorEx;
		private static  const  VECTOR_CLASS_NAME : String = getQualifiedClassName(Vector );
		
		/**
		 * 
		 * 
		 * dimension 
		 * @option array of dimension as first param
		 * @param	...args
		 */
		public function VectorEx(cls:Class=null,applicationDomain : ApplicationDomain = null,...args) 
		{
			var arguments:Array;
			if(!cls) 
			return;
			
			if (args.length < 0)
			throw new Error("Unimatrix should have at least one dimension");
			
					
			if (args[0] is Array) {
			    arguments = args[0];
			}else {
				arguments = args;
			}
			
			   _dimensionArray = arguments;
				_length = getLength(arguments);
			
				
				_argsVector = new Vector.<int>(arguments.length, true);
			
			_vector =VectorEx.createCustomVector(cls,_length,true,applicationDomain);
			
			_mtx = new VectorEx();
			
			
			
		}
		
		private static function getVectorDefinition(itemDefinition : Class, applicationDomain : ApplicationDomain = null) : Class
        {
            if(!applicationDomain) applicationDomain = ApplicationDomain.currentDomain;
            return applicationDomain.getDefinition( VECTOR_CLASS_NAME + '.<' + getQualifiedClassName( itemDefinition ) + '>' ) as Class;
        } 
     
       private static function createCustomVector(itemDefinition : Class, length : uint = 0, fixed : Boolean = false, applicationDomain : ApplicationDomain = null) :  *//Vector.<*>
        {
            var definition : Class = getVectorDefinition( itemDefinition, applicationDomain );
            return new definition( length, fixed );
        }    
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			name=Number(name);
			if (isNaN(name) || !(name is uint))
				throw new Error("Dimension < " + (name) + "> Error. Dimension should be unsign integer.");
			 
			 _argsVector[_index++] = int(name);
			 
			_vector[getIndex(_argsVector)] = value;
			
			_index = 0;
		}
		
		override flash_proxy function getProperty(name:*):* 
		{
			name=Number(name);
			if (isNaN(name) || !(name is uint))
			 throw new Error("Dimension < " + (name) + "> Error. Dimension should be unsign integer.");
			 
	
			 _argsVector[_index++]=int(name);
			
			return this;
		}
		
		private function getLength(args:Array):int
		{
			if (args.length == 1) return args[0]; 
			if (args.length == 2) return args[0] * args[1];
			if (args.length == 3 ) return args[0] * args[1] *args[2] ;
			if (args.length == 4 ) return args[0] * args[1] * args[2] * args[3];
			if (args.length == 5 ) return args[0] * args[1] * args[2] * args[3] * args[4];
			
				throw new Error("Not yet implemented");
		}
		
		private function getIndex(args:*):int
		{
			var inx:int=1;
			
			
			if (args.length == 1) {   return args[0]; }
			if (args.length == 2) return args[0] *_dimensionArray[1]+ args[1];
			//if (args.length == 3 ) return args[0] * _dimensionArray[1] + args[1] +args[2] * (_dimensionArray[0] * _dimensionArray[1]);
			if (args.length == 3 ) return  args[1] +(args[2] * _dimensionArray[0] +args[0] )*_dimensionArray[1];
			//if (args.length == 4 ) return  args[0] * _dimensionArray[1] + args[1] +args[2] * (_dimensionArray[0] * _dimensionArray[1]) + args[3] * ( _dimensionArray[0] * _dimensionArray[1] * _dimensionArray[2]);
			if (args.length == 4 ) return args[1] +   _dimensionArray[1] * ( args[0] + _dimensionArray[0]  *  ( args[2] + args[3] * _dimensionArray[2]));
			
			
			
			//if (args.length == 5 ) return _dimensionArray[1] *args[0]+ args[1] +args[2] * (_dimensionArray[0] * _dimensionArray[1]) + args[3] * ( _dimensionArray[0] * _dimensionArray[1] * _dimensionArray[2])+args[4] * ( _dimensionArray[0] * _dimensionArray[1] * _dimensionArray[2]*_dimensionArray[3]);
			if (args.length == 5 ) return args[1] +_dimensionArray[1] * (args[0] + _dimensionArray[0] * ( args[2] +  _dimensionArray[2] * (args[3] +args[4] * _dimensionArray[3])));
		
			
			throw new Error("Not yet implemented");
			
			
		
			
			return inx;
		}
		
		
		
		public function push(value:*):void {
			
			_vector[_elemInx++] = value;
		}
		
		
		
		public function getElementAt(...args):*
		{
			return _vector[getIndex(args)];
		}
		
		public function setElementAt(value:*,...args):void
		{
			 _vector[getIndex(args)] = value;
		}
		
		override flash_proxy function callProperty(name:*, ...rest):* 
		{
			trace("callProp");
			return null;
		}
		
		override flash_proxy function nextValue(index:int):* 
		{
			trace("nextValue");
			return null;
		}
		
		
		
		public function toString():String
		{
			var s:String = "";
			var i:int;
			var j:int;
			var k:int;
			var t:int;
			
			
			switch (_dimensionArray.length) {
				case 1:
				break;
				case 2:
				trace(_dimensionArray.length);
					 for(i=0;i<_dimensionArray[0];i++)
					  for (j = 0; j < _dimensionArray[1]; j++)
						  
						   {
							  
							  s+="["+i+"]["+j+"]="+getElementAt(i,j)+"\n";
							   
						   }
				break;
				
				case 3:{
				   for (k = 0; k < _dimensionArray[0]; k++)  
					for(i=0;i<_dimensionArray[1];i++)
						for (j= 0; j < 3; j++)
						   {
							   
							  s+="["+i+"]["+j+"]["+k+"]="+getElementAt(i,j,k)+"\n";
							   
						   }
				}
				break;
				
				case 4:
				   for (t=0; t < _dimensionArray[0]; t++)  
						for (k=0; k < _dimensionArray[1]; k++)  
							for(i=0;i<_dimensionArray[2];i++)
								for (j=0; j < _dimensionArray[3]; j++)
							   {
									  
									  s+="["+i+"]["+j+"]["+k+"]["+t+"]="+ getElementAt(i,j,k,t)+"\n";
									   
							   }
				break;
				
				default:
				 throw new Error("Not yet implemented");
			}
			
				
			
			return s;
		}
		
		
	}

}