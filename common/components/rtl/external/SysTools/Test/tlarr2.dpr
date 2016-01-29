{*********************************************************}
{*                    TLARR2.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TLArr2;

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

{$I STDEFINE.INC}

uses
  sysutils,
  stbase,
  stlarr
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  elements = 100000;

{create an easily-accessible array of any type}
type
  TElementType = LongInt; {tried LongInt, Double, Extended}

  TElementArray = class(TStLArray)
  protected
    function GetElement(Row : LongInt) : TElementType;
    procedure SetElement(Row : LongInt; const Value : TElementType);
  public
    constructor Create(Elements : LongInt);
    procedure Fill(const Value : TElementType);
    property Items[Row : LongInt] : TElementType
      read GetElement
      write SetElement;
      default;
  end;

function TElementArray.GetElement(Row : LongInt) : TElementType;
begin
  Get(Row, Result);
end;

procedure TElementArray.SetElement(Row : LongInt; const Value : TElementType);
begin
  Put(Row, Value);
end;

constructor TElementArray.Create(Elements : LongInt);
begin
  inherited Create(Elements, SizeOf(TElementType));
end;

procedure TElementArray.Fill(const Value : TElementType);
begin
  inherited Fill(Value);
end;

function TElementReverseCompare(const El1, El2) : Integer; far;
  {-Sort in reverse order}
begin
  if TElementType(El1) > TElementType(El2) then
    Result := -1
  else if TElementType(El1) = TElementType(El2) then
    Result := 0
  else
    Result := +1;
end;

var
  a : TElementArray;
  i : longint;
begin
  writeln('testing...');
  a := TElementArray.create(elements);

  {check the default clear operation}
  for i := 0 to elements-1 do
    if a[i] <> 0 then begin
      writeln('clear error');
      halt;
    end;

  {test filling with a non-zero element}
  a.Fill(elements);
  for i := 0 to elements-1 do
    if a[i] <> elements then begin
      writeln('fill error');
      halt;
    end;

  {set all elements to unique values and test}
  for i := 0 to elements-1 do
    a[i] := i;
  for i := 0 to elements-1 do
    if a[i] <> i then begin
      writeln('put or get error');
      halt;
    end;

  {resize the array and test the new element}
  a.count := elements+1;
  if a[elements] <> 0 then begin
    writeln('resize error');
    halt;
  end;

  {make sure all elements still have the correct data}
  a[elements] := elements;
  for i := 0 to elements do
    if a[i] <> i then begin
      writeln('resize or get error');
      halt;
    end;

  {sort the array in reverse order}
  a.sort(TElementReverseCompare);
  for i := 0 to elements do
    if a[i] <> elements-i then begin
      writeln('sort error');
      writeln('a[i] = ', a[i]);
      writeln('elements-i = ', elements-i);
      halt;
    end;

  a.free;
  Writeln('Done');
  readln;
end.
