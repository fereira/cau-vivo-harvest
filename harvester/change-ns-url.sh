#!/bin/sh
for f in  `ls -1 changenamespace-*.xml`
do
  echo $f
  # sed -i 's/localhost:8080/agrivivodev.mannlib.cornell.edu/g' $f
  # sed -i 's/localhost:8080/agrivivodev.mannlib.cornell.edu/g' $f
done
