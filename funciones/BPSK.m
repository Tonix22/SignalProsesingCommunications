
function x = bpskd(g,f) % g es cantidad de bits, f es frecuencia de portaora?
%Modulation  BPSK
%Example:
%bpskd([1 0 1 1 0],2)
if nargin > 2
    error('Too many input arguments');
elseif nargin==1
    f=1;
end
if f<1;
    error('Frequency must be bigger than 1');
end
t=0:2*pi/99:2*pi;   % tiempo ventana
cp=[];      %   
sp=[];      %   ??
mod=[];     %   moduladora?
mod1=[];    %   modulada?
bit=[];     %   bit stream
for n=1:length(g);

    if g(n)==0;
        die=-ones(1,100);   %Modulante
        se=zeros(1,100);    %Señal
    else g(n)==1;
        die=ones(1,100);    %Modulante
        se=ones(1,100);     %Señal
    end
    c=sin(f*t);     %   declaracion seno
    cp=[cp die];    %   -sen y sen cuando es 1 u 0 el bit 
    mod=[mod c];    %   forma de señal sen en arreglo
    bit=[bit se];   %   sen y cero cuando es 1 u 0 el bit de regreso 
end
x = cp.*mod;        % convolucion señal con portadora
figure(1)
plot(bit,'LineWidth',1.5);
title('Binary Signal');
axis([0 100*length(g) -2.5 2.5]);
figure(2)
plot(x,'LineWidth',1.5)
title('ASK modulation');
axis([0 100*length(g) -2.5 2.5]);
end

