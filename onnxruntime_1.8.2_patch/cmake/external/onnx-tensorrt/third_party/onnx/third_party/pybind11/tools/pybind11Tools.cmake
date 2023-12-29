diff --git a/cmake/external/onnx-tensorrt/third_party/onnx/third_party/pybind11/tools/pybind11Tools.cmake b/cmake/external/onnx-tensorrt/third_party/onnx/third_party/pybind11/tools/pybind11Tools.cmake
index c7156c0..6656bb0 100644
--- a/cmake/external/onnx-tensorrt/third_party/onnx/third_party/pybind11/tools/pybind11Tools.cmake
+++ b/cmake/external/onnx-tensorrt/third_party/onnx/third_party/pybind11/tools/pybind11Tools.cmake
@@ -20,14 +20,14 @@ include(CMakeParseArguments)
 
 if(NOT PYBIND11_CPP_STANDARD AND NOT CMAKE_CXX_STANDARD)
   if(NOT MSVC)
-    check_cxx_compiler_flag("-std=c++14" HAS_CPP14_FLAG)
+    check_cxx_compiler_flag("-std=gnu++14" HAS_CPP14_FLAG)
 
     if (HAS_CPP14_FLAG)
-      set(PYBIND11_CPP_STANDARD -std=c++14)
+      set(PYBIND11_CPP_STANDARD -std=gnu++14)
     else()
-      check_cxx_compiler_flag("-std=c++11" HAS_CPP11_FLAG)
+      check_cxx_compiler_flag("-std=gnu++11" HAS_CPP11_FLAG)
       if (HAS_CPP11_FLAG)
-        set(PYBIND11_CPP_STANDARD -std=c++11)
+        set(PYBIND11_CPP_STANDARD -std=gnu++11)
       else()
         message(FATAL_ERROR "Unsupported compiler -- pybind11 requires C++11 support!")
       endif()
@@ -37,7 +37,7 @@ if(NOT PYBIND11_CPP_STANDARD AND NOT CMAKE_CXX_STANDARD)
   endif()
 
   set(PYBIND11_CPP_STANDARD ${PYBIND11_CPP_STANDARD} CACHE STRING
-      "C++ standard flag, e.g. -std=c++11, -std=c++14, /std:c++14.  Defaults to C++14 mode." FORCE)
+      "C++ standard flag, e.g. -std=gnu++11, -std=gnu++14, /std:c++14.  Defaults to C++14 mode." FORCE)
 endif()
 
 # Checks whether the given CXX/linker flags can compile and link a cxx file.  cxxflags and
