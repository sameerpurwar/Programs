from copy import copy
import matplotlib.pyplot as plt                
import time      


class RootFinding():
    
    def __init__(self,num,den):
        self.num = num
        self.den = den
        self.count = 0
        
    
    def characteristic(self,K):
        l1 = len(self.den)
        l2 = len(self.num)
        
        a = copy(self.den)
        b = copy(self.num)
        
        
        for x in range(l2):
            b[x] = b[x] + K

        for i in range(l1-l2):
            b.insert(0,0)
        z = []

        for x,y in zip(a,b):
            z.append(x+y)    
        self.den = z
        
        
    def baristow_method(self,r = 0.5,s = - 0.5,e = 1):
        quadractic = Stack()
        values = [r,s]
        quadractic.add([self.den,values])
        L = len(self.den) - 1
        if L % 2 == 0:
            l = (L - 2)/2
        else:
            l = (L - 1)/2

        for i in range(l):
            b = self.update(r,s,e,quadractic.head.data[0])
            quadractic.add(b)
        return quadractic    
        
        
    def extract(self,List):
        L = len(self.den) - 1
        data = []
        if L % 2 == 0:
            l = (L - 2)/2
        else:
            l = (L - 1)/2
        for x in range(l):
            if(x == 0):
                temp = List.pull() 
                data.append(temp.data[0])
                data.append(temp.data[1])
            if (x != l-1):
                temp = List.pull() 
                data.append(temp.data[1])
        return data    
            
        
    def solve(self,r,s,fn1):
        if fn1 == None:
            fn1 = self.den    
        queue = Queue()
        stack = Stack()
        queue.add_list(fn1)
        
        stack.add(queue.front.data)
        queue.exit()
        
        stack.add(queue.front.data + r * stack.head.data)
        queue.exit()
        
        L = len(fn1) - 2
        for i in range(L):
            stack.add(queue.front.data + r * stack.head.data + s * stack.another.data)                    
            queue.exit()
        return stack.toList()
        
        
        
    def update(self,r,s,e,fn1 = None):
        self.count += 1
        if fn1 == None:
            fn1 = self.den
        L = len(fn1) - 1    
        b = self.solve(r,s,fn1)
        c = self.solve(r,s,b)
        dr = ((b[L]*c[L-3]) - (b[L-1]*c[L-2]))/(c[L-2]**2 - (c[L-1]*c[L-3]));
        ds = ((b[L-1]*c[L-1]) - (b[L]*c[L-2]))/(c[L-2]**2 - (c[L-1]*c[L-3]));
        r += dr
        s += ds
        er = abs((float(dr))/(r+0.000001))
        es = abs((float(ds))/(s+0.000001))
        if(er <= e and es <= e):
            values = [-r,-s]
            #print b
            return [b[:len(b)-2],values]
        #print r,s
        #print '\n'             
        b,values = self.update(r,s,e,fn1)
        return [b,values]     


    def solvingQuad(self,coeff):
        
        a,b,c = coeff
        a,b,c = float(a),float(b),float(c)
        root = Complex()
        if a != 0:
            d = b**2 - 4*a*c
            
            if(d<0):
                d = (-d)**(0.5)
                root.x1 = -b/(2*a)
                root.y1 =  d/(2*a)
                root.x2 = -b/(2*a)
                root.y2 = -d/(2*a)
                return root
                
            elif(d >= 0):
                d = d**(0.5)
                root.x1 = -b/(2*a) + d/(2*a)
                root.x2 = -b/(2*a) - d/(2*a)
                return root
                
        else:
            root.x1 = -c/b
            return root
            


            
    def output(self,Extracted_List):
        #extracted List = coeff
        Roots = []
        i = 0
        for x in Extracted_List:
            if i != 0:
                y = copy(x)
                y.insert(0,1)
                Roots.append(self.solvingQuad(y))
            else:
                if len(x) == 2:
                    y = copy(x)
                    y.insert(0,0)
                    Roots.append(self.solvingQuad(y))
                elif len(x) == 3:
                    Roots.append(self.solvingQuad(x))
            i = i + 1        
        return Roots

    def Final(self,K = 0,r = 1,s = 1.2,e = 0.001):
         self.characteristic(K)    
         f = self.baristow_method(r,s,e)
         extracted = self.extract(f)
         roots = self.output(extracted)
         Roots =  Complex.toList(roots)
        
         return Roots
     
   
            
        
        
class Queue():
    
    def __init__(self):
        self.front = None
        self.last = None
        
    def enter(self,data):
        if self.front == None:
            self.front = Queue.Data(data)
            self.last = self.front                  
        else:
            temp = self.last
            self.last = Queue.Data(data)
            temp.pointer = self.last 
    
    def add_list(self,List):                
        l = len(List)
        for i in range(l):
            self.enter(List[i])
            
    def exit(self):
        temp = self.front 
        self.front = self.front.pointer
        temp.data 
        
        
    def iterate(self):
        temp = self.front
        while (temp != None):
            print temp.data
            if temp.pointer == None:
                break
            temp = temp.pointer

    
    class Data():
        def __init__(self,data):
            self.pointer = None;
            self.data = data;    
        
            
            
class Stack():

    def __init__(self):
        self.head = None
        self.another = None
        
    def add(self,data):
        if self.head == None:
            self.head = Stack.Data(data)
        else:   
            temp = self.head
            self.head = Stack.Data(data)
            self.head.pointer = temp
            self.another = temp
    
    def add_list(self,List):                
        l = len(List)
        for i in range(l):
            self.add(List[i])        
     
    def pull(self):
        temp = self.head
        self.head = self.head.pointer
        return temp
        
    def toList(self):
        temp = self.head
        List = []
        while (temp != None):
                List.insert(0,temp.data);
                if temp.pointer == None:
                    break
                temp = temp.pointer
        return List
     
    def iterate(self):
        temp = self.head
        while (temp != None):
            print temp.data
            if temp.pointer == None:
                break
            temp = temp.pointer
    
    class Data():
        def __init__(self,data):
            self.pointer = None;
            self.data = data;
            
            
            
class Complex():
    
    def __init__(self):
        self.x1 = 0             
        self.y1 = 0
        self.x2 = 0             
        self.y2 = 0
    
    def display(self):
        if self.y2 == 0 and self.x2 == 0:
            print self.x1   
        else:    
            if self.y1 == 0 and self.y2 == 0:
                print self.x1
                print self.x2
            else:
                print '%f + %fi' % (self.x1,abs(self.y1))
                print '%f - %fi' % (self.x2,abs(self.y2))
    
    @classmethod
    def toList(cls,roots):
        Listx = []
        Listy = []
        for R in roots:
           Listx.append(R.x1)
           Listy.append(R.y1) 
           if not (R.y2 == 0 and R.x2 == 0):
                Listx.append(R.x2)
                Listy.append(R.y2)
        return [Listx,Listy]        



        
        
        
if __name__ == '__main__':
    print 'you are entering the numerator and denominator of G(s)H(s)\n'
    print '             Example - How to enter           '
    print 'Remember [ ] are important while entering the coeffecient\n'
    
    print '[1,2] are the coeffecient of numerator '
    print '[9,2,65,9,56,7] is the coeffecient of denominator '
    print 'The value of r,s,e is usually [0.5,-0.5,0.000001]'
        
    print 'for the above input data the output is'
    
    print '           s + 2'
    print '-----------------------------------------'
    print '9 s^5 + 2 s^4 + 65 s^3 + 9 s^2 + 56 s + 7'
    
    num =  input('enter the numerator co-effecient :- ')
    den =  input('enter the denominator co-effecient :- ')
    
    
    print 'The value of r = 0.5,s = -0.5,e = 0.000001,'  
    print 'but in case the function does not converge enter a diffent value of r or s or increase e'
    
    data = input('Enter the initial value of r,s,e :-')
    
    print 'calculating .......'
    Plot_list = []
    start_time = int(round(time.time() * 1000))
    Range = 600
    def fun(i):
        return 1.3**(i/50)
        
    try:    
        RF = RootFinding(num,den)
        for i in range(Range):
            Roots = RF.Final(K = 1,r = data[0],s = data[1],e = data[2])
            Plot_list.append(Roots)
        
    
    except Exception, e:
        print 'Aborted due to stack overflow'
        
    stop_time = int(round(time.time() * 1000))    
    print("--- %s ms for claculating data ---" % float(stop_time - start_time))                       
        
    print 'plotting data now'
    start_time = int(round(time.time() * 1000))    
    
    plt.plot(Plot_list[0][0],Plot_list[0][1],'yo')    
    for x in Plot_list[1:]:
        plt.plot(x[0],x[1],'g.')
        plt.grid(True)
        
        
    plt.show()
    stop_time = int(round(time.time() * 1000))    
    print("--- %s ms for plotting data ---" % float(stop_time - start_time))                       
