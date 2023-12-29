diff --git a/cmake/CMakeLists.txt b/cmake/CMakeLists.txt
index 3ffdba8..e142323 100644
--- a/cmake/CMakeLists.txt
+++ b/cmake/CMakeLists.txt
@@ -412,7 +412,7 @@ set(onnxruntime_LINK_LIBATOMIC false)
 if (NOT MSVC AND NOT (CMAKE_SYSTEM_NAME STREQUAL "iOS"))
   include(CheckCXXSourceCompiles)
   set(OLD_CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS})
-  set(CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS} -std=c++11)
+  set(CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS} -std=gnu++11)
   check_cxx_source_compiles("
     #include <atomic>
     int main() {
@@ -651,7 +651,7 @@ if(onnxruntime_BUILD_SHARED_LIB OR onnxruntime_ENABLE_PYTHON)
     find_package(PythonInterp 3.5 REQUIRED)
     find_package(PythonLibs 3.5 REQUIRED)
   else()
-    find_package(PythonInterp 3.4 REQUIRED)
+    # find_package(PythonInterp 3.4 REQUIRED)
   endif()
 endif()
 
