function s=pre(x,sf)
[b,a] = butter(6,1/(sf/2),'high');  %crea el filtro butter con los parametros
s=filtfilt(b,a,x);                  % aplica el filtro butter 