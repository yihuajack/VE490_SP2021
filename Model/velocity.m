psi = 0.8; %potential between two electrodes
vL0 = 2.82 * 10^(-9); %velocity of the large electrode
w0 = 0.03318; % ¦Ø0
xmin = 1.6 * 10^(-6);
xmax = 12 * 10^(-6);
w = 0.1*1000:1:100*1000; % x
a = sqrt(xmin.*xmax)/w0;
c = xmax/xmin;
d = xmin/xmax;
Vave = ((psi.^2 .* vL0)./(2.*(xmax-xmin))).*(((w.*a).^2.*(c-d))./(((w.*a).^2 + d).*((w.*a).^2+ c))); %y 
semilogx(w./1000,Vave./(10^(-6)));

grid on;
xlabel('Frequency(kHz)');
ylabel('Velocity(um/s)');
