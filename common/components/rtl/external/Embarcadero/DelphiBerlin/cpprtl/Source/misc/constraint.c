/*------------------------------------------------------------------------
 * filename - constraint.c
 *
 * function(s)
 *
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision:$        */

#include <stdlib.h>
#include <_io.h>
#include <_string.h>

#pragma argsused
void _RTLENTRY _EXPFUNC abort_handler_s(const char * _RESTRICT msg,
					void * _RESTRICT ptr,
					errno_t __error)
{
    /* FIXME: should probably format message here */
    _ErrorMessage(msg);
    abort();
}

#pragma argsused
void _RTLENTRY _EXPFUNC ignore_handler_s(const char * _RESTRICT msg,
					 void * _RESTRICT ptr,
					 errno_t error)
{
}

static constraint_handler_t constraint_handler = abort_handler_s;

constraint_handler_t _RTLENTRY _EXPFUNC set_constraint_handler_s(constraint_handler_t handler)
{
    constraint_handler_t previous_handler = constraint_handler;
    constraint_handler = (handler) ? handler: abort_handler_s;
    return previous_handler;
}

void _RTLENTRY _EXPFUNC __declspec(noreturn) __invoke_constraint_handler_s(const char * _RESTRICT __msg,
											   void * _RESTRICT __ptr,
											   errno_t __error)
{
    constraint_handler(__msg, __ptr, __error);
}
