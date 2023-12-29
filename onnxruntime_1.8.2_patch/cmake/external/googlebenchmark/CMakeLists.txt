diff --git a/cmake/external/googlebenchmark/CMakeLists.txt b/cmake/external/googlebenchmark/CMakeLists.txt
index e75d41f..cd24891 100644
--- a/cmake/external/googlebenchmark/CMakeLists.txt
+++ b/cmake/external/googlebenchmark/CMakeLists.txt
@@ -145,7 +145,7 @@ if (MSVC)
 else()
   # Try and enable C++11. Don't use C++14 because it doesn't work in some
   # configurations.
-  add_cxx_compiler_flag(-std=c++11)
+  add_cxx_compiler_flag(-std=gnu++11)
   if (NOT HAVE_CXX_FLAG_STD_CXX11)
     add_cxx_compiler_flag(-std=c++0x)
   endif()
