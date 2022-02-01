/* SumaVectoresC.c 
 Suma de dos vectores: v3 = v1 + v2
 
 Para compilar usar (-lrt: real time library, es posible que no sea necesario usar -lrt):  
	gcc  -O2  SumaVectores.c -o SumaVectores -lrt
	gcc  -O2 -S SumaVectores.c -lrt 

 Para ejecutar use: SumaVectoresC longitud
		
*/

#include <stdlib.h> // biblioteca con funciones atoi(), malloc() y free()
#include <stdio.h>  // biblioteca donde se encuentra la funciÃ³n printf()
#include <time.h>   // biblioteca donde se encuentra la funciÃ³n clock_gettime()

//SÃ³lo puede estar definida una de las tres constantes VECTOR_ (sÃ³lo uno de los ...
//tres defines siguientes puede estar descomentado):
//#define VECTOR_LOCAL	// descomentar para que los vectores sean variables ...
// locales (si se supera el tamaÃ±o de la pila se ...
// generarÃ¡ el error "ViolaciÃ³n de Segmento")
#define VECTOR_GLOBAL // descomentar para que los vectores sean variables ...
// globales (su longitud no estarÃ¡ limitada por el ...
// tamaÃ±o de la pila del programa)
//#define VECTOR_DYNAMIC // descomentar para que los vectores sean variables ...
                       // dinÃ¡micas (memoria reutilizable durante la ejecuciÃ³n)

#ifdef VECTOR_GLOBAL
#define MAX 5792 //sqrt 2^25


double m1[MAX][MAX], v2[MAX], v3[MAX];
#endif
int main(int argc, char **argv)
{

    int i;

    struct timespec cgt1, cgt2;
    double ncgt; //para tiempo de ejecucion

    //Leer argumento de entrada (n de componentes de la matriz)
    if (argc < 2)
    {
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
    double **m1, *v2, *v3;
    m1 = (double **)malloc(N * sizeof(double*)); // malloc necesita el tamaÃ±o en bytes
    v2 = (double *)malloc(N * sizeof(double));
    v3 = (double *)malloc(N * sizeof(double));
    if ((m1 == NULL) || (v2 == NULL) || (v2 == NULL))
    {
        printf("No hay suficiente espacio para los vectores o matriz \n");
        exit(-2);
    }

    for (int i = 0; i < N; i++)
    {
        m1[1] = (double *)malloc(N * sizeof(double));
        if( m1[i] == NULL ){
            printf("No hay suficiente espacio para las columnas de la matriz \n");
            exit(-2);
        }
    }
    
#endif

    //Inicializar 
    if (N < 9)
        for (i = 0; i < N; i++)
        {
            for(int j = 0; j < N; j++)
                m1[i][j] = N * 0.1 + i * 0.1;
            v2[i] = N * 0.1 - i * 0.1;
        }
    else
    {
        srand(time(0));
        for (i = 0; i < N; i++)
        {
            for(int j = 0; j < N; j++)
                m1[i][j] = rand() / ((double)rand());
            v2[i] = rand() / ((double)rand()); //printf("%d:%f,%f/",i,v1[i],v2[i]);
        }
    }

    //Calcular suma de vectores
    clock_gettime(CLOCK_REALTIME, &cgt1);
    for (i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            v3[i] += m1[i][j] * v2[i];
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
            
            if(i == N-1)
                printf("* #%.2f# = #%.3f#\n",v2[i], v3[i]);
            else 
                printf("  #%.2f# = #%.3f#\n",v2[i], v3[i]);
        }
    }
    else
        printf("Tiempo:%11.9f\n/ Tamanyo matriz y Vectores:%u\n/ M1[0][0] +* V2[0]=V3[0](%8.6f +* %8.6f=%8.6f) / \n/ M1[%d][%d] +* V2[%d]=V3[%d](%8.6f +* %8.6f = %8.6f) /\n",  //Este print f no representa los calculos correctos, esta como si fueran los vectores.
               ncgt, N, m1[0][0], v2[0], v3[0], N - 1, N - 1, N - 1, N - 1, m1[N - 1][N - 1], v2[N - 1], v3[N - 1]);

#ifdef VECTOR_DYNAMIC
    for(i = 0; i < N; i++)
        free(m1[i]);
    free(m1); // libera el espacio reservado para m1
    free(v2); // libera el espacio reservado para v2
    free(v3); // libera el espacio reservado para v3
#endif
    return 0;
}