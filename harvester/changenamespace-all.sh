# Execute ChangeNamespace for People
echo "Changenamespace for People"
harvester-changenamespace -X changenamespace-people.config.xml

# Execute ChangeNamespace for Orgs
echo "Changenamespace for Orgs"
harvester-changenamespace -X changenamespace-org.config.xml

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

# Execute ChangeNamespace for Vcards
echo "Changenamespace for Vcards"
harvester-changenamespace -X changenamespace-vcard.config.xml

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

