lambda_D = 4.56*10^(-9);
sigma = 0.018;
k = 6.12;
v_L0 = 2.82*10^(-9);
x_min = 1.6*10^(-6);
x_max = 12*10^(-6);
% Psi_0 = 0.1;
omega = 2 * pi * 1000;
l = 0.235;
epsilon = 80;
A = ((2*lambda_D*sigma)^2+(omega*epsilon*pi*x_max)^2)/((2*lambda_D*sigma)^2+(omega*epsilon*pi*x_min)^2);
theta = atan((2*lambda_D*sigma*omega*epsilon*pi*(x_max-x_min))/((2*lambda_D*sigma)^2+(omega*epsilon*pi)^2*x_min*x_max));
Z = pi*(sqrt(k)+1/sqrt(k))/(2*l*sigma*sqrt((log(A))+i*theta));
semilogx(Psi_0/sqrt(2),Z/1000);
xlabel()