PEOPLE=`cat data/vivo-additions.rdf.xml | grep 'http://xmlns.com/foaf/0.1/Person' | grep rdf:type | wc -l`
ORGS=`cat data/vivo-additions.rdf.xml | grep 'http://xmlns.com/foaf/0.1/Organization' | grep rdf:type | wc -l`
POSITIONS=`cat data/vivo-additions.rdf.xml | grep 'http://vivoweb.org/ontology/core#Position' | grep rdf:type | wc -l`
EVENTS=`cat data/vivo-additions.rdf.xml | grep 'http://purl.org/NET/c4dm/event.owl#Event' | grep rdf:type | wc -l`

echo "Imported $PEOPLE people"
echo "Imported $ORGS organizations"
echo "Imported $POSITIONS positions"
#echo "Imported $EVENTS events"
