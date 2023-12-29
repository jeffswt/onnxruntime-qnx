diff --git a/cmake/external/protobuf/src/google/protobuf/stubs/platform_macros.h b/cmake/external/protobuf/src/google/protobuf/stubs/platform_macros.h
index ce1b1e365..24799600d 100644
--- a/cmake/external/protobuf/src/google/protobuf/stubs/platform_macros.h
+++ b/cmake/external/protobuf/src/google/protobuf/stubs/platform_macros.h
@@ -46,7 +46,11 @@
 #define GOOGLE_PROTOBUF_ARCH_32_BIT 1
 #elif defined(__QNX__)
 #define GOOGLE_PROTOBUF_ARCH_ARM_QNX 1
+#if defined(__aarch64__)
+#define GOOGLE_PROTOBUF_ARCH_64_BIT 1
+#else
 #define GOOGLE_PROTOBUF_ARCH_32_BIT 1
+#endif
 #elif defined(_M_ARM) || defined(__ARMEL__)
 #define GOOGLE_PROTOBUF_ARCH_ARM 1
 #define GOOGLE_PROTOBUF_ARCH_32_BIT 1
