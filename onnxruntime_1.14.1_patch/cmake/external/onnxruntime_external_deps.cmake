diff --git a/cmake/external/onnxruntime_external_deps.cmake b/cmake/external/onnxruntime_external_deps.cmake
index 0c41945..c5c1e50 100644
--- a/cmake/external/onnxruntime_external_deps.cmake
+++ b/cmake/external/onnxruntime_external_deps.cmake
@@ -93,10 +93,17 @@ set(FLATBUFFERS_BUILD_FLATHASH OFF CACHE BOOL "FLATBUFFERS_BUILD_FLATHASH" FORCE
 set(FLATBUFFERS_BUILD_FLATLIB ON CACHE BOOL "FLATBUFFERS_BUILD_FLATLIB" FORCE)
 
 #flatbuffers 1.11.0 does not have flatbuffers::IsOutRange, therefore we require 1.12.0+
+message(">>> USING EXECUTABLE" ${Patch_EXECUTABLE})
+if(Patch_FOUND)
+  set(ONNXRUNTIME_FLATBUFFERS_PATCH_COMMAND ${Patch_EXECUTABLE} --binary --force --ignore-whitespace -p1 < ${PROJECT_SOURCE_DIR}/patches/flatbuffers/flatbuffers_cross.patch)
+else()
+  set(ONNXRUNTIME_FLATBUFFERS_PATCH_COMMAND "")
+endif()
 FetchContent_Declare(
     flatbuffers
     URL ${DEP_URL_flatbuffers}
     URL_HASH SHA1=${DEP_SHA1_flatbuffers}
+    PATCH_COMMAND ${ONNXRUNTIME_FLATBUFFERS_PATCH_COMMAND}
     FIND_PACKAGE_ARGS 1.12.0...<2.0.0 NAMES Flatbuffers
 )
 
@@ -105,9 +112,9 @@ FetchContent_Declare(
 #   for cross-compiling
 #2. if ONNX_CUSTOM_PROTOC_EXECUTABLE is not set, Compile everything(including protoc) from source code.
 if(Patch_FOUND)
-  set(ONNXRUNTIME_PROTOBUF_PATCH_COMMAND ${Patch_EXECUTABLE} --binary --ignore-whitespace -p1 < ${PROJECT_SOURCE_DIR}/patches/protobuf/protobuf_cmake.patch)
+  set(ONNXRUNTIME_PROTOBUF_PATCH_COMMAND ${Patch_EXECUTABLE} --binary --force --ignore-whitespace -p1 < ${PROJECT_SOURCE_DIR}/patches/protobuf/protobuf_cmake.patch)
 else()
- set(ONNXRUNTIME_PROTOBUF_PATCH_COMMAND "")
+  set(ONNXRUNTIME_PROTOBUF_PATCH_COMMAND "")
 endif()
 FetchContent_Declare(
   Protobuf
