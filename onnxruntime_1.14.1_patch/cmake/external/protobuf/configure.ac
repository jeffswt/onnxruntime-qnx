diff --git a/cmake/external/protobuf/configure.ac b/cmake/external/protobuf/configure.ac
index d9b9de3..faa146e 100644
--- a/cmake/external/protobuf/configure.ac
+++ b/cmake/external/protobuf/configure.ac
@@ -93,7 +93,7 @@ AS_IF([test "x${ac_cv_env_CXXFLAGS_set}" = "x"],[
   # Protocol Buffers contains several checks that are intended to be used only
   # for debugging and which might hurt performance.  Most users are probably
   # end users who don't want these checks, so add -DNDEBUG by default.
-  CXXFLAGS="$CXXFLAGS -std=c++11 -DNDEBUG"
+  CXXFLAGS="$CXXFLAGS -std=gnu++11 -DNDEBUG"
 
   AC_MSG_RESULT([use default: $PROTOBUF_OPT_FLAG $CXXFLAGS])
 ],[
