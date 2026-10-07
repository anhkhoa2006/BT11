@echo off
set "JAVA_HOME=C:\Program Files\Java\jdk-26.0.2.1"
set "CATALINA_HOME=C:\Program Files\apache-tomcat-10.1.57"
set "CATALINA_BASE=E:\LT_WEB\.metadata\.plugins\org.eclipse.wst.server.core\tmp0"

"%JAVA_HOME%\bin\java.exe" "-Dcatalina.base=%CATALINA_BASE%" "-Dcatalina.home=%CATALINA_HOME%" "-Dwtp.deploy=%CATALINA_BASE%\wtpwebapps" "-Djava.library.path=%CATALINA_HOME%\bin" --enable-native-access=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED -Dfile.encoding=UTF-8 -classpath "%CATALINA_HOME%\bin\bootstrap.jar;%CATALINA_HOME%\bin\tomcat-juli.jar" org.apache.catalina.startup.Bootstrap start
