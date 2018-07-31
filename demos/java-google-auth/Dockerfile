FROM qmstr/javademobase

RUN apt install -y wget unzip

RUN wget -O /tmp/sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

RUN mkdir /android-sdk
RUN unzip /tmp/sdk-tools.zip -d /android-sdk
RUN yes | /android-sdk/tools/bin/sdkmanager "platforms;android-25" "build-tools;27.0.3" "platform-tools"
ENV ANDROID_HOME /android-sdk

VOLUME /buildroot

WORKDIR /buildroot/google-auth
