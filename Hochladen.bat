git add *
@echo off
set /p message=Commit Message: 
git commit -m "%message%"
git push origin master