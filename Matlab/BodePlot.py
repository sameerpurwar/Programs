from copy import copy
import matplotlib.pyplot as plt
from math import log
from math import atan
from math import pi
from math import degrees

class BodePlot():
    
    def __init__(self,num,den):
        self.num = num
        self.den = den
        
    def phase(self,data):
        y = data.y
        x = data.x
        z = abs(y/x)
        if  (y > 0 and x > 0):
            return degrees(atan(z))
        elif(y > 0 and x < 0):    
            return degrees(pi - atan(z))
        elif(y < 0 and x < 0):    
            return degrees(atan(z) - pi)        
        elif(y < 0 and x > 0):    
            return degrees(-atan(z))
        else:
            return pi
        

    def Combine_All(self,w):
        num_fun = BodePlot.fun(self.num,w)
        den_fun = BodePlot.fun(self.den,w)
        
        num_break = BodePlot.Break(num_fun)
        den_break = BodePlot.Break(den_fun)
        
        num_complex = Complex(num_break[0],num_break[1])
        den_reciprocal = Complex(den_break[0],den_break[1]).reciprocal()
        
        final = Complex.multiply(num_complex,den_reciprocal)
        return final
        
    def calculate(self):
        y1 = []
        y2 = []
        a = range(-1200,3500)
        x = [1.2**(i/50) for i in a]
        for w in x:
            final = self.Combine_All(w);
            y1.append(20*log(final.magnitude()))
            y2.append(self.phase(final))
        return (x,y1,y2)
        
    @classmethod
    def plotting(cls,data,shape = 'ro',grid = True):
        
        plt.subplot(211)
        plt.semilogx(data[0],data[1])
        plt.grid(True)
        plt.title('magnitude plot')
        
        plt.subplot(212)
        plt.semilogx(data[0],data[2])
        plt.grid(True)
        plt.title('phase plot')
        
        
    @classmethod
    def fun(cls,data,w):
        l = len(data) - 1
        i = 0;
        List = [];
        for x in data:
            List.append(x*w**(l-i))
            i += 1
        return List   
            
        
    @classmethod    
    def Break(cls,List):
        real = 0
        imag = 0
        l = len(List)
        for x in range(l):
            y = l - x
            if (y%2) == 1:
                if(((y+3) % 4) == 0):
                    real += (List[x])
                else:
                    real += (-List[x])
            else:
                if(((y+2) % 4) == 0):
                    imag += (List[x])
                else:
                    imag += (-List[x]) 
        return (real,imag)            
        

        
class Complex():
    def __init__(self,real,imag):
        self.x = real
        self.y = imag
        
    def magnitude(self):
        return ((self.x**2) + (self.y**2))**(0.5)
        
    def reciprocal(self):
        C4 = copy(self)
        mag = C4.magnitude()
        C4.y = -C4.y/(mag)**2
        C4.x = C4.x/(mag)**2
        return C4
    
    @classmethod    
    def multiply(cls,C1,C2):
        C3 = Complex(0,0)
        C3.x = ((C1.x*C2.x) - (C1.y*C2.y))
        C3.y = ((C1.x*C2.y) + (C1.y*C2.x))
        return C3     
        
if __name__ == '__main__':
    print 'you are entering the numerator and denominator of transfer function\n'
    print '             Example - How to enter           '
    print 'Remember [ ] are important while entering the coeffecient\n'
    
    print '[25] are the coeffecient of numerator '
    print '[1,4,25] is the coeffecient of denominator '
    
    print 'for the above input data the output is'
    
    print '           s + 2'
    print '-----------------------------------------'
    print '9 s^5 + 2 s^4 + 65 s^3 + 9 s^2 + 56 s + 7'
    
    num =  input('enter the numerator co-effecient :- ')
    den =  input('enter the denominator co-effecient :- ')
    
    obj = BodePlot(num,den)
    data = obj.calculate()
    BodePlot.plotting(data)        
        