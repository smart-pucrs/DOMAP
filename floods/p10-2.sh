export PATH=$JACAMO_HOME/scripts:$PATH
{ time timeout 60m jacamo ../workspace/floodsp10/floods.jcm ; } 2>&1 | cat > output/p10/p10temp.out
for f in output/p10/*.out; do ( cat "${f}"; echo) >> ../planners/results/r3/domap/p10.out; done
rm output/p10/*.out
/bin/cp -rf /home/username/floods/p10/backup/* /home/username/floods/p10
{ time timeout 60m jacamo ../workspace/floodsp10/floods.jcm ; } 2>&1 | cat > output/p10/p10temp.out
for f in output/p10/*.out; do ( cat "${f}"; echo) >> ../planners/results/r4/domap/p10.out; done
rm output/p10/*.out
/bin/cp -rf /home/username/floods/p10/backup/* /home/username/floods/p10
