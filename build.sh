#!/bin/sh

usage() {
  echo "Usage: $0 -p PACKAGE -v VERSION -r RELEASE -d DIST"
  echo
  echo "  -p PACKAGE"
  echo "    The name of the package, like \"apache-tomcat\"."
  echo "  -v VERSION"
  echo "    The version of the package, like \"7.0.65\"."
  echo "  -r RELEASE"
  echo "    The release of the package, like \"1\"."
  echo "  -d DIST"
  echo "    The distribution tag of the package, like \"el7\"."
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
      -p)
        if [ "$2" ] ; then
          package="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -v)
        if [ "$2" ] ; then
          version="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -r)
        if [ "$2" ] ; then
          release="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -d)
        if [ "$2" ] ; then
          dist="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      *)
        echo "Unknown option or argument $1."
        echo
        shift
        usage
      ;;
    esac
  done
}

checkargs() {
  if [ ! "${package}" ] ; then
    echo "Missing package."
    echo
    usage
  fi
 if [ ! "${version}" ] ; then
    echo "Missing version."
    echo
    usage
  fi
  if [ ! "${release}" ] ; then
    echo "Missing release."
    echo
    usage
  fi
  if [ ! "${dist}" ] ; then
    echo "Missing dist."
    echo
    usage
  fi
}

main() {
  if [ -d /data ] ; then
    cd /data
    mkdir -p rpmbuild/{RPMS,BUILD,SOURCES}
  else
    echo "Directory /data does not exit."
    echo
    exit 1
  fi
  if [ -f /data/${package}.spec ] ; then
    sed -i 's/Version: .*/Version: '${version}'/' /data/${package}.spec
    sed -i 's/Release: .*/Release: '${release}.${dist}'/' /data/${package}.spec
  else
    echo "The file /data/${package}.spec does not exist."
    echo
    exit 3
  fi
  chown root:root /data/${package}.spec
  cp /data/rpm-repos-el7.repo /data/rpmbuild/SOURCES/
  yum -y groupinstall "Development Tools"
  rpmbuild --define "_topdir /data/rpmbuild" -bb /data/${package}.spec
  mkdir /data/repository/
  cp /data/rpmbuild/RPMS/noarch/${package}-${version}-${release}.${dist}.noarch.rpm /data/repository/
}

readargs "$@"
checkargs
main
