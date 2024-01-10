diff --git a/cmake/onnxruntime.cmake b/cmake/onnxruntime.cmake
index 307a0f5..e92bf99 100644
--- a/cmake/onnxruntime.cmake
+++ b/cmake/onnxruntime.cmake
@@ -91,27 +91,27 @@ elseif(onnxruntime_BUILD_APPLE_FRAMEWORK)
     SOVERSION  ${ORT_VERSION}
   )
 else()
   onnxruntime_add_shared_library(onnxruntime ${CMAKE_CURRENT_BINARY_DIR}/generated_source.c)
   if (onnxruntime_USE_CUDA)
     set_property(TARGET onnxruntime APPEND_STRING PROPERTY LINK_FLAGS " -Xlinker -rpath=\\$ORIGIN")
   endif()
 endif()
 
 add_dependencies(onnxruntime onnxruntime_generate_def ${onnxruntime_EXTERNAL_DEPENDENCIES})
 target_include_directories(onnxruntime PRIVATE ${ONNXRUNTIME_ROOT})
 
 target_compile_definitions(onnxruntime PRIVATE VER_MAJOR=${VERSION_MAJOR_PART})
 target_compile_definitions(onnxruntime PRIVATE VER_MINOR=${VERSION_MINOR_PART})
 target_compile_definitions(onnxruntime PRIVATE VER_BUILD=${VERSION_BUILD_PART})
 target_compile_definitions(onnxruntime PRIVATE VER_PRIVATE=${VERSION_PRIVATE_PART})
 target_compile_definitions(onnxruntime PRIVATE VER_STRING=\"${VERSION_STRING}\")
 target_compile_definitions(onnxruntime PRIVATE FILE_NAME=\"onnxruntime.dll\")
 
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
@@ -196,6 +196,8 @@ set(onnxruntime_INTERNAL_LIBRARIES
   ${ONNXRUNTIME_MLAS_LIBS}
   onnxruntime_common
   onnxruntime_flatbuffers
+  iconv
+  m
 )
 
 if (onnxruntime_ENABLE_LANGUAGE_INTEROP_OPS)
