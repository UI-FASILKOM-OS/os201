@echo off
set /p input="Write your app(without quotation marks): "
@echo on
coverage run --include='%input%/*' manage.py test
coverage report -m