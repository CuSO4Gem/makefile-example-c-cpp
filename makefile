#TOOLCHAIN = arm-linux-gcc					#arm开发板使用时打开

ifdef TOOLCHAIN								#选择gcc还是arm-linux-gccc
	CC = $(TOOLCHAIN)
else 
	CC = gcc
endif
					
ifeq ($(CC),gcc)							#根据不同的平台，选择不同的链接库 
	CFLAGS = -I./include -I./lib  -L./lib -lgcc -lc
else
	CFLAGS = -I./include  -I./lib -L./lib	#mm为库名
endif

#传参觉得是否需要调试，如果DEBUG=exclusive，则调试的时候会删除release版本
ifdef DEBUG
	CFLAGS += -g
endif	

#寻找所有.c文件的路径
SRC = $(wildcard  ./src/*.c  ./lib/*.c)
#指定中间文件存放位置
DIR = ./build/
#指定可执行文件位置与名字
ELF = ./bin/main.elf
#调试版本的文件名
DELF = ./bin/main_debug.elf


CFILE = $(notdir $(SRC))
#把.c 换成.o
OBJ_SRC = $(patsubst %.c, %.o, $(SRC))
OBJ = $(patsubst %.c, $(DIR)%.o, $(CFILE))


#^:所有依赖-->OBJ ,@:生成目标放置地方，把.o放到ELF中,CFLAGS:选择库
#根据是否由如果定义互斥，则调试的时候会删除发行版
ifeq ($(DEBUG),exclusive)
all:$(OBJ_SRC)
	$(CC) $(OBJ) -o $(DELF) $(CFLAGS)
	rm -f $(ELF)

else
all:$(OBJ_SRC)
	$(CC) $(OBJ) -o $(ELF) $(CFLAGS)
endif

#^:由.o生成.c，CFLAGS:选择库
$(OBJ_SRC) : %.o:%.c
	$(CC) $< -o $(DIR)$(notdir $@) -c  $(CFLAGS)

#清除可执行文件，重新编译
clean:
	rm -f $(DIR)*
	find -name "*.elf" -exec rm -rf {} \;
.PHONY: clean