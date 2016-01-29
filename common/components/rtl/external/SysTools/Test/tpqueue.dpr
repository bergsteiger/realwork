{*********************************************************}
{*                    TPQUEUE.DPR 2.00                   *}
{*                      Test Program                     *}
{*        Copyright (c) TurboPower Software Co. 1998.    *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TPQueue;

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

{$I STDEFINE.INC}

uses
  SysUtils, Classes,
  stConst,
  stBase,
  stPQueue,
  stColl
{$IFNDEF Win32}
  , WinCrt
{$ENDIF}
  ;

const
  Size = 500;    {Initial capacity of pqueue}
  Delta = 100;   {Delta capacity when growth needed}
  Tests = 200;   {Number of elements added to pqueue}

type
  PInteger = ^longint;

var
  Q, Q2 : TStPQueue;
  I, R, min, max : longint;
  P : PInteger;
  RandList : array[1..Tests] of longint;
  RandCount : integer;
  C : TStCollection;

procedure InitRandList;
var
  i : integer;
begin
  for i := 1 to Tests do
    RandList[i] := i;
  RandCount := Tests;
end;

function NextRandList : longint;
var
  p : integer;
begin
  if RandCount = 0 then
    NextRandList := 0
  else begin
    p := random(RandCount)+1;
    NextRandList := RandList[p];
    if p <> RandCount then
      RandList[p] := RandList[RandCount];
    dec(RandCount);
  end;
end;

function LongCompare(Key1, Key2 : Pointer) : Integer; far;
begin
  Result := LongInt(Key1)-LongInt(Key2);
end;

function PIntCompare(Key1, Key2 : Pointer) : Integer; far;
begin
  Result := PInteger(Key1)^-PInteger(Key2)^;
end;

procedure PIntDispose(Data : Pointer); far;
begin
  {writeln('PIntDispose called for node data ', PInteger(Data)^);}
  dispose(PInteger(Data));
end;

procedure StoreNode(Writer : TWriter; Data : pointer); far;
begin
  Writer.WriteInteger(Longint(Data));
end;

function LoadNode(Reader : TReader) : pointer; far;
begin
  Result := pointer(Reader.ReadInteger);
end;

begin
  Randomize;

  Q := TStPQueue.Create(Size, Delta);
  Q.Compare := LongCompare;

  Writeln('Adding in increasing order, testing DeleteMin');
  for I := 1 to Tests do
    Q.Insert(Pointer(I));
  for I := 1 to Tests do begin
    R := Integer(Q.DeleteMin);
    if R <> I then
      Writeln('DeleteMin error! ', R, ' <> ', I);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in decreasing order, testing DeleteMax');
  for I := Tests downto 1 do begin
    Q.Insert(Pointer(I));
    if not Q.Test then
      Writeln('Insert Test error! ', I);
  end;
  for I := Tests downto 1 do begin
    R := Integer(Q.DeleteMax);
    if R <> I then
      Writeln('DeleteMax error! ', R, ' <> ', I);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in decreasing order, testing DeleteMin');
  for I := Tests downto 1 do
    Q.Insert(Pointer(I));
  for I := 1 to Tests do begin
    R := Integer(Q.DeleteMin);
    if R <> I then
      Writeln('DeleteMin error! ', R, ' <> ', I);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in random order, testing DeleteMax');
  InitRandList;
  for I := 1 to Tests do begin
    R := NextRandList;
    Q.Insert(Pointer(R));
    if not Q.Test then
      Writeln('Insert Test error! ', I);
  end;
  for I := Tests downto 1 do begin
    R := Integer(Q.DeleteMax);
    if R <> I then
      Writeln('DeleteMax error! ', R, ' <> ', I);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in random order, testing DeleteMin');
  InitRandList;
  for I := 1 to Tests do begin
    R := NextRandList;
    Q.Insert(Pointer(R));
  end;
  for I := 1 to Tests do begin
    R := Integer(Q.DeleteMin);
    if R <> I then
      Writeln('DeleteMax error! ', R, ' <> ', I);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in increasing order, testing both deletes');
  for I := 1 to Tests do
    Q.Insert(Pointer(I));
  max := Tests;
  min := 1;
  for I := 1 to Tests do begin
    if odd(I) then begin
      R := Integer(Q.DeleteMax);
      if R <> max then
        Writeln('DeleteMax error! ', R, ' <> ', max);
      dec(max);
    end else begin
      R := Integer(Q.DeleteMin);
      if R <> min then
        Writeln('DeleteMin error! ', R, ' <> ', min);
      inc(min);
    end;
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in decreasing order, testing both deletes');
  for I := Tests downto 1 do
    Q.Insert(Pointer(I));
  max := Tests;
  min := 1;
  for I := 1 to Tests do begin
    if odd(I) then begin
      R := Integer(Q.DeleteMax);
      if R <> max then
        Writeln('DeleteMax error! ', R, ' <> ', max);
      dec(max);
    end else begin
      R := Integer(Q.DeleteMin);
      if R <> min then
        Writeln('DeleteMin error! ', R, ' <> ', min);
      inc(min);
    end;
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in random order, testing both deletes');
  InitRandList;
  for I := 1 to Tests do begin
    R := NextRandList;
    Q.Insert(Pointer(R));
  end;
  max := Tests;
  min := 1;
  for I := 1 to Tests do begin
    if odd(I) then begin
      R := Integer(Q.DeleteMax);
      if R <> max then
        Writeln('DeleteMax error! ', R, ' <> ', max);
      dec(max);
    end else begin
      R := Integer(Q.DeleteMin);
      if R <> min then
        Writeln('DeleteMin error! ', R, ' <> ', min);
      inc(min);
    end;
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in increasing order with dups, testing DeleteMax');
  for I := 1 to Tests do begin
    Q.Insert(Pointer(I));
    if not Q.Test then
      Writeln('Insert Test error! ', I);
    Q.Insert(Pointer(I));
    if not Q.Test then
      Writeln('Insert Test error! ', I);
  end;
  for I := 2*Tests downto 1 do begin
    R := Integer(Q.DeleteMax);
    if R <> (I+1) div 2 then
      Writeln('DeleteMax error! ', R, ' <> ', (I+1) div 2);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding in increasing order with dups, testing DeleteMin');
  for I := 1 to Tests do begin
    Q.Insert(Pointer(I));
    Q.Insert(Pointer(I));
  end;
  for I := 1 to 2*Tests do begin
    R := Integer(Q.DeleteMin);
    if R <> (I+1) div 2 then
      Writeln('DeleteMin error! ', R, ' <> ', (I+1) div 2);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  {put random data in again}
  InitRandList;
  for I := 1 to Tests do begin
    R := NextRandList;
    Q.Insert(Pointer(R));
    if not Q.Test then
      Writeln('Insert Test error! ', I);
  end;

  {store pqueue to stream}
  Write('Storing pqueue to stream ');
  Q.StoreData := StoreNode;
  Q.StoreToFile('tpqueue.stm');
  WriteLn;

  {free pqueue}
  Q.Free;

  {load pqueue from stream}
  Write('Loading pqueue from stream ');
  RegisterClasses([TStPQueue]);
  Q := TStPQueue.Create(Size, Delta);
  Q.Compare := LongCompare;
  Q.LoadData := LoadNode;
  Q.LoadFromFile('tpqueue.stm');
  WriteLn;

  {test once more}
  Writeln('Testing DeleteMax');
  for I := Tests downto 1 do begin
    R := Integer(Q.DeleteMax);
    if R <> I then
      Writeln('DeleteMax error! ', R, ' <> ', I);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Q.Free;

  Writeln('Creating two queues and joining');
  Q := TStPQueue.Create(Size, Delta);
  Q.Compare := LongCompare;
  Q2 := TStPQueue.Create(Size, Delta);
  Q2.Compare := LongCompare;
  InitRandList;
  for I := 1 to Tests do begin
    R := NextRandList;
    if odd(I) then begin
      Q.Insert(Pointer(R));
      if not Q.Test then
        Writeln('Insert Q Test error! ', I);
    end else begin
      Q2.Insert(Pointer(R));
      if not Q2.Test then
        Writeln('Insert Q2 Test error! ', I);
    end;
  end;
  Q.Join(Q2);
  for I := Tests downto 1 do begin
    R := Integer(Q.DeleteMax);
    if R <> I then
      Writeln('DeleteMax error! ', R, ' <> ', I);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;
  Q.Free;

  {test queue with allocated pointers}
  Q := TStPQueue.Create(Size, Delta);
  Q.Compare := PIntCompare;
  Q.DisposeData := PIntDispose;

  Writeln('Adding pointers in increasing order, testing DeleteMax');
  for I := 1 to Tests do begin
    new(P);
    P^ := I;
    Q.Insert(P);
    if not Q.Test then
      Writeln('Insert Test error! ', I);
  end;
  for I := Tests downto 1 do begin
    P := Q.DeleteMax;
    if P^ <> I then
      Writeln('DeleteMax error! ', P^, ' <> ', I);
    Q.DisposeData(P);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;

  Writeln('Adding pointers in increasing order, testing Clear');
  for I := 1 to Tests do begin
    new(P);
    P^ := I;
    Q.Insert(P);
    if not Q.Test then
      Writeln('Insert Test error! ', I);
  end;
  writeln('Count is ', Q.Count);
  Q.Clear;
  writeln('Count is ', Q.Count);
  Q.Free;

  {test the Assign method}
  Writeln('Adding elements to TStCollection');
  C := TStCollection.Create(Size);
  for I := 1 to Tests do
    C.Insert(Pointer(I));
  Q := TStPQueue.Create(Size, Delta);
  Q.Compare := LongCompare;
  Writeln('Assigning TStCollection to TStPQueue');
  Q.Assign(C);
  C.Free;
  Writeln('Testing assigned elements');
  for I := Tests downto 1 do begin
    R := Integer(Q.DeleteMax);
    if R <> I then
      Writeln('DeleteMax error! ', R, ' <> ', I);
    if not Q.Test then
      Writeln('Test error! ', I);
  end;
  Q.Free;

  writeln('Press <Enter> to continue');
  readln;
end.
