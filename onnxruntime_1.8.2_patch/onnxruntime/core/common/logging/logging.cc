diff --git a/onnxruntime/core/common/logging/logging.cc b/onnxruntime/core/common/logging/logging.cc
index fa3de25..e2b86c5 100644
--- a/onnxruntime/core/common/logging/logging.cc
+++ b/onnxruntime/core/common/logging/logging.cc
@@ -15,6 +15,8 @@
 #include <unistd.h>
 #if defined(__MACH__) || defined(__wasm__)
 #include <pthread.h>
+#elif defined(__QNX__)
+#include <process.h>
 #else
 #include <sys/syscall.h>
 #endif
@@ -216,6 +218,8 @@ unsigned int GetThreadId() {
   return static_cast<unsigned int>(tid);
 #elif defined(__wasm__)
   return static_cast<unsigned int>(pthread_self());
+#elif defined(__QNX__)
+  return static_cast<unsigned int>(gettid());
 #else
   return static_cast<unsigned int>(syscall(SYS_gettid));
 #endif
@@ -227,7 +231,7 @@ unsigned int GetThreadId() {
 unsigned int GetProcessId() {
 #ifdef _WIN32
   return static_cast<unsigned int>(GetCurrentProcessId());
-#elif defined(__MACH__) || defined(__wasm__)
+#elif defined(__MACH__) || defined(__wasm__) || defined(__QNX__)
   return static_cast<unsigned int>(getpid());
 #else
   return static_cast<unsigned int>(syscall(SYS_getpid));
