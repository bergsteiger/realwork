{*********************************************************}
{*                   STDQUE.PAS 3.01                     *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{Notes:
   This class is derived from TStList and allows all of
   the inherited list methods to be used.

   The "head" of the queue is element 0 in the list. The "tail" of the
   queue is the last element in the list.

   The dequeue can be used as a LIFO stack by calling PushTail and
   PopTail, or as a FIFO queue by calling PushTail and PopHead.
}

unit STDQue;
{-DEQue class}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  STConst, STBase, STList;

type
  TStDQue = class(TStList)
    public
      procedure PushTail(Data : Pointer);
        {-Add element at tail of queue}
      procedure PopTail;
        {-Delete element at tail of queue, destroys its data}
      procedure PeekTail(var Data : Pointer);
        {-Return data at tail of queue}

      procedure PushHead(Data : Pointer);
        {-Add element at head of queue}
      procedure PopHead;
        {-Delete element at head of queue, destroys its data}
      procedure PeekHead(var Data : Pointer);
        {-Return data at head of queue}
  end;

{======================================================================}

implementation



procedure TStDQue.PeekHead(var Data : Pointer);
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if Count = 0 then
      Data := nil
    else
      Data := Head.Data;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

procedure TStDQue.PeekTail(var Data : Pointer);
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if Count = 0 then
      Data := nil
    else
      Data := Tail.Data;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

procedure TStDQue.PopHead;
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if Count > 0 then
      Delete(Head);
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

procedure TStDQue.PopTail;
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if Count > 0 then
      Delete(Tail);
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

procedure TStDQue.PushHead(Data : Pointer);
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    Insert(Data);
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

procedure TStDQue.PushTail(Data : Pointer);
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    Append(Data);
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;


end.