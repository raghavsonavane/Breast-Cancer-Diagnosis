dh=0.043/3; dv=0.057/4; %Distance between adjacent antennas of Walabot 
%Physical antenna locations of Walabot                    
antenna1=[0,0,0];     antenna2=[dh,0,0];        antenna3=[2*dh,0,0];      antenna4=[3*dh,0,0];
antenna5=[0,dv,0];    antenna6=[dh,dv,0];       antenna7=[2*dh,dv,0];     antenna8=[3*dh,dv,0];
antenna9=[0,2*dv,0];  antenna10=[dh,2*dv,0];    antenna11=[2*dh,2*dv,0];  antenna12=[3*dh,2*dv,0];
antenna13=[0,3*dv,0]; antenna14=[dh,3*dv,0];    antenna15=[2*dh,3*dv,0];  antenna16=[3*dh,3*dv,0];
antenna17=[0,4*dv,0];                                                     antenna18=[3*dh,4*0,0];

antenna_locations=[antenna1;antenna2;antenna3;antenna4;antenna5;antenna6;antenna7;antenna8;antenna9;antenna10;antenna11;antenna12;antenna13;antenna14;antenna15;antenna16;antenna17;antenna18];
antenna_locations=antenna_locations-[1.5*dh,2*dv,0]; %Shifting Origin to the center of Walabot Plane

dx=0.05; dy=0;
antenna_locations1=antenna_locations;
antenna_locations2=antenna_locations-[dx,dy,0];
antenna_locations=[antenna_locations1,antenna_locations2]; 

x=-0.3:0.005:0.3; %10 cm radius
y=-0.3:0.005:0.3;
z=0:0.005:0.5;

Rfunc=zeros(length(x),length(y),length(z));

for tx=1:18
    for rx=1:18
        if exist("data/stretchBase1_ampData_"+num2str(tx)+"_"+num2str(rx)+".dat")
            Rfunc=Rfunc+Rfunction(tx,rx)+RfunctionStretched(tx,rx);
        end
    end
end

% figure; surf(z,x,squeeze(Rfunc(:,1,:))) %X-Z slice
% figure; surf(z,y,squeeze(Rfunc(1,:,:))) %Y-Z slice
% figure; surf(x,y,squeeze(Rfunc(:,:,1))) %X-Y slice
% 
% for t=1:length(z)
%     surf(x,y,squeeze(Rfunc(:,:,t)));
%     title(z(t))
%     pause(0.05)
% end

% for t=1:length(squeeze(y))
% surf(z,x,squeeze(Rfunc(:,t,:)));
% title(y(t))
% pause(0.05)
% end

% for tx=1:18
%     for rx=1:18
%         if exist("data/BASEampData_"+num2str(tx)+"_"+num2str(rx)+".dat")
%             A=importdata("data/PINampData_"+num2str(tx)+"_"+num2str(rx)+".dat");
%             Abase=importdata("data/BASEampData_"+num2str(tx)+"_"+num2str(rx)+".dat");
%             signals=A(:,1)-Abase(:,1);
%             time=A(:,2);
%             plot(time,signals);
%             title("tx="+tx+",rx="+rx);
%             pause(0.5);
%         end
%     end
% end