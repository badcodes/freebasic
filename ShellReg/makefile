cc=fbc
ccopt=-s console -i ../\[Modules\]/
bindir=/myplace/Program/Commands

all : ShellReg.exe

ShellReg.exe : String.o Register.o
	$(cc) $(ccopt) ShellReg.bas -a String.o -a Register.o -x ShellReg.exe
String.o :
	$(cc) $(ccopt) -c ../\[Modules\]/String.bas -o String.o
Register.o :
	$(cc) $(ccopt) -c ../\[Modules\]/Register.bas -o Register.o

clean : 
	rm -v String.o Register.o ShellReg.exe
install:
	mv -v ShellReg.exe $(bindir)
uninstall:
	if [ -f $(bindir)/ShellReg.exe ] ; then rm -v $(bindir)/ShellReg.exe ; fi
