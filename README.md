# Melissa Address Object Linux Java

## Purpose
This code showcases the Melissa Address Object using Java.

Please feel free to copy or embed this code to your own project. Happy coding!

For the latest Melissa Address Object release notes, please visit: https://releasenotes.melissa.com/on-premise-api/address-object/

For further details, please visit: https://docs.melissa.com/on-premise-api/address-object/address-object-quickstart.html

The console will ask the user for:

- Address
- City
- State
- Zip

And return 

- Melissa Address Key (MAK)
- Address Line 1
- Address Line 2
- City
- State
- Zip
- Result Codes

## Tested Environments
- Linux 64-bit Java 19.0.2, Ubuntu 20.04.05 LTS
- Melissa data files for 2024-08

## Required Files and Programs

#### libmdAddr.so

This is the c++ code of the Melissa Object. This file will be downloaded by Melissa Updater!

#### mdAddrJavaWrapper.so

This file needs to be added as a Project Dependency.  This wrapper will need to be in the same directory as the program using it.

#### Data Files
- Addr.dbf
- Congress.csv
- dph256.dte
- dph256.hsa
- dph256.hsc
- dph256.hsf
- dph256.hsn
- dph256.hsv
- dph256.hsx
- ews.txt
- lcd256
- mdAddr.dat
- mdAddr.lic
- mdAddr.nat
- mdAddr.str
- mdAddrKey.db
- mdAddrKeyCA.db
- mdCanada3.db
- mdCanadaPOC.db
- mdLACS256.dat
- mdRBDI.dat
- mdSteLink256.dat
- mdSuiteFinder.db
- month256.dat

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
This project is compatible with Java 19

#### Install Java
Before starting, make sure that Java has been correctly installed on your machine and your environment paths are configured. 

You may find detailed instructions here:
https://javahelps.com/install-oracle-jdk-19-on-linux

You can download Java 19 here: 
https://www.oracle.com/java/technologies/downloads/#jdk19-linux

Or you may also download Java 19 onto your Linux-based computer with
`wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz`

You may have to add "sudo" before the above command as well if you are using a virtual machine.

Next, navigate to where the JDK was downloaded and extract the contents. You may use the command:
`sudo tar -xvzf ~/Downloads/jdk-19_linux-x64_bin.tar.gz`

Next, set up your environment. Start by entering the command `sudo nano /etc/environment` to bring up your environment PATH and add `/usr/lib/jvm/jdk-19.0.1/bin`. PATH variable must be separated by a colon so be sure to add one to the beginning of the path if there are already variables present.

Note that the version of the Java 19 JDK you downloaded may be slightly different, in which case be sure to adjust your statements accordingly. For example you may need to add `/usr/lib/jvm/jdk-19.0.2/bin` to you PATH instead depending on if Java has updated their Java 19 JDK

Next add the line `JAVA_HOME="/usr/lib/jvm/jdk-19.0.1"` to the end of the file.
Your file should look something like this:
```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/jdk-19.0.1/bin"
JAVA_HOME="/usr/lib/jvm/jdk-19.0.1"
```

Press ctrl + X exit and Y to save the file.

If you already have a version of JDK installed then you will want to add Java 19 JDK as an alternative shortcut. To do so enter:
`sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-19.0.1/bin/java" 0` and
`sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk-19.0.1/bin/javac" 0`

Then to set these shortcuts enter:
`sudo update-alternatives --set java /usr/lib/jvm/jdk-19.0.1/bin/java` and
`sudo update-alternatives --set javac /usr/lib/jvm/jdk-19.0.1/bin/javac`

Again note that you may need to change the specific version of Java to the one you downloaded.

You can check that your environment is set up correctly by opening a command prompt window and typing the following:
`java --version`

![alt text](/screenshots/java_version.PNG)

If you see the version number then you have installed Java and set up your environment paths correctly!

----------------------------------------

#### Download this project
```
$ git clone https://github.com/MelissaData/AddressObject-Java-Linux
$ cd AddressObject-Java-Linux
```

#### Set up Melissa Updater 
Melissa Updater is a CLI application allowing the user to update their Melissa applications/data. 

- In the root directory of the project, create a folder called `MelissaUpdater` by using the command: 

  `mkdir MelissaUpdater`

- Enter the newly created folder using the command:

  `cd MelissaUpdater`

- Proceed to install the Melissa Updater using the curl command: 

  `curl -L -O https://releases.melissadata.net/Download/Library/LINUX/NET/ANY/latest/MelissaUpdater`

- After the Melissa Updater is installed, you will need to change the Melissa Updater to an executable using the command:

  `chmod +x MelissaUpdater`

- Now that the Melissa Updater is set up, you can now proceed to move back into the project folder by using the command:
  
   `cd ..`

----------------------------------------

#### Different ways to get data file(s)
1.  Using Melissa Updater
    - It will handle all of the data download/path and dll(s) for you. 
2.  If you already have the latest DQS release zip, you can find the data file(s) in there
    - To pass in your own data file path directory, you may either use the '--dataPath' parameter or enter the data file path directly in interactive mode.
    - Comment out this line "DownloadDataFiles $license" in the bash script.
    - This will prevent you from having to redownload all the files.
	
#### Change Bash Script Permissions
To be able to run the bash script, you must first make it an executable using the command:

`chmod +x MelissaAddressObjectLinuxJava.sh`

Then you need to add permissions to the build directory with the command:

`chmod +rwx MelissaAddressObjectLinuxJava`

As an indicator, the filename will change colors once it becomes an executable.

## Run Bash Script
Parameters:
- --address: a test street address (house number & street name)
- --city (optional): a test city
- --state (optional): a test state
- --zip (optional): a test zip code
 	
  These are convenient when you want to get results for a specific address in one run instead of testing multiple addresses in interactive mode.  

- --dataPath (optional): a data file path directory to test the Address Object
- --license (optional): a license string to test the Address Object
- --quiet (optional): add to the command if you do not want to get any console output from the Melissa Updater
- Interactive 

	The script will prompt the user for an address, city, state, and zip, then use the provided inputs to test Address Object. For example:
	```
	$ ./MelissaAddressObjectLinuxJava.sh
	```
    For quiet mode:
    ```
    $ ./MelissaAddressObjectLinuxJava.sh -quiet
    ```
- Command Line 

	You can pass an address, city, state, zip, and a license string into the ```--address```, ```--city```, ```--state```, ```--zip```, and ```--license``` parameters respectively to test Address Object. For example:

    With all parameters:
    ```
    $ ./MelissaAddressObjectLinuxJava.sh --address "22382 Avenida Empresa" --city "Rancho Santa Margarita" --state "CA" --zip "92688"
    $ ./MelissaAddressObjectLinuxJava.sh --address "22382 Avenida Empresa" --city "Rancho Santa Margarita" --state "CA" --zip "92688" --license "<your_license_string>"
    ```

    With any known (optional) parameters:
    ```
    $ ./MelissaAddressObjectLinuxJava.sh --address "22382 Avenida Empresa" --state "CA" 
    $ ./MelissaAddressObjectLinuxJava.sh --address "22382 Avenida Empresa" --state "CA" --license "<your_license_string>"
    ```

    For quiet mode:
    ```
    $ ./MelissaAddressObjectLinuxJava.sh --address "22382 Avenida Empresa" --city "Rancho Santa Margarita" --state "CA" --zip "92688" --quiet
    $ ./MelissaAddressObjectLinuxJava.sh --address "22382 Avenida Empresa" --city "Rancho Santa Margarita" --state "CA" --zip "92688" --license "<your_license_string>" --quiet
    ```
This is the expected output of a successful setup for interactive mode:

![alt text](/screenshots/output.png)

## Troubleshooting
Troubleshooting for errors found while running your program.

### Errors:
| Error      | Description |
| ----------- | ----------- |
| ErrorRequiredFileNotFound      | Program is missing a required file. Please check your Data folder and refer to the list of required files above. If you are unable to obtain all required files through the Melissa Updater, please contact technical support below. |
| ErrorLicenseExpired   | Expired license string. Please contact technical support below. |

## Contact Us
For free technical support, please call us at 800-MELISSA ext. 4
(800-635-4772 ext. 4) or email us at tech@Melissa.com.

To purchase this product, contact Melissa sales department at
800-MELISSA ext. 3 (800-635-4772 ext. 3).
