
%% Este programa calcula el índice de sincronía de fase 
function R = calculo_indice_sincronia(d,n1,n2,sf,f,win)

NF      = sf/2 ;  % Freceuncia de sampleo dividido 2
x       = [d(:,n1) d(:,n2)]; %Tomamos los canales de la matriz de datos
x       = pre(x,sf);  % Función que crea y aplica un filtro Butterworth 
                      %pasa alto de sexto orden 
b       = fir1(100,[f-2 f+2]./NF );  %Crea el filtro fir 1 de orden 100 
                                     % pasa banda 
h       = filtfilt(b, 1, x); % Aplica el filtro fir 1
h       = hilbert(h); % Transformada de hilbert. 
                      %Se obtiene la fase instantánea de cada canal

h       = angle(h);  % Nos quedamos con las fases
R       = exp(1i.*(diff(h')))'; % Cálculo de la diferencia entre las fases 

R       = average2(R,win);%Función que realiza el valor medio sobre una 
                           %ventana corrediza de ancho win.

R       = abs(R); %Tomamos el valor absoluto
 R=R(~isnan(R)); %Le sacamos los primeros valores NaN