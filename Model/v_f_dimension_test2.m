%%% physical constants %%%
pi = pi();
eps0 = 8.85e-12; %vacuum permittivity
epsr = 80; %relative permittivity (water @ 20 degree)
eta = 1.003e-3; %viscosity
sigma = 2.5e-6/1e-2; %conductivity S/m
T = 293; %absolute temperature
kBoltzmann = 1.38e-23; %Boltzmann constant
e = 1.6e-19; %electron charge
Na = 6.022e23; %Avogadro number
Z = 1; % ion valence, assuming we have K+ and Cl- ions
c0 =0.01e-3*1000; % concentration mol/m3 ;

%%% design parameters %%%
%%% test 2 %%%
L = [25e-6,20e-6,15e-6,10e-6];  % large electrode length
S = [5e-6,5e-6,5e-6,5e-6]; % small electrode length
G = [5e-6,5e-6,5e-6,5e-6]; % inter electrode gap

h = 50e-6; % channel height
ltot = 3e-2; % channel length
Psi0 =1.5; % potential amplitute
for i = 1:4
    lpair = 2*(L(i)+G(i)+S(i)); %spatial period of the array
    larray = 100*100e-6; %length of the electrode array
    lel = L(i)*larray/lpair; % only the L electrode generates forward velocity
    gamma = lel/ltot; % ratio electrode along the channel to channel length
    sidesElectr = 1; % sides with electrodes
    beta = sidesElectr/4; % factor for average velocity above electrodes
    %%% derived parameters %%%
    k = L(i)/S(i);
    xmax = (G(i)+L(i)+S(i)) /( sqrt(k) + 1/sqrt(k)); %normalised electrode end coord.
    xmin = G(i) /( sqrt(k) + 1/sqrt(k)); %normalised electrode start coordinate
    %Debye length
    lambdaD = sqrt( eps0*epsr*kBoltzmann*T / (2*c0*(Z^2)*(e^2)*Na) );
    %ionic strength: 1/2*(c0*1*(1^2) + c0*1*(1^2))
    %%% Equation parameters
    vL0 = eps0*epsr / (2*eta*sqrt(k)*(1+k)^2); % maximum velocity
    omega0 = 2*lambdaD*sigma / (eps0*epsr*pi); % optimal angular freq.
    %%% computations (as a function of frequency) %%%
    f = 0:0.01:100000; % frequency
    o = 2*pi*f; % angular frequency
    K1 = Psi0.^2 * vL0 / (2 * (xmax-xmin));
    K2 = ((o*sqrt(xmin*xmax)/omega0).^2) * (xmax/xmin-xmin/xmax);
    k1 = (sqrt(xmin*xmax)/omega0)^2;
    k2 = (sqrt(xmin*xmax)/omega0)^2;
    K3 = (k1.*o.^2+xmin/xmax) .* (k2.*o.^2+xmax/xmin);
    vLave = K1 .* K2 ./ K3; % average velocity on electrode surface
    semilogx(f,(vLave*beta*gamma)/10^(-6)) % plot max velocity of Poiseuille flow
    hold on;
end

%%% coments for dimension & frequency %%%
    % test 2
title('Velocity vs. Frequency & electrodes dimensions (1.5V)')
legend({'25-5-5\mum','20-5-5\mum','15-5-5\mum','10-5-5\mum'},'Location','northwest')
text(20,40,'c_0 = 0.01mM','FontSize',9);
xlim([10 100000])
xlabel('Frequency / Hz')
ylabel('Simulated x-velocity / \mum/s')
