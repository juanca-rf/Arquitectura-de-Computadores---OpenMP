#include <stdlib.h> // biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h>  // biblioteca donde se encuentra la funciÃ³n printf()
#include <time.h>   // biblioteca donde se encuentra la funciÃ³n clock_gettime()

//#define VECTOR_LOCAL	
//#define VECTOR_GLOBAL 
#define VECTOR_DYNAMIC 
#ifdef VECTOR_GLOBAL
#define MAX 5792 //sqrt 2^25
double m1[MAX][MAX], v2[MAX], v3[MAX];
#endif
int main(int argc, char **argv){
    int i;
    struct timespec cgt1, cgt2;
    double ncgt; //para tiempo de ejecucion

    if (argc < 2){//Leer argumento de entrada (n de componentes de la matriz)
        printf("Faltan nº componentes de la matriz\n");
        exit(-1);
    }

    unsigned int N = atoi(argv[1]); // MÃ¡ximo N =2^32-1=4294967295 (sizeof(unsigned int) = 4 B)
//printf("TamaÃ±o Vectores:%u (%u B)\n",N, sizeof(unsigned int));
#ifdef VECTOR_LOCAL
    double v1[N], v2[N], v3[N]; // TamaÃ±o variable local en tiempo de ejecuciÃ³n ...
                                // disponible en C a partir de C99
#endif
#ifdef VECTOR_GLOBAL
    if (N > MAX)
        N = MAX;
#endif
#ifdef VECTOR_DYNAMIC
    double **m1, **m2, **m3;
    m1 = (double **)malloc(N * sizeof(double*)); // malloc necesita el tamaÃ±o en bytes
    m2 = (double **)malloc(N * sizeof(double*));
    m3 = (double **)malloc(N * sizeof(double*));
    if ((m1 == NULL) || (m2 == NULL) || (m2 == NULL))
    {
        printf("No hay suficiente espacio para las matrices \n");
        exit(-2);
    }

    for (int i = 0; i < N; i++)
    {
        m1[i] = (double *)malloc(N * sizeof(double));
        m2[i] = (double *)malloc(N * sizeof(double));
        m3[i] = (double *)malloc(N * sizeof(double));
        if( m1[i] == NULL || m2[i] == NULL || m3[i] == NULL){
            printf("No hay suficiente espacio para las columnas de la matriz \n");
            exit(-2);
        }
    }
    
#endif

    //Inicializar 
    if( N < 9 ){ 
        for (i = 0; i < N; i++){
            for(int j = 0; j < N; j++){
                m1[i][j] = i+j;          
                m2[i][j] = N * 0.1 - i * 0.1;
                m3[i][j] = 0;
            }
        }
    }
    else{ 
        srand(time(0));
        for (i = 0; i < N; i++)
        {
            for(int j = 0; j < N; j++){
                m1[i][j] = rand() / ((double)rand());         
                m2[i][j] = rand() / ((double)rand());
                m3[i][j] = 0;
            }
        }
    }

    //Calcular suma de vectores
    clock_gettime(CLOCK_REALTIME, &cgt1);
    for (i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            for( int k = 0; k < N; k++ )
                m3[i][k] += m1[i][j]   * m2[j][k];
    clock_gettime(CLOCK_REALTIME, &cgt2);

    ncgt = (double)(cgt2.tv_sec - cgt1.tv_sec) +
           (double)((cgt2.tv_nsec - cgt1.tv_nsec) / (1.e+9));

    //Imprimir resultado de la suma y el tiempo de ejecuciÃ³n
    if (N < 10)
    {
        printf("Tiempo:%11.9f\t / TamaÃ±o Vectores:%u\n", ncgt, N);
        for (i = 0; i < N; i++){
            printf("#");
            for(int j = 0; j < N; j++)
                printf("%.2f ",m1[i][j]);
            printf("#");
            printf("    #");
            for(int j = 0; j < N; j++)
                printf("%.2f ",m2[i][j]);
            printf("#");
            printf("    #");
            for(int j = 0; j < N; j++)
                printf("%.2f ",m3[i][j]);
            printf("#\n");
        }
    }
    else
        printf("Tiempo:%11.9f\n/ Tamanyo matriz y Vectores:%u\n/ M1[0][0] +* V2[0]=V3[0](%8.6f +* %8.6f=%8.6f) / \n/ M1[%d][%d] +* V2[%d]=V3[%d](%8.6f +* %8.6f = %8.6f) /\n",  
               ncgt, N, m1[0][0], m2[0][0], m3[0][0], N - 1, N - 1, N - 1, N - 1, m1[N - 1][N - 1], m2[N - 1][N-1], m3[N - 1][N-1]);

#ifdef VECTOR_DYNAMIC
    for(i = 0; i < N; i++)
        free(m1[i]);
    free(m1); // libera el espacio reservado para m1
    for(i = 0; i < N; i++)
        free(m2[i]);
    free(m2); // libera el espacio reservado para v2
    for(i = 0; i < N; i++)
        free(m3[i]);
    free(m3); // libera el espacio reservado para v3
#endif
    return 0;
}