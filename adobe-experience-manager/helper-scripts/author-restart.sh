#!/bin/bash -v

set -o errexit
set -o xtrace
set -o nounset

MY_DIR=`dirname $0`
source "./common.sh"

restartServer()
{
echo "##########################################################################"
echo "restarting server : aem-author-$DEPLOYER_ENV"
ssh -T jenkins@jenkins.slave docker stop aem-author-$DEPLOYER_ENV  && rc=$? || rc=$?
    echo "stop code: $rc"
ssh -T jenkins@jenkins.slave docker rm -f aem-author-$DEPLOYER_ENV  && rc=$? || rc=$?
    echo "remove code: $rc"
ssh -T jenkins@jenkins.slave docker run --link aem-publisher-$DEPLOYER_ENV --name aem-author-$DEPLOYER_ENV -d -t -i -p $AEM_AUTH_PORT:4502 aem_author_standalone
echo "##########################################################################"
}


stopServer()
{
echo "##########################################################################"
echo "stopping server : aem-author-$DEPLOYER_ENV"
ssh -T jenkins@jenkins.slave docker stop aem-author-$DEPLOYER_ENV  && rc=$? || rc=$?
    echo "stop code: $rc"
ssh -T jenkins@jenkins.slave docker rm -f aem-author-$DEPLOYER_ENV  && rc=$? || rc=$?
    echo "remove code: $rc"
echo "##########################################################################"

}

setEnvironment $DEPLOYER_ENV

if [ "$JOB_NAME" == "author-server-restart" ]; then
	restartServer
elif [ "$JOB_NAME" == "author-server-stop" ]; then
	stopServer
else
	echo "You need to ensure the job name matches either author-server-restart or author-server-stop"
	echo "##########################################################################"
exit 1
fi

