#/bin/bash

REGION="us-east-1"
TO_BUCKET="my-to-bucket"

ALLINONE-STACK-NAME="name-of-the-stack"
REGION="region-you-want-to-install-the-stack"
S3-BUCKET-TO-SCAN="the-name-of-your-bucket-to-scan"
KMS-MASTER-KEY-ARN="your-KMS-master-key-which-is-used-to-encrypt-objects-in-your-s3-bucket-to-scan" # Leave it blank if you haven't enabled SSE-KMS on your bucket.
KMS-MASTER-KEY-ARN-FOR-SQS="your-KMS-master-key-which-is-used-to-encrypt-SQS-massages-in your-scanner-stack" # Leave it blank if you haven't enabled SSE-KMS on your bucket.
EXTERNAL-ID="external-id-obtained"


# Deploy the Cloud One - File Storage Security All-in-One Stack:

# aws cloudformation create-stack --stack-name ALLINONE-STACK-NAME --region REGION --template-url https://file-storage-security.s3.amazonaws.com/latest/templates/FSS-All-In-One.template --parameters ParameterKey=S3BucketToScan,ParameterValue=S3-BUCKET-TO-SCAN ParameterKey=KMSKeyARNForBucketSSE,ParameterValue=KMS-MASTER-KEY-ARN ParameterKey=KMSKeyARNForQueueSSE,ParamValue=KMS-MASTER-KEY-ARN-FOR-SQS ParameterKey=ExternalID,ParameterValue=EXTERNAL-ID --capabilities CAPABILITY_NAMED_IAM

# Verify that the stack creation is complete:

        # When the stack is ready, the status will become CREATE_COMPLETE.

# aws cloudformation describe-stacks --stack-name ALLINONE-STACK-NAME --output json --query 'Stacks[0].StackStatus'

# Obtain the ARNs of the scanner and storage stacks:

        # In the command Output, take note of the ScannerStackManagementRoleARN && StorageStackManagementRoleARN output values!

# aws cloudformation describe-stacks --stack-name ALLINONE-STACK-NAME --output json --query 'Stacks[0].Outputs'

# ----------------------==============================================---------------------------------====================

# Add the scanner and storage stacks to File Storage Security:

# First, add the Scanner Stack:

    # Call Create Stack and include the ScannerStackManagementRoleARN output value in the request body.

    # The creation of the scanner stack will begin.

    # Take note of stackID in the API response, which is the scanner stack’s ID.

    # Call Describe Stack using the scanner stack's stackID noted in the previous step, and continue calling until the status in the response body becomes ok.

    # You have now added the scanner stack.

# Now add the Storage Stack:

    # Call Create Stack, and include the previously-noted scanner stack stackID and storage stack StorageStackManagementRoleARN output value in the request body.
    
    # The creation of the storage stack will begin.

    # Take note of stackID in the API response, which is the storage stack’s ID.

    # Call Describe Stack using the storage stack's stackID noted in the previous step, and continue calling until the status in the response body becomes ok.



# ----------------------==============================================---------------------------------====================

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