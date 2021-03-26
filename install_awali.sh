set -ex

echo "Install Awali"

V=1.0.2-190218
SOURCE=http://files.vaucanson-project.org/1.0/tarballs/awali-all-v$V.tgz

wget -O awali.tgz $SOURCE
tar --extract -f awali.tgz -z
rm awali.tgz
cd awali-all-v$V
mkdir -p _build
cd _build
cmake .. && make -j7 && sudo make b -j3 && sudo make install && cd .. && rm -rf awali-all-v$V
