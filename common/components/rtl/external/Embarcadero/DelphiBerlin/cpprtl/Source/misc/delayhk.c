/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1997, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 29027 $ */

#define WIN32_LEAN_AND_MEAN
#define STRICT
#include <windows.h>

#include "DelayImp.h"

PfnDliHook   __pfnDliNotifyHook2;
PfnDliHook   __pfnDliFailureHook2;
