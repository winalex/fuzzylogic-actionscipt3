package  
{
	import flash.system.ApplicationDomain;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author alex winx
	 */
	public class UniMatrix extends Proxy
	{
		private var _vector:*;// Vector.<*>;
		
		private var _unimatrixDimObjects:Vector.<UniMatrix>;
		private var _length:int = 1;
		
		private var _dimensionArray:Array;
		private var _argsVector:Vector.<int>;
		
		private var _index:uint = 0;
		private static var _mtx:UniMatrix;
		private static  const  VECTOR_CLASS_NAME : String = getQualifiedClassName(Vector );
		
		/**
		 * dimension
		 * @param	...args
		 */
		public function UniMatrix(cls:Class=null,applicationDomain : ApplicationDomain = null,...args) 
		{
			if(!cls) 
			return;
			
			if (args.length < 0)
			throw new Error("Unimatrix should have at least one dimension");
			
			_dimensionArray = args;
			
				_length = getLength(args);
			
				_argsVector = new Vector.<int>(args.length, true);
			
			_vector =UniMatrix.createCustomVector(cls,_length,true,applicationDomain);
			
			_mtx = new UniMatrix();
			
			
			
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
		
		public function dump():String
		{
			 throw new Error("Not yet implemented");
		}
		
		public function toString():String
		{
			var s:String = "";
			
			_index = 0;
			s = String(_vector[getIndex(_argsVector)]);
			
			return s;
		}
		
		
	}

}