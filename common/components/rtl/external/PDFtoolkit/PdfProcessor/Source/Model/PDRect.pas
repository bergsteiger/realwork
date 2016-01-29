{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDRect;

interface

uses
  classes, PDArray, gtObject, PDElement;

type
  TgtPDRect = class(TgtObject)
  private
    FBaseObject: TgtPDArray;
    FLeft: Double;
    FTop: Double;
    FRight: Double;
    FBottom: Double;
    FIsValid: Boolean;
    procedure SetBottom(const Value: Double);
    procedure SetLeft(const Value: Double);
    procedure SetRight(const Value: Double);
    procedure SetTop(const Value: Double);

  public
    constructor Create; overload;
    constructor Create(ArrayObject: TgtPDArray); overload;
    constructor Create(ALeft, ATop, ARight, ABottom: Double); overload;
    destructor Destroy; override;
    function GetArray: TgtPDArray;
    procedure Assign(Source: TgtObject);
    procedure SetValues(ALeft, ATop, ARight, ABottom: Double);
    function Clone: TgtPDRect;

    property Left: Double read FLeft write SetLeft;
    property Top: Double read FTop write SetTop;
    property Right: Double read FRight write SetRight;
    property Bottom: Double read FBottom write SetBottom;
    property IsValid: Boolean read FIsValid;
  end;

procedure MapArrayToRect(ArrayObj: TgtPDArray; ARectObj: TgtPDRect);

implementation

uses
  PDInteger, PDBaseObject, PDReal, PDDocument, PDDictionary, gtConstants;


{ TgtPDRect }

constructor TgtPDRect.Create();
begin
  FIsValid := False;
  FBaseObject := nil;
  FLeft := -1;
  FTop := -1;
  FRight := -1;
  FBottom := -1;
end;

  (**
   * @param ArrayObject is the Array object with which this object need to
   *         be created
   *
   * Algorithm
   *    a. Get the objects of the array object.
   *    b. Check whether the objects are Real object or Integer Object
   *    c. Typecast to TgtPDInteger or TgtPDReal with respect to object type
   *    d. Save all the objects to FLeft, FTop, FRight, FBottom respectively
   *)

procedure TgtPDRect.Assign(Source: TgtObject);
begin
  if Source is TgtPDRect then
  begin
    Left := TgtPDRect(Source).Left;
    Top := TgtPDRect(Source).Top;
    Right := TgtPDRect(Source).Right;
    Bottom := TgtPDRect(Source).Bottom;
  end;
end;

constructor TgtPDRect.Create(ArrayObject: TgtPDArray);
var
  LObj: TgtPDBaseObject;
begin
  FBaseObject := ArrayObject;
  FIsValid := False;
  LObj := FBaseObject.Get(0);
  if LObj.IsInteger then
    FLeft := TgtPDInteger(LObj).Value
  else if LObj.IsReal then
    FLeft := TgtPDReal(LObj).Value;

  LObj := FBaseObject.Get(1);
  if LObj.IsInteger then
    FTop := TgtPDInteger(LObj).Value
  else if LObj.IsReal then
    FTop := TgtPDReal(LObj).Value;

  LObj := FBaseObject.Get(2);
  if LObj.IsInteger then
    FRight := TgtPDInteger(LObj).Value
  else if LObj.IsReal then
    FRight := TgtPDReal(LObj).Value;

  LObj := FBaseObject.Get(3);
  if LObj.IsInteger then
    FBottom := TgtPDInteger(LObj).Value
  else if LObj.IsReal then
    FBottom := TgtPDReal(LObj).Value;
end;

function TgtPDRect.Clone: TgtPDRect;
begin
  Result := Self.Create(FLeft, FTop, FRight, FBottom);
end;

constructor TgtPDRect.Create(ALeft, ATop, ARight, ABottom: Double);
begin
  Left := ALeft;
  Top := ATop;
  Right := ARight;
  Bottom := ABottom;
  FBaseObject := nil;
end;

destructor TgtPDRect.Destroy;
begin

  inherited;
end;

function TgtPDRect.GetArray: TgtPDArray;
begin
  Result := FBaseObject;
end;

procedure TgtPDRect.SetBottom(const Value: Double);
var
  LObj: TgtPDBaseObject;
begin
//  LObj := nil;
  FBottom := Value;
  FIsValid := True;
  if Assigned(FBaseObject) then
  begin
    LObj := FBaseObject.Get(3);
    if Assigned(LObj) then
    begin
      if LObj.IsReal then
        TgtPDReal(LObj).Value := Value
      else
        TgtPDInteger(LObj).Value := Round(Value);
    end;
  end;

end;

procedure TgtPDRect.SetLeft(const Value: Double);
var
  LObj: TgtPDBaseObject;
begin
//  LObj := nil;
  FLeft := Value;
  FIsValid := True;
  if Assigned(FBaseObject) then
  begin
    LObj := FBaseObject.Get(0);
    if Assigned(LObj) then
    begin
      if LObj.IsReal then
        TgtPDReal(LObj).Value := Value
      else
        TgtPDInteger(LObj).Value := Round(Value);
    end;
  end;
end;

procedure TgtPDRect.SetRight(const Value: Double);
var
  LObj: TgtPDBaseObject;
begin
//  LObj := nil;
  FRight := Value;
  FIsValid := True;
  if Assigned(FBaseObject) then
  begin
    LObj := FBaseObject.Get(2);
    if Assigned(LObj) then
    begin
      if LObj.IsReal then
        TgtPDReal(LObj).Value := Value
      else
        TgtPDInteger(LObj).Value := Round(Value);
    end;
  end;
end;

procedure TgtPDRect.SetTop(const Value: Double);
var
  LObj: TgtPDBaseObject;
begin
//  LObj := nil;
  FTop := Value;
  FIsValid := True;
  if Assigned(FBaseObject) then
  begin
    LObj := FBaseObject.Get(1);
    if Assigned(LObj) then
    begin
      if LObj.IsReal then
        TgtPDReal(LObj).Value := Value
      else
        TgtPDInteger(LObj).Value := Round(Value);
    end;
  end;

end;

procedure TgtPDRect.SetValues(ALeft, ATop, ARight, ABottom: Double);
begin
  Left := ALeft;
  Top := ATop;
  Right := ARight;
  Bottom := ABottom;
end;


procedure MapArrayToRect(ArrayObj: TgtPDArray; ARectObj: TgtPDRect);
var
  LObj: TgtPDBaseObject;
begin
  // Assign Left of rect
  LObj := TgtPDArray(ArrayObj).Get(0);
  if LObj.IsReal then
    ARectObj.Left := TgtPDReal(LObj).Value
  else
    ARectObj.Left := TgtPDInteger(LObj).Value;

  // Assign Top of rect
  LObj := TgtPDArray(ArrayObj).Get(1);
  if LObj.IsReal then
    ARectObj.Top := TgtPDReal(LObj).Value
  else
    ARectObj.Top := TgtPDInteger(LObj).Value;

  // Assign Right of rect
  LObj := TgtPDArray(ArrayObj).Get(2);
  if LObj.IsReal then
    ARectObj.Right := TgtPDReal(LObj).Value
  else
    ARectObj.Right := TgtPDInteger(LObj).Value;

  // Assign Bottom of rect
  LObj := TgtPDArray(ArrayObj).Get(3);
  if LObj.IsReal then
    ARectObj.Bottom := TgtPDReal(LObj).Value
  else
    ARectObj.Bottom := TgtPDInteger(LObj).Value;
end;

end.
