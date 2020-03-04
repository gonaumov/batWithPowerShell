@echo off
set first_counter=0
:loop
set /A first_counter=first_counter+1
echo First%counter%
TIMEOUT /T 10 /NOBREAK
goto loop