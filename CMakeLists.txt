cmake_minimum_required(VERSION 3.0.0)
project(chat_srv VERSION 1.1.0 LANGUAGES CXX C)
set(CMAKE_CXX_STANDARD 17)

MESSAGE(STATUS "operation system is ${CMAKE_SYSTEM} ${CMAKE_SYSTEM_NAME}") 

# version
execute_process(
    OUTPUT_VARIABLE GIT_BRANCH
    COMMAND git symbolic-ref --short -q HEAD
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
string(TIMESTAMP TODAY "%Y-%m-%d %H:%I")
set(BUILD_VERSION "${TODAY}")
configure_file(
	"${CMAKE_CURRENT_SOURCE_DIR}/version/version_config.h.in"
	"${CMAKE_CURRENT_SOURCE_DIR}/version/version_config.h"
)

option(CMAKE_EXPORT_COMPILE_COMMANDS "Export Compile commands" ON)
# build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

# platform
if(UNIX)
    find_file(CENTOS NAMES redhat-release PATHS "/etc" NO_DEFAULT_PATH)
    if (CENTOS MATCHES "CENTOS-NOTFOUND")
        set(CMAKE_LIBRARY_ARCHITECTURE "ubuntu")
    else()
        set(CMAKE_LIBRARY_ARCHITECTURE "centos")
        option(BUILD_CENTOS "Build in CenOS" ON)
    endif()
    include(cmake/linux.cmake)
    #ADD_COMPILE_OPTIONS(-g -std=c++17 -O2 -Wcomment -Wformat -Wmain -Wparentheses -Wswitch -Wunused -Wuninitialized -Wall)
else()
    set(CMAKE_LIBRARY_ARCHITECTURE "windows")
    include(cmake/windows.cmake)
endif()
include(cmake/common.cmake)


list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
find_package(Zlib)
include_directories("version"
            "${ZLIB_INCLUDE_DIR}"              # zlib
        )

add_definitions(-DSOL_SAFE_STACK_CHECK)
add_definitions(-DSOL_SAFE_USERTYPE)
add_definitions(-DHARDMEMTESTS)
add_subdirectory("src")