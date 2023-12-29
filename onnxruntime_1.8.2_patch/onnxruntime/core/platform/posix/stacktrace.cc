diff --git a/onnxruntime/core/platform/posix/stacktrace.cc b/onnxruntime/core/platform/posix/stacktrace.cc
index f312875..92a56a7 100644
--- a/onnxruntime/core/platform/posix/stacktrace.cc
+++ b/onnxruntime/core/platform/posix/stacktrace.cc
@@ -3,7 +3,7 @@
 
 #include "core/common/common.h"
 
-#if !defined(__ANDROID__) && !defined(__wasm__)
+#if !defined(__ANDROID__) && !defined(__wasm__) && !defined(__QNX__)
 #include <execinfo.h>
 #endif
 #include <vector>
@@ -13,7 +13,7 @@ namespace onnxruntime {
 std::vector<std::string> GetStackTrace() {
   std::vector<std::string> stack;
 
-#if !defined(NDEBUG) && !defined(__ANDROID__) && !defined(__wasm__)
+#if !defined(NDEBUG) && !defined(__ANDROID__) && !defined(__wasm__) && !defined(__QNX__)
   constexpr int kCallstackLimit = 64;  // Maximum depth of callstack
 
   void* array[kCallstackLimit];
