This program converts an SDF data file (e.g. data file from Agilent(HP) spectrum analyser) to an ASCII data file (txt or csv) in a 64-bit windows.

TO RUN: 
Copy files "*.exe" and "*.bat" into your data folder, and double click "vdosSDF.bat" to convert data.

OR (if python is installed)
Copy files "*.exe" and "vdosSDF.py" into your data folder, and double click "vdosSDF.py" to convert data.

How does it work:
"vdosSDF.bat" calls vDos to emulate a 32-bit Dos, and then call "sdftoasc.exe" to convert data.
