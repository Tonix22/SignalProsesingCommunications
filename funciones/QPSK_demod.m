function    [Z_in,Z_qd] =    QPSK_demod(Tx_sig,freq,t,num_bits,srate,muest_porbit);

Z_in = Tx_sig.*cos(2*pi*freq*t); % inphase
Z_qd = Tx_sig.*sin(2*pi*freq*t);    % quadrature
Z_in_f = real(ttof(Z_in));

figure
plot(Z_in_f)

%plot(f,Z_in_f)

%{
T = (num_bits + 10)*muest_porbit*srate; %tiempo de las muestras
t = -T/2 : srate : T/2;

senaldiscretal = zeros(1,length(t)); %se genera la señal con deltas centradas en Ts
cero   = find(t==0);
half_len = ((num_bits/2)*muest_porbit);



j=0;
before = cero-half_len;
for(i=cero-half_len+muest_porbit:muest_porbit:cero+half_len-muest_porbit)
    Z_in_intg=(trapz(t,Z_in(before:i)))*(2/T);% INPHASE
    Z_qd_intg=(trapz(t,Z_qd(before:i)))*(2/T);% QUADRATURE
    before = i;
end

Rx_data = 0;

% XXXXXXXXXXXXXXXXXXXXXXXXXXXX QPSK demodulation XXXXXXXXXXXXXXXXXXXXXXXXXX
f=br; % minimum carrier frequency
T=1/br; % bit duration
t=T/99:T/99:T; % Time vector for one bit information

Rx_data=[];
Rx_sig=Tx_sig; % Received signal
for(i=1:1:Tx_sig/99)

    %%XXXXXX inphase coherent dector XXXXXXX
    Z_in=Rx_sig((i-1)*length(t)+1:i*length(t)).*cos(2*pi*f*t); 
    % above line indicat multiplication of received & inphase carred signal
    
    Z_in_intg=(trapz(t,Z_in))*(2/T);% integration using trapizodial rull
    if(Z_in_intg>0) % Decession Maker
        Rx_in_data=1;
    else
       Rx_in_data=0; 
    end
    
    %%XXXXXX Quadrature coherent dector XXXXXX
    Z_qd=Rx_sig((i-1)*length(t)+1:i*length(t)).*sin(2*pi*f*t);
    %above line indicat multiplication ofreceived & Quadphase carred signal
    
    Z_qd_intg=(trapz(t,Z_qd))*(2/T);%integration using trapizodial rull
        if (Z_qd_intg>0)% Decession Maker
        Rx_qd_data=1;
        else
       Rx_qd_data=0; 
        end
        Rx_data=[Rx_data  Rx_in_data  Rx_qd_data]; % Received Data vector
end


figure(3)
stem(Rx_data,'linewidth',3) 
title('Information after Receiveing ');
axis([ 0 11 0 1.5]), grid on;
%}