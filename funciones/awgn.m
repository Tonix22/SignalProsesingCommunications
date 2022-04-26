% Programa awgn.m 
function senal_masruido=awgn(SNR_deseado_dB,senalBPSK); 
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&. 
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
%function senaLmasruido=awgn(var,senalBPSK); 
%Este programa toma una renal senaltrans y le suma una componente de ruido aditivo gauwano con varianza 
%especificada tal que cumple con la SNR deseada en dB; se considera que el 
%filtro de transmisor estan normalizados con energia unitaria 
%solo se necesita variar la potencia del ruido para especificar una cierta 
% relacion sepal a ruido

%Se define (a senñal digital y pasada por el modulador ) 
SNR_deseado=exp((SNR_deseado_dB)*(1/10)*log(10)); 
var_ruido=(1/(2*SNR_deseado)); 
ruido=sqrt(var_ruido)*randn(1,length(senalBPSK)); 
senal_masruido=ruido+senalBPSK; 
%figure(2); 
%subplot(2,1,1), 
%plot(t,senalBPSK); 
%subplot(2,1,2), 
%plot(senal_masruido);  
%FIN DE PROGRAMA awgn.m  
