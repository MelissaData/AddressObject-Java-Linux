#!/bin/bash

# Name:    MelissaAddressObjectLinuxJava
# Purpose: Use the Melissa Updater to make the MelissaAddressObjectLinuxJava code usable

######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

address=""
city=""
state=""
zip=""
dataPath=""
license=""
quiet="false"

while [ $# -gt 0 ] ; do
  case $1 in
    --address) 
        address="$2"

        if [ "$address" == "--city" ] || [ "$address" == "--state" ] || [ "$address" == "--zip" ] || [ "$address" == "--dataPath" ] || [ "$address" == "--license" ] || [ "$address" == "--quiet" ] || [ -z "$address" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'address\'.${NC}\n"  
            exit 1
        fi  
        ;;
	--city) 
        city="$2"

        if [ "$city" == "--address" ] || [ "$city" == "--state" ] || [ "$city" == "--zip" ] || [ "$city" == "--dataPath" ] || [ "$city" == "--license" ] || [ "$city" == "--quiet" ] || [ -z "$city" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'city\'.${NC}\n"  
            exit 1
        fi  
        ;;
	--state) 
        state="$2"

        if [ "$state" == "--city" ] || [ "$state" == "--address" ] || [ "$state" == "--zip" ] || [ "$state" == "--dataPath" ] || [ "$state" == "--license" ] || [ "$state" == "--quiet" ] || [ -z "$state" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'state\'.${NC}\n"  
            exit 1
        fi   
        ;;
	--zip) 
        zip="$2"

        if [ "$zip" == "--city" ] || [ "$zip" == "--state" ] || [ "$zip" == "--address" ] || [ "$zip" == "--dataPath" ] || [ "$zip" == "--license" ] || [ "$zip" == "--quiet" ] || [ -z "$zip" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'zip\'.${NC}\n"  
            exit 1
        fi   
        ;;		
    --dataPath) 
        dataPath="$2"

        if [ "$dataPath" == "--address" ] || [ "$dataPath" == "--city" ] || [ "$dataPath" == "--state" ] || [ "$dataPath" == "--zip" ] || [ "$dataPath" == "--license" ] || [ "$dataPath" == "--quiet" ] || [ -z "$dataPath" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'dataPath\'.${NC}\n"  
            exit 1
        fi   
        ;;

    --license) 
        license="$2"

        if [ "$license" == "--city" ] || [ "$license" == "--state" ] || [ "$license" == "--zip" ] || [ "$license" == "--dataPath" ] || [ "$license" == "--address" ] || [ "$license" == "--quiet" ] || [ -z "$license" ];
        then
            printf "${RED}Error: Missing an argument for parameter \'license\'.${NC}\n"  
            exit 1
        fi    
        ;;
    --quiet) 
        quiet="true" 
        ;;
  esac
  shift
done


# ######################### Config ###########################
RELEASE_VERSION='2025.07'
ProductName="DQ_ADDR_DATA"

# Uses the location of the .sh file 
CurrentPath=$(pwd)
ProjectPath="$CurrentPath/MelissaAddressObjectLinuxJava"

if [ -z "$dataPath" ];
then
    DataPath="$ProjectPath/Data"
else
    DataPath=$dataPath
fi

if [ ! -d "$DataPath" ] && [ "$DataPath" == "$ProjectPath/Data" ];
then
    mkdir "$DataPath"
elif [ ! -d "$DataPath" ] && [ "$DataPath" != "$ProjectPath/Data" ];
then
    printf "\nData file path does not exist. Please check that your file path is correct.\n"
    printf "\nAborting program, see above.\n"
    exit 1
fi

# Config variables for download file(s)
Config_FileName="libmdAddr.so"
Config_ReleaseVersion=$RELEASE_VERSION
Config_OS="LINUX"
Config_Compiler="GCC48"
Config_Architecture="64BIT"
Config_Type="BINARY"

Wrapper_FileName="libmdAddrJavaWrapper.so"
Wrapper_ReleaseVersion=$RELEASE_VERSION
Wrapper_OS="LINUX"
Wrapper_Compiler="JAVA"
Wrapper_Architecture="64BIT"
Wrapper_Type="INTERFACE"

Com_FileName="mdAddr_JavaCode.zip"
Com_ReleaseVersion=$RELEASE_VERSION
Com_OS="ANY"
Com_Compiler="JAVA"
Com_Architecture="ANY"
Com_Type="INTERFACE"

# ######################## Functions #########################
DownloadDataFiles()
{
    printf "========================== MELISSA UPDATER =========================\n"
    printf "MELISSA UPDATER IS DOWNLOADING DATA FILE(S)...\n"

    ./MelissaUpdater/MelissaUpdater manifest -p $ProductName -r $RELEASE_VERSION -l $1 -t $DataPath 

    if [ $? -ne 0 ];
    then
        printf "\nCannot run Melissa Updater. Please check your license string!\n"
        exit 1
    fi     
    
    printf "Melissa Updater finished downloading data file(s)!\n"
}

DownloadSO() 
{
    printf "\nMELISSA UPDATER IS DOWNLOADING SO(S)...\n"
    
    # Check for quiet mode
    if [ $quiet == "true" ];
    then
        ./MelissaUpdater/MelissaUpdater file --filename $Config_FileName --release_version $Config_ReleaseVersion --license $1 --os $Config_OS --compiler $Config_Compiler --architecture $Config_Architecture --type $Config_Type --target_directory $ProjectPath &> /dev/null
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi
    else
        ./MelissaUpdater/MelissaUpdater file --filename $Config_FileName --release_version $Config_ReleaseVersion --license $1 --os $Config_OS --compiler $Config_Compiler --architecture $Config_Architecture --type $Config_Type --target_directory $ProjectPath 
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi
    fi
    
    printf "Melissa Updater finished downloading $Config_FileName!\n"
}

DownloadWrappers() 
{    
    # Check for quiet mode
    if [ $quiet == "true" ];
    then
        # Download the wrapper
        ./MelissaUpdater/MelissaUpdater file --filename $Wrapper_FileName --release_version $Wrapper_ReleaseVersion --license $1 --os $Wrapper_OS --compiler $Wrapper_Compiler --architecture $Wrapper_Architecture --type $Wrapper_Type --target_directory $ProjectPath &> /dev/null
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        # Download the com zip
        ./MelissaUpdater/MelissaUpdater file --filename $Com_FileName --release_version $Com_ReleaseVersion --license $1 --os $Com_OS --compiler $Com_Compiler --architecture $Com_Architecture --type $Com_Type --target_directory $ProjectPath &> /dev/null
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi
    else
        #Download the wrapper
        ./MelissaUpdater/MelissaUpdater file --filename $Wrapper_FileName --release_version $Wrapper_ReleaseVersion --license $1 --os $Wrapper_OS --compiler $Wrapper_Compiler --architecture $Wrapper_Architecture --type $Wrapper_Type --target_directory $ProjectPath 
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi

        # Download the com zip
        ./MelissaUpdater/MelissaUpdater file --filename $Com_FileName --release_version $Com_ReleaseVersion --license $1 --os $Com_OS --compiler $Com_Compiler --architecture $Com_Architecture --type $Com_Type --target_directory $ProjectPath 
        if [ $? -ne 0 ];
        then
            printf "\nCannot run Melissa Updater. Please check your license string!\n"
            exit 1
        fi
    fi
    
    printf "Melissa Updater finished downloading $Wrapper_FileName!\n"

    printf "Melissa Updater finished downloading $Com_FileName!\n"

    # Check for the zip folder and extract from the zip folder if it was downloaded
    if [ ! -f "$ProjectPath/mdAddr_JavaCode.zip" ];
    then
        printf "mdAddr_JavaCode.zip not found.\n"
        printf "Aborting program, see above.\n"

        exit 1
    else
        if [ ! -d "$ProjectPath/com" ];
        then
            unzip "$ProjectPath/mdAddr_JavaCode.zip" -d "$ProjectPath"
        else
            rm -r "$ProjectPath/com"

            unzip "$ProjectPath/mdAddr_JavaCode.zip" -d "$ProjectPath"
        fi
    fi
}

CheckSOs() 
{
    if [ ! -f $ProjectPath/$Config_FileName ];
    then
        echo "false"
    else
        echo "true"
    fi
}

########################## Main ############################
printf "\n===================== Melissa Address Object =======================\n                    [ Java | Linux | 64BIT ]\n"

# Get license (either from parameters or user input)
if [ -z "$license" ];
then
  printf "Please enter your license string: "
  read license
fi

# Check license from Environment Variables 
if [ -z "$license" ];
then
  license=`echo $MD_LICENSE` 
fi

if [ -z "$license" ];
then
  printf "\nLicense String is invalid!\n"
  exit 1
fi

# Get data file path (either from parameters or user input)
if [ "$DataPath" = "$ProjectPath/Data" ]; then
    printf "Please enter your data files path directory if you have already downloaded the release zip.\nOtherwise, the data files will be downloaded using the Melissa Updater (Enter to skip): "
    read dataPathInput

    if [ ! -z "$dataPathInput" ]; then  
        if [ ! -d "$dataPathInput" ]; then  
            printf "\nData file path does not exist. Please check that your file path is correct.\n"
            printf "\nAborting program, see above.\n"
            exit 1
        else
            DataPath=$dataPathInput
        fi
    fi
fi

# Use Melissa Updater to download data file(s) 
# Download data file(s) 
DownloadDataFiles $license # Comment out this line if using own DQS release

# Download SO(s)
DownloadSO $license 

# Download wrapper and com folder
DownloadWrappers $license

# Check if all SO(s) have been downloaded. Exit script if missing
printf "\nDouble checking SO file(s) were downloaded...\n"

SOsAreDownloaded=$(CheckSOs)

if [ "$SOsAreDownloaded" == "false" ];
then
    printf "\n$Config_FileName not found"
    printf "\nMissing the above data file(s).  Please check that your license string and directory are correct.\n"

    printf "\nAborting program, see above.\n"
    exit 1
fi

printf "\nAll file(s) have been downloaded/updated!\n"

# Start
# Build project
cd $ProjectPath
printf "\n=========================== BUILD PROJECT ==========================\n"
javac -cp .:com/melissadata/*.java MelissaAddressObjectLinuxJava.java
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/.
jar cvfm MelissaAddressObjectLinuxJava.jar manifest.txt com/melissadata/*.class *.class *.so

# Run project
if [ -z "$address" ] && [ -z "$city" ] && [ -z "$state" ] && [ -z "$zip" ];
then
    java -jar MelissaAddressObjectLinuxJava.jar --license $license --dataPath $DataPath
else
    java -jar MelissaAddressObjectLinuxJava.jar --license $license --dataPath $DataPath --address "$address" --city "$city" --state "$state" --zip "$zip"
fi
