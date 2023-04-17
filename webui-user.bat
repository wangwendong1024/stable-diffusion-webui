@echo off
set CONDA_ENV_NAME=stable-diffusion-webui
set CONDA_PYTHON_VERSION=3.10.6


echo Checking if conda environment %CONDA_ENV_NAME% exists...
call conda activate %CONDA_ENV_NAME%
if %errorlevel% equ 0 (
    echo Conda environment %CONDA_ENV_NAME% already exists. Activating...
) else (
    echo Conda environment %CONDA_ENV_NAME% does not exist. Creating...
    call conda create -y -n %CONDA_ENV_NAME% python=%CONDA_PYTHON_VERSION%
    if %errorlevel% neq 0 (
        echo Failed to create conda environment %CONDA_ENV_NAME%. Exiting...
        exit /b 1
    )
)

echo Activating conda environment %CONDA_ENV_NAME%...
call conda activate %CONDA_ENV_NAME%
if %errorlevel% neq 0 (
    echo Failed to activate conda environment %CONDA_ENV_NAME%. Exiting...
    exit /b 1
)

echo Adding conda environment %CONDA_ENV_NAME% to Python environment variable...
setx PYTHONPATH "%CONDA_PREFIX%\python"
echo %PYTHONPATH%
if %errorlevel% neq 0 (
    echo Failed to set PYTHONPATH environment variable. Exiting...
    exit /b 1
)
set http_proxy=http://192.168.10.124:7890
set https_proxy=http://192.168.10.124:7890

set PYTHON=%PYTHONPATH%
set GIT=
set VENV_DIR=sdwebui
set COMMANDLINE_ARGS=--xformers

call webui.bat
