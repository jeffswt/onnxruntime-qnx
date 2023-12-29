diff --git a/cmake/onnxruntime_mlas.cmake b/cmake/onnxruntime_mlas.cmake
index 6ee1db9..e8b38b2 100644
--- a/cmake/onnxruntime_mlas.cmake
+++ b/cmake/onnxruntime_mlas.cmake
@@ -152,6 +152,9 @@ else()
     endif()
   elseif(CMAKE_SYSTEM_NAME STREQUAL "iOS" OR CMAKE_SYSTEM_NAME STREQUAL "iOSCross")
     set(IOS TRUE)
+  elseif(CMAKE_SYSTEM_NAME STREQUAL "QNX")
+    set(QNX TRUE)
+    set(ARM64 TRUE)
   else()
     execute_process(
       COMMAND ${CMAKE_C_COMPILER} -dumpmachine
