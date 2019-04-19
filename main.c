
/* **********************************************************
	
   	Los coeficientes y los alphas son números
	que se utilizan en el método de la
	cuadratura de 'Gauss-Legendre' y que
	mejoran el resultado al aproximar
	una integral por una suma de términos finitos.

	Este es el método que se utiliza en la tercer serie.

************************************************************* */

#include "defs.h"
#include "erf.h"
#include "gauss.h"

static void print_result(char* parte, int serie) {

	printf("%s - ERF(1)\n", parte);
	printf("Error: 10^(-4) - Resultado: %lf\n", erf_aprox(1, pow(10, -4), serie));
	printf("Error: 10^(-6) - Resultado: %lf\n", erf_aprox(1, pow(10, -6), serie));
	printf("Error: 10^(-8) - Resultado: %lf\n", erf_aprox(1, pow(10, -8), serie));
	printf("\n");
}

static void print_result_gauss() {

	printf("TERCERA PARTE - ERF(1)\n");
	printf("Gauss-Legendre\n");
	
	double resultados[CANTIDAD_DE_RESULTADOS];
	memset(resultados, 0, sizeof(double)*CANTIDAD_DE_RESULTADOS);
	
	erf_cuadratura_gauss(resultados);

	printf("n = 2 - Resultado: %lf\n", resultados[0]);
	printf("n = 3 - Resultado: %lf\n", resultados[1]);
	printf("n = 4 - Resultado: %lf\n", resultados[2]);
	printf("n = 5 - Resultado: %lf\n", resultados[3]);
}

int main(void) {

	print_result("PRIMERA PARTE", PRIMERA_SERIE);
	print_result("SEGUNDA PARTE", SEGUNDA_SERIE);
	print_result_gauss();

	return 0;
}

