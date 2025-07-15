@echo off
setlocal

:: Caminhos
set VCPKG_ROOT=C:\vcpkg-rme
set PROJECT_DIR=C:\Users\Dell\Documents\GitHub\remeres-map-editor
set BUILD_DIR=%PROJECT_DIR%\build

:: Triplet usado
set VCPKG_TRIPLET=x64-windows

echo --------------------------------------
echo Criando pasta de build, se necessário...
echo --------------------------------------
if not exist "%BUILD_DIR%" (
    mkdir "%BUILD_DIR%"
)

cd /d "%BUILD_DIR%"

echo --------------------------------------
echo Gerando arquivos com CMake...
echo --------------------------------------
cmake .. ^
 -G "Visual Studio 17 2022" ^
 -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
 -DVCPKG_TARGET_TRIPLET=%VCPKG_TRIPLET% ^
 -DCMAKE_BUILD_TYPE=RelWithDebInfo

if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha na configuração com CMake.
    pause
    exit /b %ERRORLEVEL%
)

echo --------------------------------------
echo Compilando projeto com CMake Build...
echo --------------------------------------
cmake --build . --config RelWithDebInfo

if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha na compilação!
    pause
    exit /b %ERRORLEVEL%
)

echo --------------------------------------
echo ✅ Build finalizado com sucesso!
echo Arquivo da solução:
echo   %BUILD_DIR%\remeres.sln
echo --------------------------------------
pause
