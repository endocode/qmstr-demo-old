FROM cangol/android-gradle

RUN chmod -R 777 /android-sdk-linux
COPY --from=qmstr/javademobase /maven /maven
COPY --from=qmstr/javademobase /usr/share/maven/conf/settings.xml /maven/conf

ENV M2_HOME /maven


WORKDIR /buildroot/blockly-android
