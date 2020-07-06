@echo off
git add .
set /p input1="Write your push title(e.g Fixing Bugs with quotation marks): "
git commit -m %input1%