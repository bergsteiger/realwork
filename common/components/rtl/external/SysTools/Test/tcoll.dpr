{*********************************************************}
{*                    TCOLL.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TColl;

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
  Nodes = 5000;
  PageNodes = 1000;
var
  coll : TStcollection;
  i, l : longint;
  t0, t1, t2 : longint;

{$IFDEF VirtualPascal}
function gettickcount : longint;
begin
  gettickcount := VPUtils.GetTimemSec;
end;
{$ENDIF}

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
  coll := TStcollection.create(pagenodes);

  writeln('calibrating loop time');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do
    l := i;
  t2 := gettickcount;
  t0 := t2-t1;

  write('adding nodes in order');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do
    coll.insert(pointer(i));
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('testing contents');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do begin
    l := longint(coll.at(i));
    if i <> l then begin
      writeln(' error!');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('testing contents backwards');
  t1 := gettickcount;
  for I := Nodes-1 downto 0 do begin
    l := longint(coll.at(i));
    if i <> l then begin
      writeln(' error!');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  PackAndCheck;

  coll.clear;

  write('inserting nodes in reverse order');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do
    coll.atinsert(0, pointer(i));
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('testing contents');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do begin
    l := longint(coll.at(i));
    if Nodes-1-i <> l then begin
      writeln(' error!');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('testing contents backwards');
  t1 := gettickcount;
  for I := Nodes-1 downto 0 do begin
    l := longint(coll.at(i));
    if Nodes-1-i <> l then begin
      writeln(' error!');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('finding indexof all data');
  t1 := gettickcount;
  for i := 0 to Nodes-1 do begin
    l := coll.indexof(pointer(i));
    if l <> Nodes-1-i then begin
      writeln(' error!');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  PackAndCheck;

  write('atput nodes in order');
  t1 := gettickcount;
  for i := 0 to Nodes-1 do
    coll.atput(i, pointer(i));
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('testing contents');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do begin
    l := longint(coll.at(i));
    if i <> l then begin
      writeln(' error!');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('deleting odd nodes');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do
    if Odd(I) then
      coll.Delete(pointer(I));
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  PackAndCheck;

  write('deleting every ninth node');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do
    if I mod 9 = 0 then
      coll.Delete(pointer(I));
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  PackAndCheck;

  write('clearing collection');
  t1 := gettickcount;
  coll.clear;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  PackAndCheck;

  write('adding sparse elements');
  t1 := gettickcount;
  for I := 0 to Nodes-1 do
    coll.atinsert(20*I, pointer(I));
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('testing sparse elements');
  t1 := gettickcount;
  for I := 0 to 20*(Nodes-1) do begin
    l := longint(coll.at(i));
    if I mod 20 = 0 then begin
      if i <> 20*l then begin
        writeln(' error!');
        halt;
      end;
    end else if l <> 0 then begin
      writeln(' error!');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  write('testing sparse elements backwards');
  t1 := gettickcount;
  for I := 20*(Nodes-1) downto 0 do begin
    l := longint(coll.at(i));
    if I mod 20 = 0 then begin
      if i <> 20*l then begin
        writeln(' error!');
        halt;
      end;
    end else if l <> 0 then begin
      writeln(' error!');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  PackAndCheck;

  write('storing collection (', coll.count, ' elements) to stream');
  coll.StoreData := StoreNode;
  coll.StoreToFile('Test.stm');
  coll.destroy;
  writeln;

  write('loading collection from stream');
  RegisterClasses([TStCollection]);
  coll := TStcollection.create(pagenodes div 10);
  coll.LoadData := LoadNode;
  coll.LoadFromFile('Test.stm');
  writeln(' (', coll.count, ' elements)');

  PackAndCheck;

  write('testing sparse elements in loaded collection');
  t1 := gettickcount;
  for I := 0 to 20*(Nodes-1) do begin
    l := longint(coll.at(i));
    if I mod 20 = 0 then begin
      if i <> 20*l then begin
        writeln(' error! (i <> 20*l)');
        halt;
      end;
    end else if l <> 0 then begin
      writeln(' error! (l <> 0)');
      halt;
    end;
  end;
  t2 := gettickcount;
  writeln(' (', t2-t1-t0, 'ms)');

  coll.free;
  WriteLn('Done');
  readln;
end.
