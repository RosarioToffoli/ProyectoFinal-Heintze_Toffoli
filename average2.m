function x=average2(x,win)

c   = cumsum(x)./win;    % suma todo dentro de la ventana y divide por el largo de la ventana 
x   = [c(win,:); c(win+1:end,:)-c(1:end-win,:)]; 