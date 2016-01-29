
{*******************************************************}
{                                                       }
{       Turbo Pascal Version 7.0                        }
{       Turbo Vision Unit                               }
{                                                       }
{       Copyright (c) 1992 Borland International        }
{                                                       }
{*******************************************************}

unit HistList;

{$H-}
{$X+,R-,I-,Q-,V-}
{$S-}

{****************************************************************************
   History buffer structure:

    Byte Byte String          Byte Byte String
    +-------------------------+-------------------------+--...--+
    | 0 | Id | History string | 0 | Id | History string |       |
    +-------------------------+-------------------------+--...--+

 ***************************************************************************}

interface

uses Use32, Objects;

const
  HistoryBlock: Pointer = nil;
  HistorySize: Sw_Word = 1024;
  HistoryUsed: Sw_Word = 0;

procedure HistoryAdd(Id: Byte; const Str: String);
function HistoryCount(Id: Byte): Sw_Word;
function HistoryStr(Id: Byte; Index: Sw_Integer): String;
procedure ClearHistory;

procedure InitHistory;
procedure DoneHistory;

procedure StoreHistory(var S: TStream);
procedure LoadHistory(var S: TStream);

implementation

type
  pbyte=^byte;
  thistrec=packed record
    Zero : byte;
    Id   : byte;
    Str  : String;
  end;
  phistrec=^thistrec;

var
  CurId: Byte;
  CurString: PString;

{ Advance CurString to next string with an ID of CurId }
procedure AdvanceStringPointer;
var
  p : phistrec;
begin
  while (CurString<>nil) do
   begin
     inc(pchar(CurString),pbyte(CurString)^+1);
     if pchar(CurString)-pchar(HistoryBlock)>=HistoryUsed then
      begin
        CurString:=nil;
        exit;
      end;
     p:=phistrec(CurString);
     inc(pchar(CurString),2);
     if (p^.Id=CurId) then
      exit;
   end;
end;


procedure DeleteString;
var
  len  : Sw_integer;
  p,p2 : pchar;
begin
  p:=pchar(CurString);
  p2:=pchar(CurString);
  len:=pbyte(p2)^+3;
  dec(p,2);
  inc(p2,pbyte(p2)^+1);
  Move(p2^,p^,HistoryUsed-(p2-pchar(HistoryBlock)));
  dec(HistoryUsed,len);
end;


procedure InsertString(Id: Byte; const Str: String);
var
  p1,p2 : pchar;
begin
  while (HistoryUsed+Length(Str)>HistorySize) do
   begin
     runerror(199);
   end;
  p1:=pchar(HistoryBlock)+1;
  p2:=p1+Length(Str)+3;
  Move(p1^,p2^,HistoryUsed-1);
  PHistRec(p1)^.Zero:=0;
  PHistRec(p1)^.Id:=Id;
  Move(Str[0],PHistRec(p1)^.Str,Length(Str)+1);
  inc(HistoryUsed,Length(Str)+3);
end;


procedure StartId(Id: Byte);
begin
  CurId := Id;
  CurString := HistoryBlock;
end;


function HistoryCount(Id: Byte): Sw_Word;
var
  Count: Sw_Word;
begin
  StartId(Id);
  Count := 0;
  AdvanceStringPointer;
  while CurString <> nil do
  begin
    Inc(Count);
    AdvanceStringPointer;
  end;
  HistoryCount := Count;
end;


procedure HistoryAdd(Id: Byte; const Str: String);
begin
  if Str = '' then
   Exit;

  StartId(Id);

  { Delete duplicates }
  AdvanceStringPointer;
  while CurString <> nil do
   begin
     if Str = CurString^ then
       DeleteString;
     AdvanceStringPointer;
   end;

  InsertString(Id, Str);
end;

function HistoryStr(Id: Byte; Index: Sw_Integer): String;
var
  I: Sw_Integer;
begin
  StartId(Id);
  for I := 0 to Index do
   AdvanceStringPointer;
  if CurString <> nil then
    HistoryStr := CurString^
  else
    HistoryStr := '';
end;

procedure ClearHistory;
begin
  PChar(HistoryBlock)^ := #0;
  HistoryUsed := 1;
end;


procedure StoreHistory(var S: TStream);
var
  Size: Sw_Word;
begin
  Size := HistoryUsed;
  S.Write(Size, SizeOf(Sw_Word));
  S.Write(HistoryBlock^, Size);
end;


procedure LoadHistory(var S: TStream);
var
  Size: Sw_Word;
begin
  S.Read(Size, SizeOf(Sw_Word));
  S.Read(HistoryBlock^, Size);
  HistoryUsed := Size;
end;


procedure InitHistory;
begin
  GetMem(HistoryBlock, HistorySize);
  ClearHistory;
end;


procedure DoneHistory;
begin
  FreeMem(HistoryBlock, HistorySize);
end;

end.
