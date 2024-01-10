
## ONNX Runtime for QNX 7.0 / 7.1

For sole demonstration purposes, we describe the instructions for building
cross binaries targeting QNX on Ubuntu 20.04.6 LTS in WSL. Here's what you'll
need to get your environment set up:

```bash
sudo apt update
sudo apt install -y git-lfs unzip make gcc g++
sudo snap install cmake --classic
# # if you need gcc 8:
# sudo apt install -y gcc-8 g++-8
# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 100
# sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100
```

You should now modify the build script `build_qnx.sh` to change the cache
directories and QNX toolchain paths:

```bash
###############################################################################
#   user configurations

_CFG_build_target="qnx700-aarch64le"
_CFG_qnx700_inst_dir=~/qnx/qnx700/
_CFG_qnx710_inst_dir=~/qnx/qnx710/
_CFG_tmp_dir=~/ort_700/
```

Now you can run the build script and let it run until completion. No user
interaction or sudo permissions are required.

One thing's worth noting is that no two build scripts shall run at the same
time as `/usr/bin/protoc` is globally overridden. If you have protobuf compiler
installed here, please remember to back it up before running the build in case
it is overwritten with another version.

```bash
./build_qnx.sh
```
