{*********************************************************}
{*                    TLIST4.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TList4;

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
  SplitNum = 1;
var
  list : TStlist;
  list2 : TStlist;
  i : longint;
  prev : pointer;

function SCompare(Data1, Data2 : Pointer) : Integer; far;
begin
  if longint(data1) < longint(data2) then
    {sort in descending order}
    SCompare := +1
  else if longint(data1) > longint(data2) then
    SCompare := -1
  else
    SCompare := 0;
end;

function ShowNode(Container : TStContainer;
                  Node : TStNode;
                  OtherData : Pointer) : Boolean; far;
begin
  if Nodes <= 100 then
    WriteLn(longint(Node.Data));
  if longint(Node.Data) > longint(Prev) then begin
    writeln('error!');
    ShowNode := False;
    exit;
  end;
  prev := Node.Data;
  ShowNode := True;
end;

begin
  list := TStlist.create(TStlistnode);

  list.Compare := SCompare;

  for I := 0 to Nodes-1 do
    list.append(pointer(I));

  list2 := list.split(list.nth(SplitNum));

  if list.count <> SplitNum then
    writeln('error in list.count');
  if list2.count <> Nodes-SplitNum then
    writeln('error in list2.count');

  list2.sort;

  prev := pointer(maxlongint);
  list2.iterate(ShowNode, True, nil);

  list2.join(list2.tail, list);

  if list2.count <> Nodes then
    writeln('error in joined list2.count');

  list2.destroy;
  WriteLn('Done');
  readln;
end.
