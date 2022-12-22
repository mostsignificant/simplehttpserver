########################################################################################################################
### SIMPLEHTTPSERVER LIBRARY
########################################################################################################################

find_package(Boost 1.74 COMPONENTS program_options REQUIRED)
find_package(Threads REQUIRED)

set(TARGET simplehttpserver)

add_executable(${TARGET}
        main.cpp)

target_compile_features(${TARGET} PUBLIC
        cxx_std_17)

target_include_directories(${TARGET} PUBLIC
        ${Boost_INCLUDE_DIRS})

target_link_libraries(${TARGET} PRIVATE
        ${Boost_LIBRARIES}
        Threads::Threads)
