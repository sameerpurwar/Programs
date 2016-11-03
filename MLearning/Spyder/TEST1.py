#%%
"""
cell 1 - SHALLOW AND DEEP COPY in case of list, every variable 
         is a object in python even the integer datatype unlike 
         java where they have a little different primitive data
         type which are there for the ease. Hence doing y = x
         is actually a deep copy, variable referencing (even in
         case of int types).
         
cell 2 - TUPLES

cell 3 - TUPLES are IMMUTABLE hence does not support assignment
         while list does.
         
cell 4 - difference between MUTABLE & IMMUTABLE objects         
 
cell 5 - don't DELETE .PYC file and run the given module 
         after updating
         
cell 6 - how to impose shallow copy

cell 7 - LOCAL, GLOBAL, INSTTANCE, STATIC & CLASS var& NAMESPACES. 

cell 8 - WHY SELF ?          
"""
#%% cell1
list1 = [1,2,3]
list2 = list1;
print id(list1),id(list2)

list2 = [2,2,3];
print id(list1),id(list2)

print list1,list2

#%% cell2
tuple1 = (1,2,3)
tuple2 = tuple1;
print id(tuple1),id(tuple2)

tuple2 = (2,2,3);
print id(tuple1),id(tuple2)

print tuple1,tuple2

#%% cell3
# Why does tuple does not support assignment?

tu1 = ((1,2,3),(3,4,5));
tu2 = tu1;
print tu2[1]
# tu[1] =[100,1,1]; assignment not supported
l1 = [1,2,3];
l2 = l1;
l2[1] = 100; # assignment supported
print l1,l2
#%% cell4

# in case of tuple
t1 = (1,2,3);
print id(t1)
t1 = t1 + ((2,2,2),(3,3,3)); 
# you created a new object with new address
print id(t1)

# in case of list
l1 = [2,3,4];
print id(l1)
l1 = l1 + [2,2,2]
# assignment creates new object whether mutable or immutable
print id(l1)

'''
but in case of list we can use assignment or built in function 
to bring about a change in original referenced variable unlike
in immmutable object like list which does not support assignment
nor does it have built in function like append. 
'''

#%% cell5

'''
In case of .pyc files don't delete them and after updating a 
given module run it once so as to make changes in the .pyc 
file for that module.  
'''

#%% cell6

def fun(x):
    x = x + 5
    return x
    
a = 10;
b = fun(a);    
# a = 10 & b = 15, int is immutable
# Since a in of int type an immutable object hence it 
# will always be a shallow copy

def fun(x):
    x[2] = 100; 
    return x

a = [1,2,3];
c = fun(a) 

# list is mutable hence both a and c changes
from copy import copy

def fun(x):
    y = copy(x)
    y[2] = 100; 
    return y

a = [1,2,3];
c = fun(a) 

# to impose shallow copy use copy function from copy 
# module
#%% cell7.1
'''
There are namely four namespaces(not talking about nested function)
in Python -module, class, object & function namespace.

module namespaces - are the one to be shown in case of dir().
class namespace - are to be shown in case of class.__dict__.
instance namespace - are to be shown in case of instance.__dict__.
function namespace - cannot be accessed beacuse it lives and dies 
during the runtime. 

Remember creating instance variables you need to use __init__ 
function and self.var_name inside it, or inside a instance method.

hierarichy goes like this -

instance namespace 

        |
        |
       \_/

  class namespace 

Try not to use object to access class namespace var, just to clear 
the confusion. If you assing a var in object namespace with the 
same name as in class namespace then using odj.var_name will give
object namespace var not the class namespace var.      
'''
#%% cell7.2

class A():
    c = 90; # this is a class variable
    def __init__(self):
        self.b = 30; # this is a instance variable
        
    def fun1(self, x = 1):
        a = 10 + x # these are local variables
        return a
        
    def fun2():
        print c # since it is not a instance method
                # c can be accessed directly.
        
obj = A()
print A.__dict__
print  obj.__dict__ 
d = obj.fun1(10)  # d is a global variable
print d
        
''' 
Now the question remains how to access c (class variable) 
inside a given instance function.
''' 
#%% cell7.2
class A():
    c = 90;
    def __init__(self):
        self.b = 100;
    
    def fun1(self, x = 1):
        print c # this one is a global variable
        a = 10 + self.c # this one is a class variable
        return a
        
obj = A()
c = 101;        
d = obj.fun1(10); # c & d are included in dir namespce
'''
Since c was not in the instance namespace, the interpreter 
searches the class namespace.

FOR MORE INFORMATION SEE GOOGLE CHROME BOOKMARKS
'''

#Accessing class variable using Class name make them behave
#like STATIC variable 
'''
class RLCN:
...     static_var = 5
...     def method1(self):
...         RLCN.static_var += 1
...     def method2(self):
...         self.static_var += 1
>>> rlcn = RLCN()
>>> RLCN.static_var, rlcn.static_var
(5, 5)
>>> rlcn.static_var
5
>>> rlcn.method1()
>>> RLCN.static_var, rlcn.static_var
(6, 6)
>>> rlcn.method2()
>>> RLCN.static_var, rlcn.static_var
(6, 7)
'''
#%% cell8
'''
WHY SELF - Its how python is made, I mean to say it depends 
upon a particular type of thinking and then it grows and takes
a tottaly different form from JAVA OOPS, very subtle 
difference, but it is all beacuse of the way of thinking of the
creators.
'''
