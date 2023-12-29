diff --git a/cmake/external/flatbuffers/src/util.cpp b/cmake/external/flatbuffers/src/util.cpp
index 08b7791..4fdc488 100644
--- a/cmake/external/flatbuffers/src/util.cpp
+++ b/cmake/external/flatbuffers/src/util.cpp
@@ -35,6 +35,9 @@
 #  define _XOPEN_SOURCE 600 // For PATH_MAX from limits.h (SUSv2 extension) 
 #  include <limits.h>
 #endif
+#ifdef __QNX__
+#  define PATH_MAX 1024
+#endif
 // clang-format on
 
 #include "flatbuffers/base.h"
