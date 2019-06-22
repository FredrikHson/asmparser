cmake_minimum_required(VERSION 3.14)

project(compiler)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
endif()



set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 11)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

#flex_target(TOKENS ${CMAKE_CURRENT_SOURCE_DIR}/tokens.l ${CMAKE_CURRENT_BINARY_DIR}/tokens.yy.c)
#bison_target(ASM ${CMAKE_CURRENT_SOURCE_DIR}/asm.y ${CMAKE_CURRENT_BINARY_DIR}/asm.tab.c)
flex_target(C ${CMAKE_CURRENT_SOURCE_DIR}/preprocessor.l ${CMAKE_CURRENT_BINARY_DIR}/preprocessor.yy.c)
bison_target(C ${CMAKE_CURRENT_SOURCE_DIR}/preprocessor.y ${CMAKE_CURRENT_BINARY_DIR}/preprocessor.tab.c)

#add_executable(${CMAKE_PROJECT_NAME}  ${BISON_ASM_OUTPUTS} ${FLEX_TOKENS_OUTPUTS})
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_executable(preprocessor  ${BISON_C_OUTPUTS} ${FLEX_C_OUTPUTS} preprocessor.c textlist.c)
#target_compile_options(preprocessor PUBLIC "-fno-omit-frame-pointer")
#target_compile_options(preprocessor PUBLIC "-fsanitize=address")

#target_link_libraries(${CMAKE_PROJECT_NAME} ${FLEX_LIBRARIES})
#target_link_libraries(preprocessor asan ${FLEX_LIBRARIES} )
target_link_libraries(preprocessor ${FLEX_LIBRARIES} )
