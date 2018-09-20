from numpy import array, float, linspace, column_stack
import visa
import time
import matplotlib.pyplot as pl

##### modify the traces you want to save 
traces = [1,2]
#####

rm = visa.ResourceManager()
sa = rm.open_resource('ASRL5::INSTR')
measurement_time = 10 # second


def read_y_data(trace=1):
    ytemp = sa.query('CALC'+str(trace)+':DATA?')
    ytemp = ytemp.split(',')
    ytemp = array(ytemp)
    y = ytemp.astype(float)
    return y

def read_x_data_time(trace=1):
    xtemp = sa.query('TRACE:X:data? TRACE'+str(trace))
    xtemp = xtemp.split(',')
    xtemp = array(xtemp)
    x = xtemp.astype(float)
    return x

def read_x_data_freq(trace=1):
    xstart = float(sa.query('frequency:start?'))
    xstop = float(sa.query('frequency:stop?'))
    points = int(sa.query('calc'+str(trace)+':data:head:points?'))
    x = linspace(xstart,xstop,points)
    return x

def read_x_data(trace=1):
    # inditify the x unit to be either Hz or second:
    # unit second return x_time = 1
    # unit Hz     return x_time = 0
    s = sa.query('trace:x:unit? trace'+str(trace))
    if s.find('s')==1:
        x = read_x_data_time(trace)
    elif s.find('Hz'):
        x = read_x_data_freq(trace)
    return x    

def read_data(trace=1):
    x = read_x_data(trace)
    y = read_y_data(trace)
    data = column_stack((x,y))
    return data    
        
def save_data(filename,trace,data):
    with open(filename,'a')as f:
        for d in data:
            f.write('{:e}\t{:e} \n'.format(d[0],d[1]))

def save_data_header(filename,trace):
    x_head = sa.query('trace:x:unit? trace'+str(trace)).strip('\n')
    y_head1 = sa.query('calc'+str(trace)+':feed?').strip('\n')
    y_head2 = sa.query('calc'+str(trace)+':form?').strip('\n')
    with open(filename,'w') as f:
        f.write(x_head+'\t'+y_head1+'\s'+y_head2+' \n')

def pause_measurement():
    sa.write('pause')
              
def continue_measurement():
    sa.write('cont')

def restart_measurement():
    sa.write('abort')

def set_center_f(freq):
    sa.write('Sense:Freq:Cent {:d}'.format(freq))
    
def measure_segment(start_freq, stop_freq, span):
    freqs = range(int(start_freq-span/2), int(stop_freq+2), int(span))
    for freq in freqs:
        set_center_f(freq)
        restart_measurement()
        time.sleep(measurement_time)

        # record and save data with your code
        

#def change_data_format(
if __name__=="__main__":
    pause_measurement()
    record_time = time.strftime('%Y-%m-%d-%H-%M-%S')
    for trace in traces:        
        filename = 'Trace'+str(trace)+'-'+record_time+'.txt'
        print('Acquiring Trace', str(trace))
        data = read_data(trace)
        print('Acquiration DONE. Saving data...')
        save_data_header(filename,trace)
        save_data(filename,trace,data)
        print('Data saved')

    
        
