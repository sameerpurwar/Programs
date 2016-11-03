#%%
from copy import copy
class InsertionSort():
    
    def __init__(self,A):
        self.A = A # initializing a object variable
        
    def Sort(self):
        input = copy(self.A) #shallow copy of the obj variable A
        length = len(input)
        
        for i in range(1,length):
            temp = input[i]
            
            for j in range(i-1,-1,-1):               
                if(temp >= input[j]):
                    break
                else:
                    input[j+1] = input[j]
                    input[j] = temp;

        return input

if __name__ == '__main__': 
    A = [1,0,2,7,4,9,6,7];
    obj = InsertionSort(A)
    B = obj.Sort()
    print 'running fine'        
#%%   
'''
This is a very crude version of Queue and can work with 
only one object, defining another Queue object will not 
work because counter is a global variable and no longer 
remains zero, so the in new Queue obj current point does 
not point to the object itself. 
'''

counter = 0    
class Queue_useless():
    
    def __init__(self,data): # data should not be NULL
        global counter
        self.data = data
        self.pointer = None
        if counter == 0:
            Queue.current = self # current is a class var(explicit)
        counter += 1;
            
    @classmethod # this is how we define a class method
    def Add(cls,data):                 
    # you can use both class name and cls here, also cls is 
    # not a keyword.                 
        cls.current.pointer = cls(data)
        cls.current = cls.current.pointer
        cls.current.pointer = None
            
    def iterate(self):
        temp = self;
        while (temp != None):
            print temp.data
            temp = temp.pointer
                 
#%% ------------------------------------------------------------------------         
class Queue():
    
    def __init__(self,data):
        self.head = Queue.Data(data)
        self.flag = 0
        
        
    def add(self,data):
        self.flag = 1                 
        temp = self.iterate()
        self.flag = 0
        temp.pointer = Queue.Data(data)
        
        
        
    def iterate(self):
        temp = self.head
        while (temp != None):
            if self.flag == 0:
                print temp.data;
            if temp.pointer == None:
                break
            temp = temp.pointer
        return temp    

    
    class Data():
        def __init__(self,data):
            self.pointer = None;
            self.data = data;    
        
        
 
#%%

class Stack():

    def __init__(self):
        self.head = None
        
        
    def add(self,data):
        if self.head == None:
            self.head = Stack.Data(data)
        else:   
            temp = self.head
            self.head = Stack.Data(data)
            self.head.pointer = temp
     
    def push(self):
        temp = self.head
        self.head = self.head.pointer
        temp.pointer = None
        
    def iterate(self):
        temp = self.head
        while (temp != None):
                print temp.data;
                if temp.pointer == None:
                    break
                temp = temp.pointer
                
    def add_list(self,List):                
        l = len(List)
        for i in range(l):
            self.add(List[i])
            
    class Data():
        def __init__(self,data):
            self.pointer = None;
#%%
class BinaryTree():
    def __init__(self):
        self.root = None
         
        
    def add(self,data,temp = None):
        if temp == None:
            temp = self.root
            
        if self.root == None:
            self.root = BinaryTree.Data(data);
        else:
            if data >= temp.data:
                if(temp.right == None):
                    temp.right = BinaryTree.Data(data)
                else:
                    self.add(data,temp = temp.right)
            else:
                if temp.left == None:
                    temp.left = BinaryTree.Data(data)
                else:
                    self.add(data,temp = temp.left)
    
    def add_list(self,List):
        l = len(List)
        for i in range(l):
            self.add(List[i])
                    
    # 0 - for LRP
    # 1 - for PLR 
    # 2 - for RLP
       
    def LRP_Search(self,temp = None,num = 0):  
        if temp == None:
            temp = self.root
        
        if self.root == None:
            print 'The tree does not have a head'
        
        else:
            
            if(num == 0):
                if temp.left != None:
                    self.LRP_Search(temp = temp.left,num = 0)
                if temp.right != None:
                    self.LRP_Search(temp = temp.right,num = 0) 
                print temp.data 
                return
            
            elif(num == 1):
                print temp.data
                if temp.left != None:
                    self.LRP_Search(temp = temp.left,num = 1)
                if temp.right != None:
                    self.LRP_Search(temp = temp.right,num = 1) 
                return
                
            elif(num == 2):
                
                if temp.right != None:
                    self.LRP_Search(temp = temp.right,num = 2) 
                if temp.left != None:
                    self.LRP_Search(temp = temp.left,num = 2)
                print temp.data
                return
        
        
        
    class Data():
        def __init__(self,data):
            self.data = data
            self.left = None
            self.right = None
            
if __name__ == '__main__':
    t = BinaryTree()        
    t.add_list([45,67,23,77,24])    
            
#%% 

#%%
'''          
Several Trees and their algorithm
Divide and Rule (Merge Sort) using Binary trees
Convex Hull 
Start with numpy
Explore more of the python 
'''
#%%

