{*********************************************************}
{*                   TCOLL2.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

{***WARNING*** if running this app from within the IDE, turn off the
               Break on Exception flag}

program TColl2;

{$I STDEFINE.INC}

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

uses
  sysutils, classes,
{$IFDEF VirtualPascal}
  VPUtils,
{$ELSE}
  winprocs,
{$ENDIF}
  stbase, stlist, stcoll
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  Nodes = 1000;
  PageNodes = 64 {2000};
  InitRandSeed = Nodes;
var
  coll : TStsortedcollection;
  i, l, prevl, dups : longint;
  t0, t1, t2 : longint;
  S : TFileStream;

{$IFDEF VirtualPascal}
function gettickcount : longint;
begin
  gettickcount := VPUtils.GetTimemSec;
end;
{$ENDIF}

function LongCompare(Data1, Data2 : Pointer) : Integer; far;
begin
  Result := LongInt(Data1)-LongInt(Data2);
end;

procedure PackAndCheck;
begin
  write(coll.Efficiency, '%, pack');
  t1 := gettickcount;
  coll.pack;
  t2 := gettickcount;
  write(' (', t2-t1, 'ms), ');
  writeln(coll.Efficiency, '%');
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
  coll := TStsortedcollection.create(pagenodes);
  coll.Compare := LongCompare;
  {coll.Duplicates := True;}

  writeln('calibrating loop time');
  randseed := initrandseed;
  dups := 0;
  l := 0;
  t1 := gettickcount;
  for I := 0 to Nodes-1 do
    try
      l := random(Nodes);
    except
      inc(dups);
      {writeln('duplicate node ', l);}
    end;
  t2 := gettickcount;
  if l = dups then {prevent hints in Delphi 2}
    ;
  t0 := t2-t1;

  write('adding random nodes');
  randseed := initrandseed;
  dups := 0;
  t1 := gettickcount;
  for I := 0 to Nodes-1 do
    try
      l := random(Nodes);
      if (l <> 0) then
        coll.insert(pointer(l));
    except
      inc(dups);
      {writeln('duplicate node ', l);}
    end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  writeln('accepted elements ', coll.count);
  writeln('rejected duplicates ', dups);

  writeln('calibrating loop time again');
  prevl := 0;
  t1 := gettickcount;
  for I := 0 to coll.count-1 do begin
    l := i;
    prevl := l;
  end;
  t2 := gettickcount;
  if prevl = l then {prevent hints in Delphi 2}
    ;
  t0 := t2-t1;

  write('testing order');
  prevl := 0;
  t1 := gettickcount;
  for I := 0 to coll.count-1 do begin
    l := longint(coll.at(i));
    if l < prevl then begin
      writeln('error');
      halt;
    end;
    prevl := l;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  PackAndCheck;

  write('testing order');
  prevl := 0;
  t1 := gettickcount;
  for I := 0 to coll.count-1 do begin
    l := longint(coll.at(i));
    if l < prevl then begin
      writeln('error');
      halt;
    end;
    prevl := l;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('storing collection (', coll.count, ' elements) to stream');
  coll.StoreData := StoreNode;
  S := TFileStream.Create('Test.stm', fmCreate);
  try
    coll.StoreToStream(S);
  finally
    S.Free;
  end;
  coll.destroy;
  writeln;

  write('loading collection from stream');
  RegisterClasses([TStSortedCollection]);
  coll := TStSortedcollection.create(pagenodes div 10);
  coll.Compare := LongCompare;
  coll.LoadData := LoadNode;
  S := TFileStream.Create('Test.stm', fmOpenRead);
  try
    coll.LoadFromStream(S);
  finally
    S.Free;
  end;
  writeln(' (', coll.count, ' elements)');

  write('testing order of loaded collection');
  prevl := 0;
  t1 := gettickcount;
  for I := 0 to coll.count-1 do begin
    l := longint(coll.at(i));
    if l < prevl then begin
      writeln('error');
      halt;
    end;
    prevl := l;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  coll.free;

  Writeln('Done');
  readln;
end.
