# makefile_example_c_cpp
A makefile example of compile c. It also adapted to the vscode editor
ctrl+B:Compile all files

## dir
./bin/:executable file<br>./build/:*.o files<br>./include/ h files<br>./lib/ some library, include *.c and *.h<br>./src/ source code 

## make
~~~
$ make all
Compile all files, and executable file will out at ./bin/main.elf

$ make clean
clean all in ./build and all *.elf

$ make make DEBUG=exclusive
Compile all files to debug as main_debug.elf

$ make make DEBUG=d
Compile all files to debug as ./bin/main.elf
~~~
