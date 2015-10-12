#!/bin/bash -ex

projectType=$1
projectVersion=$2

# prepare versions...
versionMajor=`echo "$projectVersion" | cut -d"." -f1`
versionMinor=`echo "$projectVersion" | cut -d"." -f2`
versionBuild=`echo "$projectVersion" | cut -d"." -f3`

cat <<EOF > local.properties
sdk.dir=/opt/android-sdk-linux
EOF

sudo rm -rf build library/build

JENKINS_HOME="$HOME"
PROJECT_HOME="`pwd`"
JENKINS_USER="`id -u`"

sudo docker run -i \
-v ${JENKINS_HOME}/.gradle:/root/.gradle \
-v ${JENKINS_HOME}/.androidRugionSigning:/root/.androidRugionSigning \
-v ${PROJECT_HOME}:/opt/workspace \
-w /opt/workspace \
--rm scorcher/rugion-android-builder:latest \
/bin/sh -c "./build.sh ${projectType} ${versionMajor} ${versionMinor} ${versionBuild} ${projectVersion} ${JENKINS_USER}"

