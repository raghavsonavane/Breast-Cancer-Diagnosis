function [distance] = dist(p,p1,p2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
d1=0;d2=0;
for i=1:length(p1)
    d1=d1+(p(i)-p1(i))^2;
    d2=d2+(p(i)-p2(i))^2;
end
distance=sqrt(d1)+sqrt(d2);
end

