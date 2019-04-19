
function [resultado] = erf_k(x, k, serie)

% ENTRADA
	% x: valor de la función a evaluar
	% k: número del término de la serie
	% serie: n° serie utilizada
% SALIDA
	% resultado: valor numérico
	%   del k-ésimo término de la serie
	%   utilizada

	switch serie
		case cons("PRIMERA_SERIE")
			a = realpow(-1, k);

			b = realpow(x, 2 * k + 1);

			c = (2 * k + 1)*factorial(k);

			[resultado] = (( a * b ) ./ c);

		case cons("SEGUNDA_SERIE")
			a =  realpow(e, (-1) * realpow(x, 2));

			b =  realpow(2, 2 * k);

			c =  realpow(x, 2 * k + 1);

			[resultado] = (a * b * factorial(k) * c) ./ factorial(2 * k + 1);
	end
end
