unit PDMatrix;

interface

uses
  gtObject, PDArray, PDReal, PDBaseObject;

type
  TgtPDMatrix = class(TgtObject)
  private
    FM11: Double;
    FM12: Double;
    FM21: Double;
    FM22: Double;
    FDx: Double;
    FDy: Double;

  public
    constructor Create(); overload;
    constructor Create(ArrayObject: TgtPDBaseObject); overload;
    constructor Create(aM11: Double; aM12: Double; aM21: Double; aM22: Double;
      aDx: Double; aDy: Double); overload;

    function GetArray: TgtPDBaseObject;
//    function Get(Index: Integer): Double;
    function Copy: TgtPDMatrix;

//  Premultiplies AMatrix with self
    function PreMultiply(AMatrix: TgtPDMatrix): TgtPDMatrix;
    function GetInverse: TgtPDMatrix;

    procedure SetValues(aM11: Double; aM12: Double; aM21: Double; aM22: Double;
      aDx: Double; aDy: Double);

    procedure Inverse;
    function IsIdentity: Boolean;

    procedure Assign(Value: TgtPDMatrix);

    property M11: Double read FM11 write FM11;
    property M12: Double read FM12 write FM12;
    property M21: Double read FM21 write FM21;
    property M22: Double read FM22 write FM22;
    property Dx: Double read FDx write FDx;
    property Dy: Double read FDy write FDy;

  end;

implementation

uses
  PDInteger;

{ TgtPDMatrix }

constructor TgtPDMatrix.Create();
begin
  FM11 := 1;
  FM12 := 0;
  FM21 := 0;
  FM22 := 1;
  FDx := 0;
  FDy := 0;
end;

procedure TgtPDMatrix.Assign(Value: TgtPDMatrix);
begin
  FM11 := Value.FM11;
  FM12 := Value.FM12;
  FM21 := Value.FM21;
  FM22 := Value.FM22;
  FDx := Value.FDx;
  FDy := Value.FDy;
end;

constructor TgtPDMatrix.Create(ArrayObject: TgtPDBaseObject);
var
  LObj: TgtPDBaseObject;
begin
  if ArrayObject.IsArray then
  begin
    if TgtPdArray(ArrayObject).GetLength >= 6 then
    begin
      LObj := TgtPdArray(ArrayObject).Get(0);
      if LObj.IsReal then FM11 := TgtPDReal(LObj).Value
      else FM11 := TgtPDInteger(LObj).Value;

      LObj := TgtPdArray(ArrayObject).Get(1);
      if LObj.IsReal then FM12 := TgtPDReal(LObj).Value
      else FM12 := TgtPDInteger(LObj).Value;

      LObj := TgtPdArray(ArrayObject).Get(2);
      if LObj.IsReal then FM21 := TgtPDReal(LObj).Value
      else FM21 := TgtPDInteger(LObj).Value;

      LObj := TgtPdArray(ArrayObject).Get(3);
      if LObj.IsReal then FM22 := TgtPDReal(LObj).Value
      else FM22 := TgtPDInteger(LObj).Value;

      LObj := TgtPdArray(ArrayObject).Get(4);
      if LObj.IsReal then FDx := TgtPDReal(LObj).Value
      else FDx := TgtPDInteger(LObj).Value;

      LObj := TgtPdArray(ArrayObject).Get(5);
      if LObj.IsReal then FDy := TgtPDReal(LObj).Value
      else FDy := TgtPDInteger(LObj).Value;
    end
    else
    begin
      FM11 := 1;
      FM12 := 0;
      FM21 := 0;
      FM22 := 1;
      FDx := 0;
      FDy := 0;
    end;
  end
  else
  begin
    FM11 := 1;
    FM12 := 0;
    FM21 := 0;
    FM22 := 1;
    FDx := 0;
    FDy := 0;
  end;
end;

function TgtPDMatrix.Copy: TgtPDMatrix;
begin
  Result := TgtPDMatrix.Create(FM11, FM12, FM21, FM22, FDx, FDy);
end;

constructor TgtPDMatrix.Create(aM11, aM12, aM21, aM22, aDx, aDy: Double);
begin
  FM11 := aM11;
  FM12 := aM12;
  FM21 := aM21;
  FM22 := aM22;
  FDx := aDx;
  FDy := aDy;
end;

function TgtPDMatrix.GetArray: TgtPDBaseObject;
var
  LObj: TgtPDReal;
begin
  Result := TgtPDArray.Create(nil);
  LObj := TgtPDReal.Create(FM11);
  TgtPDArray(Result).Add(LObj);

  LObj := TgtPDReal.Create(FM12);
  TgtPDArray(Result).Add(LObj);

  LObj := TgtPDReal.Create(FM21);
  TgtPDArray(Result).Add(LObj);

  LObj := TgtPDReal.Create(FM22);
  TgtPDArray(Result).Add(LObj);

  LObj := TgtPDReal.Create(FDx);
  TgtPDArray(Result).Add(LObj);

  LObj := TgtPDReal.Create(FDy);
  TgtPDArray(Result).Add(LObj);

end;

function TgtPDMatrix.GetInverse: TgtPDMatrix;
var
  LDeterminant: Double;
begin
  Result := TgtPDMatrix.Create;
  LDeterminant := FM11 * FM22 - FM12 * FM21;
  if LDeterminant = 0 then
  begin
    //Raise exception - singular matrix
    exit;
  end;

  // Inverse = Adj/ Determinant
  // Adjoint = Cofactor transpose

  Result.FM11 := FM22 / LDeterminant;
  Result.FM12 := -FM12 / LDeterminant;
  Result.FM21 := -FM21 / LDeterminant;
  Result.FM22 := FM11 / LDeterminant;
  Result.FDx := (FM21 * FDy - FM22 * FDx) / LDeterminant;
  Result.FDy := -(FM11 * FDy - FM12 * FDx) / LDeterminant;
end;

procedure TgtPDMatrix.Inverse;
var
  LObj: TgtPDMatrix;
  LDeterminant: Double;
begin
  LObj := TgtPDMatrix.Create;
  LObj.Assign(Self);
  LDeterminant := FM11 * FM22 - FM12 * FM21;
  if LDeterminant = 0 then
  begin
    //Raise exception - singular matrix
    exit;
  end;

  // Inverse = Adj/ Determinant
  // Adjoint = Cofactor transpose

  FM11 := LObj.FM22 / LDeterminant;
  FM12 := -LObj.FM12 / LDeterminant;
  FM21 := -LObj.FM21 / LDeterminant;
  FM22 := LObj.FM11 / LDeterminant;
  FDx := (LObj.FM21 * LObj.FDy - LObj.FM22 * LObj.FDx) / LDeterminant;
  FDy := -(LObj.FM11 * LObj.FDy - LObj.FM12 * LObj.FDx) / LDeterminant;
  LObj.Free;
end;

function TgtPDMatrix.IsIdentity: Boolean;
begin
  Result := (FM11 = 1) and (FM12 = 0) and (FM21 = 0) and (FM22 = 1)
    and (FDx = 0) and (FDy = 0);
end;

function TgtPDMatrix.PreMultiply(AMatrix: TgtPDMatrix): TgtPDMatrix;
begin
  Result := TgtPDMatrix.Create;
  Result.FM11 := AMatrix.FM11 * FM11 + AMatrix.FM12 * FM21;
  Result.FM12 := AMatrix.FM11 * FM12 + AMatrix.FM12 * FM22;

  Result.FM21 := AMatrix.FM21 * FM11 + AMatrix.FM22 * FM21;
  Result.FM22 := AMatrix.FM21 * FM12 + AMatrix.FM22 * FM22;

  Result.FDx := AMatrix.FDx * FM11 + AMatrix.FDy * FM21 + FDx;
  Result.FDy := AMatrix.FDx * FM12 + AMatrix.FDy * FM22 + FDy;
end;

procedure TgtPDMatrix.SetValues(aM11, aM12, aM21, aM22, aDx, aDy: Double);
begin
  FM11 := aM11;
  FM12 := aM12;
  FM21 := aM21;
  FM22 := aM22;
  FDx := aDx;
  FDy := aDy;
end;

end.
