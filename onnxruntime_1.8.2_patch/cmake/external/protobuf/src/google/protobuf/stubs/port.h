diff --git a/cmake/external/protobuf/src/google/protobuf/stubs/port.h b/cmake/external/protobuf/src/google/protobuf/stubs/port.h
index 0f3b5aa62..172a6d0c7 100644
--- a/cmake/external/protobuf/src/google/protobuf/stubs/port.h
+++ b/cmake/external/protobuf/src/google/protobuf/stubs/port.h
@@ -62,14 +62,16 @@
 #elif defined(__FreeBSD__)
 #include <sys/endian.h>  // __BYTE_ORDER
 #else
+#if !defined(__QNX__)
 #include <endian.h>  // __BYTE_ORDER
 #endif
-#if ((defined(__LITTLE_ENDIAN__) && !defined(__BIG_ENDIAN__)) ||   \
-     (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN) || \
-     (defined(BYTE_ORDER) && BYTE_ORDER == LITTLE_ENDIAN)) &&      \
-    !defined(PROTOBUF_DISABLE_LITTLE_ENDIAN_OPT_FOR_TEST)
-#define PROTOBUF_LITTLE_ENDIAN 1
 #endif
+// #if ((defined(__LITTLE_ENDIAN__) && !defined(__BIG_ENDIAN__)) ||
+//      (defined(__BYTE_ORDER) && __BYTE_ORDER == __LITTLE_ENDIAN) ||
+//      (defined(BYTE_ORDER) && BYTE_ORDER == LITTLE_ENDIAN)) &&
+//     !defined(PROTOBUF_DISABLE_LITTLE_ENDIAN_OPT_FOR_TEST)
+#define PROTOBUF_LITTLE_ENDIAN 1
+// #endif
 #endif
 
 // These #includes are for the byte swap functions declared later on.
@@ -271,6 +273,7 @@ static inline uint64 bswap_64(uint64 x) {
           ((x & PROTOBUF_ULONGLONG(0xFF0000000000)) >> 24) |
           ((x & PROTOBUF_ULONGLONG(0xFF000000000000)) >> 40) |
           ((x & PROTOBUF_ULONGLONG(0xFF00000000000000)) >> 56));
+
 }
 #define bswap_64(x) bswap_64(x)
 #endif
