{*********************************************************}
{*                    TLIST5.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TList5;

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

uses
  sysutils, stbase, stlist
{$IFNDEF Win32}
  , wincrt
{$ENDIF}
  ;
const
  Nodes = 10;
  Tests = 1000;
type
  TMyNodeData = class
    MyInt : Integer;
    MyStr : string;
    constructor Create(I : Integer; const S : string);
  end;

  TMyNode = class(TStListNode)
    destructor Destroy; override;
  end;

var
  List : TStlist;
  i, j : longint;

constructor TMyNodeData.Create(I : Integer; const S : string);
begin
  MyInt := I;
  MyStr := S;
end;

destructor TMyNode.Destroy;
begin
  writeln('destroying ', TMyNodeData(Data).MyInt);
  TMyNodeData(Data).Free;
  inherited Destroy;
end;

begin
  list := TStlist.create(TMyNode);

  for I := 0 to Nodes-1 do
    list.append(TMyNodeData.Create(I, inttostr(I)));

  for J := 1 to Tests do begin
    I := random(Nodes);
    if longint(TMyNodeData(list[I].Data).MyInt) <> I then begin
      writeln('error!');
      halt;
    end;
  end;

  list.free;
  writeln('ok!');
  readln;
end.
