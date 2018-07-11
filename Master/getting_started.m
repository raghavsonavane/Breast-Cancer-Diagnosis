% Getting started guide for MERIT
% A basic guide to:
%  - loading and visualising the sample data;
%  - processing signals using the MERIT functions;
%  - imaging with this toolbox.

%% Loading sample data
% Details of the breast phantoms used to collect the sample data
% are given in "Microwave Breast Imaging: experimental
% tumour phantoms for the evaluation of new breast cancer diagnosis
% systems", 2018 Biomed. Phys. Eng. Express 4 025036.
% The antenna locations, frequency points and scattered signals
% are given in the /data folder:
%   antenna_locations.csv: the antenna locations in metres;
%   frequencies.csv: the frequency points in Hertz;
%   channel_names.csv: the descriptions of the channels in the scattered data;
%   B0_P3_p000.csv: homogeneous breast phantom with an 11 mm diameter
%     tumour located at (15, 0, 35) mm.
%   B0_P5_p000.csv: homogeneous breast phantom with an 20 mm diameter
%     tumour located at (15, 0, 30) mm.
% For both phantoms, a second scan rotated by 36 degrees from the first
% was acquired for artefact removal:
% B0_P3_p036.csv and B0_P5_p036.csv respectively.

dh=0.015; dv=0.015; %Distance between adjacent antennas of Walabot 
%Physical antenna locations of Walabot                    
antenna1=[0,0,0];     antenna2=[dh,0,0];        antenna3=[2*dh,0,0];      antenna4=[3*dh,0,0];
antenna5=[0,dv,0];    antenna6=[dh,dv,0];       antenna7=[2*dh,dv,0];     antenna8=[3*dh,dv,0];
antenna9=[0,2*dv,0];  antenna10=[dh,2*dv,0];    antenna11=[2*dh,2*dv,0];  antenna12=[3*dh,2*dv,0];
antenna13=[0,3*dv,0]; antenna14=[dh,3*dv,0];    antenna15=[2*dh,3*dv,0];  antenna16=[3*dh,3*dv,0];
antenna17=[0,4*dv,0];                                                     antenna18=[3*dh,4*0,0];

f=5e9:50e6:9e9;


channel_count=1;
for tx=1:18
    for rx=1:18
        if exist("data/BASEampData_"+num2str(tx)+"_"+num2str(rx)+".dat")
            Abase=importdata("data/BASEampData_"+num2str(tx)+"_"+num2str(rx)+".dat");
            A=importdata("data/CUPampData_"+num2str(tx)+"_"+num2str(rx)+".dat");
            time=A(:,2);
            scan1=merit.process.td2fd(A(:,1),time,f);
            scan2=merit.process.td2fd(Abase(:,1),time,f);
            %Abasefft=fft(Abase(:,1));
            %Afft=fft(A(:,1));
            %scan1(1:265,channel_count)=Abasefft(3699:3963);
            %scan2(1:265,channel_count)=Afft(3699:3963);
            %scan1(:,channel_count)=Abasefft(:);
            %scan2(:,channel_count)=Afft(:);
            %scan1(:,channel_count)=A(:,1);
            %scan2(:,channel_count)=Abase(:,1);
            channel_names(channel_count,1) = tx;
            channel_names(channel_count,2) = rx;
            channel_count = channel_count+1; 
        end
    end
end
channel_count=channel_count-1;
Fs=A(2,2)-A(1,2);   
Fs=1/Fs;
x=-Fs/2:Fs*(1/4096):Fs*(1-1/4096)/2;

%%
%frequencies = dlmread('data/frequencies.csv');
%frequencies = x(3699:3963)-3.785e10;
frequencies = f;
%frequencies = A(:,2);
%antenna_locations = dlmread('data/antenna_locations.csv');
antenna_locations=[antenna1;antenna2;antenna3;antenna4;antenna5;antenna6;antenna7;antenna8;antenna9;antenna10;antenna11;antenna12;antenna13;antenna14;antenna15;antenna16;antenna17;antenna18];
antenna_locations=antenna_locations-[1.5*dh,2*dv,0];
%channel_names = dlmread('data/channel_names.csv');

%scan1 = dlmread('data/B0_P3_p000.csv');
%scan2 = dlmread('data/B0_P3_p036.csv');

%% Plot the acquired scans.
data_channel1 = [scan1(:, 1), scan2(:, 1)];
channel1_magnitude = mag2db(abs(data_channel1));
channel1_phase = unwrap(angle(data_channel1));
subplot(2, 1, 1);
plot(frequencies, channel1_magnitude);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('Original Scan', 'Rotated Scan');
title(sprintf('Channel (%d, %d) Magnitude', channel_names(1, :)));
subplot(2, 1, 2);
plot(frequencies, channel1_phase);
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
legend('Original Scan', 'Rotated Scan');
title(sprintf('Channel (%d, %d) Phase', channel_names(1, :)));


%% Perform rotation subtraction
signals = scan1-scan2;

%% Plot artefact removed: channel 1
rotated_channel1_magnitude = mag2db(abs(signals(:, 1)));
rotated_channel1_phase = unwrap(angle(signals(:, 1)));
subplot(2, 1, 1);
plot(frequencies, [channel1_magnitude, rotated_channel1_magnitude]);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('Original Scan', 'Rotated Scan', 'Artefact removed');
title(sprintf('Channel (%d, %d) Magnitude—Artefact removed', channel_names(1, :)));
subplot(2, 1, 2);
plot(frequencies, [channel1_phase, rotated_channel1_phase]);
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
legend('Original Scan', 'Rotated Scan', 'Artefact removed');
title(sprintf('Channel (%d, %d) Phase—Artefact removed', channel_names(1, :)));

%% Generate imaging domain and visualise
[points, axes_] = merit.domain.hemisphere('radius', 7e-2, 'resolution', 2.5e-3);
subplot(1, 1, 1);
scatter3(points(:, 1), points(:, 2), points(:, 3), '+');

%% Calculate delays
% merit.get_delays returns a function that calculates the delay
%   to each point from every antenna.
delays = merit.beamform.get_delays(channel_names, antenna_locations, ...
  'relative_permittivity',1); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Perform imaging
img = abs(merit.beamform(signals, frequencies, points, delays, ...
        merit.beamformers.DAS));

%% Convert to grid for image display
%grid_ = merit.domain.img2grid(img, points, axes_{:});

%im_slice = merit.visualize.get_slice(img, points, axes_, 'z', 35e-3);
%imagesc(axes_{1:2}, im_slice);

for t=axes_{3};im_slice = merit.visualize.get_slice(img, points, axes_, 'z', t);
imagesc(axes_{1:2}, im_slice);
title("z="+t);
pause(0.2)
end
close all