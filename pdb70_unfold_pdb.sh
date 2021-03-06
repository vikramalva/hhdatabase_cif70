#!/bin/bash

#BSUB -q mpi
#BSUB -W 47:50
#BSUB -n 1
#BSUB -a openmp
#BSUB -o /usr/users/jsoedin/jobs/cif70_unfold_cif.log
#BSUB -R "span[hosts=1]"
#BSUB -R haswell
#BSUB -R cbscratch
#BSUB -J cif70_unfold_cif

source ./paths.sh
source ~/.bashrc

pdb_archives_list=$(mktemp --suffix=.dat)
find ${pdb_dir} -name "*.gz" > ${pdb_archives_list}

mkdir -p ${pdb_dir}/all

echo "pdb70_unfold_pdb.sh: Unpacking pdb data ..."
while read f
do
  bn=$(basename $f .gz)
  if [ ! -e ${pdb_dir}/all/${bn} ];
  then
    gunzip -c ${f} > ${pdb_dir}/all/${bn}
  fi
done < ${pdb_archives_list}

rm -f ${pdb_archives_list}
