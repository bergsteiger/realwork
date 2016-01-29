{*********************************************************}
{*                  STDEFINE.INC 3.01                    *}
{*     Copyright (c) TurboPower Software Co., 1996-99    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{ Because STDEFINE.INC is included in all SysTools units, you can specify   }
{ global compiler options here. STDEFINE is included *before* each units'   }
{ required compiler options, so options specified here might be overridden  }
{ by hardcoded options in the source file.                                  }

{$IFDEF WIN32}
  {---Global compiler defines for 32-bit OS's---}
  {$A+} {Word Align Data}
  {$H+} {Huge string support}
  {$Q-} {Overflow check}
  {$R-} {Range check}
  {$S-} {Stack check}
  {$T-} {Typed @ check}
  {$V-} {Var strings}
  {$B-} {Incomplete boolean evaluation}
{$ELSE}
  {---Global compiler defines for Delphi 1.0---}
  {$A-} {Byte Align Data}
  {$F-} {Far calls
  {$G+} {80286 code}
  {$Q-} {Overflow check}
  {$R-} {Range check}
  {$S-} {Stack check}
  {$T-} {Typed @ check}
  {$V-} {Var strings}
  {$B-} {Incomplete boolean evaluation}
{$ENDIF}

{$IFDEF WIN32}
{$DEFINE ThreadSafe}
{$ENDIF}
{ This define determines whether SysTools operations are safe in a 32-bit   }
{ multi-threaded application. Leaving it undefined will improved performance}
{ slightly in a single-threaded 32-bit application.                         }

{$DEFINE Median}
{.$DEFINE MidPoint}
{.$DEFINE Random}
{ The three partitioning methods used by the merge sort algorithm in STSORT.}
{ Choose one, and one only. Median is on average fastest, and quite safe.   }
{ Midpoint is the simplest, but may degrade on some data sets. Random is    }
{ the safest, but on average the slowest. Safety in this context means the  }
{ prevention of the underlying quicksort degenerating into a sort of O(N^2) }
{ The default is Median.                                                    }


{$IFDEF Win32}
{.$DEFINE SuppressWarnings}
{$ENDIF}
{ This define enables you to suppress warnings that are generated for code  }
{ in SysTools by Delphi 2/3. The two most common warnings are (a) function  }
{ does not set Result and (b) variable used before being initialized. The   }
{ code however has been tested to be correct but is complex enough to fool  }
{ the compiler. You should leave this define activated.                     }

{.$DEFINE UseMathUnit}
{ This define is used to decide if the Math unit should be used.            }
{ Define UseMathUnit if the Math unit is available (it isn't with some      }
{ versions of the compilers -- Delphi 1, C++Builder 1, Delphi 2 Standard,   }
{ and a few others - check to be sure).                                     }


{===========!! DO NOT ALTER ANYTHING BEYOND THIS POINT !!==================}
{===========!! DO NOT ALTER ANYTHING BEYOND THIS POINT !!==================}


{$IFDEF VER93}
  {$DEFINE CBuilder}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE CBuilder}
  {$ObjExportAll On}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE CBuilder}
  {$ObjExportAll On}
{$ENDIF}
{$IFDEF VER130}
  {$IFDEF BCB}
    {$DEFINE CBuilder}
    {$ObjExportAll On}
  {$ENDIF}
{$ENDIF}

{$IFNDEF VER80}       {Delphi 1.0}
 {$DEFINE VERSION2}   {Delphi 2.0 and BCB 1 or higher}
{$ENDIF}

{$IFDEF VERSION2}
 {$IFNDEF VER90}      {Delphi 2.0}
  {$IFNDEF VER93}     {BCB 1.0}
   {$DEFINE VERSION3} {Delphi 3.0 or BCB 3.0}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$IFDEF VERSION3}
 {$IFNDEF VER100}     {Delphi 3}
  {$IFNDEF VER110}    {BCB 3}
   {$DEFINE VERSION4} {Delphi 4.0 or higher}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$IFDEF VERSION4}
 {$IFNDEF VER120}       {Delphi 4}
  {$IFNDEF VER125}      {BCB 4}
     {$DEFINE VERSION5} {Delphi 5.0 or higher}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$IFDEF VERSION2}
 {$IFNDEF VERSION3}
  {$DEFINE VERSION2ONLY}
 {$ENDIF}
{$ENDIF}

{$IFDEF VERSION3}
 {$IFNDEF VERSION4}
  {$DEFINE VERSION3ONLY}
 {$ENDIF}
{$ENDIF}


{Set up the Warnings compiler define for Delphi 2.0 compilation}
{$IFDEF VER90}
  {$IFDEF SuppressWarnings}
    {$WARNINGS OFF}
    {$HINTS OFF}
  {$ELSE}
    {$WARNINGS ON}
    {$HINTS ON}
  {$ENDIF}
{$ENDIF}

{Set up the string type expected}
{$UNDEF HStrings}
{$UNDEF WStrings}
{$DEFINE NStrings}     {255-character strings under Win16}
{$IFDEF WIN32}
  {$IFOPT H+}
    {$DEFINE HStrings} {Huge strings under WIN32}
    {$UNDEF NStrings}
  {$ELSE}
    {$DEFINE WStrings} {255-character strings under WIN32}
    {$UNDEF NStrings}
  {$ENDIF}
{$ENDIF}

{$IFDEF Median}
 {$IFDEF MidPoint}
   !! ERROR: you must define only one of Median, MidPoint, Random
 {$ENDIF}
 {$IFDEF Random}
   !! ERROR: you must define only one of Median, MidPoint, Random
 {$ENDIF}
{$ENDIF}
{$IFDEF MidPoint}
 {$IFDEF Random}
   !! ERROR: you must define only one of Median, MidPoint, Random
 {$ENDIF}
{$ENDIF}
{$IFNDEF Median}
 {$IFNDEF MidPoint}
   {$IFNDEF Random}
     !! ERROR: you must define at least one of Median, MidPoint, Random
   {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$Include l3XE.inc}
