
#include <stdlib.h>
#include <stdio.h> 
#include <time.h>  
#include <omp.h>

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
#define MAX 33554432 //=2^25
//#define MAX 4294967295  //=2^32 -1

double v1[MAX], v2[MAX], v3[MAX];
#endif
int main(int argc, char **argv)
{

  int i;

  double cgt1, cgt2, ncgt;

  //Leer argumento de entrada (nÂº de componentes del vector)
  if (argc < 2){
    printf("Faltan nÂº componentes del vector\n");
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
    double *v1, *v2, *v3;
    v1 = (double *)malloc(N * sizeof(double)); // malloc necesita el tamaÃ±o en bytes
    v2 = (double *)malloc(N * sizeof(double));
    v3 = (double *)malloc(N * sizeof(double));
    if ((v1 == NULL) || (v2 == NULL) || (v2 == NULL))
    {
      printf("No hay suficiente espacio para los vectores \n");
      exit(-2);
    }
  #endif

  srand(time(0));
  #pragma omp parallel sections private(i)
  {
    #pragma omp section
    {
      for (i = 0; i < N/4; i++)// ## __ __ __
      {
        v1[i] = rand() / ((double)rand());
        v2[i] = rand() / ((double)rand());
      }    
    }
    #pragma omp section
    {
      for (i = N/4; i < N/2; i++) // __ ##__ __
      {
        v1[i] = rand() / ((double)rand());
        v2[i] = rand() / ((double)rand());
      }    
    }
    #pragma omp section
    {
      for (i = N/2; i < 3*N/4; i++) // __ __ ## __
      {
        v1[i] = rand() / ((double)rand());
        v2[i] = rand() / ((double)rand());
      }    
    }
    #pragma omp section
    {
      for (i = 3*N/4; i < N; i++)// __ __ __ ##
      {
        v1[i] = rand() / ((double)rand());
        v2[i] = rand() / ((double)rand());
      }    
    }
    
  } 

  cgt1 = omp_get_wtime();
  //Calcular suma de vectores
  #pragma omp parallel sections private(i)
  {
    #pragma omp section  // ## __ __ __
    for (i = 0; i < N/4; i++)
      v3[i] = v1[i] + v2[i];
      
    #pragma omp section  // __ ## __ __ 
    for (i = N/4; i < N/2; i++)
      v3[i] = v1[i] + v2[i];
      
    #pragma omp section  // __ __ ## __
    for (i = N/2; i < 3*N/4; i++)
      v3[i] = v1[i] + v2[i];
      
    #pragma omp section // __ __ __ ##
    for (i = 3*N/4; i < N; i++)
      v3[i] = v1[i] + v2[i];
  }

  cgt2 = omp_get_wtime();
  ncgt = cgt2-cgt1;

  //Imprimir resultado de la suma y el tiempo de ejecuciÃ³n
  if (N < 10)
  {
    printf("Tiempo:%11.9f\t / TamaÃ±o Vectores:%u\n", ncgt, N);
    for (i = 0; i < N; i++)
      printf("/ V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n",
             i, i, i, v1[i], v2[i], v3[i]);
  }
  else
    printf("Tiempo:%11.9f\t / TamaÃ±o Vectores:%u\t/ V1[0]+V2[0]=V3[0](%8.6f+%8.6f=%8.6f) / / V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n",
           ncgt, N, v1[0], v2[0], v3[0], N - 1, N - 1, N - 1, v1[N - 1], v2[N - 1], v3[N - 1]);

#ifdef VECTOR_DYNAMIC
  free(v1); // libera el espacio reservado para v1
  free(v2); // libera el espacio reservado para v2
  free(v3); // libera el espacio reservado para v3
#endif
  return 0;
}