diff --git a/include/onnxruntime/core/framework/endian.h b/include/onnxruntime/core/framework/endian.h
index 629fb78..e931a9d 100644
--- a/include/onnxruntime/core/framework/endian.h
+++ b/include/onnxruntime/core/framework/endian.h
@@ -3,6 +3,8 @@
 
 #pragma once
 
+#include <sys/param.h>
+
 namespace onnxruntime {
 
 // the semantics of this enum should match std::endian from C++20
@@ -12,9 +14,9 @@ enum class endian {
   big = 1,
   native = little,
 #elif defined(__GNUC__) || defined(__clang__)
-  little = __ORDER_LITTLE_ENDIAN__,
-  big = __ORDER_BIG_ENDIAN__,
-  native = __BYTE_ORDER__,
+  little = LITTLE_ENDIAN,
+  big = BIG_ENDIAN,
+  native = LITTLE_ENDIAN,
 #else
 #error onnxruntime::endian is not implemented in this environment.
 #endif
