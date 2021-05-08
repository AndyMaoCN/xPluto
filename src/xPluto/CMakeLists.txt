
add_executable(xPluto main.cpp)

if (UNIX)
    target_link_libraries(xPluto m dl  ${THREAD_LIBRARY} ${FILE_SYSTEM_LIBRARY} jemalloc zlib )
    set(XPLUTO_EXEC "xPluto")
else()
    target_link_libraries(xPluto ${LUA_LIBRARIES} zlib )
    set(XPLUTO_EXEC "xPluto.exe")
endif()

add_custom_command(
    TARGET xPluto POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
    ${ROOT_BIN_OUT_DIR}/${XPLUTO_EXEC}
    ${PUBLISH_PATH}/${XPLUTO_EXEC}
)