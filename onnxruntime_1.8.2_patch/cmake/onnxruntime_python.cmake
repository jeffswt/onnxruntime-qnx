diff --git a/cmake/onnxruntime_python.cmake b/cmake/onnxruntime_python.cmake
index eccc206..faeb323 100644
--- a/cmake/onnxruntime_python.cmake
+++ b/cmake/onnxruntime_python.cmake
@@ -84,7 +84,7 @@ endif()
 if(APPLE)
   set(ONNXRUNTIME_SO_LINK_FLAG "-Xlinker -exported_symbols_list ${ONNXRUNTIME_ROOT}/python/exported_symbols.lst")
 elseif(UNIX)
-  set(ONNXRUNTIME_SO_LINK_FLAG "-Xlinker --version-script=${ONNXRUNTIME_ROOT}/python/version_script.lds -Xlinker --gc-sections")
+  set(ONNXRUNTIME_SO_LINK_FLAG "-Wl,--version-script=${ONNXRUNTIME_ROOT}/python/version_script.lds -Wl,--gc-sections")
 else()
   set(ONNXRUNTIME_SO_LINK_FLAG "-DEF:${ONNXRUNTIME_ROOT}/python/pybind.def")
 endif()
@@ -143,7 +143,7 @@ elseif (APPLE)
     INSTALL_RPATH_USE_LINK_PATH FALSE)
 else()
   target_link_libraries(onnxruntime_pybind11_state PRIVATE ${onnxruntime_pybind11_state_libs} ${onnxruntime_EXTERNAL_LIBRARIES})
-  set_property(TARGET onnxruntime_pybind11_state APPEND_STRING PROPERTY LINK_FLAGS " -Xlinker -rpath=\\$ORIGIN")
+  set_property(TARGET onnxruntime_pybind11_state APPEND_STRING PROPERTY LINK_FLAGS " -Wl,-rpath=\\$ORIGIN")
 endif()
 
 set_target_properties(onnxruntime_pybind11_state PROPERTIES PREFIX "")
