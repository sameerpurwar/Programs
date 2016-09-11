import java.util.Scanner;

class Sudoko2
{
    int[][][] sudoko  = new int[9][9][11] ;  
  
   
    Sudoko2()
    {
    }
    
    Sudoko2(Sudoko2 copy)
    {
  
        for(int a=0;a<9;a++)
       	{
           	for(int b=0;b<9;b++)
 			{
 			    for(int c = 0;c<11;c++)
 		 	  		this.sudoko[a][b][c] = copy.sudoko[a][b][c]; 
 		    }
 		}
    }
       
  
    public void checkHorizontal(int row)
    {	
        for(int a=0;a<9;a++)
        {
 			int num = sudoko[row][a][0];   
            if(num != 0)
            {
                for(int b =0;b<9;b++)
                {
                    //if(b != a)
            			sudoko[row][b][num] = 0;
            	}
            }
        }
    }
    
    public void checkVertical(int column)
    {	
        for(int a=0;a<9;a++)
        {
            int num = sudoko[a][column][0]; 
            if(num != 0)
            {
                for(int b =0;b<9;b++)
                {
                    //if(a !=b)
            			sudoko[b][column][num] = 0;
            	}
            }
        }
    }
    
    public void checkBlock(int block)
    {
        int x = (block/3)*3;
        int y = (block%3)*3;
    
        for(int a=0;a<3;a++)
        {
            for(int b=0;b<3;b++)
 			{	   
                int num = sudoko[x+a][y+b][0] ;
                if(num != 0)
                {
                   	for(int c=0;c<3;c++)
        			{	
            			for(int d=0;d<3;d++)
            			{    
            			    //if(a!=c && b!=d)
            					sudoko[x+c][y+d][num] = 0;
               			}
            		}			
    			}
    		}
    	}
    }
    
    public int whichBlock(int x,int y)
    {
        int block;
        if(x<3)
        {
        	if(y<3)
        		block =0;
        	else if(y<6)
				block =1;
        	else
        		block =2;
        }
        
        else if(x<6)
        {
            if(y<3)
        		block =3;
        	else if(y<6)
				block =4;
        	else
        		block =5;    
        }
        
        else
        {
            if(y<3)
        		block =6;
        	else if(y<6)
				block =7;
        	else
        		block =8;
        }
        return block;
    }
    
    int flag;
    public void fill()
    {
        int capture =0;
        int count;
        flag =0;
        for(int a=0;a<9;a++)
        {
            for(int b=0;b<9;b++)
 			{
 			    count =0;
 			    if(sudoko[a][b][0] == 0)
 			    {
 			    	for(int c=1;c<=9;c++)
 			    	{
 			        	int s = sudoko[a][b][c]; 
 			        	if(s != 0)
 			        	{
 			           		 capture = s;
 			        		 count ++;
 			        	}
 			    	}
 			    
 			    	
 			    	if(count == 1)
 			    	{
 			    		sudoko[a][b][0] = capture;
 			    		count =0;
 			    		sudoko[a][b][capture] = 0;
 			    		flag ++;
 			    		
 			    		for(int d =0;d<9;d++)
 						{
 				    		sudoko[a][d][capture] = 0;
 						}
 			    		
 			    		for(int d =0;d<9;d++)
 						{
 				    		sudoko[d][b][capture] = 0;
 						}
 				
 						int block = whichBlock(a,b);
 						int x = (block/3)*3;
     		   			int y = (block%3)*3;
    	
        				for(int e=0;e<3;e++)
        				{
            				for(int f=0;f<3;f++)
 							{	   
               				 sudoko[x+e][y+f][capture] =0 ;
 							}		
						}
 			    	}
 			    	sudoko[a][b][10] = count;
 			    }   
 			}
		}
    }
    
    public void printSudoko()
    {
       	for(int a=0;a<9;a++)
       	{
           	for(int b=0;b<9;b++)
 			{
 		 	  System.out.print(sudoko[a][b][0]+" "); 
 		 	  if(b == 2 || b == 5)
 		 	  	System.out.print(" ");
 		 	  	
 		    }
 		    System.out.println("");
 		    if(a == 2 || a == 5)
 		    	System.out.println("");
		}
	}
	
	public void printWholeSudoko()
    {
        for(int c=0;c<11;c++)
        {
       		for(int a=0;a<9;a++)
       		{
           		for(int b=0;b<9;b++)
 				{ 
 		 	  		System.out.print(sudoko[a][b][c]+" "); 
 		 	  		if(b == 2 || b == 5)
 		 	  			System.out.print(" ");
 		 	 	}
 		    	System.out.println("");
 		   		if(a == 2 || a == 5)
 		    		System.out.println("");
			}
			System.out.println(c);
			System.out.println("\n");
		}
	}
	
	public boolean canWeProceed()
	{
	        boolean flag = true;
	        for(int a=0;a<9;a++)
       		{
           		for(int b=0;b<9;b++)
 				{
 				    if(sudoko[a][b][0] == 0)
 				    {
 				    	
 				    		if(sudoko[a][b][10] == 0 )
 				    		{
 				    	       flag = false;
 				    	       break;
 				    		}
 				    	
 					}
 					if(flag == false)
 						break;
  				}
  				if(flag == false)
  					break;
 			}
 		    return flag;
	}
	
	public void fillBehind()
	{
       		for(int a=0;a<9;a++)
       		{
           		for(int b=0;b<9;b++)
 				{
 				    int d = sudoko[a][b][0];
 				    if(d == 0)
 				    {
 				    	for(int c=1;c<10;c++)
       					{
 				    		sudoko[a][b][c] = c;  
 						}
 					}
 				}
			}
	}
	
	public int countTerms()
	{
	   int count =0;
	   for(int a=0;a<9;a++)
       {
          	for(int b=0;b<9;b++)
 			{
 			    if(sudoko[a][b][0] != 0)
 			    {
 			        count ++;
 			    }
 			}
 	   }
 	   return count;
	}
	
	public void isAloneRow(int square)
	{
	    flag =0;
	    for(int a=0;a<9;a++)
	    {
	        int count =0;
	        int save =0;
	       	for(int b=0;b<9;b++)
 			{
 				if(sudoko[a][b][square] != 0)
 				{
 				    count ++;
 				    save = b;
 				}
 			}
 			
 			if(count == 1)
 			{   
 			    flag ++;
 				sudoko[a][save][0] = square;
 				sudoko[a][save][square] = 0;
 				sudoko[a][save][10] =0;
 				for(int d =0;d<9;d++)
 				{
 				    sudoko[d][save][square] = 0;
 				}
 				
 				int block = whichBlock(a,save);
 				int x = (block/3)*3;
     		   	int y = (block%3)*3;
    	
        		for(int e=0;e<3;e++)
        		{
            		for(int f=0;f<3;f++)
 					{	   
               			 sudoko[x+e][y+f][square] =0 ;
 					}		
				}	
				
				for(int g =1;g<=9;g++)
					sudoko[a][save][g]=0;
			}
		}
	}
	
	public void isAloneColumn(int square)
	{
	    //flag =0;
	    for(int b =0;b<9;b++)
	    {
	        int count =0;
	        int save =0;
          	for(int a=0;a<9;a++)
 			{
 				if(sudoko[a][b][square] != 0)
 				{
 					count ++;
 					save = a;
 				}
 			}
 			if(count == 1)
 			{	
 			    flag ++;
 				sudoko[save][b][0] = square;
 				sudoko[save][b][square] = 0;
 				sudoko[save][b][10] =0;
 				for(int d =0;d<9;d++)
 				{
 				    sudoko[save][d][square] = 0;
 				}
 				
 				int block = whichBlock(save,b);
 				int x = (block/3)*3;
     		   	int y = (block%3)*3;
    	
        		for(int e=0;e<3;e++)
        		{
            		for(int f=0;f<3;f++)
 					{	   
               			 sudoko[x+e][y+f][square] =0 ;
 					}		
				}
				
				for(int g =1;g<=9;g++)
					sudoko[save][b][g]=0;
 			}
		}
	}
	
	public void isAloneBlock(int square)
	{
	    //flag =0;
	    int count =0;
	    int savea =0;
	    int saveb =0;
	    for(int block =0;block<9;block++)
	    {
	        int x = (block/3)*3;
            int y = (block%3)*3;
          	for(int a=0;a<3;a++)
        	{
            	for(int b=0;b<3;b++)
 				{	   
                	int num = sudoko[x+a][y+b][square] ;
                	if(num != 0)
 					{
 					    count ++;
 				        savea = x+a;
 				    	saveb = y+b;
 					}	
 				}
 			}
 				
 			if(count == 1)
 			{
 			    flag ++;
 			    sudoko[savea][saveb][10] =0;
 				sudoko[savea][saveb][0] = square;
 				sudoko[savea][saveb][square] =0;
 				for(int d =0;d<9;d++)
 					sudoko[savea][d][square] =0;
 				for(int e =0;e<9;e++)
 					sudoko[e][saveb][square] = 0;
 				for(int g =1;g<=9;g++)
					sudoko[savea][saveb][g]=0;	
 			}
		}
	}
	
	public int[] point()
	{
	    int[] point = new int[2];
		int f =0;
 		for(int c =1;c<=9;c++)
 		{
 		    for(int a=0;a<9;a++)
       		{
        		for(int b=0;b<9;b++)
 				{
       				if(sudoko[a][b][10]== c )
       				{
       				    point[0] =a;
       				    point[1] =b;
       				    f ++;
       				    break;
       				}					
       			}
       			if(f !=0)
       				break;
       		}
       		if(f !=0)
       			break;
       	}
       	
       	return point;
	}
}	
    

	
