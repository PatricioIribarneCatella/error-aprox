
/* **********************************************************************************************
	
   	Los coeficientes y los alphas son números
	que se utilizan en el método de la cuadratura de 'Gauss-Legendre'
	y que mejoran el resultado al aproximar una integral por una suma de términos finitos.

	Este es el método que se utiliza en la tercer serie.
	Las dos primeras series se englobaron en una sola función.

************************************************************************************************* */

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>

#define CANTIDAD_DE_RESULTADOS 4
#define CANTIDAD_DE_COLUMNAS 5
#define CANTIDAD_DE_FILAS 4

#define PRIMERA_SERIE 1
#define SEGUNDA_SERIE 2

/* Constantes matemáticas */

#define PI 3.1415926536
#define E 2.7182818285

/* coeficientes 'C' */

#define C00 1.0000000000
#define C01 1.0000000000

#define C10 0.5555555556
#define C11 0.8888888889
#define C12 0.5555555556

#define C20 0.3478548451
#define C21 0.6521451549
#define C22 0.6521451549
#define C23 0.3478548451

#define C30 0.2360268850
#define C31 0.4786286705
#define C32 0.5588888889
#define C33 0.4786286705
#define C34 0.2360268850

/* coeficientes 'Alpha' */

#define A00 0.5773502692
#define A01 -0.5773502692

#define A10 0.7745966692
#define A11 0.0000000000
#define A12 -0.7745966692

#define A20 0.8611363116
#define A21 0.3399810436
#define A22 -0.3399810436
#define A23 -0.8611363116

#define A30 0.9061798459
#define A31 0.5384693101
#define A32 0.0000000000
#define A33 -0.5384693101
#define A34 -0.9061798459

/* ******************************************************************
 *        	AUXILIAR Y DEFINICIÓN DE MATRICES
 * ******************************************************************/

typedef double matriz_t[CANTIDAD_DE_FILAS][CANTIDAD_DE_COLUMNAS];

matriz_t coeficientes_c = {{C00, C01, 0.0, 0.0, 0.0},
			   {C10, C11, C12, 0.0, 0.0},
			   {C20, C21, C22, C23, 0.0},
			   {C30, C31, C32, C33, C34}};

matriz_t coeficientes_alpha = {{A00, A01, 0.0, 0.0, 0.0},
			       {A10, A11, A12, 0.0, 0.0},
			       {A20, A21, A22, A23, 0.0},
			       {A30, A31, A32, A33, A34}};

static void inicializar_arreglo(double* arreglo) {

	memset(arreglo, 0, sizeof(double)*CANTIDAD_DE_RESULTADOS);
}

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

double erf_aproximada(float x, double error, int serie_usada) {

	int k = 0;

	double suma = erf_k(x, k, serie_usada);

	while (abs(erf_k(x, k, serie_usada)) > error) {

		k++; suma = suma + erf_k(x, k, serie_usada);
	}

	return (suma*(2/(sqrt(PI))));
}

/* ******************************************************************
 *        FUNCION ERROR CALCULADA PARA LA TERCER SERIE
 * ******************************************************************/

void erf_cuadratura_gauss(double* resultados) {

	//
	// Se evaluará la función ERF(x)
	// solamente en x = 1
	//

	inicializar_arreglo(resultados);

	for (int i = 0; i < CANTIDAD_DE_RESULTADOS; i++) {

		for (int j = 0; j < i + 2; j++) {

			double alpha_cuadrado = -1 * pow(coeficientes_alpha[i][j], 2);
			resultados[i] += coeficientes_c[i][j] * pow(E, alpha_cuadrado) / sqrt(PI);
		}
	}
}

int main(void) {

	printf("PRIMERA PARTE - ERF(1)\n");
	printf("Error: 10^(-4) - Resultado: %lf\n", erf_aproximada(1, pow(10, -4), PRIMERA_SERIE));
	printf("Error: 10^(-6) - Resultado: %lf\n", erf_aproximada(1, pow(10, -6), PRIMERA_SERIE));
	printf("Error: 10^(-8) - Resultado: %lf\n", erf_aproximada(1, pow(10, -8), PRIMERA_SERIE));
	printf("Error: 10^(-10) - Resultado: %lf\n", erf_aproximada(1, pow(10, -10), PRIMERA_SERIE));
	printf("Error: 10^(-12) - Resultado: %lf\n", erf_aproximada(1, pow(10, -12), PRIMERA_SERIE));
	printf("\n");

	printf("SEGUNDA PARTE - ERF(1)\n");
	printf("Error: 10^(-4) - Resultado: %lf\n", erf_aproximada(1, pow(10, -4), SEGUNDA_SERIE));
	printf("Error: 10^(-6) - Resultado: %lf\n", erf_aproximada(1, pow(10, -6), SEGUNDA_SERIE));
	printf("Error: 10^(-8) - Resultado: %lf\n", erf_aproximada(1, pow(10, -8), SEGUNDA_SERIE));
	printf("Error: 10^(-10) - Resultado: %lf\n", erf_aproximada(1, pow(10, -10), SEGUNDA_SERIE));
	printf("Error: 10^(-12) - Resultado: %lf\n", erf_aproximada(1, pow(10, -12), SEGUNDA_SERIE));
	printf("\n");

	printf("TERCERA PARTE - ERF(1)\n");
	printf("Gauss-Legendre\n");
	
	double resultados[CANTIDAD_DE_RESULTADOS];
	erf_cuadratura_gauss(resultados);

	printf("n = 2 - Resultado: %lf\n", resultados[0]);
	printf("n = 3 - Resultado: %lf\n", resultados[1]);
	printf("n = 4 - Resultado: %lf\n", resultados[2]);
	printf("n = 5 - Resultado: %lf\n", resultados[3]);

	return 0;
}

