% Programa sist_com_BPSK,
% Esta rutina genera la simulation de un sistema de comunicaciones BPSK 
%utilizando filtro formador, un filtro acoplado y un SNR predefinida 
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  
% ------ TRANSMISOR -------------------- 
% ----Se genera una serial BPSK con los siguientes datos: 
%senalBPSK=BPSK_pb(num_bits,srate,filt,muest_porbit);

clear all; close all;

num_bits=10; %Numero de bits a transmitir 
srate=.01;      %Intervalo de muestreo
filt='sqrt';   %Tipo de filtro transmisor, tambien puede ser cosa y rect 
muest_porbit=5; %Numero de muestras por bit

[filtrotrans,senalBPSK,t,senaldig]=BPSK_pb(num_bits,srate,filt,muest_porbit);
%[filtrotrans,senalBPSK,t,senaldig]=QPSK_pb(num_bits,srate,filt,muest_porbit);

%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  
% ------------ CANAL CON RUIDO ADITIVO -------------------------- 
%— Se toma la señal y se le suma un ruido con potencia tal que se tiene una relacion 
% señal a ruido especificada 
%senal_masruido=awgn(SNR_deseado_dB,senalBPSK); 
SNR_deseado_dB = 5; 
senal_masruido = awgn(SNR_deseado_dB,senalBPSK);

%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  
% ------ RECEPTOR CON FILTRO ACOPLADO --------------
%La señal es pasada a travez de un filtro acoplado al filtro de transmisor 
%para maximizar Ia relaciOn sepal a ruido 
senal_recib=matched_filter(filtrotrans,senal_masruido);

%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
%------------- DISPOSITIVO DE DECISION ------------- 
% La señal recibida es pasada por el circuido de decision 
% que regresa el vector de bits detectados, asi como el niimero de bits erroneos contados 
umbral=0; 
[num_bits_erroneos,bits_detectadosj]=decision(umbral,senal_recib,num_bits,muest_porbit,t,senaldig,srate);

%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
% ------ GRAFICACION BER TEORICO Y SIMULADO --------------
% Los bits con error se grafican sobre la curva teórica. La señal recibida es pasada por el circuito de decisión
%que regresa el vector de bits detectados, así como el número de bits erróneos contados
grafica_BERySNR(SNR_deseado_dB, num_bits_erroneos, num_bits);
