#!/bin/bash
#Órdenes para el Gestor de carga de trabajo:
#1. Asigna al trabajo un nombre
#SBATCH --job-name=SumaVectores
#2. Asignar el trabajo a una partición (cola)
#SBATCH --partition=ac
#SBATCH --account=ac
#SBATCH --hint=nomultithread
#SBATCH --exclusive

#Obtener información de las variables del entorno del Gestor de carga de trabajo:
echo "Id. usuario del trabajo: $SLURM_JOB_USER"
echo "Id. del trabajo: $SLURM_JOBID"
echo "Nombre del trabajo especificado por usuario: $SLURM_JOB_NAME"
echo "Directorio de trabajo (en el que se ejecuta el script): $SLURM_SUBMIT_DIR"
echo "Cola: $SLURM_JOB_PARTITION"
echo "Nodo que ejecuta este trabajo:$SLURM_SUBMIT_HOST"
echo "Nº de nodos asignados al trabajo: $SLURM_JOB_NUM_NODES"
echo "Nodos asignados al trabajo: $SLURM_JOB_NODELIST"
echo "CPUs por nodo: $SLURM_JOB_CPUS_PER_NODE"

#Instrucciones del script para ejecutar código:
echo -e "\n 1. Ejecución SumaVectores locales ................."
for ((P=65536;P<=67108864;P=P*2))
do
    ./SumaVectores_l $P
done

echo -e "\n 2. Ejecución SumaVectores globales ................."
for ((P=65536;P<=67108864;P=P*2))
do
    ./SumaVectores_g $P
done

echo -e "\n 3. Ejecución SumaVectores dinamicos ................."
for ((P=65536;P<=67108864;P=P*2))
do
    ./SumaVectores_d $P
done