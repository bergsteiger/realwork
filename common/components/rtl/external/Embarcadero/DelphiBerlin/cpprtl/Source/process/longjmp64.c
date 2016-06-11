#include <windows.h>
#include <setjmp.h>

//-----------------------------------------------------------------------
//
//Name            longjmp - performs a nonlocal goto
//
//Usage           #include <setjmp.h>
//                void longjmp(jmp_buf jmpb, int retval);
//
//Prototype in    setjmp.h
//
//Description     Restores context information (register, stack position, and
//                segment  values)  from  the  jmp_buf  structure, which must
//                previously  have  been  saved  there  by  setjmp,  and then
//                returns to  the original caller  of setjmp with  val as the
//                return value  as if returning  from setjmp. The  difference
//                between  a  setjmp  return  and  a  longjmp  is that setjmp
//                returns zero, longjmp returns "val". Val can never be zero:
//                if zero argument is supplied, 1 is substituted.
//
//                Longjmp never returns to its own caller. If the contents of
//                jmpb  are not  set, or  if  the  context therein  is for  a
//                function which  is not now  active (if it  has finished and
//                returned) then  the result will  generally be to  crash the
//                program.  The safest  styles of  use of  the setjmp/longjmp
//                pair are to effect a  return  upward through several nested
//                procedure layers  to a parent procedure  designed to handle
//                exceptions, or  to place both  setjmp and longjmp  within a
//                single scheduler/event handler lexical block.
//
//Return value    longjmp  cannot return  the value  0; if  passed 0  in val,
//                longjmp will return 1.
//
//------------------------------------------------------------------------
void _EXPFUNC longjmp(jmp_buf jmpb, int retval)
{
    CONTEXT context;
    EXCEPTION_RECORD rec = {0};

    if (!retval)
        retval = 1;
    rec.ExceptionCode = STATUS_LONGJUMP;
    rec.ExceptionInformation[0] = jmpb;
    rec.ExceptionInformation[1] = retval;
    rec.NumberParameters = 2;
    RtlUnwindEx(jmpb[0].frame, jmpb[0].rip, &rec, retval, &context, 0);
}
