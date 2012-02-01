package winxalex.fuzzy
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyManifold //FuzzySurface
	{
		public var name:String;
		public var memberfunctions:AssociativeArray;
		public var maxRange:Number = Number.MIN_VALUE;
		public var minRange:Number = Number.MAX_VALUE;
		
		public var input:FuzzyInput;
		private var _output:Number;
		private var _container:Graphics;
		
		private var _fuzzificator:Fuzzificator = null;
		private var _drawingScaleX:uint;
		private var _drawingScaleY:uint;
		
		public function FuzzyManifold(name:String)
		{
			this.name = name;
			memberfunctions = new AssociativeArray(); // Array();
		}
		
		/******************************************
		 * 						 getMaxDOM
		 * @param	input
		 * @return
		 ******************************************/
		public function getMaxDOM(input:Number):Number
		{
			//same principal as in fMax
			/*	func = FuzzyMembershipFunction( ifunc);
			   func.maximumDOM = func.levelOfConfidence;
			   currentDOM = ifunc.calculateDOM(input);
			   if (max < currentDOM) max = currentDOM;
			 func.reset();*/
			
			var len:int = memberfunctions.length;
			var max1:Number;
			var max2:Number;
			var max3:Number;
			var pointer1:int;
			var pointer2:int;
			var func1:FuzzyMembershipFunction;
			var func2:FuzzyMembershipFunction;
			
			if (len == 2)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				
				func1.levelOfConfidence = func1.degreeOfMembership;
				func2.levelOfConfidence = func2.degreeOfMembership;
				
				max1 = func1.calculateDOM(input);
				max2 = func2.calculateDOM(input);
				
				//restore
				func1.degreeOfMembership = func1.levelOfConfidence;
				func2.degreeOfMembership= func2.levelOfConfidence;
				
				
				return max1 > max2 ? max1 : max2;
			}
			if (len == 3)
			{
				
				max1 = IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input);
				max2 = IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input);
				max3 = IFuzzyMembershipFunction(memberfunctions[2]).calculateDOM(input);
				
				//trace(max1, max2, max3);
				
				return max1 > max2 ? max1 > max3 ? max1 : max3 : max2 > max3 ? max2 : max3;
			}
			
			pointer1 = 1;
			pointer2 = len - 2;
			
			max1 = IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input);
			max2 = IFuzzyMembershipFunction(memberfunctions[len - 1]).calculateDOM(input);
			
			while (pointer1 <= pointer2)
			{
				
				if (max1 < IFuzzyMembershipFunction(memberfunctions[pointer1]).calculateDOM(input))
					max1 = FuzzyMembershipFunction(memberfunctions[pointer1]).degreeOfMembership;
				
				if (pointer1 < pointer2)
				{
					if (max2 < IFuzzyMembershipFunction(memberfunctions[pointer2]).calculateDOM(input))
						max2 = FuzzyMembershipFunction(memberfunctions[pointer2]).degreeOfMembership;
					pointer2 = pointer2 - 1;
				}
				
				pointer1 = pointer1 + 1;
				
					//trace(max1, max2);
					//trace("loop pass");
				
			}
			
			return max1 > max2 ? max1 : max2;
		
		}
		
		/******************************************
		 * 			 getSumDom(input:Number)
		 * @param	input
		 * @return
		 ******************************************/
		public function getSumDOM(input:Number):Number
		{
			//same principal as in fSum
			
			/*func = FuzzyMembershipFunction( ifunc);
			   func.maximumDOM =  func.levelOfConfidence;
			   sumDOMs += ifunc.calculateDOM(input);
			 func.reset();*/
			var len:int = memberfunctions.length;
			var pointer1:int;
			var pointer2:int;
			var sum1:Number;
			var sum2:Number;
			
			if (len == 2)
				return IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input) + IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input)
			if (len == 3)
				return IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input) + IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input) + IFuzzyMembershipFunction(memberfunctions[2]).calculateDOM(input);
			if (len == 4)
				return IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input) + IFuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input) + IFuzzyMembershipFunction(memberfunctions[2]).calculateDOM(input) + IFuzzyMembershipFunction(memberfunctions[3]).calculateDOM(input);
			
			//TODO test sum of 5 and more
			pointer1 = 1;
			pointer2 = len - 2;
			
			sum1 = IFuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input); // Token(args[0]).value;
			sum2 = IFuzzyMembershipFunction(memberfunctions[len - 1]).calculateDOM(input); // Token(args[len - 1]).value;
			
			while (pointer1 <= pointer2)
			{
				
				sum1 += IFuzzyMembershipFunction(memberfunctions[pointer1]).calculateDOM(input); // Token(args[pointer1]).value;
				
				if (sum1 > 1)
					return 1;
				
				if (pointer1 < pointer2)
				{
					
					sum2 += IFuzzyMembershipFunction(memberfunctions[pointer2]).calculateDOM(input); //Token(args[pointer2]).value;
					if (sum2 > 1)
						return 1;
					pointer2 = pointer2 - 1;
				}
				
				pointer1 = pointer1 + 1;
				
					//trace(sum1, sum2);
					//trace("loop pass");
				
			}
			sum1 += sum2;
			return sum1 > 1 ? 1 : sum1;
		
		}
		
		public function getCOG():Number
		{
			var len:int = memberfunctions.length;
			var max1:Number;
			var max2:Number;
			var max3:Number;
			
			var pointer1:int;
			var pointer2:int;
			
			var poly:Vector.<Point>;
			
			var func1:FuzzyMembershipFunction;
			var func2:FuzzyMembershipFunction;
			var func3:FuzzyMembershipFunction;
			var func4:FuzzyMembershipFunction;
			var func5:FuzzyMembershipFunction;
			
			var value:Number;
			var x0:Number, x1:Number, y1:Number, y0:Number;
			var a:Number;
			var signedArea:Number;
			var intersectionPoint:Point;
			var shapePoints:Vector.<Point> = new Vector.<Point>;
			
			if (len == 2)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				
				intersectionPoint = FuzzyManifold.intersect(func1, func2);
				
				shapePoints[shapePoints.length] = func1.leftPoint;
				shapePoints[shapePoints.length] = func1.leftPeekPoint;
				//if its triangle (LOC=1 ) or if intersection not lies on the LOC line
				if (func1.leftPeekPoint.x != func1.rightPeekPoint.x && intersectionPoint.y != func1.levelOfConfidence)
				{
					shapePoints[shapePoints.length] = func1.rightPeekPoint;
					
				}
				shapePoints[shapePoints.length] = intersectionPoint;
				
				if (intersectionPoint.y != func2.levelOfConfidence)
					shapePoints[shapePoints.length] = func2.leftPeekPoint;
				
				if (func2.leftPeekPoint.x != func2.rightPeekPoint.x)
					shapePoints[shapePoints.length] = func2.rightPeekPoint;
				
				shapePoints[shapePoints.length] = func2.rightPoint;
				
				return compute2DPolygonCentroid(shapePoints);
			}
			
			if (len == 3)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				func3 = FuzzyMembershipFunction(memberfunctions[2]);
				
				FuzzyManifold.intersect(func1, func2);
				
				intersectionPoint = FuzzyManifold.intersect(func1, func2);
				
				shapePoints[shapePoints.length] = func1.leftPoint;
				shapePoints[shapePoints.length] = func1.leftPeekPoint;
				//if its triangle (LOC=1 ) or if intersection not lies on the LOC line
				if (func1.leftPeekPoint.x != func1.rightPeekPoint.x && intersectionPoint.y != func1.levelOfConfidence)
				{
					shapePoints[shapePoints.length] = func1.rightPeekPoint;
					
				}
				
				shapePoints[shapePoints.length] = intersectionPoint;
				
				if (intersectionPoint.y != func2.levelOfConfidence)
					shapePoints[shapePoints.length] = func2.leftPeekPoint;
				
									
			    intersectionPoint=FuzzyManifold.intersect(func2, func3);
				
				//if its triangle (LOC=1 ) or if intersection not lies on the LOC line
				if (func2.leftPeekPoint.x != func2.rightPeekPoint.x && intersectionPoint.y != func2.levelOfConfidence)
				{
				   shapePoints[shapePoints.length] = func2.rightPeekPoint;
				}	
				
				shapePoints[shapePoints.length] = intersectionPoint;
				
				if(intersectionPoint.y!=func3.levelOfConfidence)
				shapePoints[shapePoints.length] = func3.leftPeekPoint;
				
				if(func3.leftPeekPoint.x!=func3.rightPeekPoint.x)
				shapePoints[shapePoints.length] = func3.rightPeekPoint;
				
				shapePoints[shapePoints.length] = func3.rightPoint;
			/*	
				if (_container)
				{
					drawAreaShapePoints(shapePoints);
				}*/
				
				return compute2DPolygonCentroid(shapePoints);
			}
			/*
			
			   if (len == 4)
			   {
			   return computeContureCentroid(unionConture(FuzzyMembershipFunction(memberfunctions[0]).conture,FuzzyMembershipFunction(memberfunctions[1]).conture,FuzzyMembershipFunction(memberfunctions[2]).conture));
			   }
			
			   if (len == 5)
			   return computeContureCentroid(unionConture(FuzzyMembershipFunction(memberfunctions[0]).conture,FuzzyMembershipFunction(memberfunctions[1]).conture,FuzzyMembershipFunction(memberfunctions[2]).conture));
			   }
			 */
			throw new Error(" Not Implemented for 4 memberfunction");
		}
		
		
		
		public function fillArea():void
		{
			 for each (var func:FuzzyMembershipFunction in this.memberfunctions)
					{
						func.fillArea(_container, _drawingScaleX, _drawingScaleY);
					}
		}
		
		public function draw(container:Graphics,scaleX:uint=1,scaleY:uint=50):void{
			
			container.clear();
			
			_container = container;
			_drawingScaleX = scaleX;
			_drawingScaleY = scaleY;
			
			    for each (var func:FuzzyMembershipFunction in this.memberfunctions)
					{
						func.draw(container,scaleX,scaleY);
					}
		}
		
		private function drawAreaShapePoints(points:Vector.<Point>):void
		{
			var i:int = 0;
			var len:int = points.length;
			var point:Point;
			
			_container.lineStyle(2);
			
			for (i = 0; i < len; ++i)
			{
				point = points[i];
				_container.drawCircle(point.x*_drawingScaleX, -point.y*_drawingScaleY, 2);
			}
		}
		
		
		
		
		public static function intersect(leftFunction:FuzzyMembershipFunction, rightFunction:FuzzyMembershipFunction):Point
		{
			
			var intersectionPoint:Point;
			
			if (leftFunction is FuzzyTrapezoidMembershipFunction && rightFunction is FuzzyTrapezoidMembershipFunction)
			{
				
				if (leftFunction.levelOfConfidence != 1 || rightFunction.levelOfConfidence != 1)
					if (leftFunction.levelOfConfidence > rightFunction.levelOfConfidence)
					{
						//   /\-
						intersectionPoint = lineIntersectLine(leftFunction.rightPeekPoint, leftFunction.rightPoint, rightFunction.leftPeekPoint, rightFunction.rightPeekPoint);
						
						if (intersectionPoint)
							return intersectionPoint;
						
					}
					else
					{
						//  -/\
						
						intersectionPoint = lineIntersectLine(leftFunction.leftPeekPoint, leftFunction.rightPeekPoint, rightFunction.leftPoint, rightFunction.leftPeekPoint);
						
						if (intersectionPoint)
							return intersectionPoint;
					}
				
				// /\/\
				
				intersectionPoint = lineIntersectLine(leftFunction.rightPeekPoint, leftFunction.rightPoint, rightFunction.leftPoint, rightFunction.leftPeekPoint);
				
				if (intersectionPoint)
					return intersectionPoint;
				
				throw new Error("Cant' find intersection point between " + leftFunction.linguisticTerm + "," + rightFunction.linguisticTerm);
				
			}
			else if (leftFunction is FuzzyGaussMembershipFunction && rightFunction is FuzzyTrapezoidMembershipFunction)
			{
				throw new Error("Not implemented yet");
			}
			else if (leftFunction is FuzzyTrapezoidMembershipFunction && rightFunction is FuzzyGaussMembershipFunction)
			{
				throw new Error("Not implemented yet");
			}
			else if (leftFunction is FuzzyGaussMembershipFunction && rightFunction is FuzzyGaussMembershipFunction)
			{
				throw new Error("Not implemented yet");
			}
			
			return null;
		}
		
		private static function compute2DPolygonCentroid(vertices:Vector.<Point>):Number
		{
			var centroid:Number=0;
			var signedArea:Number = 0.0;
			var x0:Number = 0.0; // Current vertex X
			var y0:Number = 0.0; // Current vertex Y
			var x1:Number = 0.0; // Next vertex X
			var y1:Number = 0.0; // Next vertex Y
			var a:Number = 0.0; // Partial signed area
			
			// For all vertices except last
			var i:int = 0;
			var len:int = vertices.length - 1;
			for (i = 0; i < len; ++i)
			{
				x0 = vertices[i].x;
				y0 = vertices[i].y;
				
				x1 = vertices[i + 1].x;
				y1 = vertices[i + 1].y;
				a = (x0 * y1 - x1 * y0);
				signedArea += a;
				centroid += (x0 + x1) * a;
				
			}
			
			// Do last vertex
			x0 = vertices[i].x;
			y0 = vertices[i].y;
			x1 = vertices[0].x;
			y1 = vertices[0].y;
			a = (x0 * y1 - x1 * y0);
			signedArea += a;
			centroid += (x0 + x1) * a;
			
			centroid /= (3 * signedArea);
			
			return centroid;
		}
		
		public static function lineIntersectGauss():Point
		{
			return null;
		}
		
		public static function gaussIntersectGauss():Point
		{
			return null;
		}
		
		//---------------------------------------------------------------
		//Checks for intersection of Segment if as_seg is true.
		//Checks for intersection of Line if as_seg is false.
		//Return intersection of Segment AB and Segment EF as a Number3D
		//Return null if there is no intersection
		//---------------------------------------------------------------
		public static function lineIntersectLine(A:Point, B:Point, E:Point, F:Point, as_seg:Boolean = true):Point
		{
			var dABy:Number;
			var denom:Number;
			//intersection Number3D
			var ip:Point;
			var a1:Number;
			var a2:Number;
			var b1:Number;
			var b2:Number;
			var c1:Number;
			var c2:Number;
			
			var dipBx:Number;
			var dipBy:Number;
			var dAz:Number;
			var dABx:Number;
			
			var dAx:Number;
			var dEx:Number;
			var dEy:Number;
			
			var dEFx:Number = E.x - F.x;
			var dEFy:Number = E.y - F.y;
			
			dABx = A.x - B.x;
			dABy = A.y - B.y;
			
			a1 = B.y - A.y;
			//a1 = -dABy;
			
			//b1 = A.x - B.x;
			b1 = dABx;
			
			c1 = B.x * A.y - A.x * B.y;
			a2 = F.y - E.y;
			//a2 = -dEFy;
			
			//b2 = E.x - F.x;
			b2 = dEFx;
			c2 = F.x * E.y - E.x * F.y;
			
			denom = a1 * b2 - a2 * b1;
			
			if (denom == 0)
			{
				return null;
			}
			
			ip = new Point();
			ip.x = (b1 * c2 - b2 * c1) / denom;
			ip.y = (a2 * c1 - a1 * c2) / denom;
			
			//---------------------------------------------------
			//Do checks to see if intersection to endNumber3Ds
			//distance is longer than actual Segments.
			//Return null if it is with any.
			//---------------------------------------------------
			
			if (as_seg)
			{
				
				dipBx = ip.x - B.x;
				dipBy = ip.y - B.y;
				
				var mul_dABx2dABy2:Number;
				mul_dABx2dABy2 = dABx * dABx + dABy * dABy;
				//if (Math.pow(ip.x - B.x, 2) + Math.pow(ip.y - B.y, 2) > Math.pow(A.x - B.x, 2) + Math.pow(A.y - B.y, 2))
				if (dipBx * dipBx + dipBy * dipBy > mul_dABx2dABy2)
				{
					return null;
				}
				
				var dipAx:Number = ip.x - A.x;
				var dipAz:Number = ip.y - A.y;
				
				//if (Math.pow(ip.x - A.x, 2) + Math.pow(ip.y - A.y, 2) > Math.pow(A.x - B.x, 2) + Math.pow(A.y - B.y, 2))
				if (dipAx * dipAx + dipAz * dipAz > mul_dABx2dABy2)
				{
					return null;
				}
				
				var dipFx:Number = ip.x - F.x;
				var dipFy:Number = ip.y - F.y;
				
				var mul_dEFx2dEFy2:Number = dEFx * dEFx + dEFy * dEFy;
				
				//if (Math.pow(ip.x - F.x, 2) + Math.pow(ip.y - F.y, 2) > Math.pow(E.x - F.x, 2) + Math.pow(E.y - F.y, 2))
				if (dipFx * dipFx + dipFy * dipFy > mul_dEFx2dEFy2)
				{
					return null;
				}
				
				var dipEx:Number = ip.x - E.x;
				var dipEy:Number = ip.y - E.y;
				
				//if (Math.pow(ip.x - E.x, 2) + Math.pow(ip.y - E.y, 2) > Math.pow(E.x - F.x, 2) + Math.pow(E.y - F.y, 2))
				if (dipEx * dipEx + dipEy * dipEy > mul_dEFx2dEFy2)
				{
					return null;
				}
			}
			return ip;
		}
		
		/**
		 * Middle of maximums (SOM  MOM  LOM)
		 * SOM - smallest input value on which of maximum LOC is achived
		 * LOM - largest input value on which of maximum LOC is achived
		 * @return
		 */
		public function getMOM():Number
		{
			
			var len:int = memberfunctions.length;
			var max1:Number;
			var max2:Number;
			var max3:Number;
			
			var pointer1:int;
			var pointer2:int;
			
			var func1:FuzzyMembershipFunction;
			var func2:FuzzyMembershipFunction;
			var func3:FuzzyMembershipFunction;
			var func4:FuzzyMembershipFunction;
			var func5:FuzzyMembershipFunction;
			
			if (len == 2)
			{
				
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				
				return max1 > max2 ? func1.averageDomain : func2.averageDomain;
			}
			
			if (len == 3)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				func3 = FuzzyMembershipFunction(memberfunctions[2]);
				
				//return  func1.maximumDOM >  func2.maximumDOM? ( func1.maximumDOM> func3.maximumDOM?  func1.averagePoint : func1.maximumDOM >  func2.maximumDOM? ( func1.maximumDOM> func3.maximumDOM?  func1.averagePoint: func3.averagePoint) : (func2.maximumDOM > func3.maximumDOM ? func2.averagePoint:func3.averagePoint);: func3.averagePoint) : (func2.maximumDOM > func3.maximumDOM ? func2.averagePoint:func3.averagePoint);					
				return func1.levelOfConfidence > func2.levelOfConfidence ? (func1.levelOfConfidence > func3.levelOfConfidence ? func1.averageDomain : func3.averageDomain) : (func2.levelOfConfidence > func3.levelOfConfidence ? func2.averageDomain : func3.averageDomain);
			}
			
			pointer1 = 1;
			pointer2 = len - 2;
			
			//pointer1=0
			func1 = FuzzyMembershipFunction(memberfunctions[0]);
			trace(FuzzyMembershipFunction(func1).toString());
			max1 = func1.levelOfConfidence;
			
			//pointer1=len-1
			func2 = FuzzyMembershipFunction(memberfunctions[len - 1]);
			max2 = func2.levelOfConfidence;
			
			//trace(max1, max2);
			
			while (pointer1 <= pointer2)
			{
				
				if (max1 < FuzzyMembershipFunction(memberfunctions[pointer1]).levelOfConfidence)
				{
					func1 = memberfunctions[pointer1];
					max1 = func1.levelOfConfidence;
					
				}
				
				if (pointer1 < pointer2)
				{
					
					if (max2 < FuzzyMembershipFunction(memberfunctions[pointer2]).levelOfConfidence)
					{
						func2 = memberfunctions[pointer2];
						max2 = func2.levelOfConfidence;
					}
					
					pointer2 = pointer2 - 1;
				}
				
				pointer1 = pointer1 + 1;
				
					//	trace(max1, max2);
					//	trace("loop pass");
				
			}
			
			return max1 > max2 ? func1.averageDomain : func2.averageDomain;
			
			//TODO make and test MOM for 4 and more functions
			throw(new Error(" MOM for 4 and more not yet implemented"));
			
			return NaN;
		
		}
		
		public function getMaxAv():Number
		{
			
			/*	for each(var ifunc:IFuzzyMembershipFunction in fm.memberfunctions)
			   {
			   func = FuzzyMembershipFunction( ifunc);
			   if(func.maximumDOM<1)
			   func.maximumDOM = 1;//it is reset
			
			   sumAvgMulLOC+= ifunc.maximumDomain *func.levelOfConfidence;
			
			   sumLOC += func.levelOfConfidence;
			
			
			 }*/
			
			var len:int = memberfunctions.length;
			var func1:FuzzyMembershipFunction;
			var func2:FuzzyMembershipFunction;
			var func3:FuzzyMembershipFunction;
			var func4:FuzzyMembershipFunction;
			var func5:FuzzyMembershipFunction;
			
			if (len == 2)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				
				return (func1.levelOfConfidence * func1.maximumDomain + func2.levelOfConfidence * func2.maximumDomain) / (func1.levelOfConfidence + func2.levelOfConfidence);
				
			}
			
			if (len == 3)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				func3 = FuzzyMembershipFunction(memberfunctions[2]);
				
				return (func1.levelOfConfidence * func1.maximumDomain + func2.levelOfConfidence * func2.maximumDomain + func3.levelOfConfidence * func3.maximumDomain) / (func1.levelOfConfidence + func2.levelOfConfidence + func3.levelOfConfidence);
			}
			
			if (len == 4)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				func3 = FuzzyMembershipFunction(memberfunctions[2]);
				func4 = FuzzyMembershipFunction(memberfunctions[3]);
				
				return (func1.levelOfConfidence * func1.maximumDomain + func2.levelOfConfidence * func2.maximumDomain + func3.levelOfConfidence * func3.maximumDomain + func4.levelOfConfidence * func4.maximumDomain) / (func1.levelOfConfidence + func2.levelOfConfidence + func3.levelOfConfidence + func4.levelOfConfidence);
				
			}
			
			if (len == 5)
			{
				func1 = FuzzyMembershipFunction(memberfunctions[0]);
				func2 = FuzzyMembershipFunction(memberfunctions[1]);
				func3 = FuzzyMembershipFunction(memberfunctions[2]);
				func4 = FuzzyMembershipFunction(memberfunctions[3]);
				func5 = FuzzyMembershipFunction(memberfunctions[4]);
				
				return (func1.levelOfConfidence * func1.maximumDomain + func2.levelOfConfidence * func2.maximumDomain + func3.levelOfConfidence * func3.maximumDomain + func4.levelOfConfidence * func4.maximumDomain + func5.levelOfConfidence * func5.maximumDomain) / (func1.levelOfConfidence + func2.levelOfConfidence + func3.levelOfConfidence + func4.levelOfConfidence + func5.levelOfConfidence);
				
			}
			
			///TODO implement for more then 6 functions
			throw(new Error("For more then 5 function not yet implemented"));
		
		}
		
		public function getMaxDOMFunc(input:Number):FuzzyMembershipFunction
		{
			var len:int = memberfunctions.length;
			var max1:Number;
			var max2:Number;
			var max3:Number;
			
			var pointer1:int;
			var pointer2:int;
			
			var func1:FuzzyMembershipFunction;
			var func2:FuzzyMembershipFunction;
			var func3:FuzzyMembershipFunction;
			
			if (len == 2)
			{
				
				max1 = FuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input);
				
				max2 = FuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input);
				
				return max1 > max2 ? memberfunctions[0] : memberfunctions[1];
			}
			if (len == 3)
			{
				
				max1 = FuzzyMembershipFunction(memberfunctions[0]).calculateDOM(input);
				
				max2 = FuzzyMembershipFunction(memberfunctions[1]).calculateDOM(input);
				
				max3 = FuzzyMembershipFunction(memberfunctions[2]).calculateDOM(input);
				
				return max1 > max2 ? (max1 > max3 ? FuzzyMembershipFunction(memberfunctions[0]) : FuzzyMembershipFunction(memberfunctions[2])) : (max2 > max3 ? FuzzyMembershipFunction(memberfunctions[1]) : FuzzyMembershipFunction(memberfunctions[2]));
			}
			
			//TODO Already partually tested
			pointer1 = 1;
			pointer2 = len - 2;
			
			//pointer1=0
			func1 = FuzzyMembershipFunction(memberfunctions[0]);
			//trace(FuzzyMembershipFunction(func1).toString());
			max1 = func1.calculateDOM(input);
			
			//pointer1=len-1
			func2 = FuzzyMembershipFunction(memberfunctions[len - 1]);
			max2 = func2.calculateDOM(input);
			
			//trace(max1, max2);
			
			while (pointer1 <= pointer2)
			{
				
				if (max1 < IFuzzyMembershipFunction(memberfunctions[pointer1]).calculateDOM(input))
				{
					func1 = memberfunctions[pointer1];
					max1 = FuzzyMembershipFunction(func1).levelOfConfidence;
					
				}
				
				if (pointer1 < pointer2)
				{
					
					if (max2 < IFuzzyMembershipFunction(memberfunctions[pointer2]).calculateDOM(input))
					{
						func2 = memberfunctions[pointer2];
						max2 = FuzzyMembershipFunction(func2).levelOfConfidence;
					}
					
					pointer2 = pointer2 - 1;
				}
				
				pointer1 = pointer1 + 1;
				
					//	trace(max1, max2);
					//	trace("loop pass");
				
			}
			
			return max1 > max2 ? FuzzyMembershipFunction(func1) : FuzzyMembershipFunction(func2);
		
		}
		
		public function addMember(func:FuzzyMembershipFunction):void
		{
			var currentRangeValue:Number;
			
			memberfunctions[func.linguisticTerm] = func;
			
			//TODO (SORT  by X) important for CENTROID
			//memberfunctions.callProperty("sort",func.leftPoint.x);
			
			//memberfunctions.length = memberfunctions.length + 1;
			
			currentRangeValue = isNaN(func.leftPoint.x) ? func.leftPeekPoint.x : func.leftPoint.x;
			if (minRange > currentRangeValue)
				minRange = currentRangeValue;
			
			currentRangeValue = isNaN(func.rightPoint.x) ? func.rightPeekPoint.x : func.rightPoint.x;
			if (maxRange < currentRangeValue)
				maxRange = currentRangeValue;
			
			trace("Membership function <" + func.linguisticTerm + ">of type:" + func.typeName + " added to manifold {" + this.name + "} range[" + minRange + "," + maxRange + "]");
		
		}
		
		/****************************************
		 *    			FUZZIFY
		 ***************************************/
		internal function Fuzzify():void
		{
			
			if (memberfunctions.length > 0)
			{
				
				if (input.value <= maxRange && input.value >= minRange)
				{
					
					for each (var func:FuzzyMembershipFunction in this.memberfunctions)
					{
						func.reset();
						func.levelOfConfidence=func.calculateDOM(input.value);
						trace(this.name, FuzzyMembershipFunction(func).linguisticTerm,"DOM:"+FuzzyMembershipFunction(func).degreeOfMembership+" for input "+input.value);
					}
				}
				else
					throw new Error("value :" + input.value + " out of range");
			}
			else
			{
				throw new Error("no membership function involved in manifold <" + this.name + ">");
			}
		}
		
		/**************************
		 *		   toString
		 * @return
		 **************************/
		public function toString():String
		{
			var s:String = "";
			
			for each (var func:IFuzzyMembershipFunction in this.memberfunctions)
			{
				
				s += func.toString() + "\n";
				
			}
			
			s += "Range:[" + minRange + "," + maxRange + "]";
			
			return s;
		}
		
		public function reset():void
		{
			for each (var func:IFuzzyMembershipFunction in this.memberfunctions)
			{
				
				func.reset();
				
			}
		}
		
		public function get output():Number
		{
			return _output;
		}
		
		public function set output(value:Number):void
		{
			_output = value;
		}
	
	}

}