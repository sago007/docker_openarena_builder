#! /bin/bash
set -euo pipefail
cd /staging
git clone https://github.com/salandgame/saland.git
cd saland
VERSION_ID=$(git log -1 --date=short --format="saland_%cd_%h")
echo $VERSION_ID
ZIPFILE="/data/${VERSION_ID}.zip"
if [ -e "$ZIPFILE" ]
then
 echo "$ZIPFILE exist -> UP TO DATE"
 exit 1
fi
STAGING_DIR=/staging/saland_windows
mkdir $STAGING_DIR
./packdata.sh
i686-w64-mingw32.static-cmake .
make
mv /staging/saland/saland.exe $STAGING_DIR/
cp -r /staging/saland/packages $STAGING_DIR/
cd /staging
zip -r $VERSION_ID saland_windows
chmod 644 $VERSION_ID.zip
mv $VERSION_ID.zip /data/
