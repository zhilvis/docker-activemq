FROM java:7

RUN curl http://archive.apache.org/dist/activemq/apache-activemq/5.9.0/apache-activemq-5.9.0-bin.tar.gz | tar -xz

EXPOSE 61612 61613 61616 8161

RUN mv apache-activemq-5.9.0/conf/activemq.xml apache-activemq-5.9.0/conf/activemq.xml.orig
RUN awk '/.*stomp.*/{print "            <transportConnector name=\"stompssl\" uri=\"stomp+nio+ssl://0.0.0.0:61612?transport.enabledCipherSuites=SSL_RSA_WITH_RC4_128_SHA,SSL_DH_anon_WITH_3DES_EDE_CBC_SHA\" />"}1' apache-activemq-5.9.0/conf/activemq.xml.orig >> apache-activemq-5.9.0/conf/activemq.xml

CMD java -Xms1G -Xmx1G -Djava.util.logging.config.file=logging.properties -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote -Djava.io.tmpdir=apache-activemq-5.9.0/tmp -Dactivemq.classpath=apache-activemq-5.9.0/conf -Dactivemq.home=apache-activemq-5.9.0 -Dactivemq.base=apache-activemq-5.9.0 -Dactivemq.conf=apache-activemq-5.9.0/conf -Dactivemq.data=apache-activemq-5.9.0/data -jar apache-activemq-5.9.0/bin/activemq.jar start