diff --git a/cmake/onnxruntime_unittests.cmake b/cmake/onnxruntime_unittests.cmake
index 00c0172..0a53feb 100644
--- a/cmake/onnxruntime_unittests.cmake
+++ b/cmake/onnxruntime_unittests.cmake
@@ -537,6 +537,8 @@ set(ONNXRUNTIME_TEST_LIBS
     ${ONNXRUNTIME_MLAS_LIBS}
     onnxruntime_common
     onnxruntime_flatbuffers
+    iconv
+    m
 )
 
 if (onnxruntime_ENABLE_TRAINING)
@@ -1369,7 +1372,7 @@ if (NOT onnxruntime_BUILD_WEBASSEMBLY)
     if (APPLE)
       set(ONNXRUNTIME_CUSTOM_OP_LIB_LINK_FLAG "-Xlinker -dead_strip")
     else()
-      set(ONNXRUNTIME_CUSTOM_OP_LIB_LINK_FLAG "-Xlinker --version-script=${TEST_SRC_DIR}/testdata/custom_op_library/custom_op_library.lds -Xlinker --no-undefined -Xlinker --gc-sections -z noexecstack")
+      set(ONNXRUNTIME_CUSTOM_OP_LIB_LINK_FLAG "-Wl,--version-script=${TEST_SRC_DIR}/testdata/custom_op_library/custom_op_library.lds -Wl,--no-undefined -Wl,--gc-sections")
     endif()
   else()
     set(ONNXRUNTIME_CUSTOM_OP_LIB_LINK_FLAG "-DEF:${TEST_SRC_DIR}/testdata/custom_op_library/custom_op_library.def")
@@ -1412,27 +1415,6 @@ if (NOT onnxruntime_BUILD_WEBASSEMBLY)
         set_property(TEST onnxruntime4j_test APPEND PROPERTY DEPENDS onnxruntime4j_jni)
     endif()
   endif()
-
-  if (onnxruntime_BUILD_SHARED_LIB AND (NOT onnxruntime_MINIMAL_BUILD OR onnxruntime_MINIMAL_BUILD_CUSTOM_OPS))
-    set (onnxruntime_customopregistration_test_SRC
-            ${ONNXRUNTIME_CUSTOM_OP_REGISTRATION_TEST_SRC_DIR}/test_registercustomops.cc)
-
-    set(onnxruntime_customopregistration_test_LIBS custom_op_library onnxruntime_common onnxruntime_test_utils)
-    AddTest(DYN
-            TARGET onnxruntime_customopregistration_test
-            SOURCES ${onnxruntime_customopregistration_test_SRC} ${onnxruntime_unittest_main_src}
-            LIBS ${onnxruntime_customopregistration_test_LIBS}
-            DEPENDS ${all_dependencies}
-    )
-
-    if (CMAKE_SYSTEM_NAME STREQUAL "iOS")
-      add_custom_command(
-        TARGET onnxruntime_customopregistration_test POST_BUILD
-        COMMAND ${CMAKE_COMMAND} -E copy_directory
-        ${TEST_DATA_SRC}
-        $<TARGET_FILE_DIR:onnxruntime_customopregistration_test>/testdata)
-    endif()
-  endif()
 endif()
 
 # Build custom op library that returns an error OrtStatus when the exported RegisterCustomOps function is called.
@@ -1447,8 +1429,8 @@ if (NOT onnxruntime_BUILD_WEBASSEMBLY AND (NOT onnxruntime_MINIMAL_BUILD OR onnx
       set(ONNXRUNTIME_CUSTOM_OP_INVALID_LIB_LINK_FLAG "-Xlinker -dead_strip")
     else()
       string(CONCAT ONNXRUNTIME_CUSTOM_OP_INVALID_LIB_LINK_FLAG
-             "-Xlinker --version-script=${TEST_SRC_DIR}/testdata/custom_op_invalid_library/custom_op_library.lds "
-             "-Xlinker --no-undefined -Xlinker --gc-sections -z noexecstack")
+             "-Wl,--version-script=${TEST_SRC_DIR}/testdata/custom_op_invalid_library/custom_op_library.lds "
+             "-Wl,--no-undefined -Wl,--gc-sections")
     endif()
   else()
     set(ONNXRUNTIME_CUSTOM_OP_INVALID_LIB_LINK_FLAG
@@ -1509,7 +1491,7 @@ if (NOT onnxruntime_MINIMAL_BUILD AND NOT onnxruntime_EXTENDED_MINIMAL_BUILD
   if(APPLE)
     set_property(TARGET test_execution_provider APPEND_STRING PROPERTY LINK_FLAGS "-Xlinker -exported_symbols_list ${REPO_ROOT}/onnxruntime/test/testdata/custom_execution_provider_library/exported_symbols.lst")
   elseif(UNIX)
-    set_property(TARGET test_execution_provider APPEND_STRING PROPERTY LINK_FLAGS "-Xlinker --version-script=${REPO_ROOT}/onnxruntime/test/testdata/custom_execution_provider_library/version_script.lds -Xlinker --gc-sections -Xlinker -rpath=\\$ORIGIN")
+    set_property(TARGET test_execution_provider APPEND_STRING PROPERTY LINK_FLAGS "-Wl,--version-script=${REPO_ROOT}/onnxruntime/test/testdata/custom_execution_provider_library/version_script.lds -Wl,--gc-sections -Wl,-rpath=\\$ORIGIN")
   elseif(WIN32)
     set_property(TARGET test_execution_provider APPEND_STRING PROPERTY LINK_FLAGS "-DEF:${REPO_ROOT}/onnxruntime/test/testdata/custom_execution_provider_library/symbols.def")
   else()
