setlocal EnableDelayedExpansion
@echo on

:: Make a build folder and change to it
mkdir build
cd build

:: configure
cmake -G "NINJA" ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DBUILD_EXAMPLES=OFF ^
    -DBUILD_PROGRAMS=ON ^
    -DBUILD_REGTEST=OFF ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_TESTING=OFF ^
    -DENABLE_BOW_DOCS=OFF ^
    -DENABLE_COMPATIBLE_LIBSNDFILE_NAME=OFF ^
    -DENABLE_CPACK=OFF ^
    -DENABLE_EXPERIMENTAL=OFF ^
    -DENABLE_EXTERNAL_LIBS=ON ^
    -DENABLE_PACKAGE_CONFIG=ON ^
    -DINSTALL_PKGCONFIG_MODULE=ON ^
    ..\ports\cmake
if errorlevel 1 exit 1

:: build
cmake --build . --config Release -- -j%CPU_COUNT%
if errorlevel 1 exit 1

:: install
cmake --build . --config Release --target install
if errorlevel 1 exit 1
