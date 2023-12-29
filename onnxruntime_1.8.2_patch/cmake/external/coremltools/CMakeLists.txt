diff --git a/cmake/external/coremltools/CMakeLists.txt b/cmake/external/coremltools/CMakeLists.txt
index b76d8c6..c08120b 100644
--- a/cmake/external/coremltools/CMakeLists.txt
+++ b/cmake/external/coremltools/CMakeLists.txt
@@ -18,7 +18,7 @@ endif()
 
 set(CMAKE_CXX_STANDARD 14)
 set(CMAKE_CXX_STANDARD_REQUIRED ON)
-set(CMAKE_CXX_EXTENSIONS OFF)
+set(CMAKE_CXX_EXTENSIONS ON)
 
 # Globally ignore "no symbols" warnings during compilation
 SET(CMAKE_CXX_ARCHIVE_CREATE "<CMAKE_AR> Scr <TARGET> <LINK_FLAGS> <OBJECTS>")
