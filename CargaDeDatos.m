
%Heintze Stefan�a y Toffoli Rosario. 
%%
clear all
close all
clc
%% An�lisis para ojos cerrados
dirName= 'Nombre de LA CARPETA donde se encuentran los DATOS '; 
GuardoArchivos=dir(['dirName /*.mat']);  %Se guardan los archivos de todos
                                         %los pacientes 
% Se definen las frecuencias centrales 
FCdelta=3;
FCtheta=5;
FCalfa=10;
FCbeta=15;
FCgamma=35;
% Se define un vector de 5 frecuencias centrales de cada banda 
%de inter�s a analizar.
vfrec=[FCdelta, FCtheta , FCalfa , FCbeta , FCgamma];

% Se definen dos matrices de 5 celdas ( una celda para cada frecuencia)
CantFrecuencias=5;
NumColumnas=1;
McellMeanEC=cell(CantFrecuencias,NumColumnas);
McellStdEC=cell(CantFrecuencias,NumColumnas);

% Se definen dos matrices c�bicas
% una para sincron�a y otra para variabilidad de la sincron�a. 
% Para eso necesitamos conocer el numero de registros y de canales
CantRegistros=length(GuardoArchivos); 
NumCanales=64; 
McubMean=zeros(NumCanales,NumCanales,CantRegistros);
McubStd=zeros(NumCanales,NumCanales,CantRegistros);   
      
for ifrec= 1:CantFrecuencias
 for ifile=1:CantRegistros;   
  %Se cargan los  datos del paciente
  load(['dirName/',GuardoArchivos(ifile).NombreRegistro]); 
  % Se guardan los registros del paciente en la matriz M
  M=RegistroX.data(1:NumCanales,:)'; 
  sf=FrecuenciaMuestreo; % Frecuencia de muestreo
  win=sf; % Ventana de un ancho igual a la frecuencia de muestreo
            % para realizar un suavizado de la se�al resultante.

  % Se obtiene la matriz sincron�a y variabilidad de la sincro�a       
 [MRmean, MRstd] = calculo_sincronia_variabilidad (M,sf, vfrec(ifrec),win); 
    
 
  end

McellMeanEC{ifrec}=McubMean;  % Se almacena en la celda la matriz
                              %sincron�a del paciente correspondiente

McellStdEC{ifrec}=McubStd; % Se almacea en la celda la matriz variabilidad 
                            %de la sincron�a del paciente correspondiente 
end