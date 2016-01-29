{*********************************************************}
{*                   TDICT2.DPR 2.00                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TDict2;

{$I STDEFINE.INC}

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

uses
{$IFDEF Win32}
  windows,
{$ENDIF}
  sysutils, stbase, stdict
{$IFNDEF Win32}
  , wincrt
{$ENDIF}
  ;
const
  Nodes = 10000;
  NodeLen = 32;
  TableSize = 10039;
var
  dict : TStdictionary;
  i, total : longint;
  bincnt : array[0..99] of integer;

function RandomStr : string;
var
  i : integer;
begin
{$IFDEF Win32}
  SetLength(Result, NodeLen);
{$ELSE}
  Result[0] := Char(NodeLen);
{$ENDIF}
  for I := 1 to NodeLen do
    Result[I] := char(byte('a')+random(26));
end;

begin
  WriteLn('Creating dictionary, adding ', Nodes, ' random nodes...');
  dict := TStDictionary.Create(TableSize);
  dict.Hash := AnsiELFHashText;

  randseed := 0;
  for i := 1 to Nodes do
    dict.add(RandomStr, pointer(i));

  randseed := 0;
  if not dict.Exists(RandomStr, pointer(i)) then
    WriteLn('error');

  {display the distribution in the hash table}
  fillchar(bincnt, sizeof(bincnt), 0);
  for i := 0 to TableSize-1 do
    inc(bincnt[dict.BinCount(i)]);
  total := 0;
  for i := 0 to 99 do
    if bincnt[i] <> 0 then begin
      writeln(i:5, ' ', bincnt[i]);
      inc(total, i*bincnt[i]);
    end;
  writeln('total ', total);

  dict.free;
  readln;
end.

