diff --git a/cmake/external/flatbuffers/CMakeLists.txt b/cmake/external/flatbuffers/CMakeLists.txt
index 3987eac..3faa6a3 100644
--- a/cmake/external/flatbuffers/CMakeLists.txt
+++ b/cmake/external/flatbuffers/CMakeLists.txt
@@ -211,7 +211,7 @@ if(EXISTS "${CMAKE_TOOLCHAIN_FILE}")
   # is being configured externally
   message(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}.")
 elseif(APPLE)
-  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
+  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -stdlib=libc++")
   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Werror -Wextra -Wno-unused-parameter")
   set(FLATBUFFERS_PRIVATE_CXX_FLAGS "-Wold-style-cast")
 elseif(CMAKE_COMPILER_IS_GNUCXX)
