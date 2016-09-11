import numpy as np,theano,cPickle as pickle,timeit
from theano import function
import theano.tensor as T
from logistic import LogisticRegression,upload_data,to_shared


class HiddenLayer(object):
    
    def __init__(self,input,rng,n_in,n_out,activation = T.tanh):
        
            self.rng = rng  
            self.input = input    
            bound = np.sqrt(6.0/(n_in + n_out))
            
            W_value = np.asarray(rng.uniform(
                                             low = -bound,
                                             high = bound,
                                             size = (n_in,n_out)
                                            ),
                                 dtype = theano.config.floatX            
                                )         
            
            
            if activation == T.nnet.sigmoid:
                W_value *= 4 
                print 'using sigmoid'
                                    
            self.W = theano.shared(value = W_value,
                                   borrow = True,
                                   name = 'W'
                                  )
                                   
            self.b = theano.shared(value = np.zeros(shape = (n_out,),
                                                    dtype = theano.config.floatX),
                                   name = 'b',
                                   borrow = True
                                  )
               
            self.params = (self.W,self.b)                   
            
            out = T.dot(input,self.W) + self.b
            if activation == None:
                self.output = out
            else:    
                self.output = activation(out)                        
 
class MLP(object):
    
    def __init__(self,input, rng, n_in, n_out, n_hidden): 

        self.hidden = HiddenLayer(input = input,
                                  rng = rng,
                                  n_in = n_in,
                                  n_out = n_hidden,
                                 )
    
       
                       
        self.logistic_reg = LogisticRegression(input = self.hidden.output,
                                               n_in = n_hidden,
                                               n_out = n_out
                                              )
                                              
def solve_MLP(datapath,learning_rate = 0.14,batch = 500,n_epoch = 20,n_hidden = 70,n_out = 10,n_in = 28*28):


    x = T.matrix('x')
    index = T.iscalar('index')
    y = T.ivector('y')
    
    mnist_data = upload_data('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz')
    train, valid, test = mnist_data    
    
    
    print 'data being converted to theano-shared............ '
    train_x, train_y = to_shared(train)
    valid_x, valid_y = to_shared(valid)
    test_x, test_y = to_shared(test)
    
    n_train_batch =  train[0].shape[0] // batch 
    n_valid_batch =  valid[0].shape[0] // batch
    n_test_batch  =  test[0].shape[0]  // batch
    
    rng = np.random.RandomState(134)    
    
    print 'creating classifier object.......'
    classifier = MLP(x,rng,n_in = n_in,n_out = n_out,n_hidden = n_hidden)
    
    fun_valid = function(inputs  = [index],
                         outputs = classifier.logistic_reg.error(y),
                         givens  = [(x,valid_x[index*batch:(index+1)*batch,:]),
                                    (y,valid_y[index*batch:(index+1)*batch])]
                        )   
       
    fun_test = function(inputs  = [index],
                        outputs = classifier.logistic_reg.y_pred,
                        givens  = [(x,test_x[index*batch:(index+1)*batch,:])],
                       )        
    
    
    
    print 'calculating symbolic gradient.....' 
    cost = classifier.logistic_reg.negative_log_likelihood(y)
    
    g_hidden_W = T.grad(cost = cost,
                        wrt = classifier.hidden.W
                       )
                       
    g_logistic_W = T.grad(cost = cost,
                          wrt = classifier.logistic_reg.W
                         )  
                         
    g_hidden_b = T.grad(cost = cost,
                        wrt = classifier.hidden.b
                       )
                       
    g_logistic_b = T.grad(cost = cost,
                          wrt = classifier.logistic_reg.b
                         )
    
    updates = [(classifier.hidden.W, classifier.hidden.W - g_hidden_W*learning_rate),
               (classifier.logistic_reg.W, classifier.logistic_reg.W - g_logistic_W*learning_rate),
               (classifier.hidden.b, classifier.hidden.b - g_hidden_b*learning_rate),
               (classifier.logistic_reg.b, classifier.logistic_reg.b - g_logistic_b*learning_rate)] 
    
    
    fun_train = function(inputs = [index],
                         outputs = None,
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
                    with open('/home/sameer/best_model_neural_relu.pkl', 'wb') as f:
                        pickle.dump(classifier, f)
                        f.close()
                    
        if total_batches > patience:
            done_looping = True
        epoch += 1
        if total_batches != 0:
            print 'the convergence ratio is %f' %(patience/float(total_batches))
            print this_error
    
    print 'the error is %f' %least_error
    print 'the total number of  epoch %d' %epoch    
    end_time = timeit.default_timer()
    t = end_time - start_time
    print 'total time = %f sec' %t
    print 'time per epoch = %f sec/epoch' %(t/epoch)
        
if __name__ == '__main__': 
           
    solve_MLP('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz')     
    
                                       

                                        
                                              
                                 
                                  
                                   
            