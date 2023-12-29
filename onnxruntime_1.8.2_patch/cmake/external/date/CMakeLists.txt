diff --git a/cmake/external/date/CMakeLists.txt b/cmake/external/date/CMakeLists.txt
index f025a3a..b5a93c1 100644
--- a/cmake/external/date/CMakeLists.txt
+++ b/cmake/external/date/CMakeLists.txt
@@ -141,7 +141,7 @@ if ( ENABLE_DATE_TESTING )
             #target_compile_definitions( ${BIN_NAME} PRIVATE ${TST_NAME} )
             set( TEST_BIN_NAME ${CMAKE_BINARY_DIR}/${BIN_NAME} )
             add_custom_target( ${BIN_NAME}
-                COMMAND ${PROJECT_SOURCE_DIR}/compile_fail.sh ${TEST_BIN_NAME} ${CMAKE_CXX_COMPILER} -std=c++14 -L${CMAKE_BINARY_DIR}/ -ltz -I${PROJECT_SOURCE_DIR}/${HEADER_FOLDER}/date -o ${BIN_NAME} ${TEST_FILE}
+                COMMAND ${PROJECT_SOURCE_DIR}/compile_fail.sh ${TEST_BIN_NAME} ${CMAKE_CXX_COMPILER} -std=gnu++14 -L${CMAKE_BINARY_DIR}/ -ltz -I${PROJECT_SOURCE_DIR}/${HEADER_FOLDER}/date -o ${BIN_NAME} ${TEST_FILE}
                 WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                 COMMENT ${TST_NAME}
                 )
