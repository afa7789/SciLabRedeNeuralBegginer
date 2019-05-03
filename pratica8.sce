clear
clc
close

function [W,b,Y,ErroE] = perceptron(max_it,alpha,X,D)
    W = rand(size(D,1),size(X,1));
    b =  rand(size(D,1),1); //rand(numero de linha,numero de coluna)
    t=1; E=1;
    N = size(X,2);
    while(t<max_it & E>0)
        E=0;
        for i = 1:N
            Y(:,i) = (W*X(:,i) + b)>=0;
            e = D(:,i) - Y(:,i);
            W = W + alpha*e*X(:,i)';
            b = b + alpha*e;
            E = E + (e'*e);
        end
        ErroE(t) = E;
        t=t+1;
    end
endfunction

function [acertos,taxaAcertos] = teste(W,b,X,d)
    acertos=0
    taxaAcertos=0
    N=size(X,2)
    for i = 1:N
        Y(:,i) = (W*X(:,i) + b)>=0;
        //disp(Y)
       // disp(string(i) +"-" + "Teste: "+ string(Y(:,i)') + " Resutlado: " + string(d(:,i)') )
        if ( bool2s(Y(:,i)) ==  d(:,i))
            acertos = acertos+1;
        end
    disp(acertos);
    taxaAcertos= acertos/N;
    end
endfunction

function [MatrixOrdenadaTreino,MatrixOrdenadaTeste] = MatrixOrdenadaPorIndice(matrixAOrdenar,vetorOrdem,ondeDivide)
    N = size(vetorOrdem,2);
    for i = 1:ondeDivide
        MatrixOrdenadaTreino(:,i)=matrixAOrdenar(:,vetorOrdem(i));
    end
    for j = ondeDivide+1:N
        MatrixOrdenadaTeste(:,j-ondeDivide)= matrixAOrdenar(:,vetorOrdem(j));
    end
endfunction

X1 = csvRead('dados.data');
max_it = 10;
a = 0.1;
n= size(X1,1);
iterFinalTestes=floor(n*0.7);
ordemIndices=grand(1,"prm", (1:n));
matriix= resize_matrix(X1',size(X1,2),size(X1,1));
matrixX= matriix(1:4,:);
matrixD= matriix(5:7,:);
[matrixTreinoX,matrixTesteX]= MatrixOrdenadaPorIndice(matrixX,ordemIndices,iterFinalTestes)
[matrixTreinoD,matrixTesteD]= MatrixOrdenadaPorIndice(matrixD,ordemIndices,iterFinalTestes)
[W,b,Y,ErroE]= perceptron(max_it,a,matrixTreinoX,matrixTreinoD);
[acertos,TaxaAcerto] = teste(W,b,matrixTesteX,matrixTesteD);
disp(length(ErroE))
plot( [1:length(ErroE)] ,ErroE )
disp("taxa de acertos: " + string(TaxaAcerto) +" acertos: " +string(acertos) )
