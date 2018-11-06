git add *
@echo off
set /p Message="Commit Message: "
git commit -m Message
git push origin master