import scipy.io as scio
import numpy as np
import gzip

def vectorized_result(j):
    """Return a 10-dimensional unit vector with a 1.0 in the jth
    position and zeroes elsewhere.  This is used to convert a digit

    (0...9) into a corresponding desired output from the neural
    network."""
    e = np.zeros((10, 1))
    e[int(j)] = 1.0
    return e
dataFile_1=r'C:\Users\Windows 10\Desktop\four_' \
         r'target_harrp_mat\four_target_harrp_mat\aircraft_ifft.mat'
dataload_1 = scio.loadmat(dataFile_1)
data_1=dataload_1['aircraft_mat_ifft_abs']
dataFile_2=r'C:\Users\Windows 10\Desktop\four_' \
         r'target_harrp_mat\four_target_harrp_mat\F22_ifft.mat'
dataload_2 = scio.loadmat(dataFile_2)
data_2=dataload_2['F22_mat_ifft_abs']

label_1=np.ones([181,1])
label_1_int=np.ones(181)
label_1_int=label_1_int.astype(int)
label_1 = [vectorized_result(y) for y in label_1]

label_2=np.ones([181,1])
label_2=label_2*2
label_2_int=np.ones(181)*2
label_2_int=label_2_int.astype(int)
label_2 = [vectorized_result(y) for y in label_2]


train_data_1=[np.reshape(x,(101,1)) for x in data_1[:140]]
test_data_1=[np.reshape(x,(101,1)) for x in data_1[140:181]]
train_data_2=[np.reshape(x,(101,1)) for x in data_2[:140]]
test_data_2=[np.reshape(x,(101,1)) for x in data_2[140:181]]

train_label_1=[x for x in label_1[:140]]
test_label_1=[x  for x in label_1_int[140:181]]
train_label_2=[x  for x in label_2[:140]]
test_label_2=[x for x in label_2_int[140:181]]
# train_data_1=zip(train_data_1,label_1)
# train_data_2=zip(train_data_2,label_2)
#
# test_data_1=zip(test_data_1,label_1_int)
# test_data_2=zip(test_data_2,label_2_int)


train_data_1.extend(train_data_2)
test_data_1.extend(test_data_2)

train_label_1.extend(train_label_2)
test_label_1.extend(test_label_2)

train_data=zip(train_data_1,train_label_1)
test_data=zip(test_data_1,test_label_1)