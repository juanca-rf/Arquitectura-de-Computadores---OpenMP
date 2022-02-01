#include <stdlib.h>
#include <stdio.h> 
#include <time.h>  

int main( int argc, char*argv[] ){
    int N;
    double constante;
    double *x, *y;
    struct timespec cgt1, cgt2;

    if(argc < 3){
        printf("Falta tamaño y constante");
        return 0;
    }

    N = atoi(argv[1]);
    constante = atof(argv[2]);

    x = (double *)malloc(N*sizeof(double));
    y = (double *)malloc(N*sizeof(double));

    for(int i = 0; i < N; i++){
        x[i] = rand()%N;
        y[i] = rand()%N;
    }
    //Calculo
    clock_gettime(CLOCK_REALTIME, &cgt1);
    for(int i = 0; i < N; i++) y[i] = constante*x[i] + y[i];
    clock_gettime(CLOCK_REALTIME, &cgt2);
    
    double ncgt = (double)(cgt2.tv_sec - cgt1.tv_sec) +
           (double)((cgt2.tv_nsec - cgt1.tv_nsec) / (1.e+9));
    
    printf("DAXPY Tiempo ejecucion %11.9f\n", ncgt);

}