diff --git a/cmake/external/protobuf/cmake/CMakeLists.txt b/cmake/external/protobuf/cmake/CMakeLists.txt
index ac92442..9ec0d2a 100644
--- a/cmake/external/protobuf/cmake/CMakeLists.txt
+++ b/cmake/external/protobuf/cmake/CMakeLists.txt
@@ -29,7 +29,7 @@ if (CYGWIN)
 else()
   set(CMAKE_CXX_STANDARD 11)
   set(CMAKE_CXX_STANDARD_REQUIRED ON)
-  set(CMAKE_CXX_EXTENSIONS OFF)
+  set(CMAKE_CXX_EXTENSIONS ON)
 endif()
 
 # The Intel compiler isn't able to deal with noinline member functions of
@@ -185,7 +185,7 @@ set(protobuf_LINK_LIBATOMIC false)
 if (NOT MSVC)
   include(CheckCXXSourceCompiles)
   set(OLD_CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS})
-  set(CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS} -std=c++11)
+  set(CMAKE_REQUIRED_FLAGS ${CMAKE_REQUIRED_FLAGS} -std=gnu++11)
   check_cxx_source_compiles("
     #include <atomic>
     int main() {
