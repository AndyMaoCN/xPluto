echo off
color 0D

set CMAKE=cmake
rem set BUILD_DIR=vs_build_curl
set DEP_ROOT=%cd%

cd curl
set CURL_PATH=%cd%
echo %CURL_PATH%

rem Visual Studio 6 ： vc6
rem Visual Studio 2003 ： vc7
rem Visual Studio 2005 ： vc8
rem Visual Studio 2008 ： vc9
rem Visual Studio 2010 ： vc10
rem Visual Studio 2012 ： vc11
rem Visual Studio 2013 ： vc12
rem Visual Studio 2015 ： vc14
rem Visual Studio 2017 ： vc15
rem Visual Studio 2019 ： vc16

call "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64

call buildconf.bat
cd winbuild

nmake /f Makefile.vc VC=16 DEBUG=no mode=static MACHINE=x64 WITH_SSL=dll WITH_ZLIB=dll SSL_PATH=%DEP_ROOT%\install\openssl ZLIB_PATH=%DEP_ROOT%\install\zlib

pause ...