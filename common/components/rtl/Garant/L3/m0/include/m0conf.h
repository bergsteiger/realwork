/*
//
// module:  m0conf.h
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0conf.h,v 1.1 2008/02/07 09:54:22 lulin Exp $
//
*/
#ifndef   _m0CONF_H
#define   _m0CONF_H


# pragma off (unreferenced)
# pragma pack (push,1)


# define  _m0TYPEDEF                                  typedef
# define  _m0STATIC                                   static
#ifdef    __cplusplus
# define  _m0EXTERN                                   extern "C"
#else 
# define  _m0EXTERN                                   extern
#endif
# define  _m0PAS___FUNCTYPE                           __pascal
# define  _m0CDECL_FUNCTYPE                           __cdecl
# define  _m0SYS___FUNCTYPE                           __syscall
# define  _m0STD___FUNCTYPE                           __stdcall
# define  _m0FST___FUNCTYPE                           __fastcall
# define  _m0FUNC_PAS___PUBLIC(_t,_n)                 _m0EXTERN _t _m0PAS___FUNCTYPE _n
# define  _m0FUNC_CDECL_PUBLIC(_t,_n)                 _m0EXTERN _t _m0CDECL_FUNCTYPE _n
# define  _m0FUNC_SYS___PUBLIC(_t,_n)                 _m0EXTERN _t _m0SYS___FUNCTYPE _n
# define  _m0FUNC_STD___PUBLIC(_t,_n)                 _m0EXTERN _t _m0STD___FUNCTYPE _n
# define  _m0FUNC_FST___PUBLIC(_t,_n)                 _m0EXTERN _t _m0FST___FUNCTYPE _n
# define  _m0VAR(_n,_t)                               _t _n
# define  _m0TYPE(_n,_t)                              _m0TYPEDEF _t _n
# define  _m0FUNC_PRIVATE(_t,_n)                      _m0STATIC _t _n
# define  _m0FUNC_PUBLIC(_t,_n)                       _m0FUNC_FST___PUBLIC(_t,_n)


# pragma pack (pop)
# pragma on (unreferenced)


#endif
