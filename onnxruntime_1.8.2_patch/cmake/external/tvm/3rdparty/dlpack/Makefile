diff --git a/cmake/external/tvm/3rdparty/dlpack/Makefile b/cmake/external/tvm/3rdparty/dlpack/Makefile
index 2bf8ae7..c7d137e 100644
--- a/cmake/external/tvm/3rdparty/dlpack/Makefile
+++ b/cmake/external/tvm/3rdparty/dlpack/Makefile
@@ -4,7 +4,7 @@ all: bin/mock
 
 LDFLAGS =
 CFLAGS = -Wall -O3 -Iinclude -Icontrib
-CXXFLAGS = -std=c++11 $(CFLAGS)
+CXXFLAGS = -std=gnu++11 $(CFLAGS)
 
 SRC = $(wildcard contrib/*.cc contrib/*.c)
 ALL_CXX_OBJ = $(patsubst contrib/%.cc, build/%.o, $(SRC))
