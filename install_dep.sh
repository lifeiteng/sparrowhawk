
mkdir -p third_party
cd third_party

CXX=g++
# CXX = clang++  # Uncomment this line to build with Clang.
CC=gcc    # used for sph2pipe

# Uncomment the next line to build with OpenFst-1.4.1.
# OPENFST_VERSION = 1.4.1
# Note: OpenFst >= 1.4 requires C++11 support, hence you will need to use a
# relatively recent C++ compiler, e.g. gcc >= 4.6, clang >= 3.0.

# On Mac OS 10.9+, clang defaults to the new c++ standard library libc++.
# Since OpenFst-1.3 uses stuff from the tr1 namespace, we need to tell clang
# to use libstdc++ instead.

# CXXFLAGS="-stdlib=libstdc++"
# LDFLAGS="-stdlib=libstdc++"

OPENFST_VERSION=1.5.4
echo "=========== Install OpenFst $OPENFST_VERSION ==========="
if [ ! -f openfst-${OPENFST_VERSION}.tar.gz ];then
    wget http://openfst.cs.nyu.edu/twiki/pub/FST/FstDownload/openfst-${OPENFST_VERSION}.tar.gz || \
    wget -T 10 -t 3 http://www.openslr.org/resources/2/openfst-${OPENFST_VERSION}.tar.gz || exit 1;
    tar xozf openfst-${OPENFST_VERSION}.tar.gz
fi

if [ ! -d openfst ];then
    cd openfst-${OPENFST_VERSION}/;
    ./configure --prefix=/usr/local --enable-static --enable-shared --enable-far \
        --enable-ngram-fsts --enable-pdt --enable-mpdt \
        CXX=$(CXX) CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)" LIBS="-ldl"

    [ -d lib64 ] && [ ! -d lib ] && ln -s lib64 lib

    make-j;make install || exit 1;

    cd ..

    rm -f openfst
    ln -s openfst-${OPENFST_VERSION} openfst
fi



THRAX_VERSION=1.2.2
echo "=========== Install Thrax $THRAX_VERSION ==========="
if [ ! -f thrax-${THRAX_VERSION}.tar.gz ];then
    wget http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-${THRAX_VERSION}.tar.gz || exit 1;
    tar xozf thrax-${THRAX_VERSION}.tar.gz
fi
if [ ! -d thrax ];then
    cd thrax-${THRAX_VERSION}/;
    ./configure --enable-static --enable-shared \
        CXX=$(CXX) CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)" LIBS="-ldl"

    [ -d lib64 ] && [ ! -d lib ] && ln -s lib64 lib

    make -j;make install || exit 1;

    cd ..

    rm -f thrax
    ln -s thrax-${THRAX_VERSION} thrax
fi

echo "=========== Install Re2 ==========="
if [ ! -d re2 ];then
    git clone https://github.com/google/re2
    cd re2
    make;make test;make install;make testinstall
    cd ..
fi

echo "=========== Install Protobuf ==========="
if [ "$OSTYPE" = "linux-gnu" ];then
    sudo apt-get install protobuf
else
    brew install  protobuf
fi

# echo "=========== Install protobuf ==========="
# if [ ! -d protobuf ];then
#     git clone https://github.com/google/protobuf --depth 1 -b master
#     cd protobuf
#     ./autogen.sh
#     make -j;make check;make install
#     ldconfig
#     cd ..
# fi

echo "$0: DONE!"










