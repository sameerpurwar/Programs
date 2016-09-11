import java.awt.event.*;
import java.awt.*;
class Sudoko2D extends Frame implements ActionListener
{
    Panel panel1;
    Panel panel2;
    Button button;
    TextField[] text; 
    Label l;
    
    public static void main(String args[])
    {
        Sudoko2D obj = new Sudoko2D();
        obj.method();
    }
    
    public void method()
    {
        text = new TextField[81];
        l = new Label();
        this.setTitle("SUDOKO by sameer");
        this.setSize(360,445);
        this.setResizable(false);
        this.addWindowListener(new MyWindowAdapter(this));
        this.setLayout(new BorderLayout());
        panel1 = new Panel(new GridLayout(9,9));
        this.add(panel1);
		panel1.setSize(360,365);
		for(int x =0;x<81;x++)
		{
		    text[x] = new TextField("0");
		    text[x].setSize(40,80);
 			panel1.add(text[x]);
		}
		
		
		button = new Button("solve");
		button.setSize(40,40);
		this.add(button,BorderLayout.SOUTH);
		
		button.addActionListener(this);
		setVisible(true);
    }
    
    
    
    String array[][];
    
    @Override
    public void actionPerformed(ActionEvent ae)
    {
         array = new String[9][9];
         for(int a=0;a<9;a++)
         {
             for(int b =0;b<9;b++)
             {
                String d = text[(a)*9 +(b)].getText(); 
                if(d == null)
   					array[a][b] = "0";
   				else	
    	 		array[a][b] = d;
    		 }
    	 }
    	 int array[][] = Algo4.main(this);
    	 for(int a =0;a<81;a++)
    	 {
    	     for(int b =0;b<9;b++)
    	     {
    	         text[(a)*9 +(b)].setText(Integer.toString(array[a][b])) ;
    	     }
    	 }
    }
}
 