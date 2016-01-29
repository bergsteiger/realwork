{******************************************************************************}
{                                                       	               }
{ Helper unit for importing of object files from c++ builder                   }
{ 								               }
{ The original Pascal code is uObjDelphiImport.pas, released February 2005.    }
{ The initial developer of the Pascal code is                                  }
{ Soeren Muehlbauer (soeren.dd@gmx.de).                                        }
{                                                                              }
{ Portions created by Soeren Muehlbauer are Copyright (C) 2005                 }
{ Soeren Muehlbauer. All Rights Reserved.                                      }
{ 								               }
{******************************************************************************}
{$I ..\..\Utils\gtCompilerDefines.inc}

unit uObjDelphiImport;

interface

uses
  Windows, Classes, SysUtils, Math, ftTypes;

type
  cmp_callback = function(P1, P2: Pointer): Integer; cdecl;

  ptm = ^tm;
  tm = record
    tm_sec: Integer;
    tm_min: Integer;
    tm_hour: Integer;
    tm_mday: Integer;
    tm_mon: Integer;
    tm_year: Integer;
    tm_wday: Integer;
    tm_yday: Integer;
    tm_isdst: Integer;
  end;

  TJMP_Buf = record
    EBX,
    ESI,
    EDI,
    ESP,
    EBP,
    EIP: Longword;
  end;

function  isprint(c: Integer): Integer; cdecl;
procedure memset(a: Pointer; b: Integer; c: Cardinal); cdecl;
function  memcmp(s1, s2: Pointer; n: Integer): Integer; cdecl;
function  memcpy(dest: Pointer; const src: Pointer; count: Cardinal): Pointer; cdecl;
procedure memmove (dest,src: Pointer; num: Cardinal); cdecl;
function  _ftol: Integer; cdecl;
function  _atol(s:PAnsiChar): Integer; cdecl;
function  atol(s:PAnsiChar): Integer; cdecl;
procedure _llmul; register; 
procedure _lldiv; register;
function  labs(n: Integer): Integer; cdecl;
function  isDigit(c: Integer): Integer; cdecl;
function  isalnum(c: Integer): Integer; cdecl;
function  isxdigit(c: Integer): Integer; cdecl;
function  fabs(Value: Double): Double; cdecl;
function  pow(x, y: Double): Double; cdecl;
function  malloc(s: Longint): Pointer; cdecl;
function  realloc(block: Pointer; Size: Integer): Pointer; cdecl;
procedure free(p: Pointer); cdecl;
function  _ltolower(ch: Integer): Integer; cdecl;
function  _ltoupper(ch: Integer): Integer; cdecl;
function  _ltowlower(ch: Integer): Integer; cdecl;
function  _ltowupper(ch: Integer): Integer; cdecl;
function  strcpy(dest: Pointer; src: Pointer): Pointer; cdecl;
function  strncpy(strDest, strSource: PAnsiChar; count: Cardinal): PAnsiChar; cdecl;
function  strtod(s: PAnsiChar; endptr: PPAnsiChar): Double; cdecl;
function  strrchr(s: PAnsiChar; c: Integer): PAnsiChar; cdecl;
function  strncmp(string1: PAnsiChar; string2: PAnsiChar; num: Cardinal): Integer; cdecl;
function  strcmp(string1: PAnsiChar; string2: PAnsiChar): Integer; cdecl;
function  strlen(s: PAnsiChar): Integer; cdecl;
function  strcat(s1, s2: PAnsiChar): PAnsiChar; cdecl;

function  sprintf(buffer: Pointer; format: Pointer; arguments: Pointer): Integer; cdecl;
function  sprintfsec(buffer: Pointer; format: Pointer; arguments: Pointer): Integer;
function  gmtime(clock: PInteger): ptm; cdecl;

function  fopen(const Path: PAnsiChar; const Mode: PAnsiChar): Pointer; cdecl;
procedure fclose(FileHandle: Pointer); cdecl;
function  ftell(FileHandle: Pointer): Integer; cdecl;
function  fread(var buf; recsize, reccount: Integer; FileHandle: Pointer): Integer; cdecl;
function  fseek(FileHandle: Pointer; offset, origin: Integer): Integer; cdecl;
function  fwrite(const buf; recsize, reccount: Integer; FileHandle: Pointer): Integer; cdecl;
function  fflush(FileHandle: Pointer): Integer; cdecl;

function  fputs(s: Pointer; FileHandle: Pointer): Integer; cdecl;
function  fputc(c: Integer; FileHandle: Pointer): Integer; cdecl;
function  fprintf(FileHandle: Pointer; format: Pointer; arguments: Pointer): Integer; cdecl;

procedure setjmp; assembler;
procedure longjmp; assembler;

procedure qsort(base: Pointer; nelem, width: Cardinal; fcmp: cmp_callback); cdecl;

type
  {$EXTERNALSYM size_t}
  size_t = Cardinal;
  

{$EXTERNALSYM strstr}
function strstr(const s1, s2: PAnsiChar): PAnsiChar; cdecl;
{$EXTERNALSYM memchr}
function memchr(const s: Pointer; c: Integer; n: size_t): Pointer; cdecl;

var
  __turboFloat: LongBool = False;
  _streams: Integer;

implementation

const
  msvcrtdll = 'msvcrt.dll';

function strstr; external msvcrtdll name 'strstr';
function memchr; external msvcrtdll name 'memchr';

type
  PFileHandle = ^TFileHandle;
  TFileHandle = packed record
    FileStream: TFileStream;
  end;

function isprint(c: Integer): Integer; cdecl;
begin
  if (c<32) or (127<=c) then
    Result:=0
  else
    Result:=1;
end;

function sprintf(buffer: Pointer; format: Pointer; arguments: Pointer): Integer; cdecl;
begin
  Result := sprintfsec(buffer,format,@arguments);
end;


function strcpy(dest: Pointer; src: Pointer): Pointer; cdecl;
var
  ma,mb: PByte;
  n: Integer;
begin
  ma:=src;
  mb:=dest;
  while True do
  begin
    n:=ma^;
    mb^:=n;
    if n=0 then break;
    Inc(ma);
    Inc(mb);
  end;
  Result:=dest;
end;

function  strncpy(strDest, strSource: PAnsiChar; count: Cardinal): PAnsiChar; cdecl;
var
  Len: Cardinal;
begin
  Len := StrLen(strSource);
  if count <= Len then
    StrLCopy(strDest, strSource, count)
  else
  begin
    StrLCopy(strDest, strSource, Len);
    FillChar((strDest + Len)^, count - Len, 0);
  end;
  Result := strDest;
end;

function  strtod(s: PAnsiChar; endptr: PPAnsiChar): Double; cdecl;
var
  Buffer: Extended;
begin
  if TextToFloat(s, Buffer, fvExtended) then
    Result := Buffer
  else
  begin
    Result := NAN;
    if Assigned(endptr) then
      endptr^ := s;
  end;
end;

function  strrchr(S: PAnsiChar; c: Integer): PAnsiChar; cdecl;
begin
  {$IFDEF DELPHI12}
  Result := StrRScan(S, AnsiChar(C));
  {$ELSE}
  Result := StrRScan(S, AnsiChar(C));
  {$ENDIF}
end;

function  strlen(s: PAnsiChar): Integer; cdecl;
begin
  Result := Length(s);
end;

function  strcat(s1, s2: PAnsiChar): PAnsiChar; cdecl;
begin
  Result := SysUtils.StrCat(s1, s2);
end;

function  strncmp(string1: PAnsiChar; string2: PAnsiChar; num: Cardinal): Integer; cdecl;
begin
  Result := StrLComp(string1, string2, num);
end;

function  strcmp(string1: PAnsiChar; string2: PAnsiChar): Integer; cdecl;
begin
  Result := StrIComp(string1, string2);
end;

function _ltolower(ch: Integer): Integer; cdecl;
begin
  raise Exception.Create('LibDelphi - call to _ltolower - should presumably not occur');
end;

function _ltoupper(ch: Integer): Integer; cdecl;
begin
  raise Exception.Create('call to _ltoupper');
end;

function _ltowlower(ch: Integer): Integer; cdecl;
begin
  raise Exception.Create('call to _ltowlower');
end;

function _ltowupper(ch: Integer): Integer; cdecl;
begin
  raise Exception.Create('call to _ltowupper');
end;

function sprintfsec(buffer: Pointer; format: Pointer; arguments: Pointer): Integer;
var
  Modifier: Integer;
  Width: Integer;
  m,ma: PByte;
  mb: Boolean;
  n: PByte;
  o: PByte;
  r: PByte;
  
    procedure Append(const p: AnsiString);
    var
      q: Integer;
    begin
      if Width>Length(p) then
      begin
        if buffer<>nil then
        begin
          for q:=0 to Width-Length(p)-1 do
          begin
            o^:=Ord('0');
            Inc(o);
          end;
        end
        else
          Inc(o,Width-Length(p));
      end;
      if buffer<>nil then CopyMemory(o,PAnsiChar(p),Length(p));
      Inc(o,Length(p));
    end;
    
begin
  m:=format;
  n:=arguments;
  o:=buffer;
  while True do
  begin
    if m^=0 then break;
    if m^=Ord('%') then
    begin
      ma:=m;
      mb:=True;
      Inc(m);
      Width:=-1;
      Modifier:=0;
      {flags}
      case m^ of
        Ord('-'): mb:=False;
        Ord('+'): mb:=False;
        Ord(' '): mb:=False;
        Ord('#'): mb:=False;
      end;
      if mb then
      begin
        {width}
        case m^ of
          Ord('1')..Ord('9'):
          begin
            Width:=0;
            while True do
            begin
              if (m^<Ord('0')) or (Ord('9')<m^) then break;
              Width:=Width*10+m^-Ord('0');
              Inc(m);
            end;
          end;
          Ord('0'): mb:=False;
          Ord('*'): mb:=False;
        end;
      end;
      if mb then
      begin
        {prec}
        case m^ of
          Ord('.'): mb:=False;
        end;
      end;
      if mb then
      begin
        {modifier}
        case m^ of
          Ord('F'): mb:=False;
          Ord('N'): mb:=False;
          Ord('h'): mb:=False;
          Ord('l'):
          begin
            Modifier:=4;
            Inc(m);
          end;
          Ord('L'): mb:=False;
        end;
      end;
      if mb then
      begin
        {type}
        case m^ of
          Ord('d'):
          begin
            case Modifier of
              0:
              begin
                Append(IntToStr(PInteger(n)^));
                Inc(m);
                Inc(n,SizeOf(Integer));
              end;
            else
              mb:=False;
            end;
          end;
          Ord('i'): mb:=False;
          Ord('o'): mb:=False;
          Ord('u'):
          begin
            case Modifier of
              0,4:
              begin
                Append(IntToStr(PCardinal(n)^));
                Inc(m);
                Inc(n,SizeOf(Cardinal));
              end;
            else
              mb:=False;
            end;
          end;
          Ord('x'):
          begin
            case Modifier of
              0,4:
              begin
                Append(IntToHex(PCardinal(n)^,8));
                Inc(m);
                Inc(n,SizeOf(Cardinal));
              end;
            else
              mb:=False;
            end;
          end;
          Ord('X'): mb:=False;
          Ord('f'): mb:=False;
          Ord('e'): mb:=False;
          Ord('g'):
          begin
            case Modifier of
              0:
              begin
                Append(FloatToStr(PSingle(n)^));
                Inc(m);
                Inc(n,SizeOf(Single));
              end;
            else
              mb:=False;
            end;
          end;
          Ord('E'): mb:=False;
          Ord('G'): mb:=False;
          Ord('c'): mb:=False;
          Ord('s'):
          begin
            r:=PPointer(n)^;
            while r^<>0 do
            begin
              if buffer<>nil then o^:=r^;
              Inc(o);
              Inc(r);
            end;
            Inc(n,SizeOf(Pointer));
            Inc(m);
          end;
          Ord('%'): mb:=False;
          Ord('n'): mb:=False;
          Ord('p'): mb:=False;
        else
          raise Exception.Create('');
        end;
      end;
      if mb=False then
      begin
        m:=ma;
        if buffer<>nil then o^:=m^;
        Inc(o);
        Inc(m);
      end;
    end
    else if m^=10 then
    begin
      if buffer<>nil then o^:=13;
      Inc(o);
      if buffer<>nil then o^:=10;
      Inc(o);
      Inc(m);
    end
    else
    begin
      if buffer<>nil then o^:=m^;
      Inc(o);
      Inc(m);
    end;
  end;
  if buffer<>nil then o^:=0;
  Inc(o);
  Result:=(Cardinal(o)-Cardinal(buffer));
end;

procedure free(p: Pointer); cdecl;
begin
  FreeMem(p);
end;

function malloc(s: Longint): Pointer; cdecl;
begin
  GetMem(Result, s);
end;

function realloc(block: Pointer; Size: Integer): Pointer; cdecl;
begin
  ReallocMem(block, Size);
  Result := Block;
end;

function _ftol: Integer; cdecl;
var
  f: double;
begin
  asm
    lea    eax, f             //  BC++ passes floats on the FPU stack
    fstp  qword ptr [eax]     //  Delphi passes floats on the CPU stack
  end;
  Result := Trunc(f);
end;

function  _atol(s:PAnsiChar): Integer; cdecl;
begin
  Result := StrToIntDef(s, 0);
end;

function  atol(s:PAnsiChar): Integer; cdecl;
begin
  result := _atol(s);
end;

function  isalnum(c: Integer): Integer; cdecl;
begin
  if c in [Integer('0')..Integer('9'), Integer('A')..Integer('Z'), Integer('a')..Integer('z')] then
    Result := 1
  else
    result := 0;
end;

function  isxdigit(c: Integer): Integer; cdecl;
begin
  if c in [Integer('A')..Integer('F'), Integer('a')..Integer('f'), Integer('0')..Integer('9')] then
    Result := 1
  else
    result := 0;
end;

function  isDigit(c: Integer): Integer; cdecl;
begin
  if c in [Integer('0')..Integer('9')] then
    Result := 1
  else
    Result := 0;
end;

procedure _llmul; 
asm
  JMP System.@_llmul
end;

procedure _lldiv;
asm
  JMP System.@_lldiv
end;

function  labs(n: Integer): Integer; cdecl;
begin
  Result := abs(n);
end;

function  fabs(Value: Double): Double; cdecl;
begin
  Result := Abs(Value);
end;

function  pow(x, y: Double): Double; cdecl;
begin
  Result := Power(x, y);
end;

function memcpy(dest: Pointer; const src: Pointer; count: Cardinal): Pointer; cdecl;
begin
  CopyMemory(dest,src,count);
  Result:=dest;
end;

procedure memmove (dest,src: Pointer; num: Cardinal); cdecl;
begin
  CopyMemory(dest, src, num);
end;

procedure memset(a: Pointer; b: Integer; c: Cardinal); cdecl;
begin
  FillMemory(a,c,b);
end;

function  memcmp(s1, s2: Pointer; n: Integer): Integer; cdecl;
begin
  {$IFDEF VCL12ORABOVE}
  Result := StrLComp(PAnsiChar(s1), PAnsiChar(s2), n);
  {$ELSE}
  Result := StrLComp(s1, s2, n);
  {$ENDIF}
end;

var
  tmX: tm; // Variable will be overwritten each time comtime is called. Just like the static struct in BCB gmtime.c.

  _daylight: Boolean;

const
  Thursday = 4;
  April    = 4;
  October  = 10;

  _Days: array[0..11] of Byte = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  _YDays: array[0..12] of Integer = (0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365);


function _isDST (hour, yday, month, year: Cardinal): Boolean;

// Determines whether daylight savings is in effect and returns non-zero if so for the given date.
//
// If month is 0, yday is the day of the year; otherwise yday is the day of the month, where month is 1 for Jan, 2 for
// Feb, etc. In either case, yday is zero based.  year is the number of years since 1970.

var
  temp,
  sunday: Cardinal;
  
begin
  Result := False;

  if month = 0 then // if only day of year given 
  begin
    temp := yday;
    if (yday >= 31 + 28) and (((year + 70) and 3) = 0) then
      Dec(temp);
    month := 0;
    while temp >= Cardinal(_YDays[month]) do
      Inc(month);
  end
  else  // if month+day of month given 
  begin
    Inc(yday, _YDays[month - 1]);
    if (month > 2) and (((year + 70) and 3) = 0) then  // leap year, Mar-Dec
      Inc(yday);
  end;

  // Weed out months other than April or October.
  if (month < April) or (month > October) then
    System.Exit;
  if (month > April) and (month < October) then
  begin
    Result := True;
    System.Exit;
  end;

  // Month is either April or October. Up through 1986, the starting * day for DST is the last Sunday in April; after
  // that it is * the first Sunday in April.  The last day of DST is the last Sunday in October.
  if (year > 16) and (month = April) then // if April and year > 1986
    sunday := _YDays[month - 1] + 7       // day = 7th day in month
  else
    sunday := _YDays[month];              // day = last day in month
  if Boolean((year + 70) and 3) then      // leap year ?
    Dec(sunday);                          // no --> adjust

  // Adjust the threshold day downward to the preceding Sunday.
  temp := sunday + ((year + 1) shr 2)     // add leap days since 1970
         + (year * 365)                   // add years since 1970
         + Thursday;                      // 01-01-70 was Thursday
  Dec(sunday, temp mod 7);                // back up to Sunday

  // Check if the day falls within the limit.
  if month = April then
  begin
    if yday > sunday then
      Result := True
    else
      if yday = sunday then
        Result := hour >= 2; // DST started at 2:00 AM
  end
  else
  begin
    if yday < sunday then
      Result := True
    else
      if yday = sunday then
        Result := hour <= 1; // DST ended at 2:00 AM
  end;
end;


function comtime(ltime: Integer; dst: Boolean): ptm;

var
  time: Cardinal;
  hpery: Integer;
  i: Integer;
  cumdays: Cardinal;

begin
  time := Cardinal(ltime);
  tmX.tm_sec := Integer(time mod 60);
  time := time div 60;                      // Time in minutes
  tmX.tm_min := Integer(time mod 60);
  time := time div 60;                      // Time in hours
  i := Cardinal(time div (1461 * Cardinal(24))); // Number of 4 year blocks.
  tmX.tm_year := i shl 2;
  Inc(tmX.tm_year, 70);
  cumdays := 1461 * i;
  time := time mod (1461 * Cardinal(24));   // Hours since end of last 4 year block.

  repeat
    hpery := 365 * 24;
    if (tmX.tm_year and 3) = 0 then
      Inc(hpery, 24);
    if time < Cardinal(hpery) then
       Break;
    Inc(cumdays, hpery div 24);
    Inc(tmX.tm_year);
    Dec(time, hpery);
  until False; // At end, time is number of hours into current year.

  if dst and _daylight and _isDST(time mod 24, time div 24, 0, tmX.tm_year - 70) then
  begin
    Inc(time);
    tmX.tm_isdst := 1;
  end
  else
    tmX.tm_isdst := 0;

  tmX.tm_hour := (time mod 24);
  time := time div 24;             // Time in days
  tmX.tm_yday := time;
  Inc(cumdays, time + 4);
  tmX.tm_wday := cumdays mod 7;
  Inc(time);

  Result := @tmX;
  if (tmX.tm_year and 3) = 0 then
  begin
    if time > 60 then
      Dec(time)
    else
      if time = 60 then
      begin
        tmX.tm_mon := 1;
        tmX.tm_mday := 29;
        System.Exit;
      end;
  end;

  tmX.tm_mon := 0;
  while _Days[tmX.tm_mon] < time do
  begin
    Inc(tmX.tm_mon);
    Dec(time, _Days[tmX.tm_mon]);
  end;

  tmX.tm_mday := time;
end;

function  gmtime(clock: PInteger): ptm; cdecl;
begin
  Result := comtime(clock^, False);
end;

function fopen(const Path: PAnsiChar; const Mode: PAnsiChar): Pointer; cdecl;
var
  FileHandle: PFileHandle;
  FMode: Integer;
begin
  Result := nil;
  New(FileHandle);
  try
    FMode := -1;
    if Pos('r', Mode)>0 then
      FMode := FMode and fmOpenRead;
    if Pos('w', Mode)>0 then
      FMode := FMode and fmOpenWrite;
    if Pos('a', Mode)>0 then
      FMode := FMode and fmCreate;
    if Pos('r+', Mode)>0 then
      FMode := FMode and fmCreate;
    if Pos('w+', Mode)>0 then
      FMode := FMode and fmOpenRead and fmOpenWrite;
    if FMode = -1 then
      FMode := fmCreate;
    if FileExists(Path) then
    begin
      FileHandle.FileStream := TFileStream.Create(Path, FMode);
      Result := FileHandle;
    end;
  except
    Dispose(FileHandle);
  end;
end;

procedure fclose(FileHandle: Pointer); cdecl;
var
  FileH: PFileHandle;
begin
  FileH := FileHandle;
  if assigned(FileH) then
  begin
    if assigned(FileH.FileStream) then
      FileH.FileStream.Free;
    Dispose(FileH);
  end;
end;

function  fread(var buf; recsize, reccount: Integer; FileHandle: Pointer): Integer; cdecl;
var
  FileH: PFileHandle;
begin
  if Assigned(FileHandle) then
  begin
    FileH := FileHandle;
    if Assigned(FileH.FileStream) then
    begin
      if FileH.FileStream.Read(buf, recsize * reccount) > 0 then
        Result := reccount
      else
        Result := 0
    end
    else
      Result := 0;
  end
  else
    Result := 0;
end;

function  fseek(FileHandle: Pointer; offset, origin: Integer): Integer; cdecl;
var
  FileH: PFileHandle;
begin
  FileH := FileHandle;
  result := -1;
  if Assigned(FileH) and Assigned(FileH.FileStream) then
    Result := FileH.FileStream.Seek(offset, origin);
end;

function  fwrite(const buf; recsize, reccount: Integer; FileHandle: Pointer): Integer; cdecl;
var
  FileH: PFileHandle;
begin
  FileH := FileHandle;
  if Assigned(FileH) and Assigned(FileH.FileStream) then
    Result := FileH.FileStream.Write(buf, recsize * reccount)
  else
   Result := 0;
end;

function ftell(FileHandle: Pointer): Integer; cdecl;
var
  FileH: PFileHandle;
begin
  Result := -1;
  FileH := FileHandle;
  if assigned(FileH) then
  begin
    if assigned(FileH.FileStream) then
      Result := FileH^.FileStream.Position;
  end;
end;

function  fflush(FileHandle: Pointer): Integer; cdecl;
begin
  Result := 0;
end;

function fputc(c: Integer; FileHandle: Pointer): Integer; cdecl;
var
  m: array[0..1] of AnsiChar;
  n: Cardinal;
  FileH: PFileHandle;
begin
  if c=13 then
  begin
    m[0]:=#13;
    m[1]:=#10;
    n:=2;
  end
  else
  begin
    m[0]:=AnsiChar(c);
    n:=1;
  end;
  FileH := FileHandle;
  c := -1;
  if Assigned(FileH) and assigned(FileH.FileStream) then
    c := FileH.FileStream.Write(m[0], n);
  Result:=c;
end;

function fputs(s: Pointer; FileHandle: Pointer): Integer; cdecl;
var
  m: Integer;
  n: Pointer;
  FileH: PFileHandle;
begin
  m:=0;
  n:=s;
  while PByte(n)^<>0 do
  begin
    Inc(m);
    Inc(PByte(n));
  end;
  FileH := FileHandle;
  Result := -1;
  if Assigned(FileH) and assigned(FileH.FileStream) then
    Result := FileH.FileStream.Write(s^, m);
end;

function fprintf(FileHandle: Pointer; format: Pointer; arguments: Pointer): Integer; cdecl;
var
  m: Integer;
  n: Pointer;
  o: Integer;
  FileH: PFileHandle;
begin
  m:=sprintfsec(nil,format,@arguments);
  o := -1;
  GetMem(n,m);
  try
    sprintfsec(n,format,@arguments);
    FileH := FileHandle;
    if Assigned(FileH) and Assigned(FileH.FileStream) then
      o := FileH.FileStream.Write(n^, m);
    Result := o;
  finally
    FreeMem(n);
  end;
end;

procedure setjmp;
asm
{     ->  EAX     jmpb   }
{     <-  EAX     Result }
          MOV     EAX, ESP + 4
          MOV     EDX, [ESP]
          // Save task state
          MOV     [EAX+TJMP_Buf.&EBX], EBX
          MOV     [EAX+TJMP_Buf.&ESI], ESI
          MOV     [EAX+TJMP_Buf.&EDI], EDI
          MOV     [EAX+TJMP_Buf.&ESP], ESP
          MOV     [EAX+TJMP_Buf.&EBP], EBP
          MOV     [EAX+TJMP_Buf.&EIP], EDX

          SUB     EAX, EAX
@@1:
end;

procedure longjmp;
asm
          MOV     EDX, ESP + 4
          MOV     EAX, ESP + 8

          MOV     ECX, [EDX+TJMP_Buf.&EIP]
          // Restore task state
          MOV     EBX, [EDX+TJMP_Buf.&EBX]
          MOV     ESI, [EDX+TJMP_Buf.&ESI]
          MOV     EDI, [EDX+TJMP_Buf.&EDI]
          MOV     ESP, [EDX+TJMP_Buf.&ESP]
          MOV     EBP, [EDX+TJMP_Buf.&EBP]
          MOV     [ESP], ECX  // (EIP)

          TEST    EAX, EAX
          JNZ     @@1
          MOV     EAX, 1
@@1:
end;

threadvar
  Compare: cmp_callback;
  QWidth: Cardinal;

procedure Exchange(Left, Right: PAnsiChar);
var
  I: Cardinal;
  C: AnsiChar;
begin
  for I := 1 to qWidth do
  begin
    C := Right^;
    Right^ := Left^;
    Inc(Right);
    Left^ := C;
    Inc(Left);
  end;
end;

procedure qSortHelp(pivotP: PAnsiChar; nElem: Cardinal);
label
  tailRecursion, qBreak;
var
  leftP,
  rightP,
  pivotEnd,
  pivotTemp,
  leftTemp: PAnsiChar;
  lNum: Cardinal;
  retval: Integer;
begin
  tailRecursion:
  
  if nElem <= 2 then
  begin
    if nElem = 2 then
    begin
      rightP := qWidth + pivotP;
      if Compare(pivotP, rightP) > 0 then
        Exchange(pivotP, rightP);
    end;
    System.Exit;
  end;

  rightP := (nElem - 1) * qWidth + pivotP;
  leftP  := (nElem shr 1) * qWidth + pivotP;

  // Sort the pivot, left, and right elements for "median of 3".
  if Compare(leftP, rightP) > 0 then
    Exchange (leftP, rightP);
  if Compare(leftP, pivotP) > 0 then
    Exchange (leftP, pivotP)
  else
    if Compare(pivotP, rightP) > 0 then
      Exchange (pivotP, rightP);

  if nElem = 3 then
  begin
    Exchange(pivotP, leftP);
    System.Exit;
  end;

  // Now for the classic Hoare algorithm.
  pivotEnd := pivotP + qWidth;
  leftP := pivotEnd;

  repeat
    while True do
    begin
      retval := Compare(leftP, pivotP);
      if retval > 0 then
        Break;
      if retval = 0 then
      begin
        Exchange(leftP, pivotEnd);
        Inc(pivotEnd, qWidth);
      end;
      if leftP < rightP then
        Inc(leftP, qWidth)
      else
        goto qBreak;
    end;  

    while leftP < rightP do
    begin
      retval := Compare(pivotP, rightP);
      if retval < 0 then
        Dec(rightP, qWidth)
      else
      begin
        Exchange(leftP, rightP);
        if retval <> 0 then
        begin
          Inc(leftP, qWidth);
          Dec(rightP, qWidth);
        end;
        Break;
      end;
    end;
  until leftP >= rightP;

  qBreak:

  if Compare(leftP, pivotP) <= 0 then
    leftP := leftP + qWidth;

  leftTemp := leftP - qWidth;

  pivotTemp := pivotP;

  while (pivotTemp < pivotEnd) and (leftTemp >= pivotEnd) do
  begin
    Exchange(pivotTemp, leftTemp);
    Inc(pivotTemp, qWidth);
    Dec(leftTemp, qWidth);
  end;
        
  lNum := Cardinal(leftP - pivotEnd) div qWidth;
  nElem := Cardinal((nElem * qWidth + pivotP) - leftP) div qWidth;

  // Sort smaller partition first to reduce stack usage.
  if nElem < lNum then
  begin
    qSortHelp(leftP, nElem);
    nElem := lNum;
  end
  else
  begin
    qSortHelp(pivotP, lNum);
    pivotP := leftP;
  end;
                
  goto tailRecursion;
end;

procedure qsort(base: Pointer; nelem, width: Cardinal; fcmp: cmp_callback);
begin
  if width > 0 then
  begin
    qWidth := width;
    Compare := fcmp;
    qSortHelp(base, nElem);
  end;
end;


end.
