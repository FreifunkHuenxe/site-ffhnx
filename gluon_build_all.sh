#!/bin/sh
set -e
BUILD_LOG=gluon-build.log
BUILD_HOME=$(pwd)/gluon-build
GLUON_RELEASE=v2016.2.7
SITE_RELEASE=2016
MY_GLUON_SITE=ffhnx
SITE_DIR=site-$MY_GLUON_SITE
ROOT_DIR=$(pwd)

echo ok, go &> $BUILD_LOG

GL_FOLDER=$BUILD_HOME/gluon
SI_FOLDER=$BUILD_HOME/$SITE_DIR

#altes zeug weg:
rm -rf $BUILD_HOME &>> $BUILD_LOG

mkdir -p $BUILD_HOME
echo BUILD_HOME: $BUILD_HOME
cd $BUILD_HOME
echo in build dir: $PWD
# check out everything
git clone https://github.com/freifunk-gluon/gluon.git gluon -b $GLUON_RELEASE
git clone https://github.com/FreifunkHuenxe/site-ffhnx.git $SITE_DIR -b $SITE_RELEASE

# copy some customizations:
cp $ROOT_DIR/custom-build/mymodules $GL_FOLDER/modules &>> $BUILD_LOG
cp $ROOT_DIR/custom-build/mysite.mk $SI_FOLDER/site.mk &>> $BUILD_LOG

# build everything
BRANCH=stable

cd $GL_FOLDER #1>> $BUILD_LOG

SITE="site-$(cat $SI_FOLDER/site.conf |grep site_code|awk {'print $3'}|sed "s/'//g"|sed "s/,//g")"
make update GLUON_SITEDIR=$SI_FOLDER &>> $BUILD_LOG # Get other repositories used by Gluon

#clear
echo "== Building $SI_FOLDER" &>> $BUILD_LOG

BINDIR=$(cat $SI_FOLDER/site.conf |grep site_code|awk {'print $3'}|sed "s/'//g"|sed "s/,//g")
GLUON_IMAGEDIR=$BUILD_HOME/images_$GLUON_RELEASE/$BINDIR
echo "== calling make for $SITE" &>> $BUILD_LOG
make GLUON_BRANCH=$BRANCH GLUON_SITEDIR=$SI_FOLDER GLUON_TARGET=ar71xx-generic V=s
## make GLUON_BRANCH=$BRANCH GLUON_SITEDIR=$SI_FOLDER GLUON_TARGET=ar71xx-nand
## make GLUON_BRANCH=$BRANCH GLUON_SITEDIR=$SI_FOLDER GLUON_TARGET=mpc85xx-generic
## make GLUON_BRANCH=$BRANCH GLUON_SITEDIR=$SI_FOLDER GLUON_TARGET=x86-generic
## make GLUON_BRANCH=$BRANCH GLUON_SITEDIR=$SI_FOLDER GLUON_TARGET=x86-kvm_guest
## make manifest GLUON_BRANCH=$BRANCH GLUON_SITEDIR=$SI_FOLDER
echo "done"
