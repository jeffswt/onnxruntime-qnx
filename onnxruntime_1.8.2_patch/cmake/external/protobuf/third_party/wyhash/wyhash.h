diff --git a/cmake/external/protobuf/third_party/wyhash/wyhash.h b/cmake/external/protobuf/third_party/wyhash/wyhash.h
index bb247a9af..298a5015f 100644
--- a/cmake/external/protobuf/third_party/wyhash/wyhash.h
+++ b/cmake/external/protobuf/third_party/wyhash/wyhash.h
@@ -67,6 +67,8 @@ static inline uint64_t _wymix(uint64_t A, uint64_t B){ _wymum(&A,&B); return A^B
   #elif defined(__BIG_ENDIAN__) || (defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
     #define WYHASH_LITTLE_ENDIAN 0
   #endif
+  #undef WYHASH_LITTLE_ENDIAN
+  #define WYHASH_LITTLE_ENDIAN 1
 #endif
 #if (WYHASH_LITTLE_ENDIAN)
 static inline uint64_t _wyr8(const uint8_t *p) { uint64_t v; memcpy(&v, p, 8); return v;}
