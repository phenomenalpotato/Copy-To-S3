#/bin/bash

REGION="us-east-1"
TO_BUCKET="my-to-bucket"

docker build --tag copy-bucket:latest  .

# If the container is still running, will stop it
docker stop copy-bucket
docker rm copy-bucket

# Before running, be sure to fill the Environment Variables AWS_ACCESS_KEY_ID AND AWS_SECRET_ACCESS_KEY
# docker run -d --rm --name copy-bucket -e AWS_ACCESS_KEY_ID=your_aws_access_key_id -e AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key copy-bucket:latest /bin/bash -c "./copy-object"

# If you want to enter inside the container that is already running
# docker exec -it copy-bucket bash

# And if you want to execute without Dettach and see what is happening
docker run --rm --name copy-bucket -e AWS_ACCESS_KEY_ID=your_aws_access_key_id -e AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key copy-bucket:latest /bin/bash -c "./copy-object"

# To test without the credentials
# docker run -d --rm --name copy-bucket copy-bucket:latest /bin/bash -c "./copy-object"