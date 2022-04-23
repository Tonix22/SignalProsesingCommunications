
function [num_bits_erroneos, bits_detectados] = decision(umbral,senal_recib,num_bits,muest_porbit,t,senaldig,srate) ;
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
%funCtion [num_bits_erroneos,bits_detectados]= decision(umbral,senal_recib,num_porbit) 
%Este programa toma una serial despues del filtro acoplado senal_recib, y la pasa por el circuito de deteccion 
% que decide en base al umbral, el valor del bit recibido y a sepal detectada; 
% necesita el nUmero de bits y el 6rnero de muestras por bit para sincronizarse a partir de cero 
% Regresa tambien el numero de bits erroneos 
%sincronia1bit=cero; 
muestreador=zeros(1,length(t)); %se genera la senal con deltas centradas en Ts 
cero=find(t==0); 
muestreador(cero-((num_bits/2)* muest_porbit): muest_porbit:cero+((num_bits/2)* muest_porbit)- muest_porbit)=1; 
senal_muestreada=muestreador.*senal_recib; 
senal_detectada=zeros(1,length(num_bits)); 
senal_detectada=senal_muestreada(cero-((num_bits/2)*muest_porbit):muest_porbit:cero+((num_bits/2)*muest_porbit)-muest_porbit); 
for i=1:num_bits; 
    if senal_detectada(i)>=umbral 
        senal_detectada(i)=1; 
    else 
        senal_detectada(i)=0; 
    end; 
end; 
bits_detectados=senal_detectada; 
num_bits_erroneos=sum(xor(senaldig,bits_detectados)) 
figure; 
subplot(2,1,1), plot(t,senal_recib); 
hold on;
subplot(2,1,1), stem(t,senal_muestreada,'r'); 
axis([-7*srate*muest_porbit 7*srate*muest_porbit -2.2 2.2]); 
xlabel('Señal a la salida del filtro acoplada, y decision del muestreador'); 
hold off; 
subplot(2,1,2), plot(t,senal_recib); 
hold on; 
subplot(2,1,2), stem(t,senal_muestreada,'r'); 
axis([-7*srate*muest_porbit 7*srate*muest_porbit -2.2 2.2]); 
xlabel('Señal a la salida del filtro acoplada, y valores del muestreador'); 
hold off; 
%figure(5); 
%subplot(2,1,1), stem(senaldig); 
%hold on; 
%subplot(2,1,1), stem(.5*bits_detectados,'r'); 
%hold off; 
%----------FIN DE PROGRAMA decision.m ----------------- %
