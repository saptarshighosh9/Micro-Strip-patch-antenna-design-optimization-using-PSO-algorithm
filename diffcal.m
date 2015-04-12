function [q] = diffcalc(l,w,f,h,freq)
c=3*10^11;
freq=freq*10^9;
lamda=c/freq;
k=(2*3.14)/lamda;
g=(w*( 1- (((k*h)^2))/24))/(120*lamda);
rin=1/(2*g);
r=rin*(cos((3.14*f)/l)^2);
q=abs(r-50); #Fitness Function
end