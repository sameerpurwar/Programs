class Stack<T>
{
    Node<T> tail;
    Node<T> savetail;
    Stack()
    {
        tail = null;
        savetail = null;
    }
    
    void push(T data)
    {
        savetail = tail;
        tail = new Node<T>();
        tail.data = data;
        tail.next = savetail;
    }
    
    
    
    void pop()
    {
        if(savetail != null)
        {
        	tail.next = null;
        	tail = savetail;
        	savetail = tail.next;
        }
        else
        {
        	tail = null;
        	savetail = null;
        }
    }
    
	class Node<T>
	{
  		Node<T> next;
  		T data ;
  		
  		Node()
  		{
  		    next = null;
  		    data= null;
  		}
	}	
}
