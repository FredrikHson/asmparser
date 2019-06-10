cmake_minimum_required(VERSION 3.14)

project(compiler)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)



set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 11)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

flex_target(TOKENS ${CMAKE_CURRENT_SOURCE_DIR}/tokens.l ${CMAKE_CURRENT_BINARY_DIR}/tokens.yy.c)
bison_target(ASM ${CMAKE_CURRENT_SOURCE_DIR}/asm.y ${CMAKE_CURRENT_BINARY_DIR}/asm.tab.c)

add_executable(${CMAKE_PROJECT_NAME}  ${BISON_ASM_OUTPUTS} ${FLEX_TOKENS_OUTPUTS})

target_link_libraries(${CMAKE_PROJECT_NAME}
    ${FLEX_LIBRARIES}
)
