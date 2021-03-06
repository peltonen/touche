%% General framework for delivering a stimulus %%

% Init DAQ
Fs = 40000;
s = daqSetup(Fs);


% Construct stimulus
stimulus = 'randSquareWithOffset';
edgeLength = 5000; %for glabrous skin 2500, 2236, 2000, 1789, 1600, 1431,1280, 1145, 1024, 916, 820, 733, 656, 587, 524, 469, 420, 376, 336, 300        
offsetX = 0; % [-26000, , -24000, 26000 ]  empirical range [-x, +x, -y, +y]
offsetY = 0;
numStim = 20000;
dwellTime = 0.0005;  
ISI = .1;  %empirical min is .00035 seconds 

rng(.08041961) % seed random number generator for reproducibility
[x1,y1,lz1,lz2] = randSquareWithOffset(edgeLength, offsetX, offsetY, numStim, dwellTime, ISI, Fs);
lz2(1:round(Fs/acqFPS):end) = 9; %possible to trigger with a single sample?




 queueOutputData(s, horzcat(x1, y1, lz1, lz2))
 pause(5);
 s.startForeground()



% Clean up and save congfiguration
s.release()

% Save the fields of a structure as individual variables:
s1.stimulus = stimulus;
s1.edgeLength = edgeLength;
s1.offsetX = offsetX;
s1.offsetY = offsetY;
s1.numStim = numStim;
s1.dwellTime = dwellTime;
s1.ISI = ISI;
save(strcat(stimulus,'_',datestr(now, 'yymmdd HHMM SS'),'.mat'), '-struct', 's1');