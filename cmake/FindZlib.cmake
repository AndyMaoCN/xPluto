
if( WIN32 )
	set(BUILD_SHARED_LIBS ON)
	# set(SKIP_INSTALL_ALL)
	set(CMAKE_INSTALL_PREFIX "${ROOT_ARC_OUT_DIR}")
	add_subdirectory("opt/zlib")
	set(ZLIB_INCLUDE_DIR "${CMAKE_INSTALL_PREFIX}/include")
	set(ZLIB_LIBRARIES zlib)
	message(STATUS "${ZLIB_INCLUDE_DIR}")
	message(STATUS "${ZLIB_LIBRARIES}")
else()
endif()


MARK_AS_ADVANCED(
  ZLIB_INCLUDE_DIR
  ZLIB_LIBRARIES
  )

# handle the QUIETLY and REQUIRED arguments and set ZLIB_FOUND to TRUE if
# all listed variables are TRUE
include( FindPackageHandleStandardArgs )
find_package_handle_standard_args( ZLIB REQUIRED_VARS ZLIB_LIBRARIES ZLIB_INCLUDE_DIR
	VERSION_VAR	ZLIB_VERSION_STRING )
