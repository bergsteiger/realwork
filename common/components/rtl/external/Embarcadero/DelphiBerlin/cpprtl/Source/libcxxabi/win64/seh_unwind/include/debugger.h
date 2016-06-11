/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2003, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


#ifndef DEBUGGER_H
#define _DELPHI_DEBUGGER_XCPT_CODE 0xEEDFAE6

// To enable debugger tracing, the debugger finds the address of
// ___CPPdebugHook (an exported variable) and writes a "2" there.
// When the RTL has a notification to provide to the debugger, it
// will raise a nested exception _DELPHI_DEBUGGER_XCPT_CODE.
// the debugger should then look at the exception parameters, the first
// one will be one of the following:

enum	XXdebuggerNotification
{
// Destructor about to be called
// Params:
//	0:   XXDNdtor
//	1:   0
//	2:   address of destructor
//	3:   name of class, not 0-terminated
//	4:   length of class name
	XXDNdtor	   = 0,

// Exception about to be thrown
// Params:
//	0:   XXDNthrow
//	1:   0
// Win32 only:
//	2:   address where exception was thrown

//	3:   name of type being thrown, not 0-terminated
//	4:   length of name
//	5:   address object being thrown

// Win32 only:
//	6:   user EAX
//	7:   user EBX
//	8:   user EDX
//	9:   user EDI
//	10:  user ESI
//	11:  user EBP
//	12:  user ESP
	XXDNthrow	   = 1,


// FIXME: what, precisely is a raw exception?  seems to be a exception
// not in the range [0xeedface,0xeefface].  need to checkthis more
// closely.
// --xmsb (2003-4-25 17:52)
// Params:
//	0: XXDNrawException
//	1: 0
//	2: address of exception registration record
//	3: address of Win32 EXCEPTION_RECORD
//	4: address of Win32 CONTEXT
	XXDNrawException   = 2,


// A catch handler is about to be entered.
// Params:
//	0: XXDNcatch
//	1: 0
//	2: address of the handler
//	3: name of type being caught, not 0-terminated
//	4: length of that name
//	5: exception object
	XXDNcatch	   = 3,

// terminate is about to be called
// Params:
//	0: XXDNterminated
//	1: 0
//	2: address of terminate function
	XXDNterminated	   = 4,

// unexpected is about to be called
// Params:
//	0: XXDNunexpected
//	1: 0
//	2: address of unexepected handler
	XXDNunexpected	   = 5,

// a catch block is being exited
// Params:
//	0: XXDNcatchTerminate
//	1: 0
//	2: some address
	XXDNcatchTerminate = 6,
};

//void __raiseDebuggerException(XXdebuggerNotification kind,
//			      int paramCount,
//			      void ** params);

void __notifyThrow(void *obj, std::type_info* tinfo);
void __notifyCatch(void *obj, std::type_info** ptinfo, void *handlerAddr);
void __notifyCatchTerminate(void *handlerAddr);

#endif
