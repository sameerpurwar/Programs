import numpy as np
import theano,timeit
from theano import function
import theano.tensor as T
import gzip
import cPickle as pickle



class LogisticRegression(object):
    
    def __init__(self,input,n_in,n_out):
        
        self.W = theano.shared(value = np.zeros(shape = (n_in,n_out),
                                           dtype = theano.config.floatX),
                          name  = 'W',
                          borrow = True
                         )
        
        self.b = theano.shared(value = np.zeros(shape = (n_out,),
                                           dtype = theano.config.floatX),
                          name = 'b',
                          borrow = True
                         )
        
        self.params = (self.W,self.b)
        
        self.p_y_given_x = T.nnet.softmax((T.dot(input,self.W) + self.b))
        
        self.y_pred = T.argmax(self.p_y_given_x,axis = 1)
        
        self.input = input

    def negative_log_likelihood(self,y):
        
         return -T.mean((self.p_y_given_x)[T.arange(y.shape[0]),y])
        
    def error(self,y):
        
            if y.dtype.startswith('int'):
                return T.sum(T.neq(y,self.y_pred))
                  
            
        

        
def to_shared(data):
    data_x, data_y = data
    shared_x = theano.shared(np.asarray(data_x,
                                        dtype = theano.config.floatX),
                             borrow = True,
                            )
    shared_y = theano.shared(np.asarray(data_y,
                                        dtype = theano.config.floatX),
                             borrow = True,
                            ) 
    return shared_x, T.cast(shared_y,'int32')                        

    
def upload_data(datapath):
        print 'performing data upload.......'
        print 'loading file from %s' %datapath
        file = gzip.open(filename = datapath, mode = 'rb')
        return pickle.load(file)

                       
def solving_logistic_regression(datapath, learning_rate = 0.54,batch = 500,n_epoch = 30):
    ##for MNIST DATA LOADING PROCESS
    print "loading data...."
    mnist_data = upload_data(datapath)
    train, valid, test = mnist_data
    
    ##creating theano buffer for python data
    
    print 'moving to data to shared conversion'
    train_x, train_y = to_shared(train)
    valid_x, valid_y = to_shared(valid)
    test_x, test_y = to_shared(test)
    
    n_train_batch =  train[0].shape[0] // batch 
    n_valid_batch =  valid[0].shape[0] // batch
    n_test_batch  =  test[0].shape[0]  // batch
   
    
    x = T.matrix('x')
    y = T.ivector('y')
    index = T.iscalar('index')
       
    logistic = LogisticRegression(input = x,
                                  n_in = 784,
                                  n_out = 10)
    
    
    fun_valid = function(inputs  = [index],
                         outputs = logistic.error(y),
                         givens  = [(x,valid_x[index*batch:(index+1)*batch,:]),
                                    (y,valid_y[index*batch:(index+1)*batch])]
                        )   
       
    fun_test = function(inputs  = [index],
                        outputs = logistic.y_pred,
                        givens  = [(x,test_x[index*batch:(index+1)*batch,:])],
                       )    
        
    print "calaculating cost function"                
    cost = logistic.negative_log_likelihood(y) 
    
    g_W = T.grad(cost = cost,wrt = logistic.W)                                  
    g_b = T.grad(cost = cost,wrt = logistic.b)
                        
    updates = [(logistic.W, logistic.W - g_W*learning_rate),
               (logistic.b, logistic.b - g_b*learning_rate)]
               
    fun_train = function(inputs =[index],
                         outputs = logistic.params,
                         updates = updates,
                         givens = [(x,train_x[index*batch:(index+1)*batch,:]),
                                   (y,train_y[index*batch:(index+1)*batch])]
                         )
                  
                      

    ################
    #TRAINING MODEL#                      
    ################..........................................                     
    print 'training starts now -->'
    patience = 5000
    patience_increase = 2
    
    improvement = 0.96
    validation_frequency = min(n_train_batch, patience//2)    
  
    least_error = np.Inf
    epoch = 0
    done_looping = False
    
    print 'EPOCH counting .....'
    start_time = timeit.default_timer()
    while epoch < n_epoch and (not done_looping):
        for current_batch in range(n_train_batch):            
            total_batches = (epoch*n_train_batch) + current_batch
            fun_train(current_batch) 
            
            if (total_batches+1) % validation_frequency == 0:                
                this_error = [fun_valid(n) for n in range(n_valid_batch)]
                this_error = np.mean(this_error)
                
                if this_error < least_error*improvement:
                    least_error = this_error
                    patience =  max(patience,total_batches * patience_increase)
                    with open('/home/sameer/best_model.pkl', 'wb') as f:
                        pickle.dump(logistic, f)
                    
        if total_batches > patience:
            done_looping = True
        epoch += 1
        if total_batches != 0:
            print least_error
            print 'the convergence ratio is %f' %(patience/float(total_batches))
    
    end_time = timeit.default_timer()
    net_time = end_time - start_time
    print 'total time %f' %net_time
    print 'time per epoch %f' %(net_time/epoch)
    print 'the error is %f' %least_error
    print 'the total number of  epoch %d' %epoch    
        
if __name__ == '__main__':        
    solving_logistic_regression('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz')     
           

    
                
                    