@echo off
REM Launches build with docker image.
REM sed command for removing root path so vscode problemMatcher links to the correct path.
REM Output the log to out.txt
docker run --rm -v %cd%/..:/home/stm32/ws cortesja/stm32-cmake:2.0 bash -c "sh build.sh 2>&1 | sed -e 's/^\/home\/stm32\/ws\///' | tee out.txt"
