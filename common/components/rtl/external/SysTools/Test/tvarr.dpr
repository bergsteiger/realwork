{*********************************************************}
{*                    TVARR.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$R-,S-}
program TVArr;

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

{$I STDEFINE.INC}

uses
  sysutils, classes,
  stbase,
  stvarr
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  rows = 100;
  cols = 100;
  cacherows = 19;
  datafile = 'test.arr';

{create an easily-accessible array of any type}
type
  TElementType = LongInt; {tried LongInt, Double, Extended}

  TElementArray = class(TStVMatrix)
  protected
    function GetElement(Row, Col : Cardinal) : TElementType;
    procedure SetElement(Row, Col : Cardinal; const Value : TElementType);
  public
    constructor CreateCache(Rows, Cols : Cardinal; CacheRows : Integer;
                       DataFile : string);
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

constructor TElementArray.CreateCache(Rows, Cols : Cardinal; CacheRows : Integer;
                                 DataFile : string);
begin
  inherited Create(Rows, Cols, SizeOf(TElementType),
                   CacheRows, DataFile, fmOpenReadWrite);
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
  r, c : longint;
  rowarr : array[0..cols-1] of TElementType;

begin
  writeln('starting');

  a := TElementArray.createcache(rows, cols, cacherows, datafile);

  {set the last element and test}
  a[rows-1, cols-1] := 1;
  if a[rows-1, cols-1] <> 1 then begin
    writeln('put error');
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

  {sort and test}
  a.SortRows(1, TElementReverseCompare);
  for r :=  0 to rows do
    if a[r, 1] <> rows-r-1 then begin
      writeln('sort error');
      halt;
    end;

  {shrink to 2 rows with 2 cache rows}
  a.rows := 2;
  a.cacherows := 2;

  {set all elements to unique values and test}
  for r := 0 to 1 do
    for c := 0 to cols-1 do
      a[r, c] := longint(r)+c;
  for r := 0 to 1 do
    for c := 0 to cols-1 do
      if a[r, c] <> longint(r)+c then begin
        writeln('resize error');
        halt;
      end;

  a.free;
  WriteLn('Done');
  readln;
end.
