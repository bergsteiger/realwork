{ ********************************************************************* }
{                                                                       }
{                       Gnostice Utilities                              }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }
{$I gtCompilerDefines.inc}

unit gtTypes;

interface

uses
  Classes, SysUtils;

var
  IsReg: Boolean = False;


{$IFDEF DELPHI5}
type
  PCardinal     = ^Cardinal;
  PPChar        = ^PChar;
  PPAnsiChar    = PPChar;
  PPointer      = ^Pointer;
  PSmallInt     = ^SmallInt;
  PByte         = ^Byte;

  { TStream seek origins }
  TSeekOrigin = (soBeginning, soCurrent, soEnd);

  const
    NaN = 0.0 / 0.0;
{$ENDIF}

type
  Bytes = array of Byte;

  EPDFProcessor = class(Exception);

  // Unicode character.
  TgtUnicode = Word;
  // Character ID for CID character collections.
  TgtCID = Word;

  TgtUnicodes = array of TgtUnicode;

  // This is large enough to hold any of the following:
  // - 8-bit AnsiChar code
  // - 16-bit CID
  // - Unicode
  TgtCharCode = Word;

  // Signature related

  TgtSigSubfilter = (sfX509RsaSha1, sfPkcs7Detached, sfPkcs7Sha1);

  TgtSigCertLevel = (clNoChange, clFillFormFields, clInsertAnnots);

  //Represents a calendar time span used to calculate ambiguous time spans such
  //as 1 year and 3 months. A calendar time span cannot be negative.
  TgtDate = record
    Year: Word;
    Month: Word;
    Day: Word;
    Hour: Word;
    Minutes: Word;
    Seconds: Word;
    MilliSeconds: Word;
  end;

  //Type relates to TextOut
  TgtHAlignment = (haLeft, haCenter, haRight);
  TgtVAlignment = (vaTop, vaCenter, vaBottom);


{$IFDEF COPYPROTECT}
const
  TRIALPERIOD = 30;
  TIMELIMITED = 1;
  PDFTOOLKITPRO = 2;
  PDFTOOLKITPROPLUS = 3;

  ACINVALID = $00000000;
  ACEXPIRED = $00000001;
  ACSTOLEN  = $00000002;
  ACOK      = $00000003;
{$ENDIF}

implementation

end.
