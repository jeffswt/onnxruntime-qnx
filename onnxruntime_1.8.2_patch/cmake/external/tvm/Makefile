diff --git a/cmake/external/tvm/Makefile b/cmake/external/tvm/Makefile
index fb50b82..cde2d0f 100644
--- a/cmake/external/tvm/Makefile
+++ b/cmake/external/tvm/Makefile
@@ -12,7 +12,7 @@ ifndef DLPACK_PATH
 endif
 
 INCLUDE_FLAGS = -Iinclude -I$(DLPACK_PATH)/include -I$(DMLC_CORE_PATH)/include
-PKG_CFLAGS = -std=c++11 -Wall -O2 $(INCLUDE_FLAGS) -fPIC
+PKG_CFLAGS = -std=gnu++11 -Wall -O2 $(INCLUDE_FLAGS) -fPIC
 PKG_LDFLAGS =
 
 
@@ -29,7 +29,7 @@ cpptest:
 	@mkdir -p build && cd build && cmake .. && $(MAKE) cpptest
 
 # EMCC; Web related scripts
-EMCC_FLAGS= -std=c++11 -DDMLC_LOG_STACK_TRACE=0\
+EMCC_FLAGS= -std=gnu++11 -DDMLC_LOG_STACK_TRACE=0\
 	-Oz -s RESERVED_FUNCTION_POINTERS=2 -s MAIN_MODULE=1 -s NO_EXIT_RUNTIME=1\
 	-s TOTAL_MEMORY=1073741824\
 	-s EXTRA_EXPORTED_RUNTIME_METHODS="['addFunction','cwrap','getValue','setValue']"\
