if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

make -f snappy.mk build-snappy
