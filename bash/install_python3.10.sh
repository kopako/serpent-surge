sudo su -
dnf groupinstall -y "Development Tools"
dnf install -y gcc gcc-c++ make zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel tk-dev
cd /usr/src
curl -O https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
tar xvf Python-3.10.0.tgz
cd Python-3.10.0
./configure --enable-optimizations --with-ensurepip=install
make -j$(nproc)
make altinstall

