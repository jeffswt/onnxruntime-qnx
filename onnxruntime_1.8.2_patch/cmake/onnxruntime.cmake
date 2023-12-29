diff --git a/cmake/onnxruntime.cmake b/cmake/onnxruntime.cmake
index 524a916..867b222 100644
--- a/cmake/onnxruntime.cmake
+++ b/cmake/onnxruntime.cmake
@@ -89,7 +89,7 @@ elseif(onnxruntime_BUILD_APPLE_FRAMEWORK)
 else()
   onnxruntime_add_shared_library(onnxruntime ${CMAKE_CURRENT_BINARY_DIR}/generated_source.c)
   if (onnxruntime_USE_CUDA)
-    set_property(TARGET onnxruntime APPEND_STRING PROPERTY LINK_FLAGS " -Xlinker -rpath=\\$ORIGIN")
+    set_property(TARGET onnxruntime APPEND_STRING PROPERTY LINK_FLAGS " -Wl,-rpath=\\$ORIGIN")
   endif()
 endif()
 
@@ -110,7 +110,7 @@ if(UNIX)
   if (APPLE)
     set(ONNXRUNTIME_SO_LINK_FLAG " -Xlinker -dead_strip")
   else()
-    set(ONNXRUNTIME_SO_LINK_FLAG " -Xlinker --version-script=${SYMBOL_FILE} -Xlinker --no-undefined -Xlinker --gc-sections -z noexecstack")
+    set(ONNXRUNTIME_SO_LINK_FLAG " -Wl,--version-script=${SYMBOL_FILE} -Wl,--no-undefined -Wl,--gc-sections")
   endif()
 else()
   set(ONNXRUNTIME_SO_LINK_FLAG " -DEF:${SYMBOL_FILE}")
@@ -181,6 +181,7 @@ set(onnxruntime_INTERNAL_LIBRARIES
   onnxruntime_common
   onnxruntime_mlas
   onnxruntime_flatbuffers
+  iconv
 )
 
 if (onnxruntime_ENABLE_LANGUAGE_INTEROP_OPS)
