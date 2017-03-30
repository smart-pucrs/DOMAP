export PATH=$JACAMO_HOME/scripts:$PATH
{ time timeout 60m jacamo ../workspace/floodsp03/floods.jcm ; } 2>&1 | cat > output/p03/p03temp.out
for f in output/p03/*.out; do ( cat "${f}"; echo) >> ../planners/results/r1/domap/p03.out; done
rm output/p03/*.out
/bin/cp -rf /home/username/floods/p03/backup/* /home/username/floods/p03
{ time timeout 60m jacamo ../workspace/floodsp03/floods.jcm ; } 2>&1 | cat > output/p03/p03temp.out
for f in output/p03/*.out; do ( cat "${f}"; echo) >> ../planners/results/r2/domap/p03.out; done
rm output/p03/*.out
/bin/cp -rf /home/username/floods/p03/backup/* /home/username/floods/p03
