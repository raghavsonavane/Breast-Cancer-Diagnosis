import matplotlib.pyplot as plt
import numpy as np
import time
from imp import load_source
walabot=load_source('WalabotAPI','C:/Program Files/Walabot/WalabotSDK/Python/WalabotAPI.py')
walabot.Init()
walabot.SetSettingsFolder()
#Step 1: Connect to Walabot
walabot.ConnectAny()
#vcomplex_struct Phasor of reflected signal
#Step 2: Configurations
#Set the scan profile as sensor (distance scanner with high resolution and slow update rate)
walabot.SetProfile(walabot.PROF_WIDE)
'''Profile Can be: 
	1)PROF_SHORT_RANGE_IMAGING, 
	2)PROF_SENSOR
	3)PROF_SENSOR_NARROW
	4)PROF_WIDE
'''
#Set the dimensions of the arena
#walabot.SetArenaZ(1,20,0.1) #Question: what values can this take on? What is the lowest resolution you can set?
#walabot.SetArenaY(-10,10,1)
#walabot.SetArenaX(-10,10,1)

#walabot.SetArenaR(1,20,1) #Question: what values can this take on? What is the lowest resolution you can set?
#walabot.SetArenaTheta(-20,20,1)
#walabot.SetArenaPhi(-20,20,1)
walabot.SetDynamicImageFilter(walabot.FILTER_TYPE_NONE)
'''Set the filter type
	1)FILTER_TYPE_MTI : Moving Target Identification: standard dynamic-imaging filter
	2)FILTER_TYPE_DERIVATIVE : Dynamic-imaging filter for the specific frequencies typical of breathing.
	3)FILTER_TYPE_NONE : Default, No filtering
	
'''
#walabot.SetThreshold(35)

#Step 3: Start the system in preparation for scanning
walabot.Start()

#Step 4: Calibration to reduce signals from fixed targets

walabot.StartCalibration()
while walabot.GetStatus()[0] == walabot.STATUS_CALIBRATING:
    #Function which initiates a scan and records the signals
   walabot.Trigger()

#Continuously scanning + recording and getting the processed data
#open('ampData.dat', 'w').close()
 
#153 pairs for Imaging [0,...,152]
print('Calibration Completed, Waiting for 5 seconds')
#time.sleep(5)
count=0;
print('Starting Process')
while count < len(walabot.GetAntennaPairs()):
			#Set the antenna pair to be used
			scanAntennaPair=walabot.GetAntennaPairs()[count] #Use antenna #1 as tx and antenna #2 as rx (numberings are as specified in the tech spec sheet)
			multiple=0
			#Step 5: Scan
			while multiple < 20:
				walabot.Trigger()
				#Step 6: Get the scan
				#timeDomainSignal=walabot.GetSignal(scanAntennaPair) #Returns the amplitude vector and corresponding time vector for the received signa
				timeDomainSignal=walabot.GetSignal(scanAntennaPair)
				if multiple==0:
					timeDomainSignalX=timeDomainSignal[1]
					timeDomainSignalY=timeDomainSignal[0]
				else:
					timeDomainSignalX=np.add(timeDomainSignal[1],timeDomainSignalX)
					timeDomainSignalY=np.add(timeDomainSignal[0],timeDomainSignalY)
				multiple = multiple + 1
				continue 
			timeDomainSignalX[:]=[x / multiple for x in timeDomainSignalX]
			timeDomainSignalY[:]=[y / multiple for y in timeDomainSignalY]
			count = count + 1
			print('Channel Count= ', count)
			f=open('base4_ampData_'+str(scanAntennaPair.txAntenna)+'_'+str(scanAntennaPair.rxAntenna)+'.dat','ab')
			np.savetxt(f,np.transpose(timeDomainSignal))
			f.close()
#plt.plot(timeDomainSignalX, timeDomainSignalY)
#plt.pause(0.1)
#plt.show()	

#Step 7: Stop and disconnect
walabot.Stop()
walabot.Disconnect()
print ("Terminated successfully")