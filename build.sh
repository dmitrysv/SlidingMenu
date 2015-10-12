#!/bin/bash -ex

projectType=$1
versionMajor=$2
versionMinor=$3
versionBuild=$4
version=$5
JENKINS_USER=$6

./gradlew -PcurrentVersionMajor=${versionMajor} -PcurrentVersionMinor=${versionMinor} -PcurrentVersionBuild=${versionBuild} clean assembleRelease

./gradlew -PcurrentVersionMajor=${versionMajor} -PcurrentVersionMinor=${versionMinor} -PcurrentVersionBuild=${versionBuild} -PpublishRepo=rugion-lib-release library:artifactoryPublish

chown -fR ${JENKINS_USER} .
