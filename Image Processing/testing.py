import logistic
import cPickle
import theano
import numpy as np

data= []
def testing_phase(choose):
    
    if choose == 1:
        print 'loading the parameters.....'        
        f = open('/home/sameer/best_model.pkl')        
        train, valid, test = logistic.upload_data('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz')
        object = cPickle.load(f)
        fun = theano.function(inputs = [object.input],
                          outputs = object.y_pred)
    
        print 'running the function......'                      
        ans =  fun(test[0])
    
        print 'deleting variables.....'
        del(train,valid)
    
        print "%3.2f %%" %(np.mean(test[1] == ans) * 100)
    
    elif choose == 2:   
        print 'loading the parameters.....'
        f = open('/home/sameer/best_model_neural.pkl')
        obj = cPickle.load(f)
        f.close()
        train, valid, test = logistic.upload_data('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz')        
        fun = theano.function(inputs = [obj.hidden.input],
                              outputs = obj.logistic_reg.y_pred)
    
        print 'running the function......'                      
        ans =  fun(test[0])
    
        print 'deleting variables.....'
        del(train,valid)
    
        print "%3.2f %%" %(np.mean(test[1] == ans) * 100)
        
    elif choose == 3:   
        print 'loading the parameters.....'
        f = open('/home/sameer/best_model_neural_relu.pkl')
        obj = cPickle.load(f)
        f.close()
        train, valid, test = logistic.upload_data('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz')        
        fun = theano.function(inputs = [obj.hidden.input],
                              outputs = obj.logistic_reg.y_pred)
    
        print 'running the function......'                      
        ans =  fun(test[0])
    
        print 'deleting variables.....'
        del(train,valid)
    
        print "%3.2f %%" %(np.mean(test[1] == ans) * 100)        
        
    

    
    elif choose == 4:   
        print 'loading the parameters.....'
        f = open('/home/sameer/reconstructed','r')
        obj = cPickle.load(f)
        f.close()
        train, valid, test = logistic.upload_data('/home/sameer/Projects/DeepLearningTutorials/data/mnist.pkl.gz')        
        fun = theano.function(inputs = [obj.input],
                              outputs = obj.reconstruction)
    
        print 'running the function......'                      
        ans =  fun(train[0])
    
        print 'deleting variables.....'
        del(train,valid)
        final = ans.reshape([50000,28,28])
        data.append(final)        
    
    
    
                       
if __name__ == '__main__':
    testing_phase(4)
        
                          