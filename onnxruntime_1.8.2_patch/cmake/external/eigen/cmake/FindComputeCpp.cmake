diff --git a/cmake/external/eigen/cmake/FindComputeCpp.cmake b/cmake/external/eigen/cmake/FindComputeCpp.cmake
index 3cca515..bcd2d1e 100644
--- a/cmake/external/eigen/cmake/FindComputeCpp.cmake
+++ b/cmake/external/eigen/cmake/FindComputeCpp.cmake
@@ -251,9 +251,9 @@ function(__build_ir)
   if (targetCxxStandard MATCHES 17)
     set(device_compiler_cxx_standard "-std=c++1z")
   elseif (targetCxxStandard MATCHES 14)
-    set(device_compiler_cxx_standard "-std=c++14")
+    set(device_compiler_cxx_standard "-std=gnu++14")
   elseif (targetCxxStandard MATCHES 11)
-    set(device_compiler_cxx_standard "-std=c++11")
+    set(device_compiler_cxx_standard "-std=gnu++11")
   elseif (targetCxxStandard MATCHES 98)
     message(FATAL_ERROR "SYCL applications cannot be compiled using C++98")
   else ()
