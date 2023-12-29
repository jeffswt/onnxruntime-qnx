diff --git a/cmake/external/nsync/CMakeLists.txt b/cmake/external/nsync/CMakeLists.txt
index 6b1f1dc..7fad5e1 100644
--- a/cmake/external/nsync/CMakeLists.txt
+++ b/cmake/external/nsync/CMakeLists.txt
@@ -195,7 +195,7 @@ endif ()
 
 if (NSYNC_POSIX)
 	include_directories ("${PROJECT_SOURCE_DIR}/platform/posix")
-	set (NSYNC_CPP_FLAGS "-std=c++11")
+	set (NSYNC_CPP_FLAGS "-std=gnu++11")
 
 	set (NSYNC_OS_SRC
 		${NSYNC_POSIX_SRC}
