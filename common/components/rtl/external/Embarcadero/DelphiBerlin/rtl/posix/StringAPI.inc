{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

function memccpy(var s1; const s2; c: Integer; n: size_t): Pointer; cdecl;
  external libc name _PU + 'memccpy';
{$EXTERNALSYM memccpy}

function memchr(const s; c: Integer; n: size_t): Pointer; cdecl;
  external libc name _PU + 'memchr';
{$EXTERNALSYM memchr}

function memcmp(const s1; const s2; n: size_t): Integer; cdecl;
  external libc name _PU + 'memcmp';
{$EXTERNALSYM memcmp}

function memcpy(var s1; const s2; n: size_t): Pointer; cdecl;
  external libc name _PU + 'memcpy';
{$EXTERNALSYM memcpy}

function memmove(var s1; const s2; n: size_t): Pointer; cdecl;
  external libc name _PU + 'memmove';
{$EXTERNALSYM memmove}

function memset(var b; c: Integer; len: size_t): Pointer; cdecl;
  external libc name _PU + 'memset';
{$EXTERNALSYM memset}

function strchr(s: MarshaledAString; c: Integer): MarshaledAString; cdecl;
  external libc name _PU + 'strchr';
{$EXTERNALSYM strchr}

function strrchr(s: MarshaledAString; c: Integer): MarshaledAString; cdecl;
  external libc name _PU + 'strrchr';
{$EXTERNALSYM strrchr}

function strlen(S1: MarshaledAString): size_t; cdecl;
  external libc name _PU + 'strlen';
{$EXTERNALSYM strlen}

function strcmp(s1: MarshaledAString; s2: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'strcmp';
{$EXTERNALSYM strcmp}

function strcpy(s1: MarshaledAString; s2: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'strcpy';
{$EXTERNALSYM strcpy}

function strcat(s1: MarshaledAString; s2: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'strcat';
{$EXTERNALSYM strcat}

function strcasecmp(s1: MarshaledAString; s2: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'strcasecmp';
{$EXTERNALSYM strcasecmp}

function strncasecmp(s1: MarshaledAString; s2: MarshaledAString; n: size_t): Integer; cdecl;
  external libc name _PU + 'strncasecmp';
{$EXTERNALSYM strncasecmp}

function strdup(s1: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'strdup';
{$EXTERNALSYM strdup}

function strstr(s1: MarshaledAString; s2: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'strstr';
{$EXTERNALSYM strstr}

function strtok(str: MarshaledAString; sep: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'strtok';
{$EXTERNALSYM strtok}

function strtok_r(str: MarshaledAString; sep: MarshaledAString; var lasts: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'strtok_r';
{$EXTERNALSYM strtok_r}

function strerror(errnum: Integer): MarshaledAString; cdecl;
  external libc name _PU + 'strerror';
{$EXTERNALSYM strerror}

function strerror_r(errornum: Integer; buf: MarshaledAString; buflen: size_t): Integer; cdecl;
  external libc name _PU + 'strerror_r';
{$EXTERNALSYM strerror_r}

function strnlen(s1: MarshaledAString; n: size_t): size_t; cdecl;
  external libc name _PU + 'strnlen';
{$EXTERNALSYM strnlen}

function strncat(s1: MarshaledAString; s2: MarshaledAString; n: size_t): MarshaledAString; cdecl;
  external libc name _PU + 'strncat';
{$EXTERNALSYM strncat}

function strndup(s1: MarshaledAString; n: size_t): MarshaledAString; cdecl;
  external libc name _PU + 'strndup';
{$EXTERNALSYM strndup}

function strncmp(s1: MarshaledAString; s2: MarshaledAString; n: size_t): Integer; cdecl;
  external libc name _PU + 'strncmp';
{$EXTERNALSYM strncmp}

function strncpy(s1: MarshaledAString; s2: MarshaledAString; n: size_t): MarshaledAString; cdecl;
  external libc name _PU + 'strncpy';
{$EXTERNALSYM strncpy}

function strlcat(s1: MarshaledAString; s2: MarshaledAString; n: size_t): MarshaledAString; cdecl;
  external libc name _PU + 'strlcat';
{$EXTERNALSYM strlcat}

function strlcpy(s1: MarshaledAString; s2: MarshaledAString; n: size_t): MarshaledAString; cdecl;
  external libc name _PU + 'strlcpy';
{$EXTERNALSYM strlcpy}

function strcspn(s1: MarshaledAString; s2: MarshaledAString): size_t; cdecl;
  external libc name _PU + 'strcspn';
{$EXTERNALSYM strcspn}

function strpbrk(s1: MarshaledAString; s2: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'strpbrk';
{$EXTERNALSYM strpbrk}

function strspn(s1: MarshaledAString; s2: MarshaledAString): size_t; cdecl;
  external libc name _PU + 'strspn';
{$EXTERNALSYM strspn}

function strsignal(sig: Integer): MarshaledAString; cdecl;
  external libc name _PU + 'strsignal';
{$EXTERNALSYM strsignal}

function strcoll(s1: MarshaledAString; s2: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'strcoll';
{$EXTERNALSYM strcoll}

function strxfrm(s1: MarshaledAString; s2: MarshaledAString; n: size_t): size_t; cdecl;
  external libc name _PU + 'strxfrm';
{$EXTERNALSYM strxfrm}

{$IFNDEF ANDROID}
function stpcpy(s1: MarshaledAString; s2: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'stpcpy';
{$EXTERNALSYM stpcpy}

function strxfrm_l(s1: MarshaledAString; s2: MarshaledAString; n: size_t; loc: locale_t): size_t; cdecl;
  external libc name _PU + 'strxfrm_l';
{$EXTERNALSYM strxfrm_l}

function strcoll_l(s1: MarshaledAString; s2: MarshaledAString; loc: locale_t): Integer; cdecl;
  external libc name _PU + 'strcoll_l';
{$EXTERNALSYM strcoll_l}
{$ENDIF !ANDROID}
