{*********************************************************}
{*                    TDQUE.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TDQue;

{$I STDEFINE.INC}

{$IFDEF Win32}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  stbase,
  stlist,
  stdque
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  Nodes = 20;
var
  DQ : TStDQue;
  I, J : LongInt;

begin
  DQ := TStDQue.Create(TStListNode);

  for I := 1 to Nodes do
    DQ.PushTail(Pointer(I));

  {queue operation}
  for I := 1 to Nodes do begin
    DQ.PeekHead(Pointer(J));
    DQ.PopHead;
    writeln(J);
  end;

(*
  {stack operation}
  for I := 1 to Nodes do begin
    DQ.PeekTail(Pointer(J));
    DQ.PopTail;
    writeln(J);
  end;
*)

  DQ.Free;
  readln;
end.
