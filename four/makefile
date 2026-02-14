ASM = nasm
ASMFLAGS = -f elf32
LD = ld
LDFLAGS = -m elf_i386
#change target to your programs
TARGET = tictactoe.exe

#change main to your programs name
all: $(TARGET)

$(TARGET): tictactoe.o
	$(LD) $(LDFLAGS) -o $(TARGET) tictactoe.o

tictactoe.o: tictactoe.asm
	$(ASM) $(ASMFLAGS) tictactoe.asm -o tictactoe.o -l tictactoe.lst

clean:
	rm -f *.o $(TARGET)
