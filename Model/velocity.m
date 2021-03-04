psi = 0: 0.0001: 1.2; %potential between two electrodes % Fig.5(a)
%psi = 0.8; % Fig. 3
%psi = 0.2; % Fig. 10
vL0 = 2.82 * 10^(-9); %velocity of the large electrode
w0 = 0.03318; % ¦Ø0
xmin = 1.6 * 10^(-6);
xmax = 12 * 10^(-6);
%w = 0.1*1000:1:100*1000; % Fig. 3 & 10
w = 7572; %used for V vs.Vrms Fig. 5(a)
a = sqrt(xmin.*xmax)/w0;
c = xmax/xmin;
d = xmin/xmax;
Vave = ((psi.^2 .* vL0)./(2.*(xmax-xmin))).*(((w.*a).^2.*(c-d))./(((w.*a).^2 + d).*((w.*a).^2+ c))); %y 
plot(psi,Vave./(10^(-6))); % Fig. 5(a)
yticks(0:20:150) % Fig. 5(a)
%semilogx(w./1000,Vave./(10^(-6))); % Fig. 3
title('The fluid velocity at an applied frequency of 1.21kHz with Eq.(1) as Fig.5(a)');

grid on;
%xlabel('Frequency(kHz)');
xlabel('Voltage applied(V_r_m_s)')
ylabel('*Velocity_{max}(¦Ìm/s)');
