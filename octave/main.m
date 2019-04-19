#
# Utiliza dos series para aproximar la evaluación
# de la función ERF(x).
#
# También el método de la cuadratura de 
# Gauss-Legendre
#

PRIMERA_SERIE = 1
SEGUNDA_SERIE = 2

printf("PRIMERA PARTE - ERF(1)\n")
printf("Error: 10^(-4) - Resultado: %ld\n", erf_aprox(1, realpow(10, -4), PRIMERA_SERIE));
printf("Error: 10^(-6) - Resultado: %ld\n", erf_aprox(1, realpow(10, -6), PRIMERA_SERIE));
printf("Error: 10^(-8) - Resultado: %ld\n", erf_aprox(1, realpow(10, -8), PRIMERA_SERIE));

printf("SEGUNDA PARTE - ERF(1)\n");
printf("Error: 10^(-4) - Resultado: %ld\n", erf_aprox(1, realpow(10, -4), SEGUNDA_SERIE));
printf("Error: 10^(-6) - Resultado: %ld\n", erf_aprox(1, realpow(10, -6), SEGUNDA_SERIE));
printf("Error: 10^(-8) - Resultado: %ld\n", erf_aprox(1, realpow(10, -8), SEGUNDA_SERIE));

printf("TERCERA PARTE - ERF(1) - Gauss-Legendre\n");

resultados = erf_cuadratura_gauss();
printf("n = 2 - Resultado:  %ld\n", resultados(1));
printf("n = 3 - Resultado:  %ld\n", resultados(2));
printf("n = 4 - Resultado:  %ld\n", resultados(3));
printf("n = 5 - Resultado:  %ld\n", resultados(4));

