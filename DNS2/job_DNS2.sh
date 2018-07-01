#!/bin/bash
#SBATCH --no-requeue
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=50:00:00
#SBATCH --output=mpi_job_slurm.log
#SBATCH --partition=xeon16

source /home/mek/kmpan/OpenFOAM/OpenFOAM-4.1/etc/bashrc
cd /home/mek/s153289/OpenFOAM/s153289-4.1/run/DNS2

gmshToFoam mesh_DNS2.msh
checkMesh
mapFields ../boxTurb
decomposePar
mpirun -np 16 pisoFoam -parallel
reconstructPar
postProcess -funcs '(Ur5x Ur5y Ur15x Ur15y Ur20x Ur20y Ur25x Ur25y Ur30x Ur30y Ur35x Ur35y Ur40x Ur40y Uc)'

