echo off
color 0B

set CMAKE=cmake
set BUILD_DIR=vs_build_openssl
set DEP_ROOT=%cd%

cd openssl
set OPENSSL_PATH=%cd%
echo %OPENSSL_PATH%
cd ..

if not exist %BUILD_DIR% (
    md %BUILD_DIR%
)
cd %BUILD_DIR%

::设置VS工具集,相当于指定VS版本,取决于VS的安装路径
rem set VS_DEV_CMD="D:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"
rem call %VS_DEV_CMD%
call "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64

rem Debug版本
rem %CMAKE% %OPENSSL_PATH% -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=%DEP_ROOT%/install/openssl ^
rem -DCMAKE_BUILD_TYPE=Debug ^
rem -DBUILD_SHARED_LIBS=on
rem nmake /f Makefile
rem nmake install
rem move ../bin ../vs_bin_debug

rem Release版本
%CMAKE% %OPENSSL_PATH% -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX=%DEP_ROOT%/install/openssl ^
-DCMAKE_BUILD_TYPE=Release ^
-DBUILD_SHARED_LIBS=on
nmake /f Makefile
nmake install
