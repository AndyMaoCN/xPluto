mkdir nmake_build
cd nmake_build
rem call "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat" x64
call "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64
cmake -G"NMake Makefiles" -Wno-dev -DCMAKE_BUILD_TYPE=Release ..
..\nmake_bin\jom
@rem nmake /A
pause