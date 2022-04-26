function    [Tx_sig,cuadrature,phase] =    QPSK_mod(data,freq,t);

if(mod(length(data),2) ~= 0)
   data = [data zeros(1)]; % padding a zero
end
s_p_data=reshape(data,2,int32(length(data)/2));  % S/P convertion of data

cuadrature = s_p_data(1:end-1).*cos(2*pi*(freq)*t);
phase      = s_p_data(2:end).*sin(2*pi*(freq)*t);
modulate   = cuadrature+phase;

Tx_sig = modulate;

%{
f=br; % minimum carrier frequency
T=1/br; % bit duration
t=T/99:T/99:T; % Time vector for one bit information

% XXXXXXXXXXXXXXXXXXXXXXX QPSK modulation  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
y=[];
y_in=[];
y_qd=[];
for(i=1:length(data)/2)
    y1=s_p_data(1,i)*cos(2*pi*f*t); % inphase component
    y2=s_p_data(2,i)*sin(2*pi*f*t);% Quadrature component
    y_in=[y_in y1]; % inphase signal vector
    y_qd=[y_qd y2]; %quadrature signal vector
    y=[y y1+y2]; % modulated signal vector
end
Tx_sig=y; % transmitting signal after modulation
tt=T/99:T/99:(T*length(data))/2;

figure(2)

subplot(3,1,1);
plot(tt,y_in,'linewidth',.5), grid on;
title(' wave form for inphase component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt0');

subplot(3,1,2);
plot(tt,y_qd,'linewidth',.5), grid on;
title(' wave form for Quadrature component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt0');


subplot(3,1,3);
plot(tt,Tx_sig,'r','linewidth',.5), grid on;
title('QPSK modulated signal (sum of inphase and Quadrature phase signal)');
xlabel('time(sec)');
ylabel(' amplitude(volt0');
%}