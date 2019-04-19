#include "defs.h"
#include "constants.h"

/* ******************************************************************
 *        FUNCION ERROR CALCULADA PARA LA TERCER SERIE
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

void erf_cuadratura_gauss(double* resultados) {

	//
	// Se evaluará la función ERF(x)
	// solamente en x = 1
	//

	for (int i = 0; i < CANTIDAD_DE_RESULTADOS; i++) {

		for (int j = 0; j < i + 2; j++) {

			double alpha_cuadrado = -1 * pow(coeficientes_alpha[i][j], 2);
			resultados[i] += coeficientes_c[i][j] * pow(E, alpha_cuadrado) / sqrt(PI);
		}
	}
}

