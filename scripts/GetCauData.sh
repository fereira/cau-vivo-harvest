#!/bin/bash
BUILD_DIR=/usr/local/src/cau-harvest
export CLASSPATH=$BUILD_DIR/bin:$BUILD_DIR/lib/*
java -cp $CLASSPATH  edu.cornell.mannlib.harvester.tools.GetCauData
