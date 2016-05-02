# cau-vivo-harvest
## Harvester for CAU VIVO

This project contains customizations for deploying the VIVO application for the China Agriculture Universities (CAU).

### Dependencies

* VIVO Software (https://github.com/vivo-project/VIVO/releases/) - currently using version 1.8.1
* JAVA jdk (version 1.7.x or later
* Apache Tomcat (version 7.x)
* Apache Ant
* MySQL
* VIVO-Harvester (https://github.com/vivo-project/VIVO-Harvester) - use develop branch

### Initial configuration

Once all of the dependencies are installed and the cau-vivo-harvester project has been downloaded an initial configuration can be done to get the VIVO software ready
for deployment.


* Run MySQL from the command line then create the database for the VIVO installation
 
 
 ```
 > CREATE DATABASE vitrodb18 character set utf8;
  ``` 
* Grant access to the VIVO database (replace USERNAME and PASSWORD with actual values.)
 ```
 > GRANT ALL ON vitrodb18.* TO 'USERNAME'@'localhost' IDENTIFIED BY 'PASSWORD';
```

* Go to the working directory where the cau-vivo-harvester code has been downloaded (e.g. /usr/local/src/cau-vivo-harvest)
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
  VitroConnection.DataSource.username = USERNAME  VitroConnection.DataSource.password = PASSWORD  
  ```
