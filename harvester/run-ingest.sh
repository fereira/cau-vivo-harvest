#!/bin/bash
#Copyright (c) 2010-2011 VIVO Harvester Team. For full list of contributors, please see the AUTHORS file provided.
#All rights reserved.
#This program and the accompanying materials are made available under the terms of the new BSD license which accompanies this distribution, and is available at http://www.opensource.org/licenses/bsd-license.html

# set to the directory where the harvester was installed or unpacked
# HARVESTER_INSTALL_DIR is set to the location of the installed harvester
#	If the deb file was used to install the harvester then the
#	directory should be set to /usr/share/vivo/harvester which is the
#	current location associated with the deb installation.
#	Since it is also possible the harvester was installed by
#	uncompressing the tar.gz the setting is available to be changed
#	and should agree with the installation location
HARVESTER_INSTALL_DIR=/usr/local/VIVO-Harvester
CAU_DIR=/usr/local/src/cau-harvest
export HARVEST_NAME=cau
export DATE=`date +%Y-%m-%d'T'%T`

# Add harvester binaries to path for execution
# The tools within this script refer to binaries supplied within the harvester
#	Since they can be located in another directory their path should be
#	included within the classpath and the path environment variables.
export PATH=$PATH:$HARVESTER_INSTALL_DIR/bin 
export CLASSPATH=$CLASSPATH:$HARVESTER_INSTALL_DIR/build/harvester.jar:$HARVESTER_INSTALL_DIR/build/dependency/*
export CLASSPATH=$CLASSPATH:$CAU_DIR/bin:$CAUO_DIR/lib/*

# Exit on first error
# The -e flag prevents the script from continuing even though a tool fails.
#	Continuing after a tool failure is undesirable since the harvested
#	data could be rendered corrupted and incompatible.
set -e

# Supply the location of the detailed log file which is generated during the script.
#	If there is an issue with a harvest, this file proves invaluable in finding
#	a solution to the problem. It has become common practice in addressing a problem
#	to request this file. The passwords and usernames are filtered out of this file
#	to prevent these logs from containing sensitive information.
echo "Full Logging in $HARVEST_NAME.$DATE.log"
if [ ! -d logs ]; then
  mkdir logs
fi
cd logs
touch $HARVEST_NAME.$DATE.log
ln -sf $HARVEST_NAME.$DATE.log $HARVEST_NAME.latest.log
cd ..



#clear old data
# For a fresh harvest, the removal of the previous information maintains data integrity.
#	If you are continuing a partial run or wish to use the old and already retrieved
#	data, you will want to comment out this line since it could prevent you from having
# 	the required harvest data.  
rm -rf data

#  Import CSV 
#echo "Import CSV data"
#harvester-csvtojdbc -X csvtojdbc.config.xml

# Execute Fetch
# This stage of the script is where the information is gathered together into one local
#	place to facilitate the further steps of the harvest. The data is stored locally
#	in a format based off of the source. The format is a form of RDF but not in the VIVO ontology
# The JDBCFetch tool in particular takes the data from the chosen source described in its
#	configuration XML file and places it into record set in the flat RDF directly 
#	related to the rows, columns and tables described in the target database.
echo "Fetch data"
harvester-jdbcfetch -X jdbcfetch.config.xml 

# Execute Translate
# This is the part of the script where the input data is transformed into valid RDF
#   Translate will apply an xslt file to the fetched data which will result in the data 
#   becoming valid RDF in the VIVO ontology
echo "Translate data"
harvester-xsltranslator -X xsltranslator.config.xml

# Execute Transfer to import from record handler into local temp model
# From this stage on the script places the data into a Jena model. A model is a
#	data storage structure similar to a database, but in RDF.
# The harvester tool Transfer is used to move/add/remove/dump data in models.
# For this call on the transfer tool:
# -s refers to the source translated records file, which was just produced by the translator step
# -o refers to the destination model for harvested data
# -d means that this call will also produce a text dump file in the specified location 
echo "Transfer data into local triple store"
harvester-transfer -X transfer.config.xml

# Execute Score
# In the scoring phase the data in the harvest is compared to the data within Vivo and a new model
# 	is created with the values / scores of the data comparsions. 
 

####################################################################################################
# Execute Score for People
echo "Score People"
harvester-score -X score-people.config.xml

# Execute Match for People using email address
echo "Match People"
harvester-match -X match-people.config.xml

#Truncate Score Data model
echo "Truncate score data"
harvester-jenaconnect -X truncate.config.xml

####################################################################################################

# Execute Score for vcards
. ./score-match-vcard.sh

####################################################################################################
# Execute Score for Organization (university or college)
echo "Score Orgs"
harvester-score -X score-orgs.config.xml

# Execute Match for Organizations
echo "Match Orgs"
harvester-match -X match-orgs.config.xml

#Truncate Score Data model
echo "Truncate score data"
harvester-jenaconnect -X truncate.config.xml
####################################################################################################


# Execute Score for Position
echo "Score Position"
harvester-score -X score-position.config.xml

# Execute Smush for Position
#echo "Smush Positions"
#harvester-smush -X smush-position.config.xml
echo "Match Positions"
harvester-match -X match-position.config.xml

#Truncate Score Data model
echo "Truncate score data"
harvester-jenaconnect -X truncate.config.xml

####################################################################################################
# Execute Score for concepts
#echo "Score concepts"
#harvester-score -X score-concepts.config.xml

# Execute Match for Concepts
#echo "Match concepts"
#harvester-match -X match-concepts.config.xml

#Truncate Score Data model
#echo "Truncate score data"
#harvester-jenaconnect -X truncate.config.xml


####################################################################################################
# Execute ChangeNamespace to get unmatched  into current namespace
# This is where the new people, departments, and positions from the harvest are given uris within the namespace of Vivo
# 	If there is an issue with uris being in another namespace, this is the phase
#	which should give some light to the problem.
# Execute ChangeNamespace for People
echo "Changenamespace for People"
harvester-changenamespace -X changenamespace-people.config.xml

# Execute ChangeNamespace for Orgs
echo "Changenamespace for Orgs"
harvester-changenamespace -X changenamespace-org.config.xml

# Execute ChangeNamespace for Vcards
echo "Changenamespace for Vcards"
harvester-changenamespace -X changenamespace-vcard.config.xml
echo "Changenamespace for VcardEmail"
harvester-changenamespace -X changenamespace-vcardEmail.config.xml
echo "Changenamespace for VcardUrl"
harvester-changenamespace -X changenamespace-vcardUrl.config.xml
echo "Changenamespace for VcardName"
harvester-changenamespace -X changenamespace-vcardName.config.xml
echo "Changenamespace for VcardTitle"
harvester-changenamespace -X changenamespace-vcardTitle.config.xml
echo "Changenamespace for VcardAddress"
harvester-changenamespace -X changenamespace-vcardAddress.config.xml
echo "Changenamespace for VcardPhone"
harvester-changenamespace -X changenamespace-vcardPhone.config.xml

# Execute ChangeNamespace for Position
echo "Changenamespace for Position"
harvester-changenamespace -X changenamespace-position.config.xml 

# Execute ChangeNamespace for Project
echo "Changenamespace for Project"
harvester-changenamespace -X changenamespace-project.config.xml 

echo "Changenamespace for ProjectRole"
harvester-changenamespace -X changenamespace-projectRole.config.xml 

# Execute ChangeNamespace for Concepts
echo "Changenamespace for Concept"
harvester-changenamespace -X changenamespace-concept.config.xml

# Execute ChangeNamespace for DateTime
echo "Changenamespace for DateTime"
harvester-changenamespace -X changenamespace-datetime.config.xml

# Execute ChangeNamespace for authorship
echo "Changenamespace for authorship""
harvester-changenamespace -X changenamespace-authorship.config.xml

# Execute ChangeNamespace for Pubs
echo "Changenamespace for Pubs""
harvester-changenamespace -X changenamespace-publications.config.xml

# Perform an update
# The harvester maintains copies of previous harvests in order to perform the same harvest twice
#   but only add the new statements, while removing the old statements that are no longer
#   contained in the input data. This is done in several steps of finding the old statements,
#   then the new statements, and then applying them to the Vivo main model.

# Find Subtractions
# When making the previous harvest model agree with the current harvest, the statements that exist in
#	the previous harvest but not in the current harvest need to be identified for removal.
#echo "Generate subtraction diffs"
#harvester-diff -X diff-subtractions.config.xml

# Find Additions
# When making the previous harvest model agree with the current harvest, the statements that exist in
#	the current harvest but not in the previous harvest need to be identified for addition.
echo "Generate addition diffs"
harvester-diff -X diff-additions.config.xml

# Apply Subtractions to Previous model
#echo "Apply subtractions to previous model"
#harvester-transfer -w INFO -o previous-harvest.model.xml -r data/vivo-subtractions.rdf.xml -m
# Apply Additions to Previous model
echo "Apply additions to previous model"
harvester-transfer -w INFO -o previous-harvest.model.xml -r data/vivo-additions.rdf.xml

# exit 0
# Now that the changes have been applied to the previous harvest and the harvested data in vivo
#	agree with the previous harvest, the changes are now applied to the vivo model.
# Apply Subtractions to VIVO 
#echo "Apply subtractions to vivo model"
#harvester-transfer -w INFO -o vivo.model.xml -r data/vivo-subtractions.rdf.xml -m
# Apply Additions to VIVO 
echo "Apply additions to vivo model"
harvester-transfer -w INFO -o vivo.model.xml -r data/vivo-additions.rdf.xml

#Output some counts
. ./count.sh
echo 'Harvest completed successfully'
