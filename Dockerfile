FROM pizzafactory0contorno/piatto-quadrato:debian-9.11_xpra

USER root
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    SDK_TOOL_VERSION=sdk-tools-linux-4333796 \
    ANDROID_HOME=/usr/local/android-sdk-linux \
    BUILD_TOOLS_VERSION=28.0.3 \
    PLATFORMS_VERSION=android-28
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin

RUN apt-get update && apt-get upgrade -y && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install -y openjdk-8-jdk python wget unzip \
      cmake make g++ binutils gdb \
      pkg-config fontconfig \
      libgtk-3-dev libglew-dev libsqlite3-dev libcurl4-openssl-dev && \
#PRIVATE    : "Install android sdk tools" && \
#PRIVATE    mkdir $ANDROID_HOME && \
#PRIVATE    wget -q "https://dl.google.com/android/repository/${SDK_TOOL_VERSION}.zip" && \
#PRIVATE    unzip -d $ANDROID_HOME $SDK_TOOL_VERSION.zip && \
#PRIVATE    rm -rf $SDK_TOOL_VERSION.zip && \
#PRIVATE    : "Agree licenses" && \
#PRIVATE    mkdir ~/.android && \
#PRIVATE    touch ~/.android/repositories.cfg && \
#PRIVATE    yes | sdkmanager --licenses && \
    true

# install android tools and more
#PRIVATERUN sdkmanager "tools" "build-tools;${BUILD_TOOLS_VERSION}" "platforms;${PLATFORMS_VERSION}" "platform-tools" "extras;android;m2repository" "ndk-bundle"

ENV COCOS_X_VERSION=3.17.2
RUN wget -q https://digitalocean.cocos2d-x.org/Cocos2D-X/cocos2d-x-$COCOS_X_VERSION.zip && \
    unzip cocos2d-x-$COCOS_X_VERSION.zip && mv cocos2d-x-3.17.2 /usr/local/cocos2d-x && \
    rm cocos2d-x-$COCOS_X_VERSION.zip

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
ENV COCOS_CONSOLE_ROOT=/usr/local/cocos2d-x/tools/cocos2d-console/bin
ENV PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
ENV COCOS_X_ROOT=/usr/local
ENV PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
ENV COCOS_TEMPLATES_ROOT=/usr/local/cocos2d-x/templates
ENV PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable NDK_ROOT for cocos2d-x
ENV NDK_ROOT="/usr/local/android-sdk-linux/ndk-bundle/"
ENV PATH=$NDK_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
ENV ANDROID_SDK_ROOT="/usr/local/android-sdk-linux"
ENV PATH=$ANDROID_SDK_ROOT:$PATH
ENV PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

RUN yes n | cocos

USER user

