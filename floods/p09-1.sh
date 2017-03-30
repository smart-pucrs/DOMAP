export PATH=$JACAMO_HOME/scripts:$PATH
{ time timeout 60m jacamo ../workspace/floodsp09/floods.jcm ; } 2>&1 | cat > output/p09/p09temp.out
for f in output/p09/*.out; do ( cat "${f}"; echo) >> ../planners/results/r1/domap/p09.out; done
rm output/p09/*.out
/bin/cp -rf /home/username/floods/p09/backup/* /home/username/floods/p09
{ time timeout 60m jacamo ../workspace/floodsp09/floods.jcm ; } 2>&1 | cat > output/p09/p09temp.out
for f in output/p09/*.out; do ( cat "${f}"; echo) >> ../planners/results/r2/domap/p09.out; done
rm output/p09/*.out
/bin/cp -rf /home/username/floods/p09/backup/* /home/username/floods/p09
