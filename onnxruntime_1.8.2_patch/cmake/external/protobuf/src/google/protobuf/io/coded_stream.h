diff --git a/cmake/external/protobuf/src/google/protobuf/io/coded_stream.h b/cmake/external/protobuf/src/google/protobuf/io/coded_stream.h
index b6c11d27a..462d5fd0f 100644
--- a/cmake/external/protobuf/src/google/protobuf/io/coded_stream.h
+++ b/cmake/external/protobuf/src/google/protobuf/io/coded_stream.h
@@ -136,13 +136,15 @@
 #elif defined(__FreeBSD__)
 #include <sys/endian.h>  // __BYTE_ORDER
 #else
+#if !defined(__QNX__)
 #include <endian.h>  // __BYTE_ORDER
 #endif
-#if ((defined(__LITTLE_ENDIAN__) && !defined(__BIG_ENDIAN__)) ||    \
-     (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN)) && \
-    !defined(PROTOBUF_DISABLE_LITTLE_ENDIAN_OPT_FOR_TEST)
-#define PROTOBUF_LITTLE_ENDIAN 1
 #endif
+// #if ((defined(__LITTLE_ENDIAN__) && !defined(__BIG_ENDIAN__)) ||    
+//      (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN)) && 
+//     !defined(PROTOBUF_DISABLE_LITTLE_ENDIAN_OPT_FOR_TEST)
+#define PROTOBUF_LITTLE_ENDIAN 1
+// #endif
 #endif
 #include <google/protobuf/stubs/common.h>
 #include <google/protobuf/stubs/logging.h>
