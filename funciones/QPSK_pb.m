function    [filtrotrans,senalBPSK,t,senaldig] =    QPSK_pb(num_bits,srate,filt,muest_porbit);
    %% Descripcion
    
    % function senal_BPSK=BSPK_pb(num_bits,srate,filt,muestr_porbit);
    
    %   Este progama genera una señal modulada QPSK en su representacion compleja pasabajas
    %   num_bits    : especifica el numero de bits a transmitir, debe ser numero par y mayor a 100;
    %   srate       : especifica el intervalo de muestreo
    %   filt        : especifica si se utiliza un filtro 
    %                'cosa' para coseno alzado, 
    %                'sqrt' para raiz de coseno alzado
    %                'rect'    para un filtro rectangular
    %  muest_porbit : especifica el numero de muestras por bit que se 
    %                 utilizaran en la simulacion, debe ser numero impar
    
    %% Implementacion

    senaldig = round(rand(1,num_bits)); %se puede utilizar se senaldig=randint(1,n)
    data_NZR = 2*senaldig-.5; % Data Represented at NZR form for QPSK modulation
    s_p_data = reshape(data_NZR,2,length(senaldig)/2);  % S/P convertion of data

    br=srate; %Let us transmission bit rate  1000000
    f=br; % minimum carrier frequency
    bT=1/br; % bit duration
    t=bT/100:bT/100:bT; % Time vector for one bit information

    % XXXXXXXXXXXXXXXXXXXXXXX QPSK modulation  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    y=[];
    y_in=[];
    y_qd=[];
    for(i=1:length(senaldig)/2)
        y1=s_p_data(1,i)*cos(2*pi*f*t); % inphase component
        y2=s_p_data(2,i)*sin(2*pi*f*t) ;% Quadrature component
        y_in=[y_in y1]; % inphase signal vector
        y_qd=[y_qd y2]; %quadrature signal vector
        y=[y y1+y2]; % modulated signal vector
    end
    QPSK=y; % transmitting signal after modulation
    half = (bT*length(senaldig))/2;
    t=-half/2:bT/100:half/2-bT/100;

    
    % Se produce la señal con el filtro formador
    
    %T = (bT)*muest_porbit*srate;
    %t = -T/2 : srate : T/2;
    
    senaldiscretal = zeros(1,length(t)); %se genera la señal con deltas centradas en Ts
    %se generala señal con deltas centrada en Ts
    senaldiscretal(1: muest_porbit*num_bits : end) = data_NZR;

    cero   = find(t==0);
    %% Se definen los valores de los pulsos
    pulsocuadrado   = zeros(1,length(t));
    pulsocuadrado(int64(cero-((bT-1)/2)) : int64(cero+((bT-1)/2))) = 1;
    
    frcosine = zeros(1,length(t));
    if filt=="sqrt"
        raised = rcosine(1,floor(bT/6),'sqrt');
        frcosine(cero-(length(raised)-1)/2:cero+(length(raised)-1)/2) = raised;
    else
        raised = rcosine(1,floor(bT/6));
        frcosine(cero-(length(raised)-1)/2:cero+(length(raised)-1)/2) = raised;
    end
    %% Elección del filtro
    if  filt=="rect"
        filtrotrans =   pulsocuadrado;
    else
        filtrotrans =   frcosine;
    end
    
    % estandirazion del filtro
    filtrotrans =   filtrotrans/sqrt(filtrotrans*filtrotrans');
    
    %---Se convolucionan los datos con el filtro transmisor
    senalBPSK   =   convrec(QPSK,filtrotrans);
    
    %---Se grafican los resultados
    figure;
    subplot(2,1,1), plot(t,senalBPSK);
    axis([-bT/2*num_bits bT/2*num_bits -8.2 8.2]);
    xlabel('Señal QPSK generada en tiempo');
    hold on;
    subplot(2,1,1), stem(t,senaldiscretal, 'r');
    hold off;
    subplot(2,1,2), plot(t,filtrotrans);
    axis([-bT/2 bT/2 -.03 .3]);
    xlabel('Filtro de Transmisor Seleccionado');
    
    %------------------------- FIN DE FUNCION BPSK_pb.m ----------------------------
    
    
    
    