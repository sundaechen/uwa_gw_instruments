import visa
import time
#import csv
import numpy as np

##### modify the channels you want to save 
displays = [0, 1] # choose from: 0, 1
#####

rm=visa.ResourceManager()
# print(rm.list_resources())
inst=rm.open_resource('ASRL3::INSTR')
print("connected")

def read_y_data(display=0):
    A=inst.query('DSPY ? '+str(display))
    A = A.strip('\x00')
    A = A.strip('\n')    
    A=A.split(',')
    A=np.array(A[:-1])
    Y=A.astype(float)
    return Y

def read_x_data(display=0):
    N=inst.query('DSPN ? '+ str(display))
    N = N.strip('\x00')
    N = N.strip('\n')
    N = int(N)

    # for swept sine
    MaxFString = inst.query('DBIN ? '+ str(display) +', ' + str(N-2))
    MaxFString = MaxFString.strip('\x00')
    MaxFString = MaxFString.strip('\n')
    MaxF = float(MaxFString)

    MinFString = inst.query('DBIN ? ' + str(display) + ', 0')
    MinFString = MinFString.strip('\x00')
    MinFString = MinFString.strip('\n')
    MinF = float(MinFString)

    '''
    SSTY (?) d {, i}
    The SSTY command sets (queries) the swept sine Sweep Type of display d.
    The parameter i selects Linear (0) or Logarithmic (1).
    The set command requires d=2(both displays).
    '''
    '''
    sweep_type = inst.query('SSTY ? '+ str(display))
    if sweep_type:
        X = np.logspace(MinF, MaxF, N-1)
    else:
        X = np.linspace(MinF, MaxF, N-1)
    '''
    
    X = np.linspace(MinF, MaxF, N-1)
    return X

def read_data(display=1):
    x = read_x_data(display)
    y = read_y_data(display)
    data = np.column_stack((x,y))
    return data

def save_data(filename,trace,data):
    with open(filename,'a')as f:
        for d in data:
            f.write('{:e}\t{:e} \n'.format(d[0],d[1]))

if __name__=="__main__":
    #pause_measurement()
    record_time = time.strftime('%Y-%m-%d-%H-%M-%S')
    for display in displays:        
        filename = 'Channel'+str(display)+'-'+record_time+'.txt'
        print('Acquiring Trace', str(display))
        data = read_data(display)
        print('Acquiration DONE. Saving data...')
        #save_data_header(filename,display)
        save_data(filename,display,data)
        print('Data saved')

        
