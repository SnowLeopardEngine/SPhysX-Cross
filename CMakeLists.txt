cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

project(SPhysX-Cross VERSION 0.1.0)

include(CMakeDependentOption)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# ban in-source builds
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
if ("${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
  message(SEND_ERROR "In-source builds are not allowed.")
endif()
set(TARGET_APPLE OFF)
set(TARGET_LINUX OFF)
set(TARGET_EMSCRIPTEN OFF)
set(TARGET_WINDOWS OFF)
set(TARGET_UWP OFF)
set(TARGET_ANDROID OFF)
if(CMAKE_SYSTEM_NAME MATCHES iOS OR CMAKE_SYSTEM_NAME MATCHES tvOS)
	set(CMAKE_SYSTEM_PROCESSOR "aarch64")
endif()
if(CMAKE_SYSTEM_NAME MATCHES Darwin OR CMAKE_SYSTEM_NAME MATCHES iOS OR CMAKE_SYSTEM_NAME MATCHES tvOS)
	set(TARGET_APPLE ON CACHE INTERNAL "")
elseif(CMAKE_SYSTEM_NAME MATCHES Linux)
	set(TARGET_LINUX ON CACHE INTERNAL "")
elseif(CMAKE_SYSTEM_NAME MATCHES Emscripten)
	set(TARGET_EMSCRIPTEN ON CACHE INTERNAL "")
elseif(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	set(TARGET_UWP ON)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
	set(TARGET_WINDOWS ON)
elseif (CMAKE_SYSTEM_NAME MATCHES "Android")
	set(TARGET_ANDROID ON)
endif()

if (TARGET_APPLE)
	add_definitions(-fvisibility=default -ftemplate-backtrace-limit=0 -fobjc-arc)	# silence warning when building ARM fat library on Apple platforms, enable arc
elseif(TARGET_EMSCRIPTEN)
	# required for higher memory, atomics, and threads
	add_definitions(-pthread)
	add_definitions(-fexceptions)
	set(EM_LINK "-fexceptions" "-s MAX_WEBGL_VERSION=2" "-s MIN_WEBGL_VERSION=2" "-s FULL_ES3=1" "-s USE_WEBGPU" "-s GL_ASSERTIONS=1" "-s OFFSCREEN_FRAMEBUFFER=1" "-s OFFSCREENCANVAS_SUPPORT=1" "-s GL_DEBUG=1" "-s LLD_REPORT_UNDEFINED" "-s NO_DISABLE_EXCEPTION_CATCHING" "-s NO_DISABLE_EXCEPTION_THROWING" "-s PTHREAD_POOL_SIZE=4" "-s ASSERTIONS=1" "-s ALLOW_MEMORY_GROWTH=1" "-s MAXIMUM_MEMORY=4GB")
elseif(TARGET_LINUX)
    add_definitions(-Wno-nonnull -Wno-stringop-overflow)
endif()

if(TARGET_ANDROID)
	set(APP_GLUE_DIR ${ANDROID_NDK}/sources/android/native_app_glue)
	include_directories(${APP_GLUE_DIR})
	set(ANDROID_GLUE_LIB "android-app-glue")
	add_library(${ANDROID_GLUE_LIB} STATIC ${APP_GLUE_DIR}/android_native_app_glue.c)
endif()

set(CMAKE_OSX_ARCHITECTURES "x86_64"
"arm64" CACHE INTERNAL "")

set(SPHYSX_CROSS_ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(CMAKE_INSTALL_PREFIX "${SPHYSX_CROSS_ROOT_DIR}")
set(BINARY_ROOT_DIR "${CMAKE_INSTALL_PREFIX}/")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${SPHYSX_CROSS_ROOT_DIR})
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

add_subdirectory(PhysX-CMake)

add_library(SPhysX_static STATIC empty.cpp)

target_include_directories(SPhysX_static
	PUBLIC
	"PhysX-CMake/physx/physx/include/"
	"PhysX-CMake/physx/pxshared/include/"
	"PhysX-CMake/physx/physx/snippets/"
)

target_link_libraries(SPhysX_static PRIVATE
	"PhysXExtensions"
	"PhysX"
	"PhysXPvdSDK"
	"PhysXVehicle"
	"PhysXCharacterKinematic"
	"PhysXCooking"
	"PhysXCommon"
	"PhysXFoundation"
	"PhysXTask"
	"FastXml"
	"LowLevel"
	"LowLevelAABB"
	"LowLevelDynamics"
	"SceneQuery"
	"SimulationController"
)

set_target_properties(SPhysX_static PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/lib")
