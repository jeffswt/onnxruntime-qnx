diff --git a/cmake/CMakeLists.txt b/cmake/CMakeLists.txt
index a5d28fb..d646b24 100644
--- a/cmake/CMakeLists.txt
+++ b/cmake/CMakeLists.txt
@@ -24,6 +24,7 @@ include(CMakeDependentOption)
 include(FetchContent)
 
 set(CMAKE_CXX_STANDARD 17)
+set(CMAKE_CXX_EXTENSIONS ON)
 
 set_property(GLOBAL PROPERTY USE_FOLDERS ON)
 # NOTE: POSITION INDEPENDENT CODE hurts performance, and it only make sense on POSIX systems
@@ -440,7 +441,7 @@ set(onnxruntime_LINK_LIBATOMIC false)
 if (NOT MSVC AND NOT (CMAKE_SYSTEM_NAME STREQUAL "iOS"))
   include(CheckCXXSourceCompiles)
   set(OLD_CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS})
-  set(CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS} -std=c++11)
+  set(CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS} -std=gnu++11)
   check_cxx_source_compiles("
     #include <atomic>
     int main() {
