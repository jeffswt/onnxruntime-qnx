diff --git a/cmake/external/cxxopts/CMakeLists.txt b/cmake/external/cxxopts/CMakeLists.txt
index 440490b..a46fab2 100644
--- a/cmake/external/cxxopts/CMakeLists.txt
+++ b/cmake/external/cxxopts/CMakeLists.txt
@@ -44,7 +44,7 @@ else()
   set(CMAKE_CXX_STANDARD 11)
 endif()
 
-set(CMAKE_CXX_EXTENSIONS OFF)
+set(CMAKE_CXX_EXTENSIONS ON)
 
 if(MSVC)
     set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W2")
