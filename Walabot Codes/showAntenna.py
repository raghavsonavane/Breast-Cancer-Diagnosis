import numpy as np
import matplotlib.pyplot as plt
import time
from os import listdir
from os.path import isfile, join
from tool.log5 import *

def one_signal():
    path = 'antenna'
    basefile = sorted([join(path,'bak',f) for f in listdir(join(path,'bak')) if f[-4:]=='.txt'])

    #while True:
    txtfile = sorted([join(path,f) for f in listdir(path) if f[-4:]=='.txt'])

    for name in txtfile:
      data = np.genfromtxt(name)
      base = np.genfromtxt(join(path,'bak',name.split('/')[1]))
      diff_data = np.abs(data[:,1] - base[:,1])
      #diff_data /= base[:,1]+1e-10 #np.minimum(data[:,1]+1e-10,base[:,1]+1e-10)
      diff_data /= np.max(diff_data)
      #data[:,1] = np.maximum(data[:,1],1e-4)
      if len(data.shape)==2:
          plt.clf()
          plt.plot(data[:,0],diff_data)
          plt.savefig(name[:-4]+'.png')

    #time.sleep(3)

def two_signal():
    path = 'antenna'
    basefile = sorted([join(path,'bak',f) for f in listdir(join(path,'bak')) if f[-4:]=='.txt'])

    txtfile1 = sorted([join(path,'A',f) for f in listdir(join(path,'A')) if f[-4:]=='.txt'])
    txtfile2 = sorted([join(path,'B',f) for f in listdir(join(path,'B')) if f[-4:]=='.txt'])

    for i in range(len(txtfile1)):
      data1 = np.genfromtxt(txtfile1[i])
      data2 = np.genfromtxt(txtfile2[i])

      base = np.genfromtxt(join(path,'bak',txtfile1[i].split('/')[2]))

      diff_data1 = np.abs(data1[:,1] - base[:,1])
      diff_data2 = np.abs(data2[:,1] - base[:,1])

      #diff_data1 /= np.max(diff_data1)
      #diff_data2 /= np.max(diff_data2)

      diff_data = diff_data1-diff_data2
      diff_data /= np.max(diff_data)

      if len(data1.shape)==2:
          plt.clf()
          plt.plot(data1[:,0],diff_data)
          plt.savefig(join(path,txtfile1[i].split('/')[-1])[:-4]+'.png')

    #time.sleep(3)

def avgpool(data):
  pass
  bin = 21
  for i in range(data.shape[0]/bin):
     data[bin*i:bin*(i+1)] = data[bin*i:bin*(i+1)].mean()
  return data

def tmp():
  pass
  trainData,trainLabel,valData,valLabel,testData,testLabel = load()

  trainData -= trainData[0]
  valData -= trainData[0]
  testData -= trainData[0]

  # (N,1,2048,13) => (N,1,13,2048)
  trainData = np.swapaxes(trainData,2,3)[:,:,:,200:]
  valData = np.swapaxes(valData,2,3)[:,:,:,200:]
  testData = np.swapaxes(testData,2,3)[:,:,:,200:]


  for i in range(trainData.shape[0]):
      for j in range(trainData.shape[2]):
          plt.clf()
          curr = np.copy(trainData[i,0,j])
          std = (curr - curr.min()) / (curr.max()-curr.min()+1e-10)
          plt.plot(np.arange(1848),std)

          _data = avgpool(curr)
          std = (_data - _data.min()) / (_data.max() - _data.min()+1e-10)
          plt.plot(np.arange(1848),std)

          name = 'data/'+str(i)+'_'+str(j)+'.png'
          plt.savefig(name)

def show_diff():
  pass
  trainData,trainLabel,valData,valLabel,testData,testLabel = load()

  trainData -= trainData[0]
  valData -= trainData[0]
  testData -= trainData[0]

  # (N,1,2048,13) => (N,1,13,2048)
  trainData = np.swapaxes(trainData,2,3)[:,:,:,200:]
  valData = np.swapaxes(valData,2,3)[:,:,:,200:]
  testData = np.swapaxes(testData,2,3)[:,:,:,200:]

  N,_,P,T = trainData.shape

  with open('diff.log','w') as f:
    pass

  for i in range(1,N,1):
    total_sum=0
    total_mean=0
    for j in range(P):
      _sum = trainData[i,0,j].sum()
      _mean = trainData[i,0,j].mean()
      total_sum += _sum
      total_mean += _mean

      with open('diff.log','a') as f:
        f.write("X=%.2f,Y=%.2f\tOBJ=%d,AP=%d\tSUM=%.5f, MEAN=%.5f\n"
            %(trainLabel[i,0],
              trainLabel[i,1],
              (i-1)%7,
              j,
              _sum,
              _mean))

    with open('diff.log','a') as f:
      f.write('Total_SUM=%.5f,Total_MEAN=%.5f\n\n' %(total_sum,total_mean/P))


if __name__=='__main__':
  pass
  #one_signal()
  #two_signal()
  show_diff()
  #tmp()
