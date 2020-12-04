
%% Este programa calcula la sincron�a y la variabilidad de la sincon�a
function [MRmean, MRstd] = calculo_sincronia_variabilidad (d,sf,f,win)

[l, a]=size(d); % Guardamos las dimensiones de la matriz de datos 
Nchan = size(d,2); % Guardamos el n�mero de canales 


C = nchoosek(1:Nchan,2); % Se genera una matriz que contiene todas 
                         % las combinaciones posibles de los elementos 
                         % del vector tomados de a dos 
[lC, aC]=size(C); % Guardamos las dimensiones de la matriz combinaciones

%Defino las matrices donde se almacenan la sincronia y la variabilidad
%de la sincron�a
MRmean=zeros(Nchan,Nchan);
MRstd=zeros(Nchan,Nchan);

for i = 1:length(C)
    % Se obtiene el �ndice de sincron�a de fase
     R = calculo_indice_sicronia (d,C(i,1),C(i,2),sf,f,win); 
    MRmean(C(i,1),C(i,2)) = mean(R); % C�lculo de la sincronia
    MRstd(C(i,1),C(i,2)) = std(R); % C�lculo de la variabilidad de la 
                                   % sincron�a  
end
    MRmean=MRmean+MRmean';
    MRstd=MRstd+MRstd';

    
    
