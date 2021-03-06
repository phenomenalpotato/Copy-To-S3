#include <iostream>
#include <fstream>
#include <sys/stat.h>
#include <aws/core/Aws.h>
#include <aws/s3/S3Client.h>
#include <awsdoc/s3/s3_examples.h>
#include <aws/s3/model/CopyObjectRequest.h>
#include <aws/s3/model/ListObjectsRequest.h>
#include <aws/s3/model/Bucket.h>


bool AwsDoc::S3::CopyObject(const Aws::String& objectKey, const Aws::String& fromBucket, const Aws::String& toBucket, const Aws::String& region)  {

    Aws::Client::ClientConfiguration config;

    if(!region.empty()) {

        config.region = region;
    }

    Aws::S3::S3Client s3_client(config);

    Aws::S3::Model::CopyObjectRequest request;

    request.WithCopySource(fromBucket + "/" + objectKey).WithKey(objectKey).WithBucket(toBucket);

    Aws::S3::Model::CopyObjectOutcome outcome2 = s3_client.CopyObject(request);

    if(!outcome2.IsSuccess()) {

        auto err = outcome2.GetError();

        std::cout << "Error: CopyObject: " << err.GetExceptionName() << ": " << err.GetMessage() << std::endl;

        return false;
    } 

    else {

        return true;
    }

    
}

bool AwsDoc::S3::ListObjects(const Aws::String& bucketName, const Aws::String& region) {

    Aws::Client::ClientConfiguration config;

    if(!region.empty()) {

        config.region;
    }

    Aws::S3::S3Client s3_client(config);

    Aws::S3::Model::ListObjectsRequest request;

    request.WithBucket(bucketName);

    auto outcome = s3_client.ListObjects(request);

    if(outcome.IsSuccess()) {

        std::cout << "Objects in bucket '" << bucketName << "':" << std::endl << std::endl;

        Aws::Vector<Aws::S3::Model::Object> objects = outcome.GetResult().GetContents();

        for (Aws::S3::Model::Object& object : objects) {
        
            if(!object.GetKey().empty()) {

                std::cout << object.GetKey() << std::endl;

                Aws::String objeto = object.GetKey();

                Aws::String region = "us-east-1";
                Aws::String object_key = objeto;
                Aws::String from_bucket = bucketName; // "my-from-bucket";
                Aws::String to_bucket =  "my-to-bucket";

                if(AwsDoc::S3::CopyObject(object_key, from_bucket, to_bucket, region)) {

                    std::cout << "-------------------------------------" << std::endl;

                    std::cout << "Copied object '" << object_key << "' from '" << from_bucket << "' to '" << to_bucket << "'." << std::endl;

                }

                 else {

                    return 1;

                }

            }
        }

        return true;
    }

    else {

        std::cout << "Error: ListObjects: " << outcome.GetError().GetMessage() << std::endl;

        return false;
    }

}

bool AwsDoc::S3::ListBuckets() {

    Aws::S3::S3Client s3_client3;
    Aws::S3::Model::ListBucketsOutcome outcome3 = s3_client3.ListBuckets();

    if(outcome3.IsSuccess()) {

        std::cout << "Copying objects from: Bucket:" << std::endl << std::endl;
    
        Aws::Vector<Aws::S3::Model::Bucket> buckets = outcome3.GetResult().GetBuckets();

        for(Aws::S3::Model::Bucket& bucket : buckets) {

            std::cout << bucket.GetName() << std::endl;

            Aws::String bucket_name = bucket.GetName(); // "my-from-bucket";
            Aws::String region = "us-region";

            if(!AwsDoc::S3::ListObjects(bucket_name, region)) {

                return 1;

            }

        }

        return true;
    }

    else {

        std::cout << "Error: ListBuckets: " << outcome3.GetError().GetMessage() << std::endl;

        return false;
    }

}


int main(int argc, char *argv[]) {

    Aws::SDKOptions options;
    Aws::InitAPI(options); 
    {

        if(!AwsDoc::S3::ListBuckets()) {

            return 1;
        }


    }


    Aws::ShutdownAPI(options);

    return 0;
}
