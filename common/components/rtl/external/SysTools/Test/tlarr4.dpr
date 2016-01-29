{*********************************************************}
{*                    TLARR4.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TLArr4;
  {-Demonstrate a three-dimensional array}

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
  xmag = 10;
  ymag = 20;
  zmag = 70;

{create an easily-accessible 3D array of any type}
type
  TElementType = LongInt; {tried LongInt, Double, Extended}

  T3DArray = class(TStLArray)
  protected
    function GetElement(X, Y, Z : Cardinal) : TElementType;
    procedure SetElement(X, Y, Z : Cardinal; const Value : TElementType);
  public
    constructor Create(XMag, YMag, ZMag : Cardinal);
    destructor Destroy; override;
    procedure Fill(const Value : TElementType);
    property Items[X, Y, Z : Cardinal] : TElementType
      read GetElement
      write SetElement;
      default;
  end;

function T3DArray.GetElement(X, Y, Z : Cardinal) : TElementType;
var
  A : TStLMatrix;
begin
  Get(X, A);
  A.Get(Y, Z, Result);
end;

procedure T3DArray.SetElement(X, Y, Z : Cardinal; const Value : TElementType);
var
  A : TStLMatrix;
begin
  Get(X, A);
  A.Put(Y, Z, Value);
end;

constructor T3DArray.Create(XMag, YMag, ZMag : Cardinal);
var
  X : Cardinal;
  A : TStLMatrix;
begin
  inherited Create(XMag, SizeOf(TStLMatrix));
  {create the matrices that form each node of the parent 1D array}
  for X := 0 to XMag-1 do begin
    A := TStLMatrix.Create(YMag, ZMag, SizeOf(TElementType));
    Put(X, A);
  end;
end;

destructor T3DArray.Destroy;
var
  X : Cardinal;
  A : TStLMatrix;
begin
  {free the matrices that form each node of the parent 1D array}
  for X := 0 to XMag-1 do begin
    Get(X, A);
    if Assigned(A) then
      A.Free;
  end;
  inherited Destroy;
end;

procedure T3DArray.Fill(const Value : TElementType);
var
  X : Cardinal;
  A : TStLMatrix;
begin
  for X := 0 to XMag-1 do begin
    Get(X, A);
    A.Fill(Value);
  end;
end;

var
  a : T3DArray;
  x, y, z : longint;

begin
  a := T3DArray.create(xmag, ymag, zmag);

  {quickly check each 2D matrix}
  for x := 0 to xmag-1 do
    if a[x, 0, 0] <> 0 then begin
      writeln('clear or allocation error');
      halt;
    end;

  {check the default clear operation}
  for x := 0 to xmag-1 do
    for y := 0 to ymag-1 do
      for z := 0 to zmag-1 do
        if a[x, y, z] <> 0 then begin
          writeln('clear error');
          halt;
        end;

  {test filling with a non-zero element}
  a.Fill(xmag);
  for x := 0 to xmag-1 do
    for y := 0 to ymag-1 do
      for z := 0 to zmag-1 do
        if a[x, y, z] <> xmag then begin
          writeln('fill error');
          halt;
        end;

  {set all elements to unique values and test}
  for x := 0 to xmag-1 do
    for y := 0 to ymag-1 do
      for z := 0 to zmag-1 do
        a[x, y, z] := longint(x)*y-x*z+y*z;
  for x := 0 to xmag-1 do
    for y := 0 to ymag-1 do
      for z := 0 to zmag-1 do
        if a[x, y, z] <> longint(x)*y-x*z+y*z then begin
          writeln('put or get error');
          halt;
        end;

  a.free;
  Writeln('Done');
  readln;
end.

