
function [resultado] = erf_aprox(x, error, serie)

% ENTRADA
	% x: valor de la función a evaluar
	% error: tolerancia
	% serie: n° de serie utilizada
% SALIDA
	% resultado: valor númerico de
	%  aproximar erf(x)

	k = 0;

	sumatoria = erf_k(x, k, serie);

	while abs(erf_k(x, k, serie)) > error

		k = k + 1;

		nueva_suma = erf_k(x, k, serie);

		sumatoria = sumatoria + nueva_suma;
	end

	[resultado] = sumatoria * (2 ./ sqrt(pi));
end

