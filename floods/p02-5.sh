export PATH=$JACAMO_HOME/scripts:$PATH
{ time timeout 60m jacamo ../workspace/floodsp02/floods.jcm ; } 2>&1 | cat > output/p02/p02temp.out
for f in output/p02/*.out; do ( cat "${f}"; echo) >> ../planners/results/r9/domap/p02.out; done
rm output/p02/*.out
/bin/cp -rf /home/username/floods/p02/backup/* /home/username/floods/p02
{ time timeout 60m jacamo ../workspace/floodsp02/floods.jcm ; } 2>&1 | cat > output/p02/p02temp.out
for f in output/p02/*.out; do ( cat "${f}"; echo) >> ../planners/results/r10/domap/p02.out; done
rm output/p02/*.out
/bin/cp -rf /home/username/floods/p02/backup/* /home/username/floods/p02

