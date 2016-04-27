#!/bin/bash
for f in  `ls -1 changenamespace-*.xml`
do
  echo $f
  sed -i 's/agrivivodev.mannlib.cornell.edu/localhost:8080/g' $f
done
