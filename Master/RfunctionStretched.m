function [Rfunc] = RfunctionStretched(tx,rx)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
dh=0.043/3; dv=0.057/4; %Distance between adjacent antennas of Walabot 
%Physical antenna locations of Walabot                    
antenna1=[0,0,0];     antenna2=[dh,0,0];        antenna3=[2*dh,0,0];      antenna4=[3*dh,0,0];
antenna5=[0,dv,0];    antenna6=[dh,dv,0];       antenna7=[2*dh,dv,0];     antenna8=[3*dh,dv,0];
antenna9=[0,2*dv,0];  antenna10=[dh,2*dv,0];    antenna11=[2*dh,2*dv,0];  antenna12=[3*dh,2*dv,0];
antenna13=[0,3*dv,0]; antenna14=[dh,3*dv,0];    antenna15=[2*dh,3*dv,0];  antenna16=[3*dh,3*dv,0];
antenna17=[0,4*dv,0];                                                     antenna18=[3*dh,4*0,0];

dx=0.05; dy=0;
antenna_locations=[antenna1;antenna2;antenna3;antenna4;antenna5;antenna6;antenna7;antenna8;antenna9;antenna10;antenna11;antenna12;antenna13;antenna14;antenna15;antenna16;antenna17;antenna18];
antenna_locations=antenna_locations-[1.5*dh,2*dv,0]-[dx,dy,0]; %Shifting Origin to the center of Walabot Plane

x=-0.3:0.005:0.3; %10 cm radius
y=-0.3:0.005:0.3;
z=0:0.005:0.5;

Abase=importdata("data/stretchBase2_ampData_"+num2str(tx)+"_"+num2str(rx)+".dat");
A=importdata("data/stretch2_ampData_"+num2str(tx)+"_"+num2str(rx)+".dat");

signals=A(:,1)-Abase(:,1);
time=A(:,2);
f=4.4e9:0.001e9:9.4e9;

%% Smoothing and Baseband Processing
 Afft=fftshift(fft(signals));
 Acfft=zeros(4096,1);
 Acfft(1:271)=Afft(2180:2450);
 AIQ=ifft(Acfft);
% figure;
 Adiff=abs(AIQ(2:end))-abs(AIQ(1:end-1));
 Adiff(end+1)=0;
% plot(abs(AIQ(2:end))-abs(AIQ(1:end-1)));
% title("Difference plot for tx="+tx+" rx="+rx);
x=-0.1:0.005:0.1; %10 cm radius
y=-0.1:0.005:0.1;
z=0:0.005:0.1;
Rfunc=zeros(length(x),length(y),length(z));
%%
epsilon=1; %Permittivity of Environment

for x=-0.3:0.005:0.3; %10 cm radius
    for y=-0.3:0.005:0.3;
        for z=0:0.005:0.5;
            idx=round(1+dist([x,y,z],antenna_locations(tx,:),antenna_locations(rx,:))*1024/3*sqrt(epsilon));
            %Rfunc(round((x+0.2)*400+1),round((y+0.2)*400+1),round(z*400+1))=signals(idx);
            Rfunc(round((x+0.3)*200+1),round((y+0.3)*200+1),round(z*200+1))=AIQ(idx);
            %Rfunc(round((x+0.2)*400+1),round((y+0.2)*400+1),round(z*400+1))=Adiff(idx);
        end
    end
end

% figure; surf(z,x,squeeze(Rfunc(:,1,:))) %X-Z slice
% figure; surf(z,y,squeeze(Rfunc(1,:,:))) %Y-Z slice
% figure; surf(x,y,squeeze(Rfunc(:,:,1))) %X-Y slice
% 
% for t=1:length(Rfunc)
%     surf(x,y,squeeze(Rfunc(:,:,t)));
%     title(z(t))
%     pause(0.05)
% end


end

