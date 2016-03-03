my-docker-files
==========

Very basic usage
-----
1. Download and install docker-machine
2. Each Folder contains a Dockerfile which can be built using the `docker build -t $IMAGE_NAME -f $FOLDER_NAME/Dockerfile $FOLDER_NAME` where `$IMAGE_NAME` is the name you want to give the image and `$FOLDER_NAME` is the folder containing the Dockerfile.
3. Use `docker run -t -i -d -p 2200:22 $IMAGE_NAME` to run an image and bind the ssh port to 2200