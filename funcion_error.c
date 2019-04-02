
/* **********************************************************************************************
	
   	Los coeficientes y los alphas son números
	que se utilizan en el método de la cuadratura de 'Gauss-Legendre'
	y que mejoran el resultado al aproximar una integral por una suma de términos finitos.

	Este es el método que se utiliza en la tercer serie que piden hacer.
	Las dos primeras series se englobaron en una sola función.

************************************************************************************************* */

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdbool.h>
#include <math.h>

#define PI 3.1415926536
#define E 2.7182818285

#define CANTIDAD_DE_RESULTADOS 4
#define CANTIDAD_DE_COLUMNAS 5
#define CANTIDAD_DE_FILAS 4

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

typedef float coeficientes_t[CANTIDAD_DE_FILAS][CANTIDAD_DE_COLUMNAS];
typedef float alpha_t[CANTIDAD_DE_FILAS][CANTIDAD_DE_COLUMNAS];

float* inicializar_arreglo() {

	float* arreglo = malloc(sizeof(float)*CANTIDAD_DE_RESULTADOS);

	for (int i = 0; i < CANTIDAD_DE_RESULTADOS; i++) {
		arreglo[i] = 0;
	}

	return arreglo;
}

coeficientes_t* inicializar_matriz_coeficientes() {

	coeficientes_t* matriz = malloc(sizeof(coeficientes_t));

	*matriz[0][0] = C00;
	*matriz[0][1] = C01;
	*matriz[0][2] = 0;
	*matriz[0][3] = 0;
	*matriz[0][4] = 0;
	*matriz[1][0] = C10;
	*matriz[1][1] = C11;
	*matriz[1][2] = C12;
	*matriz[1][3] = 0;
	*matriz[1][4] = 0;
	*matriz[2][0] = C20;
	*matriz[2][1] = C21;
	*matriz[2][2] = C22;
	*matriz[2][3] = C23;
	*matriz[2][4] = 0;
	*matriz[3][0] = C30;
	*matriz[3][1] = C31;
	*matriz[3][2] = C32;
	*matriz[3][3] = C33;
	*matriz[3][4] = C34;

	return matriz;
}

alpha_t* inicializar_matriz_alpha() {

	alpha_t* matriz = malloc(sizeof(alpha_t));

	*matriz[0][0] = A00;
	*matriz[0][1] = A01;
	*matriz[0][2] = 0;
	*matriz[0][3] = 0;
	*matriz[0][4] = 0;
	*matriz[1][0] = A10;
	*matriz[1][1] = A11;
	*matriz[1][2] = A12;
	*matriz[1][3] = 0;
	*matriz[1][4] = 0;
	*matriz[2][0] = A20;
	*matriz[2][1] = A21;
	*matriz[2][2] = A22;
	*matriz[2][3] = A23;
	*matriz[2][4] = 0;
	*matriz[3][0] = A30;
	*matriz[3][1] = A31;
	*matriz[3][2] = A32;
	*matriz[3][3] = A33;
	*matriz[3][4] = A34;

	return matriz;
}

/* ******************************************************************
 *        FUNCION ERROR CALCULADA PARA LAS DOS PRIMERAS SERIES
 * ******************************************************************/

int factorial(int k) {

	if (k == 0 || k == 1) return 1;

	int fact = 1;

	for (int i = 1; i <= k; i++) {
		fact = fact*i;
	}

	return fact;
}

float erf_k(float x, int k, int numero_de_serie_usada) {

	if (numero_de_serie_usada == 1) return ((pow(-1, k)*pow(x, 2*k+1))/((2*k+1)*factorial(k)));
	else return ((pow(E, (-1)*(pow(x, 2))))*pow(2, 2*k)*factorial(k)*(pow(x, 2*k+1))/factorial(2*k+1));
}

float erf_aproximada(float x, float error, int tipo_de_serie_usada) {

	int k = 0;

	float suma = erf_k(x, k, tipo_de_serie_usada);

	while (abs(erf_k(x, k, tipo_de_serie_usada)) > error) {

		k++; suma = suma + erf_k(x, k, tipo_de_serie_usada);
	}

	return (suma*(2/(sqrt(PI))));
}

/* ******************************************************************
 *        FUNCION ERROR CALCULADA PARA LA TERCER SERIE
 * ******************************************************************/

float* erf_aproximada_cuadratura_de_Gauss_en_uno() {

	coeficientes_t* c = inicializar_matriz_coeficientes();
	alpha_t* alpha = inicializar_matriz_alpha();

	float* resultados = inicializar_arreglo();

	for (int i = 0; i < CANTIDAD_DE_RESULTADOS; i++) {

		for (int j = 0; j < i + 2; j++) {

			resultados[i] = resultados[i] + (*c[i][j])*pow(E, (*alpha[i][j]));
		}
	}

	return resultados;
}
