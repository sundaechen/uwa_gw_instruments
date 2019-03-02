import os
import glob

def main():
    s = glob.glob('*.dat')

    with open('autoexec.txt','w+')as f:
        for ss in s:
            f.write('Sdftoasc.exe {0:s} {1:s} /X /O /B:, /F:%le \n'.format(ss, ss.replace('dat','csv')))
        f.write('exit')

    os.system('vDos.exe')

    os.remove('autoexec.txt')    

if __name__=='__main__':
    main()


