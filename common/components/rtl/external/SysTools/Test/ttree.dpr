{*********************************************************}
{*                    TTREE.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TTree;

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

{$I STDEFINE.INC}

uses
  SysUtils, Classes,
  stConst,
  stBase,
  stTree
{$IFNDEF OS32}
  , WinCrt
{$ENDIF}
  ;

const
  Size = 1000;    {Number of elements added to tree}

var
  T : TStTree;
  S : TStTree;
  I : LongInt;
  P : TStTreeNode;
  R : Integer;
  PrevData : LongInt;
  Count : LongInt;

  function LongCompare(Key1, Key2 : Pointer) : Integer; far;
  begin
    Result := LongInt(Key1)-LongInt(Key2);
  end;

  function CheckNodes(Container : TStContainer; Node : TStNode;
                      OtherData : Pointer) : Boolean; far;
  begin
    if LongInt(Node.Data) < PrevData then begin
      WriteLn('Tree data out of order');
      Halt;
    end;
    PrevData := LongInt(Node.Data);
    inc(Count);
    Result := True;
  end;

  function CheckNodesDown(Container : TStContainer; Node : TStNode;
                          OtherData : Pointer) : Boolean; far;
  begin
    if LongInt(Node.Data) > PrevData then begin
      WriteLn('Tree data out of order');
      Halt;
    end;
    PrevData := LongInt(Node.Data);
    inc(Count);
    Result := True;
  end;

procedure StoreNode(Writer : TWriter; Data : pointer); far;
  begin
    Writer.WriteInteger(Longint(Data));
  end;

function LoadNode(Reader : TReader) : pointer; far;
  begin
    Result := pointer(Reader.ReadInteger);
  end;


{.$DEFINE UseSequential}
  function NextNumber : Integer;
  begin
{$IFDEF UseSequential}
    inc(RandSeed);
    Result := RandSeed;
{$ELSE}
    Result := Random(32767);
{$ENDIF}
  end;

begin
  T := TStTree.Create(TStTreeNode);
  T.compare := LongCompare;

  {Add elements to tree}
  Write('Adding elements ');
  RandSeed := 0;
  for I := 1 to Size do begin
    R := NextNumber;
    if T.Find(Pointer(R)) = nil then
      T.Insert(Pointer(R));
  end;
  WriteLn('(', T.Count, ' unique elements out of ', Size, ')');

  {Find all elements}
  Write('Finding all elements added ');
  RandSeed := 0;
  for I := 1 to Size do begin
    PrevData := NextNumber;
    P := T.Find(Pointer(PrevData));
    if (not Assigned(P)) or (LongInt(P.Data) <> PrevData) then begin
      WriteLn('Error finding data ', PrevData);
      Halt;
    end;
  end;
  WriteLn('(successful)');

  {Confirm operation of Iterate(Up)}
  Write('Confirming tree order ');
  PrevData := 0;
  Count := 0;
  T.Iterate(CheckNodes, True, nil);
  WriteLn('(', Count, ' elements visited)');

  {Confirm operation of trVisitDown}
  Write('Confirming tree order descending ');
  PrevData := 65535;
  Count := 0;
  T.Iterate(CheckNodesDown, False, nil);
  WriteLn('(', Count, ' elements visited)');

  {Scan elements in increasing order}
  Write('Scanning all elements ');
  Count := 0;
  PrevData := 0;
  P := T.First;
  while Assigned(P) do begin
    inc(Count);
    if LongInt(P.Data) < PrevData then begin
      WriteLn('Scan out of order');
      Halt;
    end;
    PrevData := LongInt(P.Data);
    P := T.Next(P);
  end;
  if Count <> T.Count then begin
    WriteLn('Scan did not access all elements');
    Halt;
  end;
  WriteLn('(', Count, ' elements scanned)');

  {Dump elements in decreasing order}
  Write('Scanning all elements backwards ');
  Count := 0;
  PrevData := $FFFF;
  P := T.Last;
  while Assigned(P) do begin
    inc(Count);
    if LongInt(P.Data) > PrevData then begin
      WriteLn('Scan out of order');
      Halt;
    end;
    PrevData := LongInt(P.Data);
    P := T.Prev(P);
  end;
  if Count <> T.Count then begin
    WriteLn('Scan did not access all elements');
    Halt;
  end;
  WriteLn('(', Count, ' elements scanned)');

  {Delete every other element}
  Write('Deleting alternate elements ');
  RandSeed := 0;
  for I := 1 to Size do begin
    PrevData := NextNumber;
    if Odd(I) then
      {Remove Data from tree and dispose of node}
      T.Delete(Pointer(PrevData));
  end;
  WriteLn('(', T.Count, ' elements remaining)');

  {Confirm tree order again}
  Write('Confirming order again ');
  PrevData := 0;
  Count := 0;
  T.Iterate(CheckNodes, True, nil);
  WriteLn('(', Count, ' elements visited)');

  {Split tree}
  S := T.Split(Pointer(50));

  {Confirm tree order again}
  Write('Confirming order in split tree ');
  PrevData := 0;
  Count := 0;
  S.Iterate(CheckNodes, True, nil);
  WriteLn('(', Count, ' elements visited)');

  {Join together again}
  T.Join(S, True);

  {Confirm tree order again}
  Write('Confirming order in rejoined tree ');
  PrevData := 0;
  Count := 0;
  T.Iterate(CheckNodes, True, nil);
  WriteLn('(', Count, ' elements visited)');

  {store tree to stream}
  Write('Storing tree to stream ');
  T.StoreData := StoreNode;
  T.StoreToFile('Test.stm');
  WriteLn;

  {Clear tree}
  Write('Clearing all elements ');
  T.Clear;
  WriteLn;
  T.Free;

  {Load tree from stream}
  Write('Loading tree from stream ');
  RegisterClasses([TStTree, TStTreeNode]);
  T := TStTree.Create(TStTreeNode);
  T.compare := LongCompare;
  T.LoadData := LoadNode;
  T.LoadFromFile('Test.stm');
  WriteLn;

  {Confirm tree order again}
  Write('Confirming order in loaded tree ');
  PrevData := 0;
  Count := 0;
  T.Iterate(CheckNodes, True, nil);
  WriteLn('(', Count, ' elements visited)');

  WriteLn('Passed all tests');

  T.Free;
  readln;
end.

