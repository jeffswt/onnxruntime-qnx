diff --git a/onnxruntime/core/common/logging/logging.cc b/onnxruntime/core/common/logging/logging.cc
index 6c6e2f4..0e7cb7c 100644
--- a/onnxruntime/core/common/logging/logging.cc
+++ b/onnxruntime/core/common/logging/logging.cc
@@ -16,6 +16,8 @@
 #include <unistd.h>
 #if defined(__MACH__) || defined(__wasm__) || defined(_AIX)
 #include <pthread.h>
+#elif defined(__QNX__)
+#include <unistd.h>
 #else
 #include <sys/syscall.h>
 #endif
@@ -225,6 +227,8 @@ unsigned int GetThreadId() {
   return static_cast<unsigned int>(tid);
 #elif defined(__wasm__) || defined(_AIX)
   return static_cast<unsigned int>(pthread_self());
+#elif defined(__QNX__)
+  return static_cast<unsigned int>(gettid());
 #else
   return static_cast<unsigned int>(syscall(SYS_gettid));
 #endif
@@ -236,7 +240,7 @@ unsigned int GetThreadId() {
 unsigned int GetProcessId() {
 #ifdef _WIN32
   return static_cast<unsigned int>(GetCurrentProcessId());
-#elif defined(__MACH__) || defined(__wasm__) || defined(_AIX)
+#elif defined(__MACH__) || defined(__wasm__) || defined(_AIX) || defined(__QNX__)
   return static_cast<unsigned int>(getpid());
 #else
   return static_cast<unsigned int>(syscall(SYS_getpid));
