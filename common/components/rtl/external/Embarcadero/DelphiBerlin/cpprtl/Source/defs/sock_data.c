/*[]------------------------------------------------------------[]*/
/*|                                                              |*/
/*|     sock_data.c                                              |*/
/*|                                                              |*/
/*|     This file contains some initialized data needed          |*/
/*|     for winsock.                                             |*/
/*|                                                              |*/
/*[]------------------------------------------------------------[]*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2005, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 35387 $        */

#include <windows.h>
#include <ipexport.h>
#include <ws2tcpip.h>

const struct in6_addr in6addr_any      = IN6ADDR_ANY_INIT;
const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
