#!/bin/bash

if [ "$DOCKER_MACHINE_NAME" == "" ]; then
	echo "Please execute this command from a Docker-enabled terminal"
	exit 1
fi

# Check that install looks fine
echo "Checking Cloudant install..."
cloudant_ip=$(docker-machine ip $DOCKER_MACHINE_NAME)
result=$(curl -s $cloudant_ip)
if [[ ! $result == *"couchdb"* ]] || [[ ! $result == *"Welcome"* ]] || [[ ! @$result == *"cloudant_build"* ]]; then
  	echo "Cloudant installation does not seem to have succeded. Aborting."
	exit 1
fi

# Now display the admin URL
echo "Cloudant admin URL is http://$cloudant_ip/dashboard.html"

# Generate VCAP_SERVICES.json
echo "{
  \"cloudantNoSQLDB\": [
    {
      \"name\": \"Cloudant NoSQL DB-dk\",
      \"label\": \"cloudantNoSQLDB\",
      \"plan\": \"Shared\",
      \"credentials\": {
        \"username\": \"admin\",
        \"password\": \"admin\",
        \"host\": \"$cloudant_ip\",
        \"port\": 80,
        \"url\": \"http://admin:admin@$cloudant_ip\"
      }
    }
  ]
}" > VCAP_SERVICES.json
echo "VCAP_SERVICES.json file has been generated."
echo "Note: if you modified Cloudant admin credentials, you should update the VCAP_SERVICES.json to match these values"
