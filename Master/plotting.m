 for t=1:length(z)
     subplot(221)
     imagesc(x,y,abs(squeeze(Screw_z3cm1_Rfunc(:,:,t)))),colorbar;
     title("Screw\_z3cm1\_Rfunc,z="+z(t)+",t"+t);
     
     subplot(222)
     imagesc(x,y,abs(squeeze(Screw_z3cm2_Rfunc(:,:,t)))),colorbar;
     title("Screw\_z3cm2\_Rfunc,z="+z(t)+",t"+t);
     
     subplot(223)
     imagesc(x,y,abs(squeeze(Screw_z3cm3_Rfunc(:,:,t)))),colorbar;
     title("Screw\_z3cm3\_Rfunc,z="+z(t)+",t"+t);
     
     subplot(224)
     imagesc(x,y,abs(squeeze(Screw_z3cm4_Rfunc(:,:,t)))),colorbar;
     title("Screw\_z3cm4\_Rfunc,z="+z(t)+",t"+t);
     
     pause(0.5)
 end

  for t=1:length(z)
     subplot(411)
     imagesc(x,y,abs(squeeze(Screw_z3cm1_Rfunc(:,:,t))));
     title("Screw\_z3cm1\_Rfunc,z="+z(t)+",t"+t);
     
     subplot(412)
     imagesc(x,y,abs(squeeze(Screw_z3cm2_Rfunc(:,:,t))));
     title("Screw\_z3cm2\_Rfunc,z="+z(t)+",t"+t);
     
     subplot(413)
     imagesc(x,y,abs(squeeze(Screw_z3cm3_Rfunc(:,:,t))));
     title("Screw\_z3cm3\_Rfunc,z="+z(t)+",t"+t);
     
     subplot(414)
     imagesc(x,y,abs(squeeze(Screw_z3cm4_Rfunc(:,:,t))));
     title("Screw\_z3cm4\_Rfunc,z="+z(t)+",t"+t);
     
     pause(0.5)
  end
 
   for t=1:length(z)
     subplot(131)
     imagesc(x,y,abs(squeeze(Screw_z6cm1_Rfunc(:,:,t))));
     title("Screw\_z3cm1\_Rfunc,z="+z(t)+",t"+t);
     
     subplot(132)
     imagesc(x,y,abs(squeeze(Screw_z6cm1_Rfunc(:,:,t))));
     title("Screw\_z6cm1\_Rfunc,z="+z(t)+",t"+t);
     
     subplot(133)
     imagesc(x,y,abs(squeeze(Screw_z9cm1_Rfunc(:,:,t))));
     title("Screw\_z9cm1\_Rfunc,z="+z(t)+",t"+t);
          
     pause(0.5)
   end
 
   
      for t=1:length(y)
     subplot(131)
     imagesc(z,x,abs(squeeze(Screw_z6cm1_Rfunc(:,t,:))));
     title("Screw\_z3cm1\_Rfunc,y="+y(t)+",t"+t);
     
     subplot(132)
     imagesc(z,x,abs(squeeze(Screw_z6cm1_Rfunc(:,t,:))));
     title("Screw\_z6cm1\_Rfunc,y="+y(t)+",t"+t);
     
     subplot(133)
     imagesc(z,x,abs(squeeze(Screw_z9cm1_Rfunc(:,t,:))));
     title("Screw\_z9cm1\_Rfunc,y="+y(t)+",t"+t);
          
     pause(0.5)
      end
 
      
for t=1:length(x)
subplot(131)
imagesc(z,y,abs(squeeze(Screw_z6cm1_Rfunc(t,:,:))));
title("Screw\_z3cm1\_Rfunc,y="+y(t)+",t"+t);
subplot(132)
imagesc(z,y,abs(squeeze(Screw_z6cm1_Rfunc(t,:,:))));
title("Screw\_z6cm1\_Rfunc,y="+y(t)+",t"+t);
subplot(133)
imagesc(z,y,abs(squeeze(Screw_z9cm1_Rfunc(t,:,:))));
title("Screw\_z9cm1\_Rfunc,y="+y(t)+",t"+t);
pause(0.5)
end