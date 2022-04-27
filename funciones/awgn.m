% Programa awgn.m 
function senal_masruido=awgn(SNR_deseado_dB,senalBPSK,t); 
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&. 
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
%function senaLmasruido=awgn(var,senalBPSK); 
%Este programa toma una renal senaltrans y le suma una componente de ruido aditivo gauwano con varianza 
%especificada tal que cumple con la SNR deseada en dB; se considera que el 
%filtro de transmisor estan normalizados con energia unitaria 
%solo se necesita variar la potencia del ruido para especificar una cierta 
% relacion sepal a ruido
%t =  length(senalBPSK);
%Se define (a senñal digital y pasada por el modulador ) 
SNR_deseado=exp((SNR_deseado_dB)*(1/10)*log(10)); 
var_ruido=(1/(2*SNR_deseado)); 
ruido=sqrt(var_ruido)*randn(1,length(senalBPSK)); 
senal_masruido=ruido+senalBPSK; 
figure; 
plot(t,senalBPSK); 
axis([-.1 .1 -1.5 1.5]);
hold on;
plot(t,senal_masruido, 'r');  
hold off;
%FIN DE PROGRAMA awgn.m  
