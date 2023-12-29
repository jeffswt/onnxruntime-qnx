diff --git a/cmake/external/protobuf/configure.ac b/cmake/external/protobuf/configure.ac
index 6251e37f3..8533e48b7 100644
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
@@ -170,7 +170,7 @@ AS_IF([test "$with_zlib" != no], [
 ])
 AM_CONDITIONAL([HAVE_ZLIB], [test $HAVE_ZLIB = 1])
 
-# Add -std=c++11 if necesssary. It is important for us to do this before the
+# Add -std=gnu++11 if necesssary. It is important for us to do this before the
 # libatomic check below, since that also depends on C++11.
 AX_CXX_COMPILE_STDCXX([11], [noext], [mandatory])
 
