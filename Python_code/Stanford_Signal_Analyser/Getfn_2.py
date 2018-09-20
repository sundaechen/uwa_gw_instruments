import visa
import time
import csv
from numpy import array, float, linspace, column_stack

rm=visa.ResourceManager()
inst=rm.open_resource(u'ASRL4::INSTR')
print(inst.query('*IDN ?'))
print("connected")

def read_y_data():
    ytemp = inst.query('DSPY ? 0')
    ytemp = ytemp[1:-1].split(',')
    ytemp = array(ytemp)
    y = ytemp.astype(float)
    return y

def save_data(filename,data):
    with open(filename,'a')as f:
        for d in data:
            f.write('{:e} \n'.format(d))
    '''
    with open(filename + '.csv','w') as fp:
        writer = csv.writer(fp, delimiter=',')
        writer.writerow(y)
    '''

if __name__=="__main__":
    record_time = time.strftime('%Y-%m-%d-%H-%M-%S')
    filename = 'Trace' + '-' + record_time + '.txt'
    y = read_y_data()
    save_data(filename,y)
    print('Data saved.')
