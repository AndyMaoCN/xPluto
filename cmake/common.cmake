
# output directory
# message("out ${CMAKE_BINARY_DIR}")
# message("out ${CMAKE_LIBRARY_PATH}")
set(ROOT_LIB_OUT_DIR ${PROJECT_SOURCE_DIR}/_generate/lib/${CMAKE_LIBRARY_ARCHITECTURE}/${CMAKE_BUILD_TYPE})
set(ROOT_ARC_OUT_DIR ${PROJECT_SOURCE_DIR}/_generate/arc/${CMAKE_LIBRARY_ARCHITECTURE}/${CMAKE_BUILD_TYPE})
set(ROOT_BIN_OUT_DIR ${PROJECT_SOURCE_DIR}/_generate/bin/${CMAKE_LIBRARY_ARCHITECTURE}/${CMAKE_BUILD_TYPE})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${ROOT_ARC_OUT_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${ROOT_LIB_OUT_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${ROOT_BIN_OUT_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${ROOT_ARC_OUT_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${ROOT_LIB_OUT_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${ROOT_BIN_OUT_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${ROOT_ARC_OUT_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${ROOT_LIB_OUT_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${ROOT_BIN_OUT_DIR})
if(UNIX)
    if(BUILD_CENTOS)
        set(PUBLISH_PATH "${PROJECT_SOURCE_DIR}/scripts/cbin")
    else()
        set(PUBLISH_PATH "${PROJECT_SOURCE_DIR}/scripts/ubin")
    endif()
    set(PROTOBUF_PROTOC_EXECUTABLE "${ROOT_BIN_OUT_DIR}/protoc")
else()
    set(PUBLISH_PATH "${PROJECT_SOURCE_DIR}/scripts/bin")
    set(PROTOBUF_PROTOC_EXECUTABLE "${ROOT_BIN_OUT_DIR}/protoc.exe")
endif()
# set(MOD_OUTPUT_PATH ${PUBLISH_PATH}/luamod)
# def
add_definitions(-DASIO_STANDALONE)
add_definitions(-DASIO_NO_DEPRECATED)
add_definitions(-DUSE_OPENSSL)
add_definitions(-D_SILENCE_CXX17_ALLOCATOR_VOID_DEPRECATION_WARNING)

# include
# set(OPT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/opt")
# find_path(ASIO_INCLUDE_DIR NAMES "asio.hpp" PATHS "${OPT_PATH}/asio/asio/include")
# find_path(SOL2_INCLUDE_DIR NAMES "sol/sol.hpp" PATHS "${OPT_PATH}/sol2/include")
# find_path(SPDLOG_INCLUDE_DIR NAMES "spdlog/spdlog.h" PATHS "${OPT_PATH}/spdlog/include")
# include( FindPackageHandleStandardArgs )
# find_package_handle_standard_args(HEADERS REQUIRED_VARS ASIO_INCLUDE_DIR SOL2_INCLUDE_DIR SPDLOG_INCLUDE_DIR)

# if(NOT HEADERS_FOUND)
#     message(SEND_ERROR "Incomplete file")
# endif()


# include_directories("${CMAKE_CURRENT_SOURCE_DIR}/opt/rapidjson/include")   # rapidjson
# include_directories("${CMAKE_CURRENT_SOURCE_DIR}/opt/zlib/include")        # zlib
# include_directories("${CMAKE_CURRENT_SOURCE_DIR}/opt/yaml-cpp/include")    # yaml-cpp
# include_directories("${CMAKE_CURRENT_SOURCE_DIR}/opt/benchmark/inclue")    # benchmark

# include_directories("${OPENSSL_INCLUDE_DIR}")                                 # openssl
# include_directories("${ZLIB_INCLUDE_DIR}")                                    # zlib
