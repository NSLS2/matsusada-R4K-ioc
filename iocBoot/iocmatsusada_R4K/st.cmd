#!../../bin/linux-x86_64/matsusada_R4K

#- You may have to change matsusada_R4K to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/matsusada_R4K.dbd"
matsusada_R4K_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadTemplate "db/user.substitutions"
dbLoadRecords "db/matsusada_R4KVersion.db", "user=dgavrilov"
dbLoadRecords "db/dbSubExample.db", "user=dgavrilov"

#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=dgavrilov"
