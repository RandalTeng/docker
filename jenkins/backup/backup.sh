#!/bin/bash
set -o nounset
containerBackupDir="/var/backup" && readonly containerBackupDir
containerName='jenkins' && readonly containerName
hostBackupDir="${JENKINS_BACKUP_DIR}" && readonly hostBackupDir
timeForFile=$(date "+%Y%m%d-%H%M") && readonly timeForFile
backupFileName="jenkins-${time}.tar" && readonly backupFileName
jenkinsHomeDir="/var/jenkins_home" && readonly jenkinsHomeDir

set -o errexit
result=$(docker run --rm \
    --volumes-from $containerName \
    -v $hostBackupDir:$containerBackupDir \
    ubuntu \
    tar cvf "$containerBackupDir$backupFileName" $jenkinsHomeDir)
echo -e "Backup success at $(date "+%Y-%m-%d %H:%M:%S").\n"
echo -e "$hostBackupDir$backupFileName\n"
exit 0