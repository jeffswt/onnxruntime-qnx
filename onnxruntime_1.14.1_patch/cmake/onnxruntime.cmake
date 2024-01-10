diff --git a/cmake/onnxruntime.cmake b/cmake/onnxruntime.cmake
index 307a0f5..a736a8b 100644
--- a/cmake/onnxruntime.cmake
+++ b/cmake/onnxruntime.cmake
@@ -110,8 +110,10 @@ target_compile_definitions(onnxruntime PRIVATE FILE_NAME=\"onnxruntime.dll\")
 if(UNIX)
   if (APPLE)
     set(ONNXRUNTIME_SO_LINK_FLAG " -Xlinker -dead_strip")
+  elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
+    set(ONNXRUNTIME_SO_LINK_FLAG " -Wl,--version-script=${SYMBOL_FILE} -Wl,--no-undefined -Wl,--gc-sections -Wl,-z,now")
   else()
-    set(ONNXRUNTIME_SO_LINK_FLAG " -Xlinker --version-script=${SYMBOL_FILE} -Xlinker --no-undefined -Xlinker --gc-sections -z noexecstack")
+    set(ONNXRUNTIME_SO_LINK_FLAG " -Wl,--version-script=${SYMBOL_FILE} -Wl,--no-undefined -Wl,--gc-sections")
   endif()
 else()
   set(ONNXRUNTIME_SO_LINK_FLAG " -DEF:${SYMBOL_FILE}")
@@ -196,6 +198,8 @@ set(onnxruntime_INTERNAL_LIBRARIES
   ${ONNXRUNTIME_MLAS_LIBS}
   onnxruntime_common
   onnxruntime_flatbuffers
+  iconv
+  m
 )

 if (onnxruntime_ENABLE_LANGUAGE_INTEROP_OPS)
