
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

There are a few things worth noting before you start:

  - No two build scripts shall run at the same time as `/usr/bin/protoc` is
    globally overridden. Do not especially run two build scripts targeting
    different ORT versions.
  - If you have protobuf compiler installed here, please remember to back it up
    before running the build in case it is overwritten by another version.
  - Ensure that `miniconda` is not present or that it does not interfere with
    the header lookup mechanism.

Now you can run the build script and let it run until completion. No user
interaction is required.

```bash
sudo ./build_qnx.sh
```

### Tests

```bash
./onnxruntime_test_all
```

Test results for onnxruntime-1.8.2-qnx700-aarch64le:

```
[----------] Global test environment tear-down
[==========] 2754 tests from 207 test suites ran. (58767 ms total)
[  PASSED  ] 2752 tests.
[  FAILED  ] 2 tests, listed below:
[  FAILED  ] PathTest.trailing_slash2
[  FAILED  ] ContribOpTest.StringNormalizerTest

 2 FAILED TESTS
  YOU HAVE 5 DISABLED TESTS
```

Test results for onnxruntime-1.14.1-qnx710-aarch64le:

```
[----------] Global test environment tear-down
[==========] 3509 tests from 249 test suites ran. (32834 ms total)
[  PASSED  ] 3504 tests.
[  SKIPPED ] 5 tests, listed below:
[  SKIPPED ] TunableOp.SelectFast
[  SKIPPED ] TunableOp.SelectSupported
[  SKIPPED ] TunableOp.SelectFastestIfSupported
[  SKIPPED ] TunableOp.DisabledWithManualSelection
[  SKIPPED ] TunableOp.HandleInplaceUpdate

  YOU HAVE 7 DISABLED TESTS
```
