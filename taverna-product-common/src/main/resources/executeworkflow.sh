#!/bin/sh

set -e

## resolve links - $0 may be a symlink
prog="$0"

real_path() {
    readlink -m "$1" 2>/dev/null || echo $(cd $(dirname "$1") && pwd -P)/$(basename "$1")
}

realprog=`real_path "$prog"`
taverna_home=`dirname "$realprog"`
javabin=java
if test -x "$taverna_home/jre/bin/java"; then
    javabin="$taverna_home/jre/bin/java"
elif test -x "$JAVA_HOME/bin/java"; then
    javabin="$JAVA_HOME/bin/java"
fi

interaction_settings=""
## Uncomment and change the value of the following line to enable web-driven interaction with
## an external site
## interaction_settings="$interaction_settings -Dtaverna.interaction.host=http://localhost"

## Uncomment the following three lines to enable web-driven interaction
## interaction_settings="$interaction_settings -Dtaverna.interaction.port=8080"
## interaction_settings="$interaction_settings -Dtaverna.interaction.webdav_path=/interaction"
## interaction_settings="$interaction_settings -Dtaverna.interaction.feed_path=/feed"


# 700 MB memory, 200 MB for classes
exec "$javabin" -Xmx700m -XX:MaxPermSize=200m \
  "-Dcom.sun.net.ssl.enableECC=false" \
  "-Djsse.enableSNIExtension=false" \
  "-Draven.profile=file://$taverna_home/conf/current-profile.xml" \
  "-Djava.util.logging.config.file=$taverna_home/lib/logging.properties" \
  "-Dtaverna.startup=$taverna_home" \
  -Djava.system.class.loader=net.sf.taverna.raven.prelauncher.BootstrapClassLoader \
  -Draven.launcher.app.main=net.sf.taverna.t2.commandline.CommandLineLauncher \
  -Draven.launcher.show_splashscreen=false \
  $interaction_settings \
  -Djava.awt.headless=true \
  -jar "$taverna_home/lib/"prelauncher-*.jar \
  ${1+"$@"}
