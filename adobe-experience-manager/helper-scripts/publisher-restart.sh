#!/bin/bash -v

set -o errexit
set -o xtrace
set -o nounset

MY_DIR=`dirname $0`
source "./common.sh"

restartServer()
{
echo "##########################################################################"
echo "restarting server : aem-publisher-$DEPLOYER_ENV"
ssh -T jenkins@jenkins.slave docker stop aem-publisher-$DEPLOYER_ENV  && rc=$? || rc=$?
    echo "stop code: $rc"
ssh -T jenkins@jenkins.slave docker rm -f aem-publisher-$DEPLOYER_ENV  && rc=$? || rc=$?
    echo "remove code: $rc"
ssh -T jenkins@jenkins.slave docker run --hostname aem.publisher.$DEPLOYER_ENV --name aem-publisher-$DEPLOYER_ENV -d -t -i -p $AEM_PUB_PORT:4503 aem_publisher_standalone
echo "##########################################################################"
}


stopServer()
{
echo "##########################################################################"
echo "stopping server : aem-publisher-$DEPLOYER_ENV"
ssh -T jenkins@jenkins.slave docker stop aem-publisher-$DEPLOYER_ENV  && rc=$? || rc=$?
    echo "stop code: $rc"
ssh -T jenkins@jenkins.slave docker rm -f aem-publisher-$DEPLOYER_ENV  && rc=$? || rc=$?
    echo "remove code: $rc"
echo "##########################################################################"

}

setEnvironment $DEPLOYER_ENV

if [ "$JOB_NAME" == "publisher-server-restart" ]; then
	restartServer
elif [ "$JOB_NAME" == "publisher-server-stop" ]; then
	stopServer
else
	echo "You need to ensure the job name matches either publisher-server-restart or publisher-server-stop"
	echo "##########################################################################"
exit 1
fi

