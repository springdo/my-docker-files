docker run -h cloudant -d -p 1080:80 cloudant-dev


# chmod +x ./scripts/cloudant-deploy.sh
# ./scripts/cloudant-deploy.sh cloudant-dev 1080 3

image_name=${1}; shift
template_port=${1}; shift
number_of_slaves=${1}
if [[ -z ${image_name} || -z ${template_port} || -z ${number_of_slaves} ]]
 then echo "no param passed to script, must atleast provide a base image name"
 exit 1;
fi

echo "tearing down containers"
for slave in `docker ps | grep "${image_name}-" | awk -F' ' '{ print $1 }'`
 do
    echo "stopping $slave"
    docker stop $slave
 done
for slave in `docker ps -a | grep "${image_name}-" | awk -F' ' '{ print $1 }'`
 do
    echo "removing $slave"
    docker rm $slave
 done

port=$((template_port))
while [ $port -le $((template_port+number_of_slaves)) ]
 do
   echo "running docker container ${image_name}-${port}"
   docker run -p ${port}:80 -t -i -d --name ${image_name}-${port} \
      --add-host='jenkins.master.pub:169.50.100.21' \
      -h cloudant ${image_name}
   port=$((port+1))
 done