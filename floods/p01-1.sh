export PATH=$JACAMO_HOME/scripts:$PATH
{ time timeout 60m jacamo ../workspace/floodsp01/floods.jcm ; } 2>&1 | cat > output/p01/p01temp.out
for f in output/p01/*.out; do ( cat "${f}"; echo) >> ../planners/results/r1/domap/p01.out; done
rm output/p01/*.out
/bin/cp -rf /home/username/floods/p01/backup/* /home/username/floods/p01
{ time timeout 60m jacamo ../workspace/floodsp01/floods.jcm ; } 2>&1 | cat > output/p01/p01temp.out
for f in output/p01/*.out; do ( cat "${f}"; echo) >> ../planners/results/r2/domap/p01.out; done
rm output/p01/*.out
/bin/cp -rf /home/username/floods/p01/backup/* /home/username/floods/p01
