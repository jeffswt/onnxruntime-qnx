diff --git a/cmake/external/tvm/CMakeLists.txt b/cmake/external/tvm/CMakeLists.txt
index f532960..bc49c47 100644
--- a/cmake/external/tvm/CMakeLists.txt
+++ b/cmake/external/tvm/CMakeLists.txt
@@ -83,12 +83,12 @@ if(MSVC)
   endif()
 else(MSVC)
   include(CheckCXXCompilerFlag)
-  check_cxx_compiler_flag("-std=c++11"    SUPPORT_CXX11)
+  check_cxx_compiler_flag("-std=gnu++11"    SUPPORT_CXX11)
   if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
-    add_compile_options(-O0 -Wall -fPIC -fvisibility=hidden -std=c++11)
+    add_compile_options(-O0 -Wall -fPIC -fvisibility=hidden -std=gnu++11)
   else()
     set(CMAKE_C_FLAGS "-O2 -Wall -fPIC -fvisibility=hidden ${CMAKE_C_FLAGS}")
-    set(CMAKE_CXX_FLAGS "-O2 -Wall -fPIC -fvisibility=hidden -std=c++11 ${CMAKE_CXX_FLAGS}")
+    set(CMAKE_CXX_FLAGS "-O2 -Wall -fPIC -fvisibility=hidden -std=gnu++11 ${CMAKE_CXX_FLAGS}")
   endif ()
   if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND
       CMAKE_CXX_COMPILER_VERSION VERSION_GREATER 7.0)
