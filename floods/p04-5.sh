export PATH=$JACAMO_HOME/scripts:$PATH
{ time timeout 60m jacamo ../workspace/floodsp04/floods.jcm ; } 2>&1 | cat > output/p04/p04temp.out
for f in output/p04/*.out; do ( cat "${f}"; echo) >> ../planners/results/r9/domap/p04.out; done
rm output/p04/*.out
/bin/cp -rf /home/username/floods/p04/backup/* /home/username/floods/p04
{ time timeout 60m jacamo ../workspace/floodsp04/floods.jcm ; } 2>&1 | cat > output/p04/p04temp.out
for f in output/p04/*.out; do ( cat "${f}"; echo) >> ../planners/results/r10/domap/p04.out; done
rm output/p04/*.out
/bin/cp -rf /home/username/floods/p04/backup/* /home/username/floods/p04

