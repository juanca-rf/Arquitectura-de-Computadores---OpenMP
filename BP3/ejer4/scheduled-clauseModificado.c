#include <stdio.h>
#include <stdlib.h>

#ifdef _OPENMP
#include <omp.h>
#else
#define omp_get_thread_num() 0
#endif

int main(int argc, char **argv){
    int i, n = 200, chunk, a[n], suma = 0, dinamic, nthreads, limit, chunk2;
    omp_sched_t tipo;

    if (argc < 3){
        fprintf(stderr, "\nFalta iteraciones o chunk\n");
        exit(-1);
    }

    n = atoi(argv[1]);
    if (n > 200) n = 200;
    chunk = atoi(argv[2]);

    for (i = 0; i < n; i++) a[i] = i;

    #pragma omp parallel  for firstprivate(suma) lastprivate(suma) schedule(dynamic, chunk)
    for (i = 0; i < n; i++)
    {
        if(i==0){ 
            printf("\n DENTRO DE LA REGION PARALLEL\n \tdyn-var: %d\n", omp_get_dynamic() );
            printf("\tnthreads-var: %d\n", omp_get_max_threads() );
            printf("\tthreads-limit-var: %d\n", omp_get_max_threads() );
            omp_get_schedule(&tipo,&chunk2);
            printf("\trun-ched-var: %x\n\n", tipo );
        }  
        suma = suma + a[i];
        printf(" thread %d suma a[%d]=%d suma=%d \n",
            omp_get_thread_num(), i, a[i], suma);
    }  

    printf("\nFuera de 'parallel for' suma=%d\n", suma);
    printf("\tdyn-var: %d\n", omp_get_dynamic() );
    printf("\tnthreads-var: %d\n", omp_get_max_threads() );
    printf("\tthreads-limit-var: %d\n", omp_get_thread_limit() );
    omp_get_schedule(&tipo,&chunk2);
    printf("\trun-ched-var: %x\n\n", tipo );
}