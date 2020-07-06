@echo off
set /p input="Write your project name: "
set /p appname="Write your starting app name: "
@echo on
django-admin startproject %input%
@echo off
cd %input%
@echo off
django-admin startapp %appname%
echo Your Project named %input% with App %appname% has been successfully created!