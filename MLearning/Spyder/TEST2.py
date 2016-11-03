#%%
'''
cell 1 - use of GLOBAL

cell 2 - NAMESPACES, use of dir() and __dict__ and local & global

cell 3 - classmethod defining

cell 4 - local and global(in case of nested function, class or nested class) 
'''
#%% cell1.1
g_c = 1
class TestClass():
    
    def run(self):  
        global g_c
        for i in range(3):
            print g_c 
            # prints the initial value of global var g_c here
            
            # referencing before assignment in a function will cause error, 
            # because interpreter will think you are trying to access the variable 
            # g_c given in the function(run) namespace. To tell the interpreter   
            # that you are trying to access the global var you need to have a 
            # way of specying it, and it is where global comes to your rescue.
            g_c = 100
            # assigning g_c does not creates a var g_c in function namespace now,
            # because here g_c is a global var now and you are just changing 
            # its value from 1 to 100 
            

t = TestClass()
print '-------------- run fun starts'
t.run()
print '-------------- run fun ends'
print 'global var(g_c) changed from 1 to -', g_c 
print  t.__dict__ # g_c is not present
#%% cell1.2
# Let us chage the above code a little bit

g_c = 1
class TestClass():
    print g_c  # from here you can access the global variable
    g_c = 100
    def run(self):
        g_c = 2000  # ----> added this
        # python consider this a nuisance and attaches both global and local g_c 
        # into one
        global g_c
        
        for i in range(3):
            
            print g_c 
            g_c = 100
            
t = TestClass()
print '-------------- run fun starts'
t.run()
print '-------------- run fun ends'
print 'global var(g_c) changed from 1 to -', g_c 
#%% cell1.3
# Let us chage the above code a little bit

g_c = 1
class TestClass():
   
    def run(self):
        # g_c = 2000  # ----> We removed this
        # global g_c ------------->  We removed this
        for i in range(3):
            print g_c
            # The above statement will cause error - 
            # UnboundLocalError: local variable 'g_c' referenced before assignment
            g_c = 100
            

t = TestClass()
print '-------------- run fun starts'
t.run()
print '-------------- run fun ends'


#%% cell1.4     
# Now let us add to the code a little bit
g_c = 1
alpha = 10
class TestClass():
    global g_c # to make sure that now we use global
    g_c = 10; 
    # this would have been a class var if global g_c was not present 
    # but now we are referring to global g_c            
    print g_c
    
    def run(self):  
        global g_c
        for i in range(3):
            print g_c
            g_c = 100
            
            

t = TestClass()
print '-------------- run fun starts'
t.run()
print '-------------- run fun ends'
print 'global var(g_c) changed from 1 to -', g_c
print TestClass.g_c 
#%% cell1.5
'''
The error still remains the same, though you might have thought that, it should
now be gone,  but that is not the case even though the function run() comes under 
the scope of the class TestClass, because the global is not made in this manner,
had it been defined so, then it must have snatched away the function's namespace 
liberty of defining a variable with the same as global var g_c once you had 
defined a variable name global in you class.   
'''
#%% cell2
a = 1
class C1():
    b = 2
    def fun1(self):
        c = 3
        print 'Is c global-','c' in globals()
        print 'Is c local-','c' in locals()
        print 'Is b global-','b' in globals()
        print 'Is b local-','b' in locals()
        print 'Is a global-','a' in globals()
        print 'Is a local-','a' in locals()
        global a 
        # at times this is how we access global variable though they can
        # be accessed from anywhere
        
        print C1.b 
        # accessing a class variable
        
        print a
        a = 10
        
print C1.__dict__        
obj = C1()
print obj.__dict__
obj.fun1()
print ('1 changed to ',a) #a has change to 10
print dir() 
'''
a local variable - is within a function
a global variable - is one defined outside any scope, dir()
'''
#%% cell3
class C1():
    a =10
    @classmethod
    def fun(cls):
        cls.a = 100
        return cls.a
print C1.fun();        

#%% cell4
global_var = 2
class C1():
    class_var = 3
    def outer(self):
        self.x = 10;
        def inner():  # the inner function is not an instance function
            return (self.x * 10 * global_var * C1.class_var)
        return (inner() * 10)    

obj = C1();
obj.outer()            
'''
Inner function can access global, instance and class variable just like 
any normal function, but it does not require a self argument. 
'''
