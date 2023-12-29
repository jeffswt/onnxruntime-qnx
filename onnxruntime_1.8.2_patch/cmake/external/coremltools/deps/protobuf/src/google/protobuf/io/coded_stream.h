diff --git a/cmake/external/coremltools/deps/protobuf/src/google/protobuf/io/coded_stream.h b/cmake/external/coremltools/deps/protobuf/src/google/protobuf/io/coded_stream.h
index 20d8614..ae9a8d6 100644
--- a/cmake/external/coremltools/deps/protobuf/src/google/protobuf/io/coded_stream.h
+++ b/cmake/external/coremltools/deps/protobuf/src/google/protobuf/io/coded_stream.h
@@ -125,11 +125,11 @@
   #endif
 #else
   #include <sys/param.h>   // __BYTE_ORDER
-  #if ((defined(__LITTLE_ENDIAN__) && !defined(__BIG_ENDIAN__)) || \
-         (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN)) && \
-      !defined(PROTOBUF_DISABLE_LITTLE_ENDIAN_OPT_FOR_TEST)
+  // #if ((defined(__LITTLE_ENDIAN__) && !defined(__BIG_ENDIAN__)) || 
+  //        (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN)) && 
+  //     !defined(PROTOBUF_DISABLE_LITTLE_ENDIAN_OPT_FOR_TEST)
     #define PROTOBUF_LITTLE_ENDIAN 1
-  #endif
+  // #endif
 #endif
 #include <google/protobuf/stubs/atomicops.h>
 #include <google/protobuf/stubs/common.h>
