{*********************************************************}
{*                    TLARR3.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TLArr3;

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

{$I STDEFINE.INC}

uses
  sysutils, classes,
  stbase,
  stlarr
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  rows = 100;
  cols = 100;

{create an easily-accessible array of any type}
type
  TElementType = LongInt; {tried LongInt, Double, Extended}
  {note if this is changed, LoadElement and StoreElement must also be changed}

  TElementArray = class(TStLMatrix)
  protected
    function GetElement(Row, Col : Cardinal) : TElementType;
    procedure SetElement(Row, Col : Cardinal; const Value : TElementType);
  public
    constructor Create(Rows, Cols : Cardinal);
    procedure Fill(const Value : TElementType);
    property Items[Row, Col : Cardinal] : TElementType
      read GetElement
      write SetElement;
      default;
  end;

function TElementArray.GetElement(Row, Col : Cardinal) : TElementType;
begin
  Get(Row, Col, Result);
end;

procedure TElementArray.SetElement(Row, Col : Cardinal; const Value : TElementType);
begin
  Put(Row, Col, Value);
end;

constructor TElementArray.Create(Rows, Cols : Cardinal);
begin
  inherited Create(Rows, Cols, SizeOf(TElementType));
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
  GlobalElement : TElementType;

procedure StoreElement(Writer : TWriter; Data : pointer); far;
  begin
    Writer.WriteInteger(Longint(Data^));
  end;

function LoadElement(Reader : TReader) : pointer; far;
  begin
    GlobalElement := Reader.ReadInteger;
    Result := @GlobalElement;
  end;

var
  a : TElementArray;
  r, c : longint;
  rowarr : array[0..cols-1] of TElementType;

begin
  a := TElementArray.create(rows, cols);

  {check the default clear operation}
  for r := 0 to rows-1 do
    for c := 0 to cols-1 do
      if a[r, c] <> 0 then begin
        writeln('clear error');
        halt;
      end;

  {test filling with a non-zero element}
  a.Fill(rows);
  for r := 0 to rows-1 do
    for c := 0 to cols-1 do
      if a[r, c] <> rows then begin
        writeln('fill error');
        halt;
      end;

  {set all elements to unique values and test}
  for r := 0 to rows-1 do
    for c := 0 to cols-1 do
      a[r, c] := longint(r)*c-c;
  for r := 0 to rows-1 do
    for c := 0 to cols-1 do
      if a[r, c] <> longint(r)*c-c then begin
        writeln('put or get error');
        halt;
      end;

  {read an entire row and test}
  a.getrow(2, rowarr);
  for c := 0 to cols-1 do
    if rowarr[c] <> longint(2)*c-c then begin
      writeln('getrow error');
      halt;
    end;

  {set an entire row and test}
  for c := 0 to cols-1 do
    rowarr[c] := c*c;
  a.putrow(2, rowarr);
  a.getrow(2, rowarr);
  for c := 0 to cols-1 do
    if rowarr[c] <> c*c then begin
      writeln('setrow error');
      halt;
    end;

  {resize rows}
  a.rows := rows+1;

  {check the default clear operation}
  for c := 0 to cols-1 do
    if a[rows, c] <> 0 then begin
      writeln('resize clear error');
      halt;
    end;

  {set all elements to unique values and test}
  for r := 0 to rows do
    for c := 0 to cols-1 do
      a[r, c] := longint(r)*c-c;
  for r := 0 to rows do
    for c := 0 to cols-1 do
      if a[r, c] <> longint(r)*c-c then begin
        writeln('setrows error');
        halt;
      end;

  {resize columns}
  a.cols := cols+1;

  {check the default clear operation}
  for r := 0 to rows do
    if a[r, cols] <> 0 then begin
      writeln('resize clear error');
      halt;
    end;

  {set all elements to unique values and test}
  for r := 0 to rows do
    for c := 0 to cols do
      a[r, c] := longint(r)*c-c;
  for r := 0 to rows do
    for c := 0 to cols do
      if a[r, c] <> longint(r)*c-c then begin
        writeln('setcols error');
        halt;
      end;


  write('storing matrix to stream (direct)');
  a.ElementsStorable := true;
  a.StoreToFile('Test.stm');
  a.destroy;
  writeln;

  write('loading matrix from stream');
  RegisterClasses([TElementArray]);
  a := TElementArray.create(1, 1);
  a.LoadFromFile('Test.stm');
  writeln;

  for r := 0 to rows do
    for c := 0 to cols do
      if a[r, c] <> longint(r)*c-c then begin
        writeln('store/load (direct) error');
        halt;
      end;


  write('storing matrix to stream (indirect)');
  a.ElementsStorable := false;
  a.StoreData := StoreElement;
  a.StoreToFile('Test.stm');
  a.destroy;
  writeln;

  write('loading matrix from stream');
  RegisterClasses([TElementArray]);
  a := TElementArray.create(1, 1);
  a.LoadData := LoadElement;
  a.LoadFromFile('Test.stm');
  writeln;

  for r := 0 to rows do
    for c := 0 to cols do
      if a[r, c] <> longint(r)*c-c then begin
        writeln('store/load (indirect) error');
        halt;
      end;


  a.SortRows(1, TElementReverseCompare);
  for r :=  0 to rows do
    if a[r, 1] <> rows-r-1 then begin
      writeln('sort error');
      halt;
    end;

  a.free;
  Writeln('Done');
  readln;
end.
