{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//TODO -ocbensen -cImplement : Complete translation

const
  EXIT_FAILURE = 1;
  {$EXTERNALSYM EXIT_FAILURE}
  EXIT_SUCCESS = 0;
  {$EXTERNALSYM EXIT_SUCCESS}
  NULL = nil;
  {$EXTERNALSYM NULL}
  RANDMAX = $7fffffff;
  {$EXTERNALSYM RANDMAX}
//  MB_CUR_MAX =

type
  div_t = record
    quot: Integer;
    rem: Integer;
  end;

  ldiv_t = record
    quote: LongInt;
    rem: LongInt;
  end;

//  size_t = PosixStdDef.size_t;
//  {$EXTERNALSYM size_t}
//  Psize_t = PosixStdDef.Psize_t;
//
//  wchar_t = PosixStdDef.wchar_t;
//  {$EXTERNALSYM wchar_t}
//  Pwchar_t = PosixStdDef.Pwchar_t;

