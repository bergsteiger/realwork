{*********************************************************}
{*                    TDICT.DPR 2.00                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TDict;

{$I STDEFINE.INC}

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

uses
  sysutils, classes, stbase, stdict
{$IFNDEF Win32}
  , wincrt
{$ENDIF}
  ;

procedure StoreNode(Writer : TWriter; Data : pointer); far;
  begin
    Writer.WriteInteger(LongInt(Data));
  end;

function LoadNode(Reader : TReader) : pointer; far;
  var
    L : longint;
  begin
    L := Reader.ReadInteger;
    Result := pointer(L);
  end;

const
  Nodes = 1000;
var
  dict, dict2 : TStdictionary;
  strlist : TStringList;
  i, j : longint;
  Name : string;

begin
  WriteLn('Creating dictionary, adding ', Nodes, ' nodes...');
  dict := TStDictionary.Create(Nodes);
  dict.Hash := AnsiELFHashText;

  for i := 1 to Nodes do
    dict.Add(inttostr(i), pointer(i));

(*
  dict.Delete(inttostr(1));
  dict.Delete(inttostr(Nodes div 2));
  dict.Delete(inttostr(Nodes));
*)

  WriteLn('Testing empty string existence...');
  if dict.Exists('', pointer(j)) then
    writeln('oops, found empty string');

  WriteLn('Testing node existence...');
  for i := 1 to Nodes do
    if not dict.Exists(inttostr(i), pointer(j)) then
      writeln('error finding ', i)
    else if i <> j then
      writeln('error in data ', i, ' ', j);

  WriteLn('Searching for nodes...');
  for i := 1 to Nodes do
    if not dict.Find(pointer(i), Name) then
      writeln('error finding ', i)
    else if Name <> inttostr(i) then
      writeln('error in data ', i, ' ', Name);

  dict.StoreData := StoreNode;
  dict.StoreToFile('test.stm');
  dict.destroy;

  RegisterClasses([TStDictionary, TStDictNode]);
  dict := TStDictionary.Create(Nodes);
  dict.LoadData := LoadNode;
  dict.LoadFromFile('Test.stm');

  WriteLn('Testing node existence after loading...');
  for i := 1 to Nodes do
    if not dict.Exists(inttostr(i), pointer(j)) then
      writeln('error finding ', i)
    else if i <> j then
      writeln('error in data ', i, ' ', j);

  WriteLn('Testing Assign method...');
  WriteLn('Creating another dictionary, adding ', Nodes, ' nodes...');
  dict2 := TStDictionary.Create(Nodes);
  for i := Nodes+1 to Nodes+Nodes do
    dict2.Add(inttostr(i), pointer(i));
  WriteLn('Assign new dictionary to original one');
  dict.Assign(dict2);
  WriteLn('Testing original node non-existence after assignment...');
  for i := 1 to Nodes do
    if dict.Exists(inttostr(i), pointer(j)) then
      writeln('error: found ', i);
  WriteLn('Testing new node existence after assignment...');
  for i := Nodes+1 to Nodes+Nodes do
    if not dict.Exists(inttostr(i), pointer(j)) then
      writeln('error finding ', i)
    else if i <> j then
      writeln('error in data ', i, ' ', j);
  dict2.free;
  WriteLn('Creating a string list, adding ', Nodes, ' items...');
  strlist := TStringList.Create;
  for i := Nodes+Nodes+1 to Nodes+Nodes+Nodes do
    strlist.AddObject(inttostr(i), TObject(pointer(i)));
  WriteLn('Assign stringlist to  dictionary');
  dict.Assign(strlist);
  WriteLn('Testing original node non-existence after assignment...');
  for i := 1 to Nodes+Nodes do
    if dict.Exists(inttostr(i), pointer(j)) then
      writeln('error: found ', i);
  WriteLn('Testing new node existence after assignment...');
  for i := Nodes+Nodes+1 to Nodes+Nodes+Nodes do
    if not dict.Exists(inttostr(i), pointer(j)) then
      writeln('error finding ', i)
    else if i <> j then
      writeln('error in data ', i, ' ', j);
  strlist.free;

  dict.free;
  WriteLn('Done');
  readln;
end.

