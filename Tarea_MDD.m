%Para empezar mapeamos los datos de CasosTrainTestWisconsin. Usamos la
%variable Train para distingir los casos Benignos y Malignos
Map_Maligno = Train(:,11)==4;
Malignos=Train((Map_Maligno), :);

Map_Benigno = Train(:,11)==2;
Benignos=Train((Map_Benigno), :);

%Variable con el numero de casos benignos y malignos
Num_malignos=size(Malignos, 1);
Num_Benignos=size(Benignos, 1);

%Total de valores en train
tot_train = size(Train,1);

%Calculamos dividiendo el nummero de casos malignos sobre el total para
%obtener la probabilidad de ser maligno. 
Prob_M = Num_malignos/tot_train;
%Para obtener los benignos se le resta a 1 la probabilidad de malignos
Prob_B = 1-Prob_M;

%Mapamos los datos malignos usando Train, tomando el id del final de la
%matriz
Map_Maligno_T = Train(:,11)==4;
Train_M = Train((Map_Maligno_T), :);
%Mapamos los datos benignos usando Train, tomando el id del final de la
%matriz
Map_Benigno_T = Train(:,11)==2;
Train_B=Train((Map_Benigno_T), :);

%Antes de seguir, se modificaron ambos Train_B y Train_M eliminando la
%primera columna ya que era un id de referencia y no nos es util

%Sacamos los datos unicos de Train_M
A=unique(Train_M(:, 2:10));

%Codigo para hacer conteo de Benignos

%Sacamos los valores unicos de la matriz A:
U = unique(A);

%Contamos cuantos valores unicos tengo en A
SU =size(U);

%Inicializamos un vector de tamalo 10 x 10 iniciandolo en cero
conteoBenigno=zeros(10,10);

%Este es un for que va a ir de uno hasta el primer elemento del tama�o de
%los unicos que haya tenido en A.
for c=1:SU(1)
    %vamos a sacar un mapa de cuantos elementos en Train_B son iguales a
    %los elementos del vector unico
    mapBenigno=Train_B_Copia==U(c);
    
    %Como el mapa te va a dar ceros y unos le sumamos un uno para no
    %manejar ceros
    conteoBenigno(c,:)=((sum(mapBenigno))+ 1);
end

%Al final de este for nos queda el vector con frecuencias de los Benignos
conteoBenigno;

%Concatenamos en una matriz
TablaFreqBenigno=[U,conteoBenigno]; 

%Codigo para hacer conteo de Malignos

%Reutilizaremos los valores unicos de la matriz (U) y el numero de de
%valores unicos que tenemos en A (SU)

%Inicializamos un vector de tamalo 10 x 10 iniciandolo en cero
conteoMaligno=zeros(10,10);

%Este es un for que va a ir de uno hasta el primer elemento del tama�o de
%los unicos que haya tenido en A.
for c=1:SU(1)
    %vamos a sacar un mapa de cuantos elementos en Train_M son iguales a
    %los elementos del vector unico
    mapMaligno=Train_M_Copia==U(c);
    
    %Como el mapa te va a dar ceros y unos le sumamos un uno para no
    %manejar ceros
    conteoMaligno(c,:)=((sum(mapMaligno))+ 1);
end
%Al final de este for nos queda el vector con frecuencias de los Malignos
conteoMaligno;

%Concatenamos en una matriz
TablaFreqMaligno=[U,conteoMaligno] ;

%Lo que sigue obtener Normalizaci�n, cada celda se divide por la suma de
%los valores de la columna
sumaBenigno= sum(conteoBenigno);
normBenignos= conteoBenigno/sumaBenigno(1);% Es el mismo valor para todas las columnas, as� que tomamos una al azar.

sumaMaligno= sum(conteoMaligno);
normMalignos=conteoMaligno/sumaMaligno(1);% Es el mismo valor para todas las columnas, as� que tomamos una al azar.

%Concatenamos en una matriz para malignos y benignos
TablaNormBenigno =[U,normBenignos];
TablaNormMaligno =[U,normMalignos];


%Intentaremos predecir la probabilidad de malignidad de una muestra del set
%de test. Despu�s la probabilidad de ser un tumor benigno y se le asignar�
%un diagn�stico basado en la probabilidad m�s alta.


% Tomaremos la primera muestra del set test y calculamos la probabilidad de que sea un tumor maligno
num_reg=1;
S= Test;
%Probablididad que la muestra sea maligna
ProbsM=Prob_M; 
%numero de columnas empezamos de 1 ya que eliminamos la primera columna con
%los identificadores
num_cols= size(A,1); 
for col=1:num_cols
    valor= S(num_reg, col);
    idx= find(TablaFreqMaligno(:, 1)==valor);
    ProbsM = ProbsM .* normMalignos(idx, col);

end

%Probablididad que la muestra sea benigna
ProbsB=Prob_B; 
%numero de columnas empezamos de 1 ya que eliminamos la primera columna con
%los identificadores
num_cols= size(A,1); 
for col=1:num_cols
    valor= S(num_reg, col);
    idx= find(TablaFreqBenigno(:, 1)==valor);
    ProbsB = ProbsB .* normBenignos(idx, col);

end


