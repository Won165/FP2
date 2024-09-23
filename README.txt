The ZIP file 'NC_Code' contains MATLAB codes for analyzing fiber photometry data. Raw data can be obtained from SYNAPSE SOFTWARE (TDT). 
The files '0607_VF4_f_4055.csv', '0607_VF4_f_465.csv', 'Expected output1.mat', and 'Expected output2.mat' are included for the demo.

1. System requirements:
These codes have been tested on MATLAB 2019a and R2022b.
No non-standard hardware is required.

2. Installation guide:
Download the files from the ZIP file 'NC_Code' to the default Current Folder in MATLAB, typically set to C:\Users\Username\Documents\MATLAB.
Alternatively, set the folder containing the downloaded files as the Current Folder in MATLAB.

The typical download time is a few seconds.

3. Demo:
Use 'FP.m' to normalize 465 nm signal data with 405 nm signal data (isosbestic control).
1) Type 'FP' in the Command Window in MATLAB.
2) Enter the file name of the 465 nm data (e.g., '0607_VF4_f_4655').
3) Enter the file name of the 405 nm data (e.g., '0607_VF4_f_4055').
4) Enter the onset time of the event (in seconds) (e.g., 126.6762).

Three graphs will display:
- A graph of raw 465 nm and 405 nm signal data (top).
- A graph of raw 465 nm data and the 405 nm data fitted to raw 465 nm data using a linear regression function (middle).
- A graph of the 465 nm data normalized with the fitted 405 nm data (bottom).

Normalized 465 nm data will be saved in variable 'Normalized_465'. 
The expected output of the example can be found in 'Expected output1.mat'.

For normalizing raw 465 nm data with median values of baseline instead of the 405 nm data, use 'mediannor.m'. This method was used in the manuscript.
1) Open the 'FP' code result file (e.g., 'Expected output1.mat').
2) Type 'mediannor' in MATLAB's Command Window.
3) Enter the baseline duration to analyze (in seconds) (e.g., 5).
4) Enter the event or post-event duration to analyze (in seconds) (e.g., 10).

Then, a graph of the 465 nm data normalized with median values of baseline will be displayed.
Normalized 465 nm data will be saved in variable 'L1_m'. The expected output can be found in 'Expected output2.mat'.

Demo runtime is typically a few minutes.

4. Instructions for use:
Run the codes to analyze the data after obtaining raw data (.csv) from SYNAPSE SOFTWARE.
Calculate mean or peak values using variables 'Normalized_465' or 'L1_m'.