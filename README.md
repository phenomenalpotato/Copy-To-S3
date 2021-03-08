# Copy-To-S3

## This program will copy all the objects listed in all bucket in your account and copy to another bucket!

<hr />
<br />

### How To:

<br />

<b> In the docker_run.sh: </b>

    - Put your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY;

<b> For now, open the copy-object.cpp file and edit the following variables that are for your environment/ use case: </b>

<ul>

<li> <b> bucket_name </b> in the main() function; <- This bucket is the From/ destiny bucket </li>

<li> <b> region </b> in the ListObjects() function; </li>

<li> <b> to_bucket </b> in the ListObjects() function; <- This bucket is the To/ origin bucket </li> 

</ul>

<br />

<b> Execute the docker_run.sh script </b>

    - ./docker_run.sh



<br />

<hr />
<br />

### Tests:

<b> The tool copying 3.011 objects in 10 buckets in one account took 3 hours and 24 minutes hours. </b>

### WARNING:

        - This project/ files are only for DEMONSTRATION purpose!! 
        - This is a work in progress!!
<br />

<hr />
<br />

<i> <strong> If you want to contribute, feel free to do so! </i> </strong>