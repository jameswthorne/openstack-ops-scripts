README
======

add-openstack-users-to-project.sh
---------------------------------

### Summary

This bash script is intended to be run within the utility LXC container on any of the OpenStack Controller Nodes.

This bash script will allow you to quickly add many users to an OpenStack Project regardless if they exist or not.

### Usage

#### Create Email List

Create a text file containing the email addresses of the users you want to add. 

For example:

    james.bond@mi6.co.uk
    jack.bauer@ctu.gov
    luke.skywalker@rebel-alliance.org

This text file will be used as input for the script.

User names will be generated from the user part of the email address.

#### Create OpenStack Project

If the OpenStack Project you want to add the users to is not already created, create it. You will use the name of the OpenStack Project as input for the script.

#### Run the Script

Finally, run the bash script:

    sh add-openstack-users-to-project.sh /path/to/emails.txt openstack-project-name

The bash script will verify if the user already exists.

If the user _already exists_, the user is simply added to the specified OpenStack Project.

If the user _does not exist_, the user is created and added to the specified OpenStack Project. A secure password share link is generated for that user.

Share the output of the bash script with the appropriate users.

reset-openstack-users-password.sh
---------------------------------

### Summary

This bash script is intended to be run within the utility LXC container on any of the OpenStack Controller Nodes.

This bash script will allow you to quickly reset many user's password.

### Usage

#### Create Email List

Create a text file containing the email addresses of the users you want to reset the passwords of.

For example:

    james.bond@mi6.co.uk
    jack.bauer@ctu.gov
    luke.skywalker@rebel-alliance.org

This text file will be used as input for the script.

User names will be generated from the user part of the email address.

#### Run the Script

Finally, run the bash script:

    sh reset-openstack-users-password.sh /path/to/emails.txt

The bash script will reset existing user's password and generate a secure password share link.

Share the output of the bash script with the appropriate users.