diff --git a/cmake/external/onnx/CMakeLists.txt b/cmake/external/onnx/CMakeLists.txt
index 628dcaa..5a205f5 100644
--- a/cmake/external/onnx/CMakeLists.txt
+++ b/cmake/external/onnx/CMakeLists.txt
@@ -16,7 +16,7 @@ cmake_policy(SET CMP0063 NEW)
 # Project
 project(onnx C CXX)
 option(ONNX_BUILD_BENCHMARKS "Build ONNX micro-benchmarks" OFF)
-option(ONNX_USE_PROTOBUF_SHARED_LIBS "Build ONNX using protobuf shared library. Sets PROTOBUF_USE_DLLS CMAKE Flag " OFF)
+option(ONNX_USE_PROTOBUF_SHARED_LIBS "Build ONNX using protobuf shared library. Sets PROTOBUF_USE_DLLS CMAKE Flag and Protobuf_USE_STATIC_LIBS. " OFF)
 
 option(BUILD_ONNX_PYTHON "Build Python binaries" OFF)
 option(ONNX_GEN_PB_TYPE_STUBS "Generate protobuf python type stubs" ON)
@@ -48,11 +48,14 @@ if(NOT DEFINED ONNX_VERIFY_PROTO3)
   option(ONNX_VERIFY_PROTO3 "Generate code by proto3" ${PROTO3_ENABLED})
 endif()
 
- if (ONNX_USE_PROTOBUF_SHARED_LIBS)
+if(ONNX_USE_PROTOBUF_SHARED_LIBS)
   if(MSVC)
     #TODO: if ONNX_USE_MSVC_STATIC_RUNTIME is ON, it may not work
     add_definitions(-DPROTOBUF_USE_DLLS)
   endif()
+  set(Protobuf_USE_STATIC_LIBS OFF)
+else()
+  set(Protobuf_USE_STATIC_LIBS ON)
 endif()
 
 # Set C++11 as standard for the whole project
@@ -79,14 +82,6 @@ endif()
 if(NOT ONNX_NAMESPACE)
   set(ONNX_NAMESPACE "onnx")
 endif()
-
-if(MSVC)
-  if(NOT ONNX_DISABLE_EXCEPTIONS)
-    string(APPEND CMAKE_CXX_FLAGS " /EHsc /wd26812")
-    string(APPEND CMAKE_C_FLAGS " /EHsc /wd26812")
-  endif()
-endif()
-
 if(ONNX_DISABLE_EXCEPTIONS)
   add_compile_definitions("ONNX_NO_EXCEPTIONS")
   # Disable C++ exceptions.
@@ -103,16 +98,17 @@ if(ONNX_WERROR)
     string(APPEND CMAKE_CXX_FLAGS " /WX")
     string(APPEND CMAKE_C_FLAGS " /WX")
   else()
-    string(APPEND CMAKE_CXX_FLAGS " -Werror")
-    string(APPEND CMAKE_C_FLAGS " -Werror -Wno-error=incompatible-pointer-types")
+    string(APPEND CMAKE_C_FLAGS "-Wno-error=incompatible-pointer-types")
   endif()
 endif()
 
 # find_package Python has replaced PythonInterp and PythonLibs since cmake 3.12
 # Use the following command in the future; now this is only compatible with the latest pybind11
 # find_package(Python ${PY_VERSION} COMPONENTS Interpreter Development REQUIRED)
-find_package(PythonInterp ${PY_VERSION} REQUIRED)
-find_package(PythonLibs ${PY_VERSION})
+if ( NOT CMAKE_SYSTEM_NAME STREQUAL "QNX" )
+  find_package(PythonInterp ${PY_VERSION} REQUIRED)
+  find_package(PythonLibs ${PY_VERSION})
+endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "AIX")
   set(CMAKE_NO_SYSTEM_FROM_IMPORTED 1)
@@ -357,6 +353,7 @@ list(REMOVE_ITEM __tmp_srcs ${onnx_gtests_src})
 list(APPEND ONNX_SRCS ${__tmp_srcs})
 
 add_library(onnx_proto ${ONNX_PROTO_SRCS} ${ONNX_PROTO_HDRS})
+add_dependencies(onnx_proto gen_onnx_operators_proto gen_onnx_data_proto)
 target_include_directories(onnx_proto PUBLIC
   $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
   $<INSTALL_INTERFACE:include>
@@ -485,22 +482,6 @@ if(BUILD_ONNX_PYTHON)
     target_link_libraries(onnx_cpp2py_export PRIVATE ${PYTHON_LIBRARIES})
     target_compile_options(onnx_cpp2py_export
                            PRIVATE /MP
-                                   /WX
-                                   /wd4800 # disable warning type' : forcing
-                                           # value to bool 'true' or 'false'
-                                           # (performance warning)
-                                   /wd4503 # identifier' : decorated name length
-                                           # exceeded, name was truncated
-                                   /wd4146 # unary minus operator applied to
-                                           # unsigned type, result still
-                                           # unsigned from include\google\protob
-                                           # uf\wire_format_lite.h
-                                 /wd4244 # 'argument': conversion from 'google::
-                                         # protobuf::uint64' to 'int', possible
-                                         # loss of data
-                                 /wd4267 # Conversion from 'size_t' to 'int',
-                                         # possible loss of data
-                                 /wd4996 # The second parameter is ignored.
                                    ${EXTRA_FLAGS})
     if(ONNX_USE_PROTOBUF_SHARED_LIBS)
       target_compile_options(onnx_cpp2py_export
@@ -545,38 +526,9 @@ endif()
 if(MSVC)
   target_compile_options(onnx_proto
                          PRIVATE /MP
-                                 /WX
-                                 /wd4800 # disable warning type' : forcing value
-                                         # to bool 'true' or 'false'
-                                         # (performance warning)
-                                 /wd4503 # identifier' : decorated name length
-                                         # exceeded, name was truncated
-                                 /wd4146 # unary minus operator applied to
-                                         # unsigned type, result still unsigned:
-                                         # include\google\protobuf\wire_format_l
-                                         # ite.h
-                                 /wd4244 #'argument': conversion from 'google::
-                                         #protobuf::uint64' to 'int', possible
-                                         # loss of data
-                                 /wd4267 # Conversion from 'size_t' to 'int',
-                                         # possible loss of data
                                  ${EXTRA_FLAGS})
   target_compile_options(onnx
                          PRIVATE /MP
-                                 /WX
-                                 /wd4800 # disable warning type' : forcing value
-                                         # to bool 'true' or 'false'
-                                         # (performance warning)
-                                 /wd4503 # identifier' : decorated name length
-                                         # exceeded, name was truncated
-                                 /wd4146 # unary minus operator applied to
-                                         # unsigned type, result still unsigned
-                                 /wd4244 # 'argument': conversion from 'google::
-                                         # protobuf::uint64' to 'int', possible
-                                         # loss of data
-                                 /wd4267 # Conversion from 'size_t' to 'int',
-                                         # possible loss of data
-                                 /wd4996 # The second parameter is ignored.
                                  ${EXTRA_FLAGS})
   if(ONNX_USE_PROTOBUF_SHARED_LIBS)
       target_compile_options(onnx_proto
@@ -678,11 +630,6 @@ target_link_libraries(onnxifi_dummy PUBLIC onnxifi ${CMAKE_DL_LIBS})
 target_compile_definitions(onnxifi_dummy PRIVATE ONNXIFI_BUILD_LIBRARY=TRUE)
 if(MSVC)
   add_msvc_runtime_flag(onnxifi_dummy)
-
-  target_compile_options(onnxifi_dummy
-                         PRIVATE /wd4113 # 'identifier1' differs in parameter
-                                         # lists from 'identifier2'
-                        )
 endif()
 
 include(GNUInstallDirs)
@@ -728,5 +675,8 @@ if(ONNX_BUILD_TESTS)
   include(${ONNX_ROOT}/cmake/unittest.cmake)
 endif()
 
+# Support older g++ to use PRId64
+add_definitions(-D__STDC_FORMAT_MACROS)
+
 include(cmake/summary.cmake)
 onnx_print_configuration_summary()
