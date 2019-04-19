#*****************************************************************
#           FUNCION ERROR CALCULADA PARA SERIES 1 Y 2
#*****************************************************************

function [ resultado ] = erf_k(x, k, serie)

	if (serie == 1)

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


function [ resultado ] = erf_aprox(x, error, serie)

	k = 0;

	sumatoria = erf_k(x, k, serie);

	while abs(erf_k(x, k, serie)) > error

		k = k + 1;

		[ nueva_suma ] = erf_k(x, k, serie);

		sumatoria = sumatoria + nueva_suma;

	end

	[resultado] = sumatoria * (2 ./ sqrt(pi));
end

