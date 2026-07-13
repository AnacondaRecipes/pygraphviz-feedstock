@echo off
setlocal enabledelayedexpansion

REM Windows conda packages keep headers/libs under %PREFIX%\Library
set "GRAPHVIZ_PREFIX=%PREFIX%\Library"

%PYTHON% -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vv
if errorlevel 1 exit /b 1