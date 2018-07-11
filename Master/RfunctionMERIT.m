frequencies = dlmread('data/frequencies.csv');
antenna_locations = dlmread('data/antenna_locations.csv');
channel_names = dlmread('data/channel_names.csv');

scan1 = dlmread('data/B0_P5_p000.csv');
scan2 = dlmread('data/B0_P5_p036.csv');
signals=scan1-scan2;

time=0:0.001/3e8:1.999/3e8; %1mm Precision
B_time=merit.process.fd2td(signals,frequencies,time);

%resampled_signal=merit.process.resample(signals,1,2);
%B_original=ifft(scan1);
%B_rotated=ifft(scan2);
%B_sub=ifft(padding_signal);


x=-0.1:0.0025:0.1; %20 cm radius
y=-0.1:0.0025:0.1;
z=0:0.0025:0.1;

AvgRfunc=zeros(length(x),length(y),length(z));
Rfunc=AvgRfunc;
epsilon=8; %Permittivity of Breast Tissues


for c=1:length(channel_names)
        for x=-0.1:0.0025:0.1 %50 cm radius, 5 mm resolution
            for y=-0.1:0.0025:0.1
                for z=0:0.0025:0.1
                    idx=round(1+dist([x,y,z],antenna_locations(channel_names(c,1),:),antenna_locations(channel_names(c,2),:))*1000*sqrt(epsilon));
                    Rfunc(round((x+0.1)*400+1),round((y+0.1)*400+1),round(z*400+1))=B_time(idx,c); %Sampling rate(time)= 0.001/3e8 => 10000
                end
            end
        end
        AvgRfunc=AvgRfunc+Rfunc;
        Rfunc=zeros(length(Rfunc(:,1,1)),length(Rfunc(1,:,1)),length(Rfunc(1,1,:)));
end

x=-0.1:0.0025:0.1; %20 cm radius
y=-0.1:0.0025:0.1;
z=0:0.0025:0.1;



for t=1:length(z)
     surf(x,y,squeeze(abs(AvgRfunc(:,:,t))));
    title(z(t))
    view(2);
     pause(0.5)
end
