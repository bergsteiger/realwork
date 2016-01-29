{*********************************************************}
{*                    TLIST2.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TList2;

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

{$I STDEFINE.INC}

uses
  sysutils, stbase, stlist
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;
const
  Nodes = 20;
  NodeLen = 5;
var
  list : TStlist;
  i : longint;
  compares : longint;
  p : string;
  prev : pstring;
  checkorder : boolean;

function SCompare(Data1, Data2 : Pointer) : Integer; far;
begin
  inc(compares);
  SCompare := CompareStr(pstring(Data1)^, pstring(Data2)^);
end;

procedure SDispose(Data : Pointer); far;
begin
  disposestr(pstring(data));
end;

function RandomStr : string;
var
  i : integer;
  Dest : PChar;
begin
{$IFDEF Win32}
  SetLength(Result, NodeLen);
  Dest := Pointer(Result);
  for I := 1 to NodeLen do begin
    Dest^ := char(byte('a')+random(26));
    inc(Dest);
  end;
{$ELSE}
  for I := 1 to NodeLen do
    Result[I] := char(byte('a')+random(26));
  Result[0] := Char(NodeLen);
{$ENDIF}
end;

function ShowNode(Container : TStContainer;
                  Node : TStNode;
                  OtherData : Pointer) : Boolean; far;
begin
  if Nodes <= 100 then
    WriteLn(pstring(Node.Data)^);
  if CheckOrder then begin
   if prev <> nil then
     if pstring(Node.Data)^ < Prev^ then begin
       writeln('error!');
       writeln(pstring(TStList(Container).Prev(TStListNode(Node)).Data)^);
       writeln(pstring(Node.Data)^);
       ShowNode := False;
       exit;
     end;
   prev := pstring(Node.Data);
  end;
  ShowNode := True;
end;

function NewStr(const S: string): PString;
begin
  if S = '' then Result := NullStr else
  begin
    New(Result);
    Result^ := S;
  end;
end;

begin
  list := TStlist.create(TStlistnode);

  list.Compare := SCompare;
  list.DisposeData := SDispose;

  compares := 0;
  for I := 1 to Nodes do begin
    P := RandomStr;
    list.append(newstr(p));
  end;

  prev := nil;
  checkorder := false;
  list.iterate(ShowNode, True, nil);
  writeln(compares);
  WriteLn;

  compares := 0;
  list.sort;

  prev := nil;
  checkorder := true;
  list.iterate(ShowNode, True, nil);
  writeln(compares);

  list.destroy;
  writeln('Done');
  readln;
end.

