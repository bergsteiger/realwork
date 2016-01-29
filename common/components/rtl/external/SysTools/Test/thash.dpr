{*********************************************************}
{*                    THASH.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program THash;

{$I STDEFINE.INC}

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

uses
  sysutils, classes, stbase, sthash, stdict
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  Nodes = 1000;
type
  TNodeVal = string[20];
  TNodeHashTable = class (TStHashTable)
  protected
    function nhtGetNode(V : TNodeVal) : Pointer;
    procedure nhtSetNode(V : TNodeVal; const Data : Pointer);
  public
    constructor CreateTable(AHashSize : Integer); virtual;
    function NodeExists(const V : TNodeVal; var Data : Pointer) : Boolean;
    procedure NodeAdd(const V : TNodeVal; Data : Pointer);
    procedure NodeDelete(const V : TNodeVal);
    procedure NodeUpdate(const V : TNodeVal; Data : Pointer);
    function NodeFind(Data : Pointer; var V : TNodeVal) : Boolean;
    procedure NodeRemoved(const V; Data : Pointer); override;
    property Items[V : TNodeVal] : Pointer
      read nhtGetNode
      write nhtSetNode;
      default;
  end;

var
  ht : TNodeHashTable;
  i, j : longint;
  Name : TNodeVal;

constructor TNodeHashTable.CreateTable(AHashSize : Integer);
begin
  inherited Create(sizeof(TNodeVal), AHashSize);
end;

function TNodeHashTable.NodeExists(const V : TNodeVal; var Data : Pointer) : Boolean;
begin
  Result := Exists(V, Data);
end;

procedure TNodeHashTable.NodeAdd(const V : TNodeVal; Data : Pointer);
begin
  Add(V, Data);
end;

procedure TNodeHashTable.NodeDelete(const V : TNodeVal);
begin
  Delete(V);
end;

procedure TNodeHashTable.NodeUpdate(const V : TNodeVal; Data : Pointer);
begin
  Update(V, Data);
end;

function TNodeHashTable.NodeFind(Data : Pointer; var V : TNodeVal) : Boolean;
begin
  Result := Find(Data, V);
end;

procedure TNodeHashTable.NodeRemoved(const V; Data : Pointer);
begin
  writeln('removed node ', TNodeVal(V), ' with data ', longint(Data));
end;

function TNodeHashTable.nhtGetNode(V : TNodeVal) : Pointer;
begin
  if not NodeExists(V, Result) then
    Result := nil;
end;

procedure TNodeHashTable.nhtSetNode(V : TNodeVal; const Data : Pointer);
var
  J : Pointer;
begin
  if NodeExists(V, J) then
    NodeUpdate(V, Data)
  else
    NodeAdd(V, Data);
end;

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

function NameHash(const V; Size : Integer) : Integer; far;
begin
  Result := StDict.AnsiHashText(TNodeVal(V), Size);
end;

function NameEqual(const El1, El2) : Integer; far;
begin
  Result := SysUtils.AnsiCompareText(TNodeVal(El1), TNodeVal(El2));
end;

begin
  WriteLn('Creating hash table, adding ', Nodes, ' nodes...');
  ht := TNodeHashTable.CreateTable(199);
  ht.Hash := NameHash;
  ht.Equal := NameEqual;

(* uncommenting this causes the hash table to throw out the oldest nodes
   whenever the number of nodes would exceed MaxNodes
  ht.MaxNodes := Nodes-2;
*)

  for i := 1 to Nodes do
    ht[inttostr(i)] := pointer(i);
(*
    ht.NodeAdd(inttostr(i), pointer(i));
*)

(*
  ht.NodeDelete(inttostr(1));
  ht.NodeDelete(inttostr(Nodes div 2));
  ht.NodeDelete(inttostr(Nodes));
*)

  WriteLn('Testing node existence...');
  for i := 1 to Nodes do begin
    pointer(j) := ht[inttostr(i)];
    if j = 0 then
      writeln('error finding ', i)
    else if i <> j then
      writeln('error in data ', i, ' ', j);
  end;

  WriteLn('Searching for nodes...');
  for i := 1 to Nodes do
    if not ht.NodeFind(pointer(i), Name) then
      writeln('error finding ', i)
    else if Name <> inttostr(i) then
      writeln('error in data ', i, ' ', Name);

  ht.StoreData := StoreNode;
  ht.StoreToFile('test.stm');
  ht.destroy;

  RegisterClasses([TNodeHashTable, TStHashNode]);
  ht := TNodeHashTable.CreateTable(Nodes);
  ht.Hash := NameHash;
  ht.Equal := NameEqual;
  ht.LoadData := LoadNode;
  ht.LoadFromFile('Test.stm');

  WriteLn('Testing node existence after loading...');
  for i := 1 to Nodes do
    if not ht.NodeExists(inttostr(i), pointer(j)) then
      writeln('error finding ', i)
    else if i <> j then
      writeln('error in data ', i, ' ', j);

  ht.free;
  WriteLn('Done');
  readln;
end.

