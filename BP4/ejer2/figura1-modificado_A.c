#include <stdlib.h>
#include <stdio.h> 
#include <time.h>  

struct Vectores {
    int a;
    int b;
};

int main(int argc, char **argv)
{
    struct timespec cgt1, cgt2;
    int N,M;
    if (argc < 3){//Leer argumento de entrada (n de componentes de la matriz)
        printf("Faltan tamaño N  y M \n");
        exit(-1);
    }
    N = atoi(argv[1]);
    M = atoi(argv[2]);
    struct Vectores s[N];
    int R[M];

    //Inicializacion
    if( N>8 || M>8 ){
        for( int i = 0; i<N; i++ ){
            s[i].a = i;
            s[i].b = i;
        }
    }else{
        for( int i = 0; i<N; i++ ){
            s[i].a = rand()%N;
            s[i].b = rand()%N;
        }
    }

    int X1;
    int X2;
    //Calculo
    clock_gettime(CLOCK_REALTIME, &cgt1);
    for (int ii = 0; ii < M; ii++)
    {
        X1 = 0;
        X2 = 0;
        for (int i = 0; i < N; i++){
            X1 += 2 * s[i].a + ii;
            X2 += 3 * s[i].b - ii;
        }
        R[ii] = (X1 < X2)? X1 : X2;
    }
    clock_gettime(CLOCK_REALTIME, &cgt2);
    double ncgt = (double)(cgt2.tv_sec - cgt1.tv_sec) +
           (double)((cgt2.tv_nsec - cgt1.tv_nsec) / (1.e+9));
    printf("ModA Tiempo ejecucion %11.9f\n", ncgt);
    return 0;
}