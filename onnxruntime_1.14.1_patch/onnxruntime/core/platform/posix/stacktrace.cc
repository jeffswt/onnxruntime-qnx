diff --git a/onnxruntime/core/platform/posix/stacktrace.cc b/onnxruntime/core/platform/posix/stacktrace.cc
index 76864b2..1722bc1 100644
--- a/onnxruntime/core/platform/posix/stacktrace.cc
+++ b/onnxruntime/core/platform/posix/stacktrace.cc
@@ -3,7 +3,7 @@
 
 #include "core/common/common.h"
 
-#if !defined(__ANDROID__) && !defined(__wasm__) && !defined(_OPSCHEMA_LIB_) && !defined(_AIX)
+#if !defined(__ANDROID__) && !defined(__wasm__) && !defined(_OPSCHEMA_LIB_) && !defined(_AIX) && !defined(__QNX__)
 #include <execinfo.h>
 #endif
 #include <vector>
