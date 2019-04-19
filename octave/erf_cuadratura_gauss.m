
function [resultados] = erf_cuadratura_gauss()

%
% ERF(x) - a partir de Gauss-Legendre
%
% SALIDA
	% resultados: evaluar erf(1)
	%  con disintos valores de 'n'


	[c] = inicializar_matriz_c();

	[alpha] = inicializar_matriz_alpha();

	[resultados] = inicializar_arreglo();

	for i = 1:4

		for j = 1:(i + 1)

			alpha_cuadrado = realpow(alpha(i,j), 2);

			resultados(i) = resultados(i) + c(i,j) * realpow(e, (-1) * alpha_cuadrado) ./ sqrt(pi);
		end
	end
end

#*****************************************************************
#                       INICIALIZACION
#*****************************************************************

function [matriz] = inicializar_matriz_c()

	coeficientes_c = [1.0000000000 0.5555555556 0.8888888889 0.3478548451 0.6521451549 0.2360268850 0.4786286705 0.5588888889];

	matriz = zeros(4, 5);

	matriz(1,1) = coeficientes_c(1);
	matriz(1,2) = coeficientes_c(1);

	matriz(2,1) = coeficientes_c(2);
	matriz(2,2) = coeficientes_c(3);
	matriz(2,3) = coeficientes_c(2);

	matriz(3,1) = coeficientes_c(4);
	matriz(3,2) = coeficientes_c(5);
	matriz(3,3) = coeficientes_c(5);
	matriz(3,4) = coeficientes_c(4);

	matriz(4,1) = coeficientes_c(6);
	matriz(4,2) = coeficientes_c(7);
	matriz(4,3) = coeficientes_c(8);
	matriz(4,4) = coeficientes_c(7);
	matriz(4,5) = coeficientes_c(6);
end

function [matriz] = inicializar_matriz_alpha()

	coeficientes_alpha = [0.5773502692 0.7745966692 0.0000000000 0.8611363116 0.3399810436 0.9061798459 0.5384693101];
	
	matriz = zeros(4,5);

	matriz(1,1) = coeficientes_alpha(1);
	matriz(1,2) = (-1)*coeficientes_alpha(1);

	matriz(2,1) = coeficientes_alpha(2);
	matriz(2,2) = coeficientes_alpha(3);
	matriz(2,3) = (-1)*coeficientes_alpha(2);

	matriz(3,1) = coeficientes_alpha(4);
	matriz(3,2) = coeficientes_alpha(5);
	matriz(3,3) = (-1)*coeficientes_alpha(5);
	matriz(3,4) = (-1)*coeficientes_alpha(4);

	matriz(4,1) = coeficientes_alpha(6);
	matriz(4,2) = coeficientes_alpha(7);
	matriz(4,3) = coeficientes_alpha(3);
	matriz(4,4) = (-1)*coeficientes_alpha(7);
	matriz(4,5) = (-1)*coeficientes_alpha(6);
end

function [arreglo_de_resultados] = inicializar_arreglo()
	arreglo_de_resultados = zeros(1, 4);
end

