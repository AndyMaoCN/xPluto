
# cxx flag
if (MSVC_VERSION GREATER_EQUAL "1900")
    include(CheckCXXCompilerFlag)
    CHECK_CXX_COMPILER_FLAG("/std:c++latest" _cpp_latest_flag_supported)
    if (_cpp_latest_flag_supported)
        add_compile_options("/std:c++latest")
    endif()
else()
    message("Current msvc not support /std:c++latest")
    # set(CMAKE_CXX_STANDARD 17)
endif()

string(REGEX REPLACE "/EH[a-z]+" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc")
add_compile_options("/MP")
add_compile_options("-bigobj")

# .pdb on release
# set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Zi /O2 /D")  
# set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /debug")
# set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} /DEBUG /OPT:REF /OPT:ICF")


set_property(GLOBAL PROPERTY USE_FOLDERS ON)

add_definitions(-DWIN32)
add_definitions(-D_WIN32_WINDOWS)
add_definitions(-D_WINSOCK_DEPRECATED_NO_WARNINGS)
add_definitions(-DASIO_HAS_IOCP)
set(DLL_SUFFIX ".dll")
# other
set(THREAD_LIBRARY)
set(FILE_SYSTEM_LIBRARY)
# warning
add_definitions(
    /wd4018 # 'expression' : signed/unsigned mismatch
    /wd4065 # switch statement contains 'default' but no 'case' labels
    /wd4146 # unary minus operator applied to unsigned type, result still unsigned
    /wd4244 # 'conversion' conversion from 'type1' to 'type2', possible loss of data
    /wd4251 # 'identifier' : class 'type' needs to have dll-interface to be used by clients of class 'type2'
    /wd4267 # 'var' : conversion from 'size_t' to 'type', possible loss of data
    /wd4305 # 'identifier' : truncation from 'type1' to 'type2'
    /wd4307 # 'operator' : integral constant overflow
    /wd4309 # 'conversion' : truncation of constant value
    /wd4334 # 'operator' : result of 32-bit shift implicitly converted to 64 bits (was 64-bit shift intended?)
    /wd4355 # 'this' : used in base member initializer list
    /wd4506 # no definition for inline function 'function'
    /wd4800 # 'type' : forcing value to bool 'true' or 'false' (performance warning)
    /wd4819 # The file contains a character that can ot be represented in the current code page(936)
    /wd4996 # The compiler encountered a deprecated declaration.
    /wd4200 # nonstandard extension used : zero-sized array in struct/union
)