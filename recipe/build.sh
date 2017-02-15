#!/bin/bash

CPPFLAGS=-I${PREFIX}/include \
LDFLAGS=-L${PREFIX}/lib      \
  ./configure --prefix=${PREFIX} \
              --with-launchd-agent-dir=${PREFIX} \
              --disable-systemd \
              --disable-selinux \
              --disable-xml-docs
make -j${CPU_COUNT}
make check
make install

if [[ -f ${RECIPE_DIR}/post-link.sh.$(uname) ]]; then
  cp ${RECIPE_DIR}/post-link.sh.$(uname) "${PREFIX}/bin/.dbus-post-link.sh"
fi
