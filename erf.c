#include "defs.h"
#include "constants.h"

/* ******************************************************************
 *        FUNCION ERROR CALCULADA PARA LAS DOS PRIMERAS SERIES
 * ******************************************************************/

static int factorial(int k) {

	if (k == 0 || k == 1) return 1;

	int fact = 1;

	for (int i = 1; i <= k; i++) {
		fact = fact*i;
	}

	return fact;
}

static double erf_k(float x, int k, int serie_usada) {

	switch (serie_usada) {
		case PRIMERA_SERIE:
			return ((pow(-1, k)*pow(x, 2*k+1))/((2*k+1)*factorial(k)));
		case SEGUNDA_SERIE:
			return ((pow(E, (-1)*(pow(x, 2))))*pow(2, 2*k)*factorial(k)*(pow(x, 2*k+1))/factorial(2*k+1));
		default:
			return -1;
	}
}

double erf_aprox(float x, double error, int serie_usada) {

	int k = 0;

	double suma = erf_k(x, k, serie_usada);

	while (abs(erf_k(x, k, serie_usada)) > error) {

		k++; suma = suma + erf_k(x, k, serie_usada);
	}

	return (suma*(2/(sqrt(PI))));
}

