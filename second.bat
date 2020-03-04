@echo off
set counter=0
:loop
set /A counter=counter+1
echo Second%counter%
TIMEOUT /T 10 /NOBREAK
goto loop