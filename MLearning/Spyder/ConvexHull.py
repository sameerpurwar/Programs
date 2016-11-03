from copy import copy
import numpy as np

class ConvexHull():
    
    def __init__(self,points):
        self.points = points
        
        
    def findLowestY(self):
        temp = copy(self.points)
        self.l = len(temp)
        
        for i in range(1,self.l):
            if(temp[0][1] >  temp[i][1]):
                t = temp[0]
                temp[0] = temp[i]
                temp[i] = t
        
        return temp

    def SlopeAll(self):
        temp = self.findLowestY()
        slope = []
        for i in range(1,self.l):
            slope.append(float((temp[i][1] - temp[0][1]))/(temp[i][0] - temp[0][0]))  
        infinity = float('-Inf')
        slope.insert(0,infinity)
        return slope 
    
        
    def SortBySlope(self):
        temp = self.findLowestY()
        slope = self.Slope()
        zipped = zip(temp,slope)
        arranged = copy(zipped)
        l = len(slope)
        
        for i in range(0,l):
            for j in range(i-1,-1,-1):
                if(arranged[j+1][1] < arranged[j][1]):
                    t = arranged[j+1]
                    arranged[j+1] = arranged[j]
                    arranged[j] = t
        another = []
        for i in range(l):
            if(arranged[i][1] > 0):
                another.append(arranged[i:])
                arranged = arranged[0:i]
                break              
            
        another = (another[0])
        another.reverse()
        for i in another:
            arranged.insert(0,i)
        return arranged    
        
    def Start(self,data):
        stack = Stack()
        stack.add(data[0][0])
        stack.add(data[1][0])
        
        def slope(stack,data):
            
            
            
        
        
        
        
        
class Stack():

    def __init__(self):
        self.head = None
        self.previous = None
        
    def add(self,data):
        if self.head == None:
            self.head = Stack.Data(data)
        else:   
            temp = self.head
            self.head = Stack.Data(data)
            self.head.pointer = temp
            self.previous = temp
    
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
            
            
        
        
        
        
        
if __name__ == '__main__':
    a = [[1, 2], [3, 4], [7, -1], [-9, 3], [9, 4],[10,7],[10,1],[0,-4]];
    obj = ConvexHull(a)
    print a
    print obj.findLowestY()
    print obj.Slope()
    A = obj.SortBySlope()
     
