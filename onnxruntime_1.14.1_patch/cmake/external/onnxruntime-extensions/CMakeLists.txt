diff --git a/cmake/external/onnxruntime-extensions/CMakeLists.txt b/cmake/external/onnxruntime-extensions/CMakeLists.txt
index a8c5b9c..fdb0066 100644
--- a/cmake/external/onnxruntime-extensions/CMakeLists.txt
+++ b/cmake/external/onnxruntime-extensions/CMakeLists.txt
@@ -28,7 +28,7 @@ set(CMAKE_C_STANDARD 99)
 
 set(CMAKE_CXX_STANDARD 17)
 set(CMAKE_CXX_STANDARD_REQUIRED ON)
-set(CMAKE_CXX_EXTENSIONS OFF)
+set(CMAKE_CXX_EXTENSIONS ON)
 include(CheckCXXCompilerFlag)
 include(CheckLanguage)
 
