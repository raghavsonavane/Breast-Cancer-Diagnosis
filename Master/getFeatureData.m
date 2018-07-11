A=[];
for tx=1:18
    for rx=1:18
        if exist("data/base_ampData_"+num2str(tx)+"_"+num2str(rx)+".dat")
            A1=importdata("data/metal_ampData_"+num2str(tx)+"_"+num2str(rx)+".dat");
            A=[A,A1(:,1:200)];
        end
    end
end