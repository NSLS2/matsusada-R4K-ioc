#!../../bin/linux-x86_64/matsusada_R4K

<xf31id1-lab3-ioc1-netsetup.cmd

epicsEnvSet("ENGINEER",  "C. Engineer")
epicsEnvSet("LOCATION",  "LAB3")

epicsEnvSet("IOCNAME",   "r4k")
epicsEnvSet("SYS",       "XF:31ID1-BI")
epicsEnvSet("DEV",       "{PWR:1}")
epicsEnvSet("IOC_SYS",   "XF:31ID1-CT")
epicsEnvSet("IOC_DEV",   "{IOC:$(IOCNAME)}")

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase("dbd/matsusada_R4K.dbd")
matsusada_R4K_registerRecordDeviceDriver pdbbase


## Streamdevice Protocol Path
epicsEnvSet ("STREAM_PROTOCOL_PATH", "protocols")

# Controller-specific variables
epicsEnvSet("PORT","matsu-px")
epicsEnvSet("DEV","{RG:T}")
epicsEnvSet("IP","10.69.57.80:10001")

drvAsynIPPortConfigure("$(PORT)", "$(IP)")

## Load record instances
dbLoadRecords("db/R4K_80H.db", "Sys=${SYS},Dev=${DEV},PORT=${PORT}")

epicsEnvSet("IOC_PREFIX", "$(IOC_SYS)$(IOC_DEV)")

dbLoadRecords("$(DEVIOCSTATS)/db/iocAdminSoft.db", "IOC=${IOC_PREFIX}")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=${IOC_PREFIX}")
dbLoadRecords("${RECCASTER}/db/reccaster.db", "P=${IOC_PREFIX}RecSync")

#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit
