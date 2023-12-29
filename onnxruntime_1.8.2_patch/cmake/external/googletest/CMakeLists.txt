diff --git a/cmake/external/googletest/CMakeLists.txt b/cmake/external/googletest/CMakeLists.txt
index f11bbb5..cc076ef 100644
--- a/cmake/external/googletest/CMakeLists.txt
+++ b/cmake/external/googletest/CMakeLists.txt
@@ -11,12 +11,12 @@ project(googletest-distribution)
 set(GOOGLETEST_VERSION 1.10.0)
 
 if (CMAKE_VERSION VERSION_LESS "3.1")
-  add_definitions(-std=c++11)
+  add_definitions(-std=gnu++11)
 else()
   set(CMAKE_CXX_STANDARD 11)
   set(CMAKE_CXX_STANDARD_REQUIRED ON)
   if(NOT CYGWIN)
-    set(CMAKE_CXX_EXTENSIONS OFF)
+    set(CMAKE_CXX_EXTENSIONS ON)
   endif()
 endif()
 
