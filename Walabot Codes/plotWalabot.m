% A=importdata('ampData.dat');
% plot(A12(:,2),A12(:,1))
% Fs=A12(2,2)-A12(1,2)
% Fs=1/Fs
[Assb,time,freq]=getR(1,2);
for i=3:9 
    Assb=Assb+getR(1,i)
end
plot(time,abs(Assb))
title('Cup1')