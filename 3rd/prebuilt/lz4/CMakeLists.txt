add_library(lz4_static # Sets the name of the library.
             # Sets the library as ashared library.
             STATIC
             # Provides a relative pathto your source file(s).
             IMPORTED )

set_target_properties(
            lz4_static
            PROPERTIES IMPORTED_LOCATION
            ${CMAKE_CURRENT_SOURCE_DIR}/lib/liblz4.a)

set_target_properties(
            lz4_static
            PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
            ${CMAKE_CURRENT_SOURCE_DIR}/include
)
