{*********************************************************}
{*                    TLARR.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TLArr;

{$I STDEFINE.INC}

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

uses
  sysutils, classes,
  stbase,
  stlarr
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  elements = 1000;
var
  a : TStLarray;
  i : longint;
  l : longint;

  GlobalElement : longint;

procedure StoreElement(Writer : TWriter; Data : pointer); far;
  begin
    Writer.WriteInteger(Longint(Data^));
  end;

function LoadElement(Reader : TReader) : pointer; far;
  begin
    GlobalElement := Reader.ReadInteger;
    Result := @GlobalElement;
  end;

begin
  a := TStlarray.create(elements, sizeof(longint));

  l := elements;
  a.fill(l);
  for i := 0 to elements-1 do begin
    a.get(i, l);
    if l <> elements then begin
      writeln('cleara error');
      halt;
    end;
  end;

  for i := 0 to elements-1 do begin
    l := i;
    a.put(i, l);
  end;

  for i := 0 to elements-1 do begin
    a.get(i, l);
    if i <> l then begin
      writeln('get error');
      halt;
    end;
  end;

  write('storing array (', a.count, ' elements) to stream (direct)');
  a.ElementsStorable := true;
  a.StoreToFile('Test.stm');
  a.destroy;
  writeln;

  write('loading array from stream');
  RegisterClasses([TStLArray]);
  a := TStlarray.create(elements, sizeof(longint));
  a.LoadFromFile('Test.stm');
  writeln(' (', a.count, ' elements)');

  for i := 0 to elements-1 do begin
    a.get(i, l);
    if i <> l then begin
      writeln('get error');
      halt;
    end;
  end;

  write('storing array (', a.count, ' elements) to stream (indirect)');
  a.ElementsStorable := false;
  a.StoreData := StoreElement;
  a.StoreToFile('Test2.stm');
  a.destroy;
  writeln;

  write('loading array from stream');
  RegisterClasses([TStLArray]);
  a := TStlarray.create(elements, sizeof(longint));
  a.LoadData := LoadElement;
  a.LoadFromFile('Test2.stm');
  writeln(' (', a.count, ' elements)');

  for i := 0 to elements-1 do begin
    a.get(i, l);
    if i <> l then begin
      writeln('get error');
      halt;
    end;
  end;

  a.free;
  WriteLn('Done');
  readln;
end.
