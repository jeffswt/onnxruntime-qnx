diff --git a/cmake/onnxruntime_providers.cmake b/cmake/onnxruntime_providers.cmake
index ca6d122..725bd71 100644
--- a/cmake/onnxruntime_providers.cmake
+++ b/cmake/onnxruntime_providers.cmake
@@ -337,7 +337,8 @@ if (NOT onnxruntime_MINIMAL_BUILD AND NOT onnxruntime_EXTENDED_MINIMAL_BUILD
   if(APPLE)
   set_property(TARGET onnxruntime_providers_shared APPEND_STRING PROPERTY LINK_FLAGS "-Xlinker -exported_symbols_list ${ONNXRUNTIME_ROOT}/core/providers/shared/exported_symbols.lst")
   elseif(UNIX)
-  set_property(TARGET onnxruntime_providers_shared APPEND_STRING PROPERTY LINK_FLAGS "-Xlinker --version-script=${ONNXRUNTIME_ROOT}/core/providers/shared/version_script.lds -Xlinker --gc-sections")
+  set_property(TARGET onnxruntime_providers_shared APPEND_STRING PROPERTY LINK_FLAGS "-Wl,--version-script=${ONNXRUNTIME_ROOT}/core/providers/shared/version_script.lds -Wl,--gc-sections")
+  # set_property(TARGET onnxruntime_providers_shared APPEND_STRING PROPERTY LINK_FLAGS "-Xlinker --version-script=${ONNXRUNTIME_ROOT}/core/providers/shared/version_script.lds -Xlinker --gc-sections")
   elseif(WIN32)
   set_property(TARGET onnxruntime_providers_shared APPEND_STRING PROPERTY LINK_FLAGS "-DEF:${ONNXRUNTIME_ROOT}/core/providers/shared/symbols.def")
   set(ONNXRUNTIME_PROVIDERS_SHARED onnxruntime_providers_shared)
