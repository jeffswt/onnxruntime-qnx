diff --git a/cmake/external/coremltools/deps/pybind11/tools/pybind11Tools.cmake b/cmake/external/coremltools/deps/pybind11/tools/pybind11Tools.cmake
index 3fbffee..0b60124 100644
--- a/cmake/external/coremltools/deps/pybind11/tools/pybind11Tools.cmake
+++ b/cmake/external/coremltools/deps/pybind11/tools/pybind11Tools.cmake
@@ -20,19 +20,19 @@ include(CMakeParseArguments)
 
 function(select_cxx_standard)
   if(NOT MSVC AND NOT PYBIND11_CPP_STANDARD)
-    check_cxx_compiler_flag("-std=c++14" HAS_CPP14_FLAG)
-    check_cxx_compiler_flag("-std=c++11" HAS_CPP11_FLAG)
+    check_cxx_compiler_flag("-std=gnu++14" HAS_CPP14_FLAG)
+    check_cxx_compiler_flag("-std=gnu++11" HAS_CPP11_FLAG)
 
     if (HAS_CPP14_FLAG)
-      set(PYBIND11_CPP_STANDARD -std=c++14)
+      set(PYBIND11_CPP_STANDARD -std=gnu++14)
     elseif (HAS_CPP11_FLAG)
-      set(PYBIND11_CPP_STANDARD -std=c++11)
+      set(PYBIND11_CPP_STANDARD -std=gnu++11)
     else()
       message(FATAL_ERROR "Unsupported compiler -- pybind11 requires C++11 support!")
     endif()
 
     set(PYBIND11_CPP_STANDARD ${PYBIND11_CPP_STANDARD} CACHE STRING
-        "C++ standard flag, e.g. -std=c++11 or -std=c++14. Defaults to latest available." FORCE)
+        "C++ standard flag, e.g. -std=gnu++11 or -std=gnu++14. Defaults to latest available." FORCE)
   endif()
 endfunction()
 
