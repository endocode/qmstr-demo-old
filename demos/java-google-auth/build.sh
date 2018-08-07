#!/bin/bash
set -e

echo "######################"
echo "# Running GAuth demo #"
echo "######################"

if [ "$(uname -s)" = 'Linux' ]; then
DEMOWD="$(dirname "$(readlink -f "$0")")"
else
DEMOWD="$(dirname "$(greadlink -f "$0")")"
fi

source ${DEMOWD}/../../build.inc
pushd ${DEMOWD}
setup_git_src https://github.com/google/google-authenticator-android.git master google-auth

pushd google-auth
git clean -fxd
echo "Applying qmstr plugin to gradle build configuration"
patch -p1  < ${DEMOWD}/add-qmstr.patch
popd

echo "Waiting for qmstr-master server"
eval $(qmstrctl start --wait --verbose)

echo "[INFO] Start gradle build"
qmstr --container qmstr/java-google-authdemo ./gradlew qmstr

echo "[INFO] Build finished. Triggering analysis."
qmstrctl analyze --verbose

echo "[INFO] Analysis finished. Triggering reporting."
qmstrctl report --verbose

qmstrctl quit

echo "[INFO] Build finished."
