def get(name):

    import visa;
    import time;
    import csv;

    rm=visa.ResourceManager();
    print(rm.list_resources())
    inst=rm.open_resource(u'ASRL4::INSTR');
    print("connected")
    
    inst.query('*IDN ?')
    print(inst.query('*IDN ?'))

    print(inst.query('DBIN ? 0, 0'))
#    print(int(inst.query('DSPN ? 1')))
    
    A=inst.query('DSPY ? 0')
#    B=inst.query('DSPY ? 1')
    
    N=int(inst.query('DSPN ? 0'))-2
    MaxFString=inst.query('DBIN ? 0, ' + str(N))
    N2=len(MaxFString)-1
    MaxF=float(MaxFString[:N2])
    MinF=float(inst.query('DBIN ? 0, 0'))
    
    As=[]
    for I in range(0,N+1,1):
        As = As + [float(A[I*16:I*16+15])]
    '''
    Bs=[]
    for I in range(0,N+1,1):
        Bs = Bs + [float(B[I*16:I*16+15])]
    '''

    Xs=[]
    for I in range(0,N+1,1):
        Xs = Xs + [MinF+I*(MaxF-MinF)/N]

    with open(name + '.csv','w') as fp:
        writer = csv.writer(fp, delimiter=',')
#        writer.writerows([Xs]+[As]+[Bs])
        writer.writerow([As])

if __name__=="__main__":
    name = 'test'
    get(name)
