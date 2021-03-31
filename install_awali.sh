set -ex

echo "Install Awali"

MM_VERSION=1.0
VERSION=BINDERSNAPSHOT-210330
FULLNAME=awali-all-${VERSION}
TARFILE=${FULLNAME}.tgz
DIR=${FULLNAME}
URL="http://files.vaucanson-project.org/${MM_VERSION}/tarballs/$TARFILE"

wget -O awali.tgz $URL
tar --extract -f awali.tgz
rm awali.tgz
cd ${DIR}
mkdir -p _build
cd _build
cmake ..
make -j7
sudo mkdir -p /usr/local/lib/awali_otf/
sudo make -j4 b
sudo make -j7 install

cd ../..
rm -rf awali-all-v$V
