diff --git a/cmake/external/onnx/third_party/pybind11/CMakeLists.txt b/cmake/external/onnx/third_party/pybind11/CMakeLists.txt
index 3787982..c8d37c3 100644
--- a/cmake/external/onnx/third_party/pybind11/CMakeLists.txt
+++ b/cmake/external/onnx/third_party/pybind11/CMakeLists.txt
@@ -75,7 +75,7 @@ if(CMAKE_SOURCE_DIR STREQUAL PROJECT_SOURCE_DIR)
   message(STATUS "CMake ${CMAKE_VERSION}")
 
   if(CMAKE_CXX_STANDARD)
-    set(CMAKE_CXX_EXTENSIONS OFF)
+    set(CMAKE_CXX_EXTENSIONS ON)
     set(CMAKE_CXX_STANDARD_REQUIRED ON)
   endif()
 
