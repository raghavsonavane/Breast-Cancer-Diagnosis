a=0.0286;
d=0.2622;
m=d^2-a^2
n=d^2
f = @(x,y,z) (x.^2)./m + ((y-a/2).^2)./n + (z.^2)./m-0.25;
fimplicit3(f)
56.61*x^2 +55.65*(y-0.0175)^2 + 56.61*z^2 = 1

f14 = @(x,y,z) (x/sqrt(d14^2-a14^2)).^2 + ((y-a14/2)/d14).^2 + (z/sqrt(d14^2-a14^2)).^2-0.25;
fimplicit3(f14,interval); hold on;
f17 = @(x,y,z) (y/sqrt(d17^2-a17^2)).^2 + ((x-a17/2)/d17).^2 + (z/sqrt(d17^2-a17^2)).^2-0.25;
fimplicit3(f17,interval)