{ ******************************************************* }
{ }
{ CodeGear Delphi Runtime Library }
{ }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{ }
{ ******************************************************* }

{ Get the current time of day and timezone information,
  putting it into *TV and *TZ.  If TZ is NULL, *TZ is not filled.
  Returns 0 on success, -1 on errors.
  NOTE: This form of timezone information is obsolete.
  Use the functions and variables declared in <time.h> instead. }
function gettimeofday(var timeval: timeval; timezone: Pointer): Integer; cdecl;
  external libc name _PU + 'gettimeofday';
{$EXTERNALSYM gettimeofday}

function settimeofday(const timeval: Ptimeval; const timezone: Pointer)
  : Integer; cdecl; external libc name _PU + 'settimeofday';
{$EXTERNALSYM settimeofday}

function getitimer(which: Integer; curr_value: Pitimerval): Integer; cdecl;
  external libc name _PU + 'getitimer';
{$EXTERNALSYM getitimer}

function setitimer(which: Integer; const new_value: Pitimerval;
  old_value: Pitimerval): Integer; cdecl; external libc name _PU + 'setitimer';
{$EXTERNALSYM setitimer}

function utimes(const filename: MarshaledAString; const times: Ptimeval)
  : Integer; cdecl; external libc name _PU + 'utimes';
{$EXTERNALSYM utimes}
