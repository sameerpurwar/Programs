import numpy as np
import theano
from theano import tensor
from logistic import to_shared,upload_data 
import cPickle as pickle
class DenoisingEncoder(object):
    
    def __init__(
                 self,
                 rng,
                 input,
                 n_hidden = 50,
                 n_input = 784,
                 W_vis = None,
                 b_hid = None,
                 b_vis = None):
                     
        range = 4 * np.sqrt(6.0/n_input + n_hidden)      
        self.W_value = np.array(rng.uniform(low = -range,
                                       high = range,
                                       size = (n_input,n_hidden)
                                       ),
                           dtype = theano.config.floatX)
        if W_vis == None:                   
            self.W_vis = theano.shared(value = self.W_value,
                                  name = 'W_hid',
                                  borrow = True)
        
        if b_vis == None:
            self.b_vis = theano.shared(value = np.zeros(shape = (n_hidden,),
                                                   dtype = theano.config.floatX),
                                  name = 'b_vis',
                                  borrow = True)
                              
        if b_hid == None: 
            self.b_hid = theano.shared(value = np.zeros(shape = (n_input,),
                                                   dtype = theano.config.floatX),
                                  name = 'b_hid',
                                  borrow = True)
          
        self.W_hid = self.W_vis.T
                
        
        self.input = input
        self.params = [self.W_vis,self.b_vis,self.b_hid]
                
        
    def reconstruction(self,I):
        self.hidden_output = tensor.nnet.sigmoid(tensor.dot(I,self.W_vis) + self.b_vis)
        return tensor.nnet.sigmoid(tensor.dot(self.hidden_output,self.W_hid) + self.b_hid)
    
    def Cost(self):    
        L = -tensor.sum(self.input * tensor.log(self.reconstruction(self.input))  + (1 - self.input) * tensor.log(1 - self.reconstruction(self.input)),axis = 1)
        return tensor.mean(L)        
    
            
        
def solve_dA(datapath,batch = 500,learning_rate = 0.14,n_epoch = 10):
    
    ##for MNIST DATA LOADING PROCESS
    print "loading data...."
    mnist_data = upload_data(datapath)
    train, valid, test = mnist_data
    
    ##creating theano buffer for python data
    
    print 'moving to data to shared conversion'
    train_x, train_y = to_shared(train)
    
    
    n_train_batch =  train[0].shape[0] // batch 
    
   
    
    x = tensor.dmatrix('x')
    index = tensor.iscalar('index')    
    
    rng = np.random.RandomState(112)
    
    dA = DenoisingEncoder(input = x,
                          rng = rng,
                          )
                          
    grad_all = tensor.grad(cost = dA.Cost(), wrt = dA.params)
                          
    updates = [(param_i, param_i - learning_rate * grad_i)
                for param_i, grad_i in zip(dA.params, grad_all)]

    fun = theano.function(inputs = [index],
                          outputs = dA.Cost(),
                          updates = updates,
                          givens = [(x,train_x[index*batch:(index+1)*batch,:])]
                         )

    ################
    #Training Start#  
    ################

    epoch = 0
    print 'main training starts'
    while epoch < n_epoch:
        for n in range(n_train_batch):        
           print fun(n)
        epoch = epoch + 1
        print epoch
    with open('/home/sameer/reconstructed', 'wb') as f:
        pickle.dump(dA, f)
        f.close()           
solve_dA('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz') 
                                              