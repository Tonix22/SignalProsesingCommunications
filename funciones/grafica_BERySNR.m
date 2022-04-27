% Programa grafica_BERySNR.m 
function grafica_BERySNR(SNR_deseado_dB,num_bits_erroneos,num_bits); 
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 
%function grafica_BERySNR(SNR_deseado,num_bits_erroneos,num_bits); 
%Este programa grafica la curva de BER contra relacion serial a ruido teorica, 
%asi como el punto de la simulacion obtenida 
SNR_teorico_dB = 0:.1:10;
exp_arg = SNR_teorico_dB*log(10)/10;
SNR_teorico = exp(exp_arg);
prob_error  = Qfunc(sqrt(SNR_teorico*2)); 
figure; 
semilogy(10*log10(SNR_teorico),prob_error); 
SNR_deseado=exp((SNR_deseado_dB)*log(10)/10); 
SNR_sim=SNR_deseado; 
pber_sim=num_bits_erroneos/num_bits; 
hold on; 
semilogy(10*log10(SNR_sim),pber_sim,'rd'); 
xlabel('10"log10(Eb/N0)'); 
ylabel('Probabilidad de bits erroneos'); 
hold off; 
%-------- FIN DE PROGRAMA grafica_BERySNR.m ------------