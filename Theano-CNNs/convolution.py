import numpy as np
import theano,timeit
from theano import tensor as T
from theano.tensor.nnet import conv2d
from theano.tensor.signal import downsample
from logistic import LogisticRegression, upload_data,to_shared
from perceptron import HiddenLayer
import cPickle as pickle

                
                
class ConvPoolLayer(object):
    
    def __init__(self,input,rng,filter_shape,pool_size = (2,2)):
        
        self.rng = rng
       
        
   
        w1 = np.prod(filter_shape[1:])
        w2 = filter_shape[0] * np.prod(filter_shape[2:]) // np.prod(pool_size)
        w_bound = np.sqrt(6.0/(w1 + w2))
        
        self.W =  theano.shared(np.asarray(rng.uniform
                                     (low = -w_bound,
                                      high = w_bound,
                                      size = filter_shape),
                                dtype= input.dtype),
                                name = 'W',
                                borrow = True
                               )
                             
        
        b_value = np.asarray(rng.uniform(low = -0.5,
                                         high = 0.5,
                                         size = (filter_shape[0],)),
                                dtype = input.dtype)   
                               
        
        self.b = theano.shared(value = b_value,
                               name = 'b',
                               borrow = True
                              )
                              
        
    
        output_ = conv2d(input, self.W)
        pool_out = downsample.max_pool_2d(output_,pool_size, ignore_border=True)
        
        self.output = T.tanh(pool_out + self.b.dimshuffle('x',0,'x','x'))
        self.input = input
        self.params = (self.W,self.b)
    
save = np.zeros(1000)
def solve_CNN(datapath, batch = 500,n_hidden = 5,n_out = 10,n_epoch = 100,learning_rate = 0.54):
   
    x = T.dmatrix('x')
    y = T.ivector('y')
    index = T.iscalar('index')
    
    kernal = (50,30)
    mnist_data = upload_data(datapath)
    train, valid, test = mnist_data    
    
    
    print 'data being converted to theano-shared............ '
    train_x, train_y = to_shared(train)
    valid_x, valid_y = to_shared(valid)
    
    n_train_batch =  train[0].shape[0] // batch 
    n_valid_batch =  valid[0].shape[0] // batch
   
    rng = np.random.RandomState(123)    
    
    layer0_input = x.reshape((batch,1,28,28))
    
    layer0 = ConvPoolLayer(input = layer0_input,
                           rng = rng,
                           filter_shape = (kernal[0],1,5,5),
                          )
    layer1 = ConvPoolLayer(input = layer0.output,
                           rng = rng,
                           filter_shape = (kernal[1],kernal[0],5,5))
                           
    layer2_input = layer1.output.flatten(2)
   
    layer2 = HiddenLayer(input = layer2_input,       
                         rng = rng,
                         n_out = n_hidden,                            
                         n_in = kernal[1]*4*4,
                         )
                         
    layer3 = LogisticRegression(input = layer2.output,
                                n_in = n_hidden,
                                n_out = n_out)
    

    fun_valid = theano.function(inputs = [index],
                                outputs = layer3.error(y),
                                givens  = [(x,valid_x[index*batch:(index+1)*batch,:]),
                                           (y,valid_y[index*batch:(index+1)*batch])]
                               )
    
    cost = layer3.negative_log_likelihood(y)
    params = layer0.params + layer1.params + layer2.params + layer3.params                           
    grad_all = T.grad(cost = cost,
                      wrt = params)
    
                               
    updates = [(param_i, param_i - learning_rate * grad_i)
                for param_i, grad_i in zip(params, grad_all)]                       
     
    fun_train = theano.function(inputs = [index],
                                outputs = [],
                                updates = updates,
                                givens  = [(x,train_x[index*batch:(index+1)*batch,:]),
                                           (y,train_y[index*batch:(index+1)*batch])]
                                )

                     
     ################
    #TRAINING MODEL#                      
    ################..........................................                     
    print 'training starts now -->'
    patience = 5000
    patience_increase = 2
    
    improvement = 0.995
    validation_frequency = min(n_train_batch, patience//2)    
  
    least_error = np.Inf
    epoch = 0
    done_looping = False
    this_error = 0
    start_time = timeit.default_timer()
    print 'EPOCH counting .....'
    while epoch < n_epoch and (not done_looping):
        for current_batch in range(n_train_batch):            
            total_batches = epoch*n_train_batch + current_batch
            fun_train(current_batch) 
            
            if (total_batches+1) % validation_frequency == 0:                
                this_error = [fun_valid(n) for n in range(n_valid_batch)]
                this_error = np.mean(this_error)
                
                if this_error < least_error*improvement:
                    least_error = this_error
                    patience =  max(patience,total_batches * patience_increase)
                    with open('/home/sameer/best_model_neural_filters.pkl', 'wb') as f:
                        pickle.dump(layer0.params, f)
                        f.close()
                    
        if total_batches > patience:
            done_looping = True
        epoch += 1
        if total_batches != 0:
            #print 'the convergence ratio is %f' %(patience/float(total_batches))
            print this_error
            print epoch
            save[epoch] = this_error
    
    print 'the error is %f' %least_error
    print 'the total number of  epoch %d' %epoch    
    end_time = timeit.default_timer()
    t = end_time - start_time
    print 'total time = %f sec' %t
    print 'time per epoch = %f sec/epoch' %(t/epoch) 
        
if __name__ == '__main__':        
    solve_CNN('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz')     



                                                        
                                                                 