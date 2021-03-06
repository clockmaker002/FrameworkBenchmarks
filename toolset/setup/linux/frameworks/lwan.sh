#!/bin/bash

RETCODE=$(fw_exists ${IROOT}/lwan.installed)
[ ! "$RETCODE" == 0 ] || { \
  source $IROOT/lwan.installed
  return 0; }

REV='f1cd15c1a1bd15791c9f321fdc8c3ddb8d0e3799'
LWAN_HOME=$IROOT/lwan

[ ! -e $IROOT/lwan.installed -a -d $LWAN_HOME ] && rm -rf $LWAN_HOME

# Lwan is only built during installation as a dependency sanity check.
git clone git://github.com/lpereira/lwan.git
cd $LWAN_HOME
git checkout ${REV}
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$IROOT
make techempower
make install

echo "export LWAN_ROOT=${LWAN_HOME}" > $IROOT/lwan.installed
echo -e "export LWAN_BUILD=\$LWAN_ROOT/build" >> $IROOT/lwan.installed

source $IROOT/lwan.installed
