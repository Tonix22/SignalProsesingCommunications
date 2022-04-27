% Programa matched_filter.m 
function senal_recib=matched_filter(filtrotrans,senal_masruido,t); 
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
%function senal_recib=matched_filter(filtrotrans,senal_masruido); 
%Este programa toma una senal masruido y la pasa por un filtro acoplado para mayor inmunidad 
%ante el ruido; 
%el filtro es filtro trans; 
filtro_acoplado=zeros(1,length(filtrotrans)); 
for i=1:length(filtrotrans); 
    filtro_acoplado(i)=filtrotrans(length(filtrotrans)+1-i); 
end; 
senal_recib=convrec(filtro_acoplado,senal_masruido); 
%senal_recib=senal_masruido; %  linea para pregunta de capitulo  
figure; 
subplot(2,1,1), 
plot(t,filtro_acoplado);
axis([-.1 .1 -0.15 1.5]); 
xlabel('Window of Filter');
subplot(2,1,2), 
plot(t,senal_recib);
axis([-.07 .07 -1.8 1.8]);
xlabel('Signal Filtered'); 
%FIN DE PROGRAMA matchedfilter.m

%ylabel('Probabilidad de bits erroneos'); 