
function [val] = cons(name)

% ENTRADA
	% name: nombre de la constante
% SALIDA
	% val: número asociado a la constante

	name = toupper(name);

	aux = 0;

	if (strcmp(name, "PRIMERA_SERIE")==1)
		aux = 1;
	elseif (strcmp(name, "SEGUNDA_SERIE")==1)
		aux = 2;
	elseif (strcmp(name, "FILAS")==1)
		aux = 4;
	elseif (strcmp(name, "COLUMNAS")==1)
		aux = 5;
	end

	[val] = aux;
end
