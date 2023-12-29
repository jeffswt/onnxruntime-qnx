diff --git a/cmake/onnxruntime_unittests.cmake b/cmake/onnxruntime_unittests.cmake
index a0d7ce7..b8c9b39 100644
--- a/cmake/onnxruntime_unittests.cmake
+++ b/cmake/onnxruntime_unittests.cmake
@@ -451,6 +451,7 @@ if (onnxruntime_ENABLE_LANGUAGE_INTEROP_OPS)
 endif()
 
 set(ONNXRUNTIME_TEST_LIBS
+    iconv
     onnxruntime_session
     ${ONNXRUNTIME_INTEROP_TEST_LIBS}
     ${onnxruntime_libs}
@@ -1081,7 +1082,7 @@ if(UNIX)
   if (APPLE)
     set(ONNXRUNTIME_CUSTOM_OP_LIB_LINK_FLAG "-Xlinker -dead_strip")
   else()
-    set(ONNXRUNTIME_CUSTOM_OP_LIB_LINK_FLAG "-Xlinker --version-script=${TEST_SRC_DIR}/testdata/custom_op_library/custom_op_library.lds -Xlinker --no-undefined -Xlinker --gc-sections -z noexecstack")
+    set(ONNXRUNTIME_CUSTOM_OP_LIB_LINK_FLAG "-Wl,--version-script=${TEST_SRC_DIR}/testdata/custom_op_library/custom_op_library.lds -Wl,--no-undefined -Wl,--gc-sections")
   endif()
 else()
   set(ONNXRUNTIME_CUSTOM_OP_LIB_LINK_FLAG "-DEF:${TEST_SRC_DIR}/testdata/custom_op_library/custom_op_library.def")
@@ -1147,7 +1148,7 @@ if (NOT onnxruntime_MINIMAL_BUILD AND NOT onnxruntime_EXTENDED_MINIMAL_BUILD
   if(APPLE)
     set_property(TARGET test_execution_provider APPEND_STRING PROPERTY LINK_FLAGS "-Xlinker -exported_symbols_list ${REPO_ROOT}/onnxruntime/test/testdata/custom_execution_provider_library/exported_symbols.lst")
   elseif(UNIX)
-    set_property(TARGET test_execution_provider APPEND_STRING PROPERTY LINK_FLAGS "-Xlinker --version-script=${REPO_ROOT}/onnxruntime/test/testdata/custom_execution_provider_library/version_script.lds -Xlinker --gc-sections")
+    set_property(TARGET test_execution_provider APPEND_STRING PROPERTY LINK_FLAGS "-Wl,--version-script=${REPO_ROOT}/onnxruntime/test/testdata/custom_execution_provider_library/version_script.lds -Wl,--gc-sections")
   elseif(WIN32)
     set_property(TARGET test_execution_provider APPEND_STRING PROPERTY LINK_FLAGS "-DEF:${REPO_ROOT}/onnxruntime/test/testdata/custom_execution_provider_library/symbols.def")
   else()
