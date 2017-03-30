export PATH=$JACAMO_HOME/scripts:$PATH
{ time timeout 60m jacamo ../workspace/floodsp06/floods.jcm ; } 2>&1 | cat > output/p06/p06temp.out
for f in output/p06/*.out; do ( cat "${f}"; echo) >> ../planners/results/r1/domap/p06.out; done
rm output/p06/*.out
/bin/cp -rf /home/username/floods/p06/backup/* /home/username/floods/p06
{ time timeout 60m jacamo ../workspace/floodsp06/floods.jcm ; } 2>&1 | cat > output/p06/p06temp.out
for f in output/p06/*.out; do ( cat "${f}"; echo) >> ../planners/results/r2/domap/p06.out; done
rm output/p06/*.out
/bin/cp -rf /home/username/floods/p06/backup/* /home/username/floods/p06
