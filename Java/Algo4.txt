import java.util.Scanner;
class Algo4
{
    static Stack<Sudoko2> stack;
    static Sudoko2 obj;
    int x =1;
    
    public static int[][] main(Sudoko2D s)
    {
        
        stack = new Stack<Sudoko2>();
    	stack.push(new Sudoko2());
    	obj = stack.tail.data;
    	
    		for(int x =0;x<9;x++)
    		{
    		    for(int y =0;y<9;y++)
    		    {
    		        obj.sudoko[x][y][0] = Integer.parseInt(s.array[x][y]);  
    		    }
    		}
    	
    	
    	long t1 = System.currentTimeMillis();
    	obj.fillBehind();  
    	
        while(obj.countTerms() != 81)
        {
        	checks();
        	if(obj.canWeProceed())
        		operatePush();
        	else
        		operatePop();
        }
        int array[][] = new int[9][9];
        
   		for(int x=0;x<9;x++)
   		{
   		    for(int y=0;y<9;y++)
   		    {
   		        array[x][y] = obj.suboko[x][y][0];
   		    }
   		}
   		return array;
   	}
	

	public static void checks()
	{
	   check();
	   {
	   		while(obj.flag !=0)
	   		{
	   		   while(obj.flag != 0)
	   			    check();	    
   		       backgroundCheck();
   		       
   		   	   check();
   	        } 
   	        obj.printWholeSudoko();
	   }
	   
	}
	
	private static void check()
	{
	    
	    	for(int c = 0;c < 9;c++)
	    	{
	    	    obj.checkHorizontal(c);
			}
		
			for(int c = 0;c < 9;c++)
	   	 	{
	     	   obj.checkVertical(c);
			}
		
			for(int c = 0;c < 9;c++)
	   		{
	    	    obj.checkBlock(c);
			}
		
			obj.fill();
			
	   		
	}

    static void backgroundCheck()
	{
	     for(int square =1;square <=9;square++)
	     {
	   		  obj.isAloneRow(square);
	   		  obj.isAloneColumn(square);
	   		  obj.isAloneBlock(square);
	   		  //obj.fill();
	     } 
	}
	    
	static void operatePush()
	{
	    int point[] = obj.point();
	    int a = point[0];
	    int b = point[1];
	    int save = 0;
	    Sudoko2 saveobj = obj;
	    stack.push(new Sudoko2(obj));
	    obj = stack.tail.data;
	    for(int x=1;x<=9;x++)
	    {
	        if(saveobj.sudoko[a][b][x] != 0)
	        {
	            saveobj.sudoko[a][b][10]--;
	            saveobj.sudoko[a][b][x] = 0;
	            save =x;
	            break;
	        }
	    }
	    
	   for(int x=1;x<=10;x++)
	    {
	    	obj.sudoko[a][b][x] = 0;
	   	}
	   		   		
	   obj.sudoko[a][b][0] = save;
 	    
	   for(int d =0;d<9;d++)
	   {
	   		obj.sudoko[a][d][save] = 0; 			    	
 			obj.sudoko[d][b][save] = 0;
 	   }
 			
 	   int block = obj.whichBlock(a,b);
 	   int x = (block/3)*3;
       int y = (block%3)*3;
      
       for(int e=0;e<3;e++)
       {
       		for(int f=0;f<3;f++)
 			{	   
           		 obj.sudoko[x+e][y+f][save] =0;
 			}		
	   }
	   	 	
	}
	
	static void operatePop()
	{
	    stack.pop();
	    obj = stack.tail.data;
	}	
}

