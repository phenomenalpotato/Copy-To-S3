# Minimal CMakeLists.txt for the AWS SDK for C++.
cmake_minimum_required(VERSION 3.8)

# Use shared libraries, which is the default for the AWS C++ SDK build.
option(BUILD_SHARED_LIBS "Build shared libraries" ON)

# "my-example" is just an example value.
project(copy-object.cpp)

# Locate the AWS SDK for C++ package.
# "s3" and "cloudtrail" are just example values.
# find_package(AWSSDK REQUIRED COMPONENTS s3 cloudtrail)
find_package(AWSSDK REQUIRED COMPONENTS s3)

# The executable name and its sourcefiles.
add_executable(copy-object copy-object.cpp)

# Build using the C++ standard version 11.
target_compile_features(copy-object PUBLIC cxx_std_11)

# The libraries used by your executable.
target_link_libraries(copy-object ${AWSSDK_LINK_LIBRARIES})
