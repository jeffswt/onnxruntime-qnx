diff --git a/cmake/external/re2/CMakeLists.txt b/cmake/external/re2/CMakeLists.txt
index f87c4ff..97eb3fa 100644
--- a/cmake/external/re2/CMakeLists.txt
+++ b/cmake/external/re2/CMakeLists.txt
@@ -40,15 +40,15 @@ elseif(CYGWIN OR MINGW)
   # See https://stackoverflow.com/questions/38139631 for details.
   add_compile_options(-std=gnu++11)
 elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
-  add_compile_options(-std=c++11)
+  add_compile_options(-std=gnu++11)
 endif()
 
 if(WIN32)
   add_definitions(-DUNICODE -D_UNICODE -DSTRICT -DNOMINMAX)
   add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS)
 elseif(UNIX)
-  add_compile_options(-pthread)
-  list(APPEND EXTRA_TARGET_LINK_LIBRARIES -pthread)
+  # add_compile_options(-pthread)
+  # list(APPEND EXTRA_TARGET_LINK_LIBRARIES -pthread)
 endif()
 
 if(USEPCRE)
