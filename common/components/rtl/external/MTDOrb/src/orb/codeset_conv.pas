// **********************************************************************
//
// Copyright (c) 2000 - 2003 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit codeset_conv;

interface

uses orbtypes;

const
  C_ERROR = -1;
  C_OK = 0;
  C_NO_ERROR = 0;

  C_ASCII7 = $ffff0001;
  C_EBCDIC = $ffff0002;
  C_HTML3 = $ffff0003;
  C_MACINTOSH = $ffff0004;
  C_KOI8_R = $ffff0006;

  C_ISO8859_1 = $00010001;
  C_ISO8859_2 = $00010002;
  C_ISO8859_3 = $00010003;
  C_ISO8859_4 = $00010004;
  C_ISO8859_5 = $00010005;
  C_ISO8859_6 = $00010006;
  C_ISO8859_7 = $00010007;
  C_ISO8859_8 = $00010008;
  C_ISO8859_9 = $00010009;
  C_ISO8859_10 = $0001000a;

  C_IBM_437 = $100201b5;     (* IBM Codepage 437 - English      *)
  C_IBM_850 = $10020352;     (* IBM Codepage 850 - Multilingual *)
  C_IBM_852 = $10020354;     (* IBM Codepage 852 - Latin 2      *)
  (* not in registry, using IBM-282 instead *)
  C_IBM_860 = $1002011a;     (* IBM Codepage 860 - Portuguese   *)
  C_IBM_863 = $1002035f;     (* IBM Codepage 863 - Canada       *)
  (* not in registry, using IBM-277 instead *)
  C_IBM_865 = $10020115;     (* IBM Codepage 865 - Norway       *)
  C_IBM_1251 = $100204E3; (* IBM Codepage MS Windows Cyrillic       *)
                                    
  C_WIN31_LATIN1 = $ffff0005;

  (* Unicode and ISO/IEC 10646 *)
  (*  (for more information visit: 'http://www.unicode.org')   *)
  C_UCS4 = $00010106;        (* 4 bytes for every character                *)
  C_UTF16= $00010109;        (* extended UCS2, 2 or 4 bytes for every char *)
  C_UTF8 = $05010001;        (* 1-6 bytes for every character              *)
  C_UTF7 = $ffff0007;        (* Internet conform ASCII7 representation     *)

  C_CODEPAGE_AMIGA = C_ISO8859_1;
  C_UNICODE_CALWA  = C_UTF8;
  C_CODEPAGE_MAC   = C_MACINTOSH;
  C_CODEPAGE_MSDOS = C_IBM_437;
  C_CODEPAGE_UNIX  = C_ISO8859_1;
  C_CODEPAFE_WIN31 = C_WIN31_LATIN1;
  C_CODEPAGE_WINNT = C_ISO8859_1;
  C_UNICODE_WINNT  = C_UTF16;

{$IFNDEF USELIB}

function UnicodeToUTF8(var AUtf8: AnsiString; const ASrc: AnsiString; AChars: _ulong;
  const AStringType: CodesetId; var AWritten: _ulong): long;
function UnicodeFromUTF8(var AUtf8: AnsiString; const ASrc: AnsiString; var AChars, AUtfRead: _ulong;
  const AStringType: CodesetId; var AWritten: _ulong): long;
function ConvertString(const Src: AnsiString; const ASrcType, ADstType: CodesetId): AnsiString;

{$IFNDEF BUILDIN_CONV}
var
{$IFDEF MSWINDOWS}
  uni_fromUTF8: function(utf8: PAnsiChar; const src: PAnsiChar; var chars, utf_read: _ulong; string_type: _ulong; line_type: AnsiChar; var written: _ulong): long; stdcall = nil;
  uni_toUTF8: function(utf8: PAnsiChar; src: PAnsiChar; chars, str_type: _ulong; line_type: byte; var written: _ulong): long; stdcall = nil;
{$ENDIF}
{$IFDEF LINUX}
  uni_fromUTF8: function(utf8: PAnsiChar; const src: PAnsiChar; var chars, utf_read: _ulong; string_type: _ulong; line_type: AnsiChar; var written: _ulong): long; cdecl = nil;
  uni_toUTF8: function(utf8: PAnsiChar; src: PAnsiChar; chars, str_type: _ulong; line_type: byte; var written: _ulong): long; cdecl = nil;
{$ENDIF}

{$ENDIF} // build in

//conversion functions
function UTF16StrTocp1251(const s: WideString): AnsiString;
function UTF16StrToKOI8_R(const s: Widestring): AnsiString;

implementation

uses SysUtils {$IFDEF BUILDIN_CONV}, unicode_external{$ENDIF};

function UTF16CharKOI8_R(const P: WideChar):AnsiChar;
begin
  case Ord(P) of
    $2500: result:= #$80;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: result:= #$81;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: result:= #$82;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: result:= #$83;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: result:= #$84;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: result:= #$85;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: result:= #$86;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: result:= #$87;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: result:= #$88;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: result:= #$89;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: result:= #$8a;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2580: result:= #$8b;  // UPPER HALF BLOCK
    $2584: result:= #$8c;  // LOWER HALF BLOCK
    $2588: result:= #$8d;  // FULL BLOCK
    $258c: result:= #$8e;  // LEFT HALF BLOCK
    $2590: result:= #$8f;  // RIGHT HALF BLOCK
    $2591: result:= #$90;  // LIGHT SHADE
    $2592: result:= #$91;  // MEDIUM SHADE
    $2593: result:= #$92;  // DARK SHADE
    $2320: result:= #$93;  // TOP HALF INTEGRAL
    $25a0: result:= #$94;  // BLACK SQUARE
    $2219: result:= #$95;  // BULLET OPERATOR
    $221a: result:= #$96;  // SQUARE ROOT
    $2248: result:= #$97;  // ALMOST EQUAL TO
    $2264: result:= #$98;  // LESS-THAN OR EQUAL TO
    $2265: result:= #$99;  // GREATER-THAN OR EQUAL TO
    $00a0: result:= #$9a;  // NO-BREAK SPACE
    $2321: result:= #$9b;  // BOTTOM HALF INTEGRAL
    $00b0: result:= #$9c;  // DEGREE SIGN
    $00b2: result:= #$9d;  // SUPERSCRIPT TWO
    $00b7: result:= #$9e;  // MIDDLE DOT
    $00f7: result:= #$9f;  // DIVISION SIGN
    $2550: result:= #$a0;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: result:= #$a1;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: result:= #$a2;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $0451: result:= #$a3;  // CYRILLIC SMALL LETTER IO
    $2553: result:= #$a4;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: result:= #$a5;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: result:= #$a6;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: result:= #$a7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: result:= #$a8;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: result:= #$a9;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: result:= #$aa;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: result:= #$ab;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: result:= #$ac;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: result:= #$ad;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: result:= #$ae;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: result:= #$af;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: result:= #$b0;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: result:= #$b1;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: result:= #$b2;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $0401: result:= #$b3;  // CYRILLIC CAPITAL LETTER IO
    $2562: result:= #$b4;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: result:= #$b5;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: result:= #$b6;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: result:= #$b8;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: result:= #$b9;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: result:= #$ba;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: result:= #$bb;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: result:= #$bc;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: result:= #$bd;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: result:= #$be;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $00a9: result:= #$bf;  // COPYRIGHT SIGN
    $044e: result:= #$c0;  // CYRILLIC SMALL LETTER YU
    $0430: result:= #$c1;  // CYRILLIC SMALL LETTER A
    $0431: result:= #$c2;  // CYRILLIC SMALL LETTER BE
    $0446: result:= #$c3;  // CYRILLIC SMALL LETTER TSE
    $0434: result:= #$c4;  // CYRILLIC SMALL LETTER DE
    $0435: result:= #$c5;  // CYRILLIC SMALL LETTER IE
    $0444: result:= #$c6;  // CYRILLIC SMALL LETTER EF
    $0433: result:= #$c7;  // CYRILLIC SMALL LETTER GHE
    $0445: result:= #$c8;  // CYRILLIC SMALL LETTER HA
    $0438: result:= #$c9;  // CYRILLIC SMALL LETTER I
    $0439: result:= #$ca;  // CYRILLIC SMALL LETTER SHORT I
    $043a: result:= #$cb;  // CYRILLIC SMALL LETTER KA
    $043b: result:= #$cc;  // CYRILLIC SMALL LETTER EL
    $043c: result:= #$cd;  // CYRILLIC SMALL LETTER EM
    $043d: result:= #$ce;  // CYRILLIC SMALL LETTER EN
    $043e: result:= #$cf;  // CYRILLIC SMALL LETTER O
    $043f: result:= #$d0;  // CYRILLIC SMALL LETTER PE
    $044f: result:= #$d1;  // CYRILLIC SMALL LETTER YA
    $0440: result:= #$d2;  // CYRILLIC SMALL LETTER ER
    $0441: result:= #$d3;  // CYRILLIC SMALL LETTER ES
    $0442: result:= #$d4;  // CYRILLIC SMALL LETTER TE
    $0443: result:= #$d5;  // CYRILLIC SMALL LETTER U
    $0436: result:= #$d6;  // CYRILLIC SMALL LETTER ZHE
    $0432: result:= #$d7;  // CYRILLIC SMALL LETTER VE
    $044c: result:= #$d8;  // CYRILLIC SMALL LETTER SOFT SIGN
    $044b: result:= #$d9;  // CYRILLIC SMALL LETTER YERU
    $0437: result:= #$da;  // CYRILLIC SMALL LETTER ZE
    $0448: result:= #$db;  // CYRILLIC SMALL LETTER SHA
    $044d: result:= #$dc;  // CYRILLIC SMALL LETTER E
    $0449: result:= #$dd;  // CYRILLIC SMALL LETTER SHCHA
    $0447: result:= #$de;  // CYRILLIC SMALL LETTER CHE
    $044a: result:= #$df;  // CYRILLIC SMALL LETTER HARD SIGN
    $042e: result:= #$e0;  // CYRILLIC CAPITAL LETTER YU
    $0410: result:= #$e1;  // CYRILLIC CAPITAL LETTER A
    $0411: result:= #$e2;  // CYRILLIC CAPITAL LETTER BE
    $0426: result:= #$e3;  // CYRILLIC CAPITAL LETTER TSE
    $0414: result:= #$e4;  // CYRILLIC CAPITAL LETTER DE
    $0415: result:= #$e5;  // CYRILLIC CAPITAL LETTER IE
    $0424: result:= #$e6;  // CYRILLIC CAPITAL LETTER EF
    $0413: result:= #$e7;  // CYRILLIC CAPITAL LETTER GHE
    $0425: result:= #$e8;  // CYRILLIC CAPITAL LETTER HA
    $0418: result:= #$e9;  // CYRILLIC CAPITAL LETTER I
    $0419: result:= #$ea;  // CYRILLIC CAPITAL LETTER SHORT I
    $041a: result:= #$eb;  // CYRILLIC CAPITAL LETTER KA
    $041b: result:= #$ec;  // CYRILLIC CAPITAL LETTER EL
    $041c: result:= #$ed;  // CYRILLIC CAPITAL LETTER EM
    $041d: result:= #$ee;  // CYRILLIC CAPITAL LETTER EN
    $041e: result:= #$ef;  // CYRILLIC CAPITAL LETTER O
    $041f: result:= #$f0;  // CYRILLIC CAPITAL LETTER PE
    $042f: result:= #$f1;  // CYRILLIC CAPITAL LETTER YA
    $0420: result:= #$f2;  // CYRILLIC CAPITAL LETTER ER
    $0421: result:= #$f3;  // CYRILLIC CAPITAL LETTER ES
    $0422: result:= #$f4;  // CYRILLIC CAPITAL LETTER TE
    $0423: result:= #$f5;  // CYRILLIC CAPITAL LETTER U
    $0416: result:= #$f6;  // CYRILLIC CAPITAL LETTER ZHE
    $0412: result:= #$f7;  // CYRILLIC CAPITAL LETTER VE
    $042c: result:= #$f8;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $042b: result:= #$f9;  // CYRILLIC CAPITAL LETTER YERU
    $0417: result:= #$fa;  // CYRILLIC CAPITAL LETTER ZE
    $0428: result:= #$fb;  // CYRILLIC CAPITAL LETTER SHA
    $042d: result:= #$fc;  // CYRILLIC CAPITAL LETTER E
    $0429: result:= #$fd;  // CYRILLIC CAPITAL LETTER SHCHA
    $0427: result:= #$fe;  // CYRILLIC CAPITAL LETTER CHE
    $042a: result:= #$ff;  // CYRILLIC CAPITAL LETTER HARD SIGN
  else
    Result:= AnsiChar(Ord(P));
  end;
end;

function UTF16StrToKOI8_R(const s: Widestring):AnsiString;
// Converts an KOI8-R string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=UTF16CharKOI8_R(s[i]);
end;

function UTF16CharTocp1251(const P: WideChar):AnsiChar;
begin
  case ord(P) of
    $0402: result:= #$80;  // CYRILLIC CAPITAL LETTER DJE
    $0403: result:= #$81;  // CYRILLIC CAPITAL LETTER GJE
    $201a: result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $0453: result:= #$83;  // CYRILLIC SMALL LETTER GJE
    $201e: result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2026: result:= #$85;  // HORIZONTAL ELLIPSIS
    $2020: result:= #$86;  // DAGGER
    $2021: result:= #$87;  // DOUBLE DAGGER
    $20ac: result:= #$88;  // EURO SIGN
    $2030: result:= #$89;  // PER MILLE SIGN
    $0409: result:= #$8a;  // CYRILLIC CAPITAL LETTER LJE
    $2039: result:= #$8b;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $040a: result:= #$8c;  // CYRILLIC CAPITAL LETTER NJE
    $040c: result:= #$8d;  // CYRILLIC CAPITAL LETTER KJE
    $040b: result:= #$8e;  // CYRILLIC CAPITAL LETTER TSHE
    $040f: result:= #$8f;  // CYRILLIC CAPITAL LETTER DZHE
    $0452: result:= #$90;  // CYRILLIC SMALL LETTER DJE
    $2018: result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201c: result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201d: result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $2022: result:= #$95;  // BULLET
    $2013: result:= #$96;  // EN DASH
    $2014: result:= #$97;  // EM DASH
    //$98: raise EConvertError.CreateFmt('Invalid cp1251 sequence "%s"',[P]);
    $2122: result:= #$99;  // TRADE MARK SIGN
    $0459: result:= #$9a;  // CYRILLIC SMALL LETTER LJE
    $203a: result:= #$9b;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $045a: result:= #$9c;  // CYRILLIC SMALL LETTER NJE
    $045c: result:= #$9d;  // CYRILLIC SMALL LETTER KJE
    $045b: result:= #$9e;  // CYRILLIC SMALL LETTER TSHE
    $045f: result:= #$9f;  // CYRILLIC SMALL LETTER DZHE
    $00a0: result:= #$a0;  // NO-BREAK SPACE
    $040e: result:= #$a1;  // CYRILLIC CAPITAL LETTER SHORT U
    $045e: result:= #$a2;  // CYRILLIC SMALL LETTER SHORT U
    $0408: result:= #$a3;  // CYRILLIC CAPITAL LETTER JE
    $00a4: result:= #$a4;  // CURRENCY SIGN
    $0490: result:= #$a5;  // CYRILLIC CAPITAL LETTER GHE WITH UPTURN
    $0401: result:= #$a8;  // CYRILLIC CAPITAL LETTER IO
    $0404: result:= #$aa;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $0407: result:= #$af;  // CYRILLIC CAPITAL LETTER YI
    $0406: result:= #$b2;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $0456: result:= #$b3;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $0491: result:= #$b4;  // CYRILLIC SMALL LETTER GHE WITH UPTURN
    $0451: result:= #$b8;  // CYRILLIC SMALL LETTER IO
    $2116: result:= #$b9;  // NUMERO SIGN
    $0454: result:= #$ba;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $0458: result:= #$bc;  // CYRILLIC SMALL LETTER JE
    $0405: result:= #$bd;  // CYRILLIC CAPITAL LETTER DZE
    $0455: result:= #$be;  // CYRILLIC SMALL LETTER DZE
    $0457: result:= #$bf;  // CYRILLIC SMALL LETTER YI
    $0410..$044f:
      result:= AnsiChar(Ord(P)-$350);
  else
    result:= AnsiChar(Ord(P));
  end;
end;

function UTF16StrTocp1251(const s: WideString):AnsiString;
// Converts an cp1251 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=UTF16CharTocp1251(s[i]);
end;

function cp1251ToUTF16Char(const P: AnsiChar):WideChar;
begin
  case ord(P) of
    $80: result:= #$0402;  // CYRILLIC CAPITAL LETTER DJE
    $81: result:= #$0403;  // CYRILLIC CAPITAL LETTER GJE
    $82: result:= #$201a;  // SINGLE LOW-9 QUOTATION MARK
    $83: result:= #$0453;  // CYRILLIC SMALL LETTER GJE
    $84: result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $85: result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: result:= #$2020;  // DAGGER
    $87: result:= #$2021;  // DOUBLE DAGGER
    $88: result:= #$20ac;  // EURO SIGN
    $89: result:= #$2030;  // PER MILLE SIGN
    $8a: result:= #$0409;  // CYRILLIC CAPITAL LETTER LJE
    $8b: result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8c: result:= #$040a;  // CYRILLIC CAPITAL LETTER NJE
    $8d: result:= #$040c;  // CYRILLIC CAPITAL LETTER KJE
    $8e: result:= #$040b;  // CYRILLIC CAPITAL LETTER TSHE
    $8f: result:= #$040f;  // CYRILLIC CAPITAL LETTER DZHE
    $90: result:= #$0452;  // CYRILLIC SMALL LETTER DJE
    $91: result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $94: result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $95: result:= #$2022;  // BULLET
    $96: result:= #$2013;  // EN DASH
    $97: result:= #$2014;  // EM DASH
    $98: raise Exception.CreateFmt('Invalid cp1251 sequence "%s"',[P]);
    $99: result:= #$2122;  // TRADE MARK SIGN
    $9a: result:= #$0459;  // CYRILLIC SMALL LETTER LJE
    $9b: result:= #$203a;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9c: result:= #$045a;  // CYRILLIC SMALL LETTER NJE
    $9d: result:= #$045c;  // CYRILLIC SMALL LETTER KJE
    $9e: result:= #$045b;  // CYRILLIC SMALL LETTER TSHE
    $9f: result:= #$045f;  // CYRILLIC SMALL LETTER DZHE
    $a0: result:= #$00a0;  // NO-BREAK SPACE
    $a1: result:= #$040e;  // CYRILLIC CAPITAL LETTER SHORT U
    $a2: result:= #$045e;  // CYRILLIC SMALL LETTER SHORT U
    $a3: result:= #$0408;  // CYRILLIC CAPITAL LETTER JE
    $a4: result:= #$00a4;  // CURRENCY SIGN
    $a5: result:= #$0490;  // CYRILLIC CAPITAL LETTER GHE WITH UPTURN
    $a8: result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $aa: result:= #$0404;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $af: result:= #$0407;  // CYRILLIC CAPITAL LETTER YI
    $b2: result:= #$0406;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $b3: result:= #$0456;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $b4: result:= #$0491;  // CYRILLIC SMALL LETTER GHE WITH UPTURN
    $b8: result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $b9: result:= #$2116;  // NUMERO SIGN
    $ba: result:= #$0454;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $bc: result:= #$0458;  // CYRILLIC SMALL LETTER JE
    $bd: result:= #$0405;  // CYRILLIC CAPITAL LETTER DZE
    $be: result:= #$0455;  // CYRILLIC SMALL LETTER DZE
    $bf: result:= #$0457;  // CYRILLIC SMALL LETTER YI
    $c0..$ff:
      result:= WideChar(ord(P)+$350);
  else
    result:= WideChar(ord(P));
  end;
end;

function cp1251ToUTF16Str(const s: AnsiString):wideString;
// Converts an cp1251 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=cp1251ToUTF16Char(s[i]);
end;

type
  UCS4 = Cardinal;

const
  ReplacementCharacter: UCS4 = $0000FFFD;
  MaximumUCS2: UCS4 = $0000FFFF;
  MaximumUTF16: UCS4 = $0010FFFF;
  MaximumUCS4: UCS4 = $7FFFFFFF;

  SurrogateHighStart: UCS4 = $D800;
  SurrogateHighEnd: UCS4 = $DBFF;
  SurrogateLowStart: UCS4 = $DC00;
  SurrogateLowEnd: UCS4 = $DFFF;

  HalfShift: Integer = 10;

  HalfBase: UCS4 = $0010000;
  HalfMask: UCS4 = $3FF;

  OffsetsFromUTF8: array[0..5] of UCS4 = ($00000000, $00003080, $000E2080,
                                          $03C82080, $FA082080, $82082080);

  BytesFromUTF8: array[0..255] of Byte = (
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5);

  FirstByteMark: array[0..6] of Byte = ($00, $00, $C0, $E0, $F0, $F8, $FC);

//----------------------------------------------------------------------------------------------------------------------

function WideStringToUTF8(S: WideString): AnsiString;

var
  Ch: UCS4;
  L, J, T,
  BytesToWrite: Cardinal;
  ByteMask: UCS4;
  ByteMark: UCS4;

begin
  if Length(S) = 0 then
    Result := ''
  else
  begin
    SetLength(Result, Length(S) * 6); // assume worst case
    T := 1;
    ByteMask := $BF;
    ByteMark := $80;

    for J := 1 to Length(S) do
    begin
      Ch := UCS4(S[J]);

      if Ch < $80 then
        BytesToWrite := 1
      else
        if Ch < $800 then
          BytesToWrite := 2
        else
          if Ch < $10000 then
            BytesToWrite := 3
          else
            if Ch < $200000 then
              BytesToWrite := 4
            else
              if Ch < $4000000 then
                BytesToWrite := 5
              else
                if Ch <= MaximumUCS4 then
                  BytesToWrite := 6
                else
                begin
                  BytesToWrite := 2;
                  Ch := ReplacementCharacter;
                end;

      for L := BytesToWrite downto 2 do
      begin
        Result[T + L - 1] := AnsiChar((Ch or ByteMark) and ByteMask);
        Ch := Ch shr 6;
      end;
      Result[T] := AnsiChar(Ch or FirstByteMark[BytesToWrite]);
      Inc(T, BytesToWrite);
    end;
    SetLength(Result, T - 1); // set to actual length
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function UTF8ToWideString(S: AnsiString): WideString;

var
  L, J, T: Cardinal;
  Ch: UCS4;
  ExtraBytesToWrite: Word;

begin
  if Length(S) = 0 then
    Result := ''
  else
  begin
    SetLength(Result, Length(S)); // create enough room

    L := 1;
    T := 1;
    while L <= Cardinal(Length(S)) do
    begin
      Ch := 0;
      ExtraBytesToWrite := BytesFromUTF8[Ord(S[L])];

      for J := ExtraBytesToWrite downto 1 do
      begin
        Ch := Ch + Ord(S[L]);
        Inc(L);
        Ch := Ch shl 6;
      end;
      Ch := Ch + Ord(S[L]);
      Inc(L);
      Ch := Ch - OffsetsFromUTF8[ExtraBytesToWrite];

      if Ch <= MaximumUCS2 then
      begin
        Result[T] := WideChar(Ch);
        Inc(T);
      end
      else
        if Ch > MaximumUCS4 then
        begin
          Result[T] := WideChar(ReplacementCharacter);
          Inc(T);
        end
        else
        begin
          Ch := Ch - HalfBase;
          Result[T] := WideChar((Ch shr HalfShift) + SurrogateHighStart);
          Inc(T);
          Result[T] := WideChar((Ch and HalfMask) + SurrogateLowStart);
          Inc(T);
        end;
    end;
    SetLength(Result, T - 1); // now fix up length
  end;
end;

function UnicodeToUTF8(var AUtf8: AnsiString; const ASrc: AnsiString; AChars: _ulong;
  const AStringType: CodesetId; var AWritten: _ulong): long;
var
  wstr: WideString;
begin
  case AStringType of
    {C_KOI8_R: begin
      wstr := KOI8_RToUTF16Str(ASrc);
      AUtf8 := UTF16BEToUTF8Str(wstr, False);
      //AUtf8 := wstr;// UTF16BEToUTF8Str(wstr, False);
      Result := C_OK;
      AWritten := Length(AUtf8) + 1;
    end;}
    C_IBM_1251: begin
      wstr := cp1251ToUTF16Str(ASrc);
      //AUtf8 := wstr;//UTF16BEToUTF8Str(wstr, False);
      AUtf8 := WideStringToUTF8(wstr);//, False);
      Result := C_OK;
      AWritten := Length(AUtf8) + 1;
    end;
    else begin
      if Length(ASrc) = 0 then begin
        Result := C_OK;
        AWritten := 1;
        Exit;
      end;
      Result := uni_toUTF8(PAnsiChar(AUtf8), PAnsiChar(ASrc), AChars, AStringType, 2, AWritten);
    end;
  end;
end;

function UnicodeFromUTF8(var AUtf8: AnsiString; const ASrc: AnsiString; var AChars, AUtfRead: _ulong;
  const AStringType: CodesetId; var AWritten: _ulong): long;
var
  wstr: WideString;
  str: AnsiString;
begin
  case AStringType of
    {C_KOI8_R: begin
      str := Copy(ASrc, 1, AChars - 1);
      wstr := UTF8ToUTF16BEStr(str);
      //wstr := str;//UTF8ToUTF16BEStr(str);
      AUtf8 := UTF16StrToKOI8_R(wstr);
      Result := C_OK;
      AWritten := Length(AUtf8) + 1;
    end;}
    C_IBM_1251: begin
      str := Copy(ASrc, 1, AChars - 1);
      wstr := UTF8ToWideString(str);
      //wstr := str;//UTF8ToUTF16BEStr(str);
      AUtf8 := UTF16StrTocp1251(wstr);
      Result := C_OK;
      AWritten := Length(AUtf8) + 1;
    end;
    else begin
      if Length(ASrc) = 0 then begin
        Result := C_OK;
        AWritten := 1;
        Exit;
      end;
      Result := uni_fromUTF8(PAnsiChar(AUtf8), PAnsiChar(ASrc), AChars, AUtfRead, AStringType, Char(2), AWritten);
      end;
  end;
end;

function ConvertString(const Src: AnsiString; const ASrcType, ADstType: CodesetId): AnsiString;
var
  tmp: AnsiString;
  len: Integer;
  written, chars, utfwrite: Cardinal;
begin
  len := Length(Src);
  SetLength(tmp, 6 * len + 1); // UTF8 has max 6 code points per char
  UnicodeToUTF8(tmp, Src, len, ASrcType, chars);
  SetLength(Result, chars);
  UnicodeFromUTF8(Result, tmp, chars, utfwrite, ADstType, written);
  SetLength(Result, len);
end;

{$IFDEF LIBRARY}
exports
  ConvertString;
{$ENDIF}

{$ELSE}

{$IFDEF USELIB}
function ConvertString(const Src: AnsiString; const ASrcType, ADstType: CodesetId): AnsiString; external MTDORB_Library_Name;
{$ENDIF}

implementation
{$ENDIF}
end.
