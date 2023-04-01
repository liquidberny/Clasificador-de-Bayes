Map_Maligno = Train(:,11)==4;
Malignos=Train((Map_Maligno), :);

Map_Benigno = Train(:,11)==2;
Benignos=Train((Map_Benigno), :);

Num_malignos=size(Malignos, 1);
Num_Benignos=size(Benignos, 1);

tot_train = size(Train,1);

Prob_M = Num_malignos/tot_train;
Prob_B = 1-Prob_M;

Map_Maligno_T = Train(:,11)==4;
Train_M = Train((Map_Maligno_T), :);

Map_Benigno_T = Train(:,11)==2;
Train_B=Train((Map_Benigno_T), :);

A=unique(Train_M(:, 2:10));

%Codigo para hacer conteo de Benignos

%Sacamos los valores unicos de la matriz A:
U = unique(A);

%Contamos cuantos valores unicos tengo en A
SU =size(U);

%Inicializamos un vector de tamalo 10 x 10 iniciandolo en cero
conteoBenigno=zeros(10,10);

%Este es un for que va a ir de uno hasta el primer elemento del tamaño de
%los unicos que haya tenido en A.
for c=1:SU(1)
    %vamos a sacar un mapa de cuantos elementos en Train_B son iguales a
    %los elementos del vector unico
    mapBenigno=Train_B==U(c);
    
    %Como el mapa te va a dar ceros y unos le sumamos un uno para no
    %manejar ceros
    conteoBenigno(c,:)=((sum(mapBenigno))+ 1);
end

%Al final de este for nos queda el vector con frecuencias de los Benignos
conteoBenigno;

%Concatenamos en una matriz
TablaConteoBenigno=[U,conteoBenigno]; 

%Codigo para hacer conteo de Malignos
U = unique(A);
SU =size(U);
conteoMaligno=zeros(10,10);
for c=1:SU(1)
    mapMaligno=Train_M==U(c);
    conteoMaligno(c,:)=((sum(mapMaligno))+ 1);
end
conteoMaligno;
TablaConteoMaligno=[U,conteoMaligno] ;
