// inst.cpp -- force DLL instances for Microsoft
#include <yvals.h>

 #if _IS_EMBEDDED

 #else /* _IS_EMBEDDED */
#define __FORCE_INSTANCE

#pragma warning(push, 1)
#include <complex>
#include <fstream>
#include <ios>
#include <istream>
#include <limits>
#include <locale>
#include <ostream>
#include <sstream>
#include <streambuf>
#include <xlocale>
#include <xlocmes>
#include <xlocmon>
#include <xlocnum>
#include <xloctime>
#include <xstring>

#pragma warning(disable: 4786)

 #if 1300 <= _MSC_VER

 #else /* 1300 <= _MSC_VER */
  #pragma warning(disable:4661)
 #endif /* 1300 <= _MSC_VER */

_STD_BEGIN

template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl operator>>(
        basic_istream<char, char_traits<char> >&, char *);
template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl operator>>(
        basic_istream<char, char_traits<char> >&, char&);
template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl operator>>(
        basic_istream<char, char_traits<char> >&, signed char *);
template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl operator>>(
        basic_istream<char, char_traits<char> >&, signed char&);
template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl operator>>(
        basic_istream<char, char_traits<char> >&, unsigned char *);
template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl operator>>(
        basic_istream<char, char_traits<char> >&, unsigned char&);
template _CRTIMP2 basic_istream<wchar_t, char_traits<wchar_t> >& __cdecl operator>>(
        basic_istream<wchar_t, char_traits<wchar_t> >&, wchar_t *);
template _CRTIMP2 basic_istream<wchar_t, char_traits<wchar_t> >& __cdecl operator>>(
        basic_istream<wchar_t, char_traits<wchar_t> >&, wchar_t&);

 #ifdef _NATIVE_WCHAR_T_DEFINED
template _CRTIMP2 basic_istream<unsigned short, char_traits<unsigned short> >& __cdecl operator>>(
        basic_istream<unsigned short, char_traits<unsigned short> >&, unsigned short *);
template _CRTIMP2 basic_istream<unsigned short, char_traits<unsigned short> >& __cdecl operator>>(
        basic_istream<unsigned short, char_traits<unsigned short> >&, unsigned short&);
 #endif /* _NATIVE_WCHAR_T_DEFINED */

template _CRTIMP2 basic_ostream<char, char_traits<char> >& __cdecl operator<<(
        basic_ostream<char, char_traits<char> >&, const char *);
template _CRTIMP2 basic_ostream<char, char_traits<char> >& __cdecl operator<<(
        basic_ostream<char, char_traits<char> >&, char);
template _CRTIMP2 basic_ostream<char, char_traits<char> >& __cdecl operator<<(
        basic_ostream<char, char_traits<char> >&, const signed char *);
template _CRTIMP2 basic_ostream<char, char_traits<char> >& __cdecl operator<<(
        basic_ostream<char, char_traits<char> >&, signed char);
template _CRTIMP2 basic_ostream<char, char_traits<char> >& __cdecl operator<<(
        basic_ostream<char, char_traits<char> >&, const unsigned char *);
template _CRTIMP2 basic_ostream<char, char_traits<char> >& __cdecl operator<<(
        basic_ostream<char, char_traits<char> >&, unsigned char);
template _CRTIMP2 basic_ostream<wchar_t, char_traits<wchar_t> >& __cdecl operator<<(
        basic_ostream<wchar_t, char_traits<wchar_t> >&, const wchar_t *);
template _CRTIMP2 basic_ostream<wchar_t, char_traits<wchar_t> >& __cdecl operator<<(
        basic_ostream<wchar_t, char_traits<wchar_t> >&, wchar_t);

 #ifdef _NATIVE_WCHAR_T_DEFINED
template _CRTIMP2 basic_ostream<unsigned short, char_traits<unsigned short> >& __cdecl operator<<(
        basic_ostream<unsigned short, char_traits<unsigned short> >&, const unsigned short *);
template _CRTIMP2 basic_ostream<unsigned short, char_traits<unsigned short> >& __cdecl operator<<(
        basic_ostream<unsigned short, char_traits<unsigned short> >&, unsigned short);
 #endif /* _NATIVE_WCHAR_T_DEFINED */

template _CRTIMP2 basic_string<char, char_traits<char>, allocator<char> > __cdecl operator+(
        const basic_string<char, char_traits<char>, allocator<char> >&,
        const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 basic_string<char, char_traits<char>, allocator<char> > __cdecl operator+(
        const char *, const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 basic_string<char, char_traits<char>, allocator<char> > __cdecl operator+(
        const char, const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 basic_string<char, char_traits<char>, allocator<char> > __cdecl operator+(
        const basic_string<char, char_traits<char>, allocator<char> >&, const char *);
template _CRTIMP2 basic_string<char, char_traits<char>, allocator<char> > __cdecl operator+(
        const basic_string<char, char_traits<char>, allocator<char> >&, const char);
template _CRTIMP2 bool __cdecl operator==(
        const basic_string<char, char_traits<char>, allocator<char> >&,
        const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator==(
        const char *, const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator==(
        const basic_string<char, char_traits<char>, allocator<char> >&, const char *);
template _CRTIMP2 bool __cdecl operator!=(
        const basic_string<char, char_traits<char>, allocator<char> >&,
        const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator!=(
        const char *, const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator!=(
        const basic_string<char, char_traits<char>, allocator<char> >&, const char *);
template _CRTIMP2 bool __cdecl operator<(
        const basic_string<char, char_traits<char>, allocator<char> >&,
        const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator<(
        const char *, const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator<(
        const basic_string<char, char_traits<char>, allocator<char> >&, const char *);
template _CRTIMP2 bool __cdecl operator>(
        const basic_string<char, char_traits<char>, allocator<char> >&,
        const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator>(
        const char *, const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator>(
        const basic_string<char, char_traits<char>, allocator<char> >&, const char *);
template _CRTIMP2 bool __cdecl operator<=(
        const basic_string<char, char_traits<char>, allocator<char> >&,
        const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator<=(
        const char *, const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator<=(
        const basic_string<char, char_traits<char>, allocator<char> >&, const char *);
template _CRTIMP2 bool __cdecl operator>=(
        const basic_string<char, char_traits<char>, allocator<char> >&,
        const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator>=(
        const char *, const basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 bool __cdecl operator>=(
        const basic_string<char, char_traits<char>, allocator<char> >&, const char *);
template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl operator>>(
        basic_istream<char, char_traits<char> >&,
        basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl getline(
        basic_istream<char, char_traits<char> >&,
        basic_string<char, char_traits<char>, allocator<char> >&);
template _CRTIMP2 basic_istream<char, char_traits<char> >& __cdecl getline(
        basic_istream<char, char_traits<char> >&,
        basic_string<char, char_traits<char>, allocator<char> >&, const char);
template _CRTIMP2 basic_ostream<char, char_traits<char> >& __cdecl operator<<(
        basic_ostream<char, char_traits<char> >&,
        const basic_string<char, char_traits<char>, allocator<char> >&);

template _CRTIMP2 basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> > __cdecl operator+(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&,
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> > __cdecl operator+(
        const wchar_t *, const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> > __cdecl operator+(
        const wchar_t, const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> > __cdecl operator+(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t *);
template _CRTIMP2 basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> > __cdecl operator+(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t);
template _CRTIMP2 bool __cdecl operator==(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&,
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator==(
        const wchar_t *, const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator==(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t *);
template _CRTIMP2 bool __cdecl operator!=(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&,
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator!=(
        const wchar_t *, const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator!=(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t *);
template _CRTIMP2 bool __cdecl operator<(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&,
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator<(
        const wchar_t *, const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator<(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t *);
template _CRTIMP2 bool __cdecl operator>(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&,
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator>(
        const wchar_t *, const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator>(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t *);
template _CRTIMP2 bool __cdecl operator<=(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&,
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator<=(
        const wchar_t *, const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator<=(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t *);
template _CRTIMP2 bool __cdecl operator>=(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&,
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator>=(
        const wchar_t *, const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 bool __cdecl operator>=(
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t *);
template _CRTIMP2 basic_istream<wchar_t, char_traits<wchar_t> >& __cdecl operator>>(
        basic_istream<wchar_t, char_traits<wchar_t> >&,
        basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 basic_istream<wchar_t, char_traits<wchar_t> >& __cdecl getline(
        basic_istream<wchar_t, char_traits<wchar_t> >&,
        basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);
template _CRTIMP2 basic_istream<wchar_t, char_traits<wchar_t> >& __cdecl getline(
        basic_istream<wchar_t, char_traits<wchar_t> >&,
        basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&, const wchar_t);
template _CRTIMP2 basic_ostream<wchar_t, char_traits<wchar_t> >& __cdecl operator<<(
        basic_ostream<wchar_t, char_traits<wchar_t> >&,
        const basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >&);

 #ifdef _NATIVE_WCHAR_T_DEFINED
template _CRTIMP2 basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> > __cdecl operator+(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&,
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> > __cdecl operator+(
        const unsigned short *, const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> > __cdecl operator+(
        const unsigned short, const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> > __cdecl operator+(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short *);
template _CRTIMP2 basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> > __cdecl operator+(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short);
template _CRTIMP2 bool __cdecl operator==(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&,
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator==(
        const unsigned short *, const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator==(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short *);
template _CRTIMP2 bool __cdecl operator!=(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&,
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator!=(
        const unsigned short *, const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator!=(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short *);
template _CRTIMP2 bool __cdecl operator<(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&,
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator<(
        const unsigned short *, const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator<(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short *);
template _CRTIMP2 bool __cdecl operator>(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&,
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator>(
        const unsigned short *, const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator>(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short *);
template _CRTIMP2 bool __cdecl operator<=(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&,
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator<=(
        const unsigned short *, const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator<=(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short *);
template _CRTIMP2 bool __cdecl operator>=(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&,
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator>=(
        const unsigned short *, const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 bool __cdecl operator>=(
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short *);
template _CRTIMP2 basic_istream<unsigned short, char_traits<unsigned short> >& __cdecl operator>>(
        basic_istream<unsigned short, char_traits<unsigned short> >&,
        basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 basic_istream<unsigned short, char_traits<unsigned short> >& __cdecl getline(
        basic_istream<unsigned short, char_traits<unsigned short> >&,
        basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
template _CRTIMP2 basic_istream<unsigned short, char_traits<unsigned short> >& __cdecl getline(
        basic_istream<unsigned short, char_traits<unsigned short> >&,
        basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&, const unsigned short);
template _CRTIMP2 basic_ostream<unsigned short, char_traits<unsigned short> >& __cdecl operator<<(
        basic_ostream<unsigned short, char_traits<unsigned short> >&,
        const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >&);
 #endif /* _NATIVE_WCHAR_T_DEFINED */


 #ifdef _NATIVE_WCHAR_T_DEFINED
template<> const basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >::size_type
        basic_string<unsigned short, char_traits<unsigned short>, allocator<unsigned short> >::npos =
		(size_type)(-1);
 #endif /* _NATIVE_WCHAR_T_DEFINED */

_STD_END
 #endif /* _IS_EMBEDDED */

/*
 * Copyright (c) 1992-2003 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
 V4.02:1422 */
