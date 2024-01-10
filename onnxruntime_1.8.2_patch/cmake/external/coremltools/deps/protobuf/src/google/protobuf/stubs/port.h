diff --git a/cmake/external/coremltools/deps/protobuf/src/google/protobuf/stubs/port.h b/cmake/external/coremltools/deps/protobuf/src/google/protobuf/stubs/port.h
index 6ec5e00..6727830 100644
--- a/cmake/external/coremltools/deps/protobuf/src/google/protobuf/stubs/port.h
+++ b/cmake/external/coremltools/deps/protobuf/src/google/protobuf/stubs/port.h
@@ -65,12 +65,12 @@
   #if defined(__OpenBSD__)
     #include <endian.h>
   #endif
-  #if ((defined(__LITTLE_ENDIAN__) && !defined(__BIG_ENDIAN__)) || \
-         (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN) || \
-         (defined(BYTE_ORDER) && BYTE_ORDER == LITTLE_ENDIAN)) && \
-      !defined(PROTOBUF_DISABLE_LITTLE_ENDIAN_OPT_FOR_TEST)
+  // #if ((defined(__LITTLE_ENDIAN__) && !defined(__BIG_ENDIAN__)) ||
+  //        (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN) ||
+  //        (defined(BYTE_ORDER) && BYTE_ORDER == LITTLE_ENDIAN)) &&
+  //     !defined(PROTOBUF_DISABLE_LITTLE_ENDIAN_OPT_FOR_TEST)
     #define PROTOBUF_LITTLE_ENDIAN 1
-  #endif
+  // #endif
 #endif
 #if defined(_MSC_VER) && defined(PROTOBUF_USE_DLLS)
   #ifdef LIBPROTOBUF_EXPORTS
