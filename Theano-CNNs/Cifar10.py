import numpy as np
import cPickle as pickle

def Cifar_data():    
    f = open('/home/sameer/Downloads/cifar-10-batches-py/data_batch_1','rb') 
    data1 = pickle.load(f)
    f = open('/home/sameer/Downloads/cifar-10-batches-py/data_batch_2','rb') 
    data2 = pickle.load(f)
    f = open('/home/sameer/Downloads/cifar-10-batches-py/data_batch_3','rb') 
    data3 = pickle.load(f)
    f = open('/home/sameer/Downloads/cifar-10-batches-py/data_batch_4','rb') 
    data4 = pickle.load(f)
    f = open('/home/sameer/Downloads/cifar-10-batches-py/data_batch_5','rb') 
    data5 = pickle.load(f)
    
    train_data = np.concatenate((data1['data'],data2['data'],data3['data'],data4['data']),axis = 0)
    train_label = np.concatenate((data1['labels'],data2['labels'],data3['labels'],data4['labels']),axis = 0)
    
    train = [train_data,train_label]
    
    test_data = data5['data']
    test_label= data5['labels']
    
    test = [test_data,test_label]
    
    del data1,data2,data3,data4,data5,train_data,train_label,test_data,test_label
    return train,test
train,test = Cifar_data()