#! /bin/bash
# mothurCluster.sh
# Geoffrey Hannigan
# Pat Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################

# Set the variables to be used in this script
export WORKDIR=$1

export MothurPath=/mnt/EXT/Schloss-data/bin/mothur

################
# Run Analysis #
################

echo PROGRESS: Clustering OTUs

$MothurPath "#cluster.split(file=$WORKDIR/unmatched.file, processors=1);
	make.shared(list=current, count=$WORKDIR/unmatched.count_table, label=0.03);
	classify.otu(list=current, count=current, taxonomy=$WORKDIR/unmatched.taxonomy, label=0.03);
	get.oturep(fasta=$WORKDIR/unmatched.fasta, count=current, list=current, label=0.03, method=abundance);
	remove.groups(shared=current, groups=mock1-mock2)"

# Rename data files
cp ./unmatched.opti_mcc.unique_list.0.03.pick.shared ./final.shared
cp ./*.cons.taxonomy ./final.taxonomy
cp ./*0.03.rep.fasta ./final.rep.seqs
cp ./*.0.03.rep.count_table ./final.rep.count_table
