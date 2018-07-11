function [Assb,time,freq] = getR(tx,rx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A=importdata("ampData_bottle_"+num2str(tx)+"_"+num2str(rx)+".dat");
%Abase=importdata("ampData_base1_"+num2str(tx)+"_"+num2str(rx)+".dat");
%Ac=A(:,1).*exp(j*angle(fft(A(:,1))))
%Acbase=Abase.*exp(j*angle(fft(Abase)))
Afft=fft(A-Abase)
N=2048 %2048 For Imaging, 8192 for Sensor, 4096 for Narrow Sensor
Abaseband=zeros(N,1) 
Abaseband(N/2-123:N/2+123)=Afft(N-2*123:N)
Assb=ifft(Abaseband)
Fs=A(2,2)-A(1,2)
Fs=1/Fs
freq=-Fs/2:Fs/N:Fs*(1-1/N)/2;
time=A(:,2);
%plot(time,A(:,1)-Abase(:,1))
%hold on
end

