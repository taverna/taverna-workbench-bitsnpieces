@ECHO OFF

REM Taverna startup script

REM distribution directory
set TAVERNA_HOME=%~dp0

REM 1000 MB memory, 140 MB for classes
set ARGS=-Xmx1000m -XX:MaxPermSize=140m

REM Taverna system properties
set ARGS=%ARGS% "-Draven.profile=file:%TAVERNA_HOME%conf/current-profile.xml"
set ARGS=%ARGS% -Djava.system.class.loader=net.sf.taverna.raven.prelauncher.BootstrapClassLoader 
set ARGS=%ARGS% -Dsun.swing.enableImprovedDragGesture 
set ARGS=%ARGS% "-Dtaverna.startup=%TAVERNA_HOME%."

java %ARGS% -jar "%TAVERNA_HOME%lib\prelauncher-2.5-SNAPSHOT.jar" %*

pause
