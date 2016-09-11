import java.awt.event.*;
class MyWindowAdapter extends WindowAdapter
{
    Sudoko2D f;
    public MyWindowAdapter(Sudoko2D f)
    {
        this.f=f;
    }
    
    public void windowClosing(WindowEvent we)
    {   
     f.setVisible(false);
    }
}
