clear all; close all;

num_bits=1000; %Numero de bits a transmitir 
srate=.01;      %Intervalo de muestreo
filt='sqrt';   %Tipo de filtro transmisor, tambien puede ser cosa y rect 
muest_porbit=6; %Numero de muestras por bit

%generamos la rama igual como si fuera BPSK
[filtrotrans,senalBPSK,t,senaldig]=BPSK_pb(num_bits,srate,filt,muest_porbit);

% ------------ CONVERSION QPSK -------------------------- 
% convertimos a serie palelo y modulamos
freq=(num_bits*8)-1; %Let us transmission bit rate
[senalQPSK,cuadrature,phase] = QPSK_mod(senalBPSK,freq,t);

figure()
subplot(3,1,1), plot(t,cuadrature), grid on;;
axis([-7*srate*muest_porbit 7*srate*muest_porbit -1.1 1.1]);
title('Quadrature component in QPSK modulation ');
subplot(3,1,2), plot(t,phase), grid on;
axis([-7*srate*muest_porbit 7*srate*muest_porbit -1.1 1.1]);
xlabel('Phase');
title('Inphase component in QPSK modulation ');
subplot(3,1,3), plot(t,senalQPSK,'r','linewidth',.5), grid on;
axis([-7*srate*muest_porbit 7*srate*muest_porbit -1.1 1.1]);
xlabel('QPSK');
title('QPSK modulated signal');

% ------------ CANAL CON RUIDO ADITIVO -------------------------- 
SNR_deseado_dB = 3; 
senalQPSK_ns = awgn(SNR_deseado_dB,senalQPSK);

% ------------ CANAL CON RUIDO ADITIVO -------------------------- 
Rx_data = QPSK_demod(senalQPSK_ns,freq,t,num_bits,srate,muest_porbit);



