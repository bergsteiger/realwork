{*********************************************************}
{*                    TSORT.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$R-,S-,X+,I+}
program TSort;

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

{$I STDEFINE.INC}

uses
  stbase,
  stsort,
  sysutils,
{$IFDEF OS32}
 {$IFDEF WIN32}
  windows;
 {$ELSE}
  VPUtils;
 {$ENDIF}
{$ELSE}
  wintypes,
  winprocs,
  wincrt;
{$ENDIF}

type
  TRec = record
    Key : LongInt;
    Data : array[1..99] of byte;
  end;
const
  Tests = 30;
  Heap = 1000000;
  RecLen = SizeOf(TRec);
  TestCounts : array[1..Tests] of LongInt =  (
    00001, 00010, 00100, 00200, 00300, 00400, 00500, 00600, 00700, 00800,
    00900, 01000, 02000, 03000, 04000, 05000, 06000, 07000, 08000, 09000,
    10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000
  );

var
  S : TStSorter;
  V : TRec;
  I, Key, LastKey : LongInt;
  F : TextFile;
  Info : TMergeInfo;
  Test : Integer;
  GetCount, Count, T1, T2 : LongInt;

{$IFDEF VirtualPascal}
function gettickcount : longint;
begin
  gettickcount := VPUtils.GetTimemSec;
end;
{$ENDIF}

function LongIntLess(const El1, El2) : Integer; far;
begin
  Result := TRec(El1).Key-TRec(El2).Key;
  {raise EAbort.Create('user abort');}
end;

begin
  assign(F, 'tsort.out');
  rewrite(F);

  try
    writeln(F, 'RecLen:', RecLen);
    writeln(F, ' Count  MaxHeap Status  Files Handles Phases MaxDisk ActHeap OptHeap MinH  Ticks');
               {cccccc  hhhhhhh  sssss  fffff  hhhhh  ppppp  ddddddd aaaaaaa ooooooo mmmm tttttt}
    for Test := 1 to Tests do begin
      Count := TestCounts[Test];
      writeln(Count);
      Info := MergeInfo(Heap, RecLen, Count);
      write(F,
            Count:6, '  ',
            Heap:7, '  ',
            Info.SortStatus:5, '  ',
            Info.MergeFiles:5, '  ',
            Info.MergeHandles:5, '  ',
            Info.MergePhases:5, '  ',
            Info.MaxDiskSpace:7, ' ',
            Info.HeapUsed:7, ' ',
            OptimumHeapToUse(RecLen, Count):7, ' ',
            MinimumHeapToUse(RecLen):4, ' ');

      if Info.SortStatus = 0 then begin
        S := TStSorter.Create(Heap, RecLen);
        S.Compare := LongIntLess;

        T1 := GetTickCount;
        GetCount := 0;
        LastKey := 0;
        try
          for I := 1 to Count do begin
            Key := Random(10000);
            V.Key := Key;
            S.Put(V);
          end;

          while S.Get(V) do begin
            inc(GetCount);
            if V.Key < LastKey then
              writeln(F, ^M^J'sort error! ', LastKey, ' ', V.Key);
            LastKey := V.Key;
          end;
        except
          on E: EAbort do
            writeln('user abort');
        end;
        T2 := GetTickCount;
        if GetCount <> Count then
          writeln(F, ^M^J'count error! ', GetCount, ' ', Count);

        S.Free;
        writeln(F, (T2-T1):6);
      end;
    end;
  finally
    close(F);
  end;
  writeln('Done');
  readln;
end.
