{*********************************************************}
{*                   TDICT3.DPR 2.00                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TDict3;

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
  Nodes = 10;
  NodeLen = 32;
var
  strings : array[1..Nodes] of string;
  dict : TStdictionary;
  i, j : longint;

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
  dict := TStDictionary.Create(1000);
  dict.Hash := AnsiELFHashText;

  randseed := 0;
  for i := 1 to Nodes do
    strings[i] := RandomStr;

  for i := 1 to Nodes do
    dict.add(strings[i], pointer(i));

  for i := 1 to Nodes do
    if not dict.Exists(strings[i], pointer(j)) then
      WriteLn('not found error on node ', i)
    else if i <> j then
      WriteLn('data error on node ', i);

  writeln('setting hashsize to 2000');
  dict.hashsize := 2000;
  writeln('new count is ', dict.count);

  for i := 1 to Nodes do
    if not dict.Exists(strings[i], pointer(j)) then
      WriteLn('not found error on node ', i)
    else if i <> j then
      WriteLn('data error on node ', i);

  writeln('setting hashsize to 3000');
  dict.hashsize := 3000;
  writeln('new count is ', dict.count);

  for i := 1 to Nodes do
    if not dict.Exists(strings[i], pointer(j)) then
      WriteLn('not found error on node ', i)
    else if i <> j then
      WriteLn('data error on node ', i);

  for i := 1 to Nodes do
    strings[i] := '';

  dict.free;
  writeln('Done');
  readln;
end.


