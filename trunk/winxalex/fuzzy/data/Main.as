package  
{
	import flash.display.Sprite;
	import flashx.textLayout.elements.InlineGraphicElement;
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class Main extends Sprite
	{
		
		
		public function Main() 
		{
			
			var uni:UniMatrix;
			var elem:int=0;
			
			trace("2D Matrix");
			uni=new UniMatrix(int,null,2, 3);
			
			
			
			for(var i:int=0;i<2;i++)
			  for (var j:int = 0; j < 3; j++)
			  
			   {
				   trace("input:["+i+"]["+j+"]="+elem);
				    uni[i][j] = elem;
					elem++;
			   }
			   
			 
			 for(var i:int=0;i<2;i++)
			  for (var j:int = 0; j < 3; j++)
				  
				   {
					  
					  trace("output["+i+"]["+j+"]="+ uni[i][j]);
					   
				   }
				   
				elem=uni[0][1];
				trace("elem[0][1][2]:"+elem);
			   
			   trace(uni.getElementAt(0,1));
			   uni.setElementAt(55,0,1);
			   trace(uni.getElementAt(0,1));
			
			
			trace("3D Matrix");
			uni=new UniMatrix(int,null,2, 3,4);
			
			
			for (var k:int = 0; k < 4; k++)
			for(var i:int=0;i<2;i++)
			  for (var j:int = 0; j < 3; j++)
			  
			   {
				   trace("input:["+i+"]["+j+"]["+k+"]="+elem);
				    uni[i][j][k] = elem;/// i * 2 + j +k * (3 * 4);
					elem++;
			   }
			   
			  for (var k:int = 0; k < 4; k++)  
			 for(var i:int=0;i<2;i++)
			  for (var j:int = 0; j < 3; j++)
				  
				   {
					   //trace(uni[i][j][k]);
					  trace("output["+i+"]["+j+"]["+k+"]="+ uni[i][j][k]);
					   
				   }
				   
				elem=uni[0][1][2];
				trace("elem[0][1][2]:"+elem);
			   
			   trace(uni.getElementAt(0,1,2));
			   uni.setElementAt(55,0,1,2);
			   trace(uni.getElementAt(0,1,2));
			
			   
			   
			   	trace("4D Matrix");
			uni=new UniMatrix(int,null,2, 3,4,5);
			
			 for (var t:int = 0; t < 5; t++)  
			for (var k:int = 0; k < 4; k++)
			for(var i:int=0;i<2;i++)
			  for (var j:int = 0; j < 3; j++)
			  
			   {
				   trace("input:["+i+"]["+j+"]["+k+"]["+t+"]="+elem);
				    uni[i][j][k][t] = elem;
					elem++;
			   }
			   
			     for (var t:int = 0; t < 5; t++)  
			  for (var k:int = 0; k < 4; k++)  
			 for(var i:int=0;i<2;i++)
			  for (var j:int = 0; j < 3; j++)
			   {
					  
					  trace("output["+i+"]["+j+"]["+k+"]["+t+"]="+ uni[i][j][k][t]);
					   
				   }
				   
				elem=uni[0][1][2][3];
				trace("elem[0][1][2][3]:"+elem);
			   
			   trace(uni.getElementAt(0,1,2,3));
			   uni.setElementAt(55,0,1,2,3);
			   trace(uni.getElementAt(0, 1, 2, 3));
			   
			   
			      	trace("5D Matrix");
			uni=new UniMatrix(int,null,2, 3,4,5,6);
			
			
			 for (var m:int = 0; m < 6; m++) 
			 for (var t:int = 0; t < 5; t++)  
			for (var k:int = 0; k < 4; k++)
			for(var i:int=0;i<2;i++)
			  for (var j:int = 0; j < 3; j++)
			  
			   {
				   trace("input:["+i+"]["+j+"]["+k+"]["+t+"]["+m+"]="+elem);
				    uni[i][j][k][t][m] = elem;
					elem++;
			   }
			   
			    for (var m:int = 0; m < 6; m++) 
			     for (var t:int = 0; t < 5; t++)  
			  for (var k:int = 0; k < 4; k++)  
			 for(var i:int=0;i<2;i++)
			  for (var j:int = 0; j < 3; j++)
			   {
					  
					  trace("output["+i+"]["+j+"]["+k+"]["+t+"]["+m+"]="+ uni[i][j][k][t][m]);
					   
				   }
				   
				elem=uni[0][1][2][3][4];
				trace("elem[0][1][2][3][4]:"+elem);
			   
			   trace(uni.getElementAt(0,1,2,3,4));
			   uni.setElementAt(55,0,1,2,3,4);
			   trace(uni.getElementAt(0,1,2,3,4));
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		}
		
	}

}

