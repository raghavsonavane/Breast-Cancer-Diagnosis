A=importdata("CUPampData_"+num2str(1)+"_"+num2str(2)+".dat");
A_IQ_cup_tx1_rx2=A;
Acfft=zeros(length(A),1);
Afft=fft(A(:,1));
Acfft(1:265)=Afft(3699:3963);
A_IQ_cup_tx1_rx2(:,1)=ifft(Acfft); %Take this as your IQ samples
Fs=A(2,2)-A(1,2);
Fs=1/Fs;
x=-Fs/2:Fs*(1/4096):Fs*(1-1/4096)/2;

figure;
plot(A(:,2), A(:,1));
hold on 
plot(A(:,2), abs(A_IQ_cup_tx1_rx2));
hold off

figure;
plot(A(:,2), 10*abs(A_IQ_cup_tx1_rx2));
hold on;
plot(A(:,2), (angle(A_IQ_cup_tx1_rx2)));

figure;
plot(abs(fft((angle(A_IQ_cup_tx1_rx2)))))

