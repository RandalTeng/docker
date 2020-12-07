#!/bin/bash
set -euo pipefail

resetCount=0
function checkAndResetContainerName() {
    set -o errexit
    existsContainerNameList=$(docker ps -a --format "{{.Names}}")
    for name in existsContainerNameList
    do
        if [[ name = containerName ]]
        then
            resetCount++
            containerName="$containerName_$resetCount"
            return checkAndResetContainerName
        fi
    done
    return 0
}

function findLastPosition() {
    strToCheck=${1-""}
    charToSearch=${2-"/"}
    return $(echo "$strToCheck" | awk -F ''$charToSearch'' '{printf "%d", length($0)-length($NF)}')
}

hostBackupDir=${JENKINS_BACKUP_DIR-"./"}
hostBackupFileName=${1-""}
targetCodeDir=${2-""}
jenkinsHomeParentDir="/var" && readonly jenkinsHomeParentDir
containerBackupFileName="${jenkinsHomeParentDir}/restore.tar" && readonly containerBackupFileName
jenkinsHomeDirName="${jenkinsHomeParentDir}/jenkins_home" && readonly jenkinsHomeDirName
jenkinsDataContainerName='jenkins-data' && readonly jenkinsDataContainerName

containerName="jenkins"
a=$(findLastPosition ${targetCodeDir})
lastDesPos=$?
echo $lastDesPos
targetCodeRoot=${targetCodeDir:0:lastDesPos}
echo $targetCodeRoot
targetCodeDirName=${targetCodeDir:lastDesPos}
echo $targetCodeDirName
exit 0

if [ "${hostBackupDir:-1:1}" != "/" ]; then
    hostBackupDir="${hostBackupDir}/"
fi
if [ ! -n hostBackupFileName ]; then
    echo "Backup file is require."
    exit 1
fi
if [ "${hostBackupFileName:0:1}" != "/" ]; then
    hostBackupFileName="$hostBackupDir$hostBackupFileName"
fi
if [ ! -e $hostBackupFileName ]; then
    echo "Backup file \`$hostBackupFileName\` does not exists."
    exit 2
fi

checkAndResetContainerName

echo "------ Check container exists start. ------"
containerExistsOrNot=$(docker stop ${containerName} || true && docker rm ${containerName} || true)
dataContainerExistsOrNot=$(docker rm -v ${jenkinsDataContainerName} || true)
echo "------ Check container exists end. ------"

echo "------ Create data container start. ------"
createDataContainer=$(docker run -v ${jenkinsHomeDirName} --name ${jenkinsDataContainerName} ubuntu /bin/bash)
tmpContainer=$(docker run --rm -d --volumes-from ${jenkinsDataContainerName} ubuntu sleep 10)
createUntarContainer=$(docker cp ${hostBackupFileName} ${tmpContainer}:${containerBackupFileName} && \
    docker exec ${tmpContainer} bash -c "cd ${jenkinsHomeParentDir} && tar xvf ${containerBackupFileName} --strip 1 &&  rm -rf ${containerBackupFileName}")
echo "------ Create data container end. ------"

echo "------ Create main container start. ------"
createContainer=$(docker run -d \
    --volumes-from ${jenkinsDataContainerName} \
    --network web_web \
    -v ${targetCodeDir}:${jenkinsHomeDirName}/phpcdr.com:rw \
    --name ${containerName} jenkins/jenkins:lts)
echo "------ Create main container end. ------"

echo "------ All process completed. ------"
echo -e "Restore success at $(date "+%Y-%m-%d %H:%M:%S").\n"
echo -e "New container name is \`$containerName\`\n"
removeDataContainer=$((docker stop $jenkinsDataContainerName && docker rm -v $jenkinsDataContainerName) || true)
exit 0
