cmake_minimum_required ( VERSION 3.14 )

# Load environment variables
set ( QNX_TARGET $ENV{QNX_TARGET} )
set ( QNX_HOST $ENV{QNX_HOST} )
set ( QNX_PROCESSOR aarch64le )

# Setup build target information
set ( arch "gcc_ntoaarch64le_gpp" )
set ( ntoarch aarch64le )
set ( CMAKE_SYSTEM_NAME QNX )
set ( CMAKE_SYSTEM_VERSION 710 )
set ( CMAKE_SYSTEM_PROCESSOR aarch64 )

# Setup toolchain config
set ( CMAKE_C_COMPILER qcc )
set ( CMAKE_C_COMPILER_TARGET ${arch} )
set ( CMAKE_C_COMPILER_VERSION 8.3.0 )
set ( CMAKE_C_EXTENSIONS ON )
set ( CMAKE_CXX_COMPILER q++ )
set ( CMAKE_CXX_COMPILER_TARGET ${arch} )
set ( CMAKE_CXX_COMPILER_VERSION 8.3.0 )
set ( CMAKE_CXX_EXTENSIONS ON )
set ( CMAKE_ASM_COMPILER qcc -V${arch} )
# set ( CMAKE_ASM_DEFINE_FLAG "-Wa,--defsym" )

# Setup dependencies
set ( Iconv_INCLUDE_DIR ${QNX_TARGET}/usr/include )
set ( Iconv_LIBRARY ${QNX_TARGET}/aarch64le/usr/lib )

# Set compiler predirectives
add_compile_definitions ( __QNX__ )
add_compile_definitions ( __QNXNTO__ )
add_compile_definitions ( _QNX_SOURCE )
add_compile_definitions ( _XOPEN_SOURCE=500 )

# Configuration inherited from pipeline
set ( CMAKE_BUILD_TYPE Release )  # or MinSizeRel
set ( onnxruntime_BUILD_SHARED_LIB ON )
set ( onnxruntime_CROSS_COMPILING ON )
set ( onnxruntime_GCC_STATIC_CPP_RUNTIME OFF )
set ( ONNX_CUSTOM_PROTOC_EXECUTABLE /usr/bin/protoc )
set ( protobuf_WITH_ZLIB OFF )
