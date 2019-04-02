#*****************************************************************
#                  AUXILIARES + INICIALIZACION
#*****************************************************************

global e = 2.7182818285;
global pi = 3.1415926536;

global CANTIDAD_DE_RESULTADOS = 4;
global CANTIDAD_DE_FILAS = 4;
global CANTIDAD_DE_COLUMNAS = 5;

global coeficientes_c = [1.0000000000 0.5555555556 0.8888888889 0.3478548451 0.6521451549 0.2360268850 0.4786286705 0.5588888889];
global coeficientes_alpha = [0.5773502692 0.7745966692 0.0000000000 0.8611363116 0.3399810436 0.9061798459 0.5384693101]

function [matriz_de_coeficientes_c] = inicializar_matriz_coeficientes_c()

	matriz_de_coeficientes_c = zeros(CANTIDAD_DE_FILAS, CANTIDAD_DE_COLUMNAS);
	matriz_de_coeficientes_c(1,1) = coeficientes_c(1);
	matriz_de_coeficientes_c(1,2) = coeficientes_c(1);

	matriz_de_coeficientes_c(2,1) = coeficientes_c(2);
	matriz_de_coeficientes_c(2,2) = coeficientes_c(3);
	matriz_de_coeficientes_c(2,3) = coeficientes_c(2);

	matriz_de_coeficientes_c(3,1) = coeficientes_c(4);
	matriz_de_coeficientes_c(3,2) = coeficientes_c(5);
	matriz_de_coeficientes_c(3,3) = coeficientes_c(5);
	matriz_de_coeficientes_c(3,4) = coeficientes_c(4);

	matriz_de_coeficientes_c(4,1) = coeficientes_c(6);
	matriz_de_coeficientes_c(4,2) = coeficientes_c(7);
	matriz_de_coeficientes_c(4,3) = coeficientes_c(8);
	matriz_de_coeficientes_c(4,4) = coeficientes_c(7);
	matriz_de_coeficientes_c(4,5) = coeficientes_c(6);
end

function [matriz_de_coeficientes_alpha] = inicializar_matriz_coeficientes_alpha()

	matriz_de_coeficientes_alpha = zeros(CANTIDAD_DE_FILAS, CANTIDAD_DE_COLUMNAS);

	matriz_de_coeficientes_alpha(1,1) = coeficientes_alpha(1);
	matriz_de_coeficientes_alpha(1,2) = (-1)*coeficientes_alpha(1);

	matriz_de_coeficientes_alpha(2,1) = coeficientes_alpha(2);
	matriz_de_coeficientes_alpha(2,2) = coeficientes_alpha(3);
	matriz_de_coeficientes_alpha(2,3) = (-1)*coeficientes_alpha(2);

	matriz_de_coeficientes_alpha(3,1) = coeficientes_alpha(4);
	matriz_de_coeficientes_alpha(3,2) = coeficientes_alpha(5);
	matriz_de_coeficientes_alpha(3,3) = (-1)*coeficientes_alpha(5);
	matriz_de_coeficientes_alpha(3,4) = (-1)*coeficientes_alpha(4);

	matriz_de_coeficientes_alpha(4,1) = coeficientes_alpha(6);
	matriz_de_coeficientes_alpha(4,2) = coeficientes_alpha(7);
	matriz_de_coeficientes_alpha(4,3) = coeficientes_alpha(3);
	matriz_de_coeficientes_alpha(4,4) = (-1)*coeficientes_alpha(7);
	matriz_de_coeficientes_alpha(4,5) = (-1)*coeficientes_alpha(6);
end

function [arreglo_de_resultados] = inicializar_arreglo()

	arreglo_de_resultados = zeros(1, CANTIDAD_DE_RESULTADOS);
end

#*****************************************************************
#           FUNCION ERROR CALCULADA PARA SERIES 1 Y 2
#*****************************************************************

function [ resultado ] = erf_k(x, k, numero_de_serie_usada)

	if (numero_de_serie_usada == 1)

		a = realpow(-1, k);

		b = realpow(x, 2*k+1);

		c = (2 * k + 1)*factorial(k);

		resultado = (( a * b ) ./ c );

	else
		a =  realpow(E, (-1) * realpow(x, 2));

		b =  realpow(2, 2*k);

		c =  realpow(x, 2*k+1);

		resultado = (a * b * factorial(k) * c) ./ factorial(2*k+1);
	end
end


function [ resultado ] = erf_aproximada(x, error, tipo_de_serie_usada)

	k = 0;

	sumatoria  = erf_k(x, k, tipo_de_serie_usada);

	while abs(erf_k(x, k, tipo_de_serie_usada)) > error

		k = k + 1;

		[ nueva_suma ] = erf_k(x, k, tipo_de_serie_usada);

		sumatoria = sumatoria + nueva_suma;

	end

	[resultado] = sumatoria * (2 ./ (sqrt( "pi" )));
end

#*****************************************************************
#               FUNCION ERROR CALCULADA PARA SERIE 3
#*****************************************************************

function [ resultados ] = erf_aproximada_cuadratura_de_Gauss_en_uno()

	[ matriz_de_coeficientes_c ] = inicializar_matriz_coeficientes();

	[ matriz_de_coeficientes_alpha ] = inicializar_matriz_alpha();

	[ resultados ] = inicializar_arreglo();

	for i = 1:CANTIDAD_DE_RESULTADOS

		for j = 1:(i+1)

			alpha_cuadrado = realpow(matriz_de_coeficientes_alpha(i)(j), 2);

			resultados(i) = resultados(i) +  c(i)(j) * realpow("e", (-1) * alpha_cuadrado) ./sqrt("pi");
		end
	end
end

