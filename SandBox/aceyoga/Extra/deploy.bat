@echo off
git add .
set /p input1="Write your push title(e.g Fixing Bugs with quotation marks): "
set /p input2="Write your push branch target(e.g master with quotation marks): "
git commit -m %input1%
git push -f origin %input2%