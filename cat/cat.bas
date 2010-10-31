declare sub process overload (byref filename as string)
declare sub process overload () 

dim argc as integer = 1
dim argv as string = command(argc)

do until argv = ""
    process argv
    argc = argc + 1
    argv = command(argc)
loop

if(argc=1) then process()


sub process(byref filename as string)
dim n as integer = freefile()
Dim tmp as string

open filename for input as #n
do until eof(n)
    line input #n,tmp
    print tmp
loop
close #n
end sub

sub process()
    dim c as string
    c = inkey$()
    do until c=""
        print c;
        c= inkey$()
    loop
end sub


