{*********************************************************}
{*                    TLIST3.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TList3;

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
  Nodes = 100;
  Tests = 1000;
var
  list : TStlist;
  i, j : longint;

begin
  list := TStlist.create(TStlistnode);

  for I := 0 to Nodes-1 do
    list.append(pointer(I));

  for J := 1 to Tests do begin
    I := random(Nodes);
    if longint(list[I].Data) <> I then begin
      writeln('error!');
      halt;
    end;
  end;

  list.destroy;
  WriteLn('Done');
  readln;
end.
