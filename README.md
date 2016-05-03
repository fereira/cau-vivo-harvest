# cau-vivo-harvest
## Harvester for CAU VIVO

This project contains customizations for deploying the VIVO application for the China Agriculture Universities (CAU). For the
purposes of explaining the installing process use the following environment variables.  Example directory names have been provided.

* $VIVO_INSTALL_DIR  - /usr/local/src/vivo-rel-1.8.1
* $JAVA_HOME - /usr/local/java
* $TOMCAT_HOME - /usr/local/tomcat
* $ANT_HOME - /usr/local/apache-ant-1.9.6
* $MYSQL_HOME - /usr/local/mysql
* $VIVO_HARVESTER_DIR - /usr/local/src/VIVO-Harvester
* $CAU_VIVO_DIR - /usr/local/cau-vivo-harvest


### Dependencies

* VIVO Software (https://github.com/vivo-project/VIVO/releases/) - currently using version 1.8.1
  * install software $VIVO_INSTALL_DIR
* JAVA jdk (version 1.7.x or later
  * Install to $JAVA_HOME
* Apache Tomcat (version 7.x)
  * Install to $TOMCAT_HOME
* Apache Ant - version 1.9.* recommended
  * Install to $ANT_HOME
* MySQL - version 5.1.* or later recommended
  * Install to $MYSQL_HOME
* VIVO-Harvester (https://github.com/vivo-project/VIVO-Harvester) - use develop branch
  * Install to $VIVO_HARVESTER_DIR

### Initial configuration

Once all of the dependencies are installed install the cau-vivo-harvest software to the $CAU_VIVO_DIR directory. Initial configuration
involves setting up the VIVO database and applying local modifications and configuration to the VIVO sofware in $VIVO_INSTALL_DIR


* Run MySQL from the command line then create the database for the VIVO installation
 
 ```
 > CREATE DATABASE vitrodb18 character set utf8;
  ``` 
* Grant access to the VIVO database (replace USERNAME and PASSWORD with actual values.)
 ```
 > GRANT ALL ON vitrodb18.* TO 'USERNAME'@'localhost' IDENTIFIED BY 'PASSWORD';
```

* Go to the cau-vivo-harvest working ($CAU_VIVO_DIR)
* Edit the localMods/v1.8/build.properties file
  * Set tomcat.home to the location where tomcat was installed  
  ``` tomcat.home = /usr/local/tomcat ```
  * Set webapp.name to the name of the vivo instance  
  ``` webapp.name = vivo-1.8 ```
  * Set vitro.home to the location of the VIVO home directory   
  ``` vitro.home = /usr/local/vivo-1.8/home ```
* Copy localMods/v1.8/example.runtime.properties to localMods/v1.8/runtime.properties
* Edit the runtime.properties file
  * change the Vitro.defaultNamespace line to match the namespace for the vivo instance, for example:
  ```
  Vitro.defaultNamespace = http://yourhostname:8080/vivo-1.8/individual/
  ```
  * Change the database connection URL, username and password to match what was used when creating the database.
  ```
  VitroConnection.DataSource.url=jdbc:mysql://yourhostname/vitrodb18useUnicode=true&characterEncoding=utf-8
  VitroConnection.DataSource.username = USERNAME  
  VitroConnection.DataSource.password = PASSWORD  
  ```
* Copy local modifications to the VIVO instance using the ant build.xml file in the $CAU_VIVO_DIR directory
```
% cd /usr/local/src/cau-vivo-harvest
% ant localMods
```
* Deploy the VIVO software to Tomcat and set up the VIVO_HOME directory
```
% cd /usr/local/src/vivo-rel-1.8.1
% ant all
```
* Start up Tomcat 
```
% cd $TOMCAT_HOME/bin
% sh startup.sh
```
* Use a browser to determine if VIVO is running.  Enter http://YOURHOSTNAME:8080/vivo-1.8 into the browser.  The first time VIVO starts
it will display a diagnostic screen which may display some warnings.  Click on "Continue" to start VIVO.  If everything worked, view the cau-vivo-harvest.txt 
file for information on how to harvest data into the VIVO instance.



