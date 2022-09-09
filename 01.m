
%m = numero de equa�oes = n de linhas da matriz A
%n = numero de ingonitas = n de linhas da matriz B = n de colunas da matriz A
%1 = n de colunas da matriz B


[m,n] = size (A);
%A primeira a��o � organizar os pivos 

for i = 1 : m - 1;
  for j = 2 : m;
    if (A (i,i)==0)
      troca = A (i,:);
      A (i,:) = A (m, :);
      A (m, :) = troca;
      
      troca = B (i,1);
      B (i,1) = B (m, :);
      B (m, :) = troca;
     endif
   endfor
endfor

disp("Matriz A ap�s organizar os piv�s. Lembrando que ela � formada pelos coeficientes que multiplicam as incognitas");

A

disp("Matriz B ap�s organizar os piv�s. Lembrando que ela � formada pelos termos independentes");
B

% A segunda a��o � realizar o escalonamento

for i = 1 : m - 1; 
  for j = i+1 : m; 
      a = A (j,i); 
      b = A (i,i);
      B (j,1) = a * B (i,1) - b * B (j,1);
      A (j,:) = a * A (i,:) - b * A (j,:);
   endfor
endfor

disp("Matriz A ap�s ser escalonada. Lembrando que ela � formada pelos coeficientes que multiplicam as incognitas");
A

disp("Matriz B ap�s ser escalonada. Lembrando que ela � formada pelos termos independentes");
B


%antes de simplificar, temos de transformar todos os numeros em inteiros
x=2;
for i = 1 : m;
    for j = 1 : n;
        y= A (i,j);
        e =int32 (y);
        if (y~=e) 
            do
                y=y*x;
                e =int32 (y);
                x=x+1;
            until (y==e);
            x=x-1;
            for j = 1 : n;
                A(i,j)= (A(i,j))*x;
            endfor
            B(i,1)= (B(i,1))*x;  
        endif
    endfor
      y= B (i,1);
      e =int32 (y);
      if (y~=e) 
          do
              y=y*x;
              e =int32 (y);
              x=x+1;
          until (y==e);
          x=x-1;
          for j = 1 : n;
              A(i,j)= (A(i,j))*x;
          endfor
          B(i,1)= (B(i,1))*x;
        endif  
endfor

    


% A ultima a��o � simplificar as matrizes
for i = 1 : m; %cada la�o ir� simplificar uma linha
  h=A (i,i); %pivo pois ele necess�riamente n�o � nulo
  f=1; % numero que dividira toda a linha
  %encontrar o numero divisor 
  for k = 2: h;
    z=0; % quantidade de numeros divisiveis por k 
    w=0; % quantidade de numeros diferentes de zero
    for j = i : n;
      o=A(i,j);
      if rem(o,k) ==0
        z=z+1;
      endif
    endfor
    p=B(i,1);
    if rem(p,k) ==0
      z=z+1;
    endif 
    
    for j = i : n;
      o=A(i,j);
      if o == 0
        w=w+1;
      endif
    endfor
    p=B(i,1);
    if p ==0
      w=w+1;
    endif     
    g=n-i+2-w;
    
        
    if z==g 
      f=k;
    endif
  endfor
  %ao final f ser� o m�ximo divisor comum
    for j = 1 : n;
      A(i,j)= (A(i,j))/f;
    endfor
    B(i,1)= (B(i,1))/f;  
endfor

disp("Matriz A ap�s ser simplificada. Lembrando que ela � formada pelos coeficientes que multiplicam as incognitas");
A

disp("Matriz B ap�s ser simplificada. Lembrando que ela � formada pelos termos independentes");
B 
   