diff --git a/onnxruntime/core/platform/posix/env.cc b/onnxruntime/core/platform/posix/env.cc
index a5aa577..4f7ad06 100644
--- a/onnxruntime/core/platform/posix/env.cc
+++ b/onnxruntime/core/platform/posix/env.cc
@@ -26,7 +26,6 @@ limitations under the License.
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/syscall.h>
 #include <unistd.h>
 
 #include <iostream>
@@ -38,11 +37,16 @@ limitations under the License.
 // We can not use CPUINFO if it is not supported and we do not want to used
 // it on certain platforms because of the binary size increase.
 // We could use it to find out the number of physical cores for certain supported platforms
-#if defined(CPUINFO_SUPPORTED) && !defined(__APPLE__) && !defined(__ANDROID__) && !defined(__wasm__) && !defined(_AIX)
+#if defined(CPUINFO_SUPPORTED) && !defined(__APPLE__) && !defined(__ANDROID__) && !defined(__wasm__) && !defined(_AIX) && !defined(__QNX__)
 #include <cpuinfo.h>
 #define ORT_USE_CPUINFO
 #endif
 
+// QNX does not have <sys/syscall.h>. All these impls are in <unistd.h>.
+#if !defined(__QNX__)
+#include <sys/syscall.h>
+#endif
+
 #include "core/common/common.h"
 #include "core/common/gsl.h"
 #include "core/common/logging/logging.h"
@@ -228,7 +232,7 @@ class PosixThread : public EnvThread {
   static void* ThreadMain(void* param) {
     std::unique_ptr<Param> p(static_cast<Param*>(param));
     ORT_TRY {
-#if !defined(__APPLE__) && !defined(__ANDROID__) && !defined(__wasm__) && !defined(_AIX)
+#if !defined(__APPLE__) && !defined(__ANDROID__) && !defined(__wasm__) && !defined(_AIX) && !defined(__QNX__)
       if (p->affinity.has_value() && !p->affinity->empty()) {
         cpu_set_t cpuset;
         CPU_ZERO(&cpuset);
