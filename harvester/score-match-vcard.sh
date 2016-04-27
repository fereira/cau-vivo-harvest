####################################################################################################
# Execute Score for vcards

echo "Score vcard-name"
harvester-score -X score-vcard-name.config.xml


# Execute Score for vcard-email
echo "Score vcard-email"
harvester-score -X score-vcard-email.config.xml

# Execute Score for vcard-title
echo "Score vcard-title"
harvester-score -X score-vcard-title.config.xml

# Execute Score for vcard-address
echo "Score vcard-address"
harvester-score -X score-vcard-address.config.xml

# Execute Score for vcard-url
echo "Score vcard-url"
harvester-score -X score-vcard-url.config.xml

# Execute Score for vcard
echo "Score vcard"
harvester-score -X score-vcard.config.xml

# Execute Match for vcard
echo "Match vcard"
harvester-match -X match-vcard.config.xml

#Truncate Score Data model
echo "Truncate score data"
harvester-jenaconnect -X truncate.config.xml

