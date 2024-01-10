diff --git a/cmake/external/eigen/CMakeLists.txt b/cmake/external/eigen/CMakeLists.txt
index 818f4a5..c9e7be4 100644
--- a/cmake/external/eigen/CMakeLists.txt
+++ b/cmake/external/eigen/CMakeLists.txt
@@ -72,17 +72,17 @@ macro(ei_add_cxx_compiler_flag FLAG)
   endif()
 endmacro()
 
-check_cxx_compiler_flag("-std=c++11" EIGEN_COMPILER_SUPPORT_CPP11)
+check_cxx_compiler_flag("-std=gnu++11" EIGEN_COMPILER_SUPPORT_CPP11)
 
 if(EIGEN_TEST_CXX11)
   set(CMAKE_CXX_STANDARD 11)
-  set(CMAKE_CXX_EXTENSIONS OFF)
+  set(CMAKE_CXX_EXTENSIONS ON)
   if(EIGEN_COMPILER_SUPPORT_CPP11)
-    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
+    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
   endif()
 else()
   #set(CMAKE_CXX_STANDARD 03)
-  #set(CMAKE_CXX_EXTENSIONS OFF)
+  set(CMAKE_CXX_EXTENSIONS ON)
   ei_add_cxx_compiler_flag("-std=c++03")
 endif()
 
