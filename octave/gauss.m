#*****************************************************************
#                       CONSTANTES
#*****************************************************************

global CANTIDAD_DE_RESULTADOS = 4;
global CANTIDAD_DE_FILAS = 4;
global CANTIDAD_DE_COLUMNAS = 5;


global coeficientes_c = [1.0000000000 0.5555555556 0.8888888889 0.3478548451 0.6521451549 0.2360268850 0.4786286705 0.5588888889];
global coeficientes_alpha = [0.5773502692 0.7745966692 0.0000000000 0.8611363116 0.3399810436 0.9061798459 0.5384693101]

#*****************************************************************
#                       INICIALIZACION
#*****************************************************************

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
#               FUNCION ERROR - GAUSS LEGENDRE
#*****************************************************************

function [ resultados ] = erf_cuadratura_gauss()

	[ coeficientes_c ] = inicializar_matriz_coeficientes();

	[ coeficientes_alpha ] = inicializar_matriz_alpha();

	[ resultados ] = inicializar_arreglo();

	for i = 1:CANTIDAD_DE_RESULTADOS

		for j = 1:(i + 1)

			alpha_cuadrado = realpow(coeficientes_alpha(i)(j), 2);

			resultados(i) = resultados(i) + coeficientes_c(i)(j) * realpow("e", (-1) * alpha_cuadrado) ./ sqrt(pi);
		end
	end
end

