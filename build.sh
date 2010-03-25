#!/bin/bash -e

MONOBJC_VERSION="2.0.492.0"
PKG_VERSION="0"
MONOBJC_DIST="/Users/eric/Downloads/Monobjc-${MONOBJC_VERSION}/dist"
MONODEVELOP_DIST="/Users/eric/Projects/MonoDevelop.Monobjc/bin/Debug"

rm -rfv monobjc monobjc-msbuild

mkdir -p monobjc/lib/mono/monobjc
cp -v $MONOBJC_DIST/libmonobjc.2.dylib     \
      $MONOBJC_DIST/2.0/Monobjc.dll        \
      $MONOBJC_DIST/2.0/Monobjc.xml        \
      $MONOBJC_DIST/2.0/Monobjc.Cocoa.dll  \
      $MONOBJC_DIST/2.0/Monobjc.Cocoa.xml  \
      monobjc/lib/mono/monobjc
      
cat > monobjc/lib/mono/monobjc/Monobjc.dll.config <<EOF
<configuration>
  <dllmap dll="@executable_path/libmonobjc.2.dylib" target="/Library/Frameworks/Mono.framework/Versions/Current/lib/mono/monobjc/libmonobjc.2.dylib"/>
</configuration>
EOF

mkdir -pv monobjc/share/pkgconfig
cat > monobjc/share/pkgconfig/monobjc.pc <<EOF
prefix=/Library/Frameworks/Mono.framework/Versions/Current
exec_prefix=${prefix}
pkglibdir=${exec_prefix}/lib/mono/monobjc
Libraries=${pkglibdir}/Monobjc.dll ${pkglibdir}/Monobjc.Cocoa.dll
 
Name: Monobjc
Description: 
Version: 2.0.476.0
 
Requires: 
Libs: -r:${pkglibdir}/Monobjc.dll -r:${pkglibdir}/Monobjc.Cocoa.dll
EOF

mkdir -p monobjc-msbuild
cp -v $MONODEVELOP_DIST/MonoDevelop.Monobjc.Build.Tasks.dll     \
      $MONODEVELOP_DIST/MonoDevelop.Monobjc.Build.Tasks.dll.mdb \
      $MONODEVELOP_DIST/MonoDevelop.MacDev.dll                  \
      $MONODEVELOP_DIST/MonoDevelop.MacDev.dll.mdb              \
      monobjc-msbuild
      
/Developer/usr/bin/packagemaker -v --doc Monobjc.pmdoc  --out Monobjc-${MONOBJC_VERSION}-${PKG_VERSION}.pkg
