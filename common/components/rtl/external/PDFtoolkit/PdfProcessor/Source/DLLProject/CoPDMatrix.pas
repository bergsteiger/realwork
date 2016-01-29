unit CoPDMatrix;

interface

uses
  PDMatrixIntf, PDMatrix, PDBaseObjectIntf, PDBaseObject, Contnrs, gtMethods,
  CoPDBaseObject;

type
  TgtCoPDMatrix = class(IgtPDMatrix)
  private
    FPDMatrix: TgtPDMatrix;
    FObjectList: TObjectList;
  protected
    property PDMatrix: TgtPDMatrix read FPDMatrix write FPDMatrix;
  public
    constructor Create(APDMatrix: TgtPDMatrix); overload;
    constructor Create(ArrayObject: TgtPDBaseObject); overload;
    constructor Create(aM11: Double; aM12: Double; aM21: Double; aM22: Double;
      aDx: Double; aDy: Double); overload;
    Destructor Destroy; override;

    function GetArray: IgtPDBaseObject; override;
    function Copy: IgtPDMatrix; override;
    function PreMultiply(AMatrix: IgtPDMatrix): IgtPDMatrix; override;
    function GetInverse: IgtPDMatrix; override;
    procedure SetVAlues(AM11: Double; AM12: Double; AM21: Double; AM22: Double;
      ADx: Double; ADy: Double); override;
    procedure Inverse; override;
    procedure Assign(Value: IgtPDMatrix); override;

    function GetM11: Double; override;
    procedure SetM11(AM11: Double); override;
    function GetM12: Double; override;
    procedure SetM12(AM12: Double); override;
    function GetM21: Double; override;
    procedure SetM21(AM21: Double); override;
    function GetM22: Double; override;
    procedure SetM22(AM22: Double); override;
    function GetDx: Double; override;
    procedure SetDx(ADx: Double); override;
    function GetDy: Double; override;
    procedure SetDy(ADy: Double); override;
  end;


implementation

{ TgtCoPDMatrix }

procedure TgtCoPDMatrix.Assign(Value: IgtPDMatrix);
begin
  FPDMatrix.Assign(TgtCoPDMatrix(Value).PDMatrix);
end;

function TgtCoPDMatrix.Copy: IgtPDMatrix;
var
  LPDMatrix: TgtPDMatrix;
  LCoPDMatrix: TgtCoPDMatrix;
begin
  LPDMatrix := FPDMatrix.Copy;
  LCoPDMatrix := TgtCoPDMatrix.Create(LPDMatrix);
  Result := LCoPDMatrix;
  FObjectList.Add(LCoPDMatrix);
end;

constructor TgtCoPDMatrix.Create(ArrayObject: TgtPDBaseObject);
begin
  FPDMatrix.Create(ArrayObject);
end;

constructor TgtCoPDMatrix.Create(aM11, aM12, aM21, aM22, aDx, aDy: Double);
begin
  FPDMatrix.Create(aM11, aM12, aM21, aM22, aDx, aDy);
end;

destructor TgtCoPDMatrix.Destroy;
begin
  if Assigned (FObjectList) then
    FreeObject(FObjectList);
end;

constructor TgtCoPDMatrix.Create(APDMatrix: TgtPDMatrix);
begin
  FPDMatrix := APDMatrix;
  if not Assigned(FObjectList) then
    FObjectList := TObjectList.Create;
end;

function TgtCoPDMatrix.GetArray: IgtPDBaseObject;
var
  LPDBaseObj: TgtPDBaseObject;
  LCoPDBaseObj: TgtCoPDBaseObject;
begin
  LPDBaseObj := FPDMatrix.GetArray;
  LCoPDBaseObj := TgtCoPDBaseObject.Create(LPDBaseObj);
  Result := LCoPDBaseObj;
  FObjectList.Add(LCoPDBaseObj);
end;

function TgtCoPDMatrix.GetDx: Double;
begin
  Result := FPDMatrix.Dx;
end;

function TgtCoPDMatrix.GetDy: Double;
begin
  Result := FPDMatrix.Dy;
end;

function TgtCoPDMatrix.GetInverse: IgtPDMatrix;
var
  LPDMatrix: TgtPDMatrix;
  LCoPDMatrix: TgtCoPDMatrix;
begin
  LPDMatrix := FPDMatrix.GetInverse;
  LCoPDMatrix := TgtCoPDMatrix.Create(LPDMatrix);
  Result := LCoPDMatrix;
  FObjectList.Add(LCoPDMatrix);
end;

function TgtCoPDMatrix.GetM11: Double;
begin
  Result := FPDMatrix.M11;
end;

function TgtCoPDMatrix.GetM12: Double;
begin
  Result := FPDMatrix.M12;
end;

function TgtCoPDMatrix.GetM21: Double;
begin
  Result := FPDMatrix.M21;
end;

function TgtCoPDMatrix.GetM22: Double;
begin
  Result := FPDMatrix.M22;
end;

procedure TgtCoPDMatrix.Inverse;
begin
  FPDMatrix.Inverse;
end;

function TgtCoPDMatrix.PreMultiply(AMatrix: IgtPDMatrix): IgtPDMatrix;
var
  LPDMatrix: TgtPDMatrix;
  LCoPDMatrix: TgtCoPDMatrix;
begin
  LPDMatrix :=   FPDMatrix.PreMultiply(TgtCoPDMatrix(AMatrix).PDMatrix);
  LCoPDMatrix := TgtCoPDMatrix.Create(LPDMatrix);
  Result := LCoPDMatrix;
  FObjectList.Add(LCoPDMatrix);
end;

procedure TgtCoPDMatrix.SetDx(ADx: Double);
begin
  FPDMatrix.Dx := ADx;
end;

procedure TgtCoPDMatrix.SetDy(ADy: Double);
begin
  FPDMatrix.Dy := ADy;
end;

procedure TgtCoPDMatrix.SetM11(AM11: Double);
begin
  FPDMatrix.M11 := AM11;
end;

procedure TgtCoPDMatrix.SetM12(AM12: Double);
begin
  FPDMatrix.M12 := AM12;
end;

procedure TgtCoPDMatrix.SetM21(AM21: Double);
begin
  FPDMatrix.M21 := AM21;
end;

procedure TgtCoPDMatrix.SetM22(AM22: Double);
begin
  FPDMatrix.M22 := AM22;
end;

procedure TgtCoPDMatrix.SetVAlues(AM11, AM12, AM21, AM22, ADx, ADy: Double);
begin
  FPDMatrix.SetValues(AM11, AM12, AM21, AM22, ADx, ADy);
end;

end.
