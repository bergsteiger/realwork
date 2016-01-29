unit PDForm;

interface

uses
  gtObject, PDXObject, PDElement, PDBaseObject, PDRect, PDMatrix, PDColorSpace;

type
  TgtPDForm = class(TgtPDXObject)
  private
    FFormType: Integer;
    FBBox: TgtPDRect;
    FMatrix: TgtPDMatrix;
    FResources: TgtPDElement;

    function GetFormType: Integer;
    function GetBBox: TgtPDRect;
    function GetMatrix: TgtPDMatrix;
    function GetResources: TgtPDElement;
  public
    constructor Create(AParentDoc: TgtObject; AResourceElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    property FormType: Integer read GetFormType;
    property BBox: TgtPDRect read GetBBox;
    property Matrix: TgtPDMatrix read GetMatrix;
    property Resources: TgtPDElement read GetResources;
//    property IsTransperantGroup: Boolean read GetIsTransparentGroup;
//    property ColorSpace: TgtPDColorSpace read GetColoSpace;

    procedure Update; override;

  end;

implementation

uses
  PDDictionary, PDStream, gtConstants, PDInteger, PDArray, PDResource;

{ TgtPDForm }

constructor TgtPDForm.Create(AParentDoc: TgtObject;
  AResourceElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AResourceElement;
  FBaseObject := ABaseObject;

  FFormType := -1;
  FBBox := nil;
  FMatrix := nil;
  FResources := nil;
end;

destructor TgtPDForm.Destroy;
begin
  if Assigned(FBBox) then
    FBBox.Free;
  if Assigned(FMatrix) then
    FMatrix.Free;
  if Assigned(FResources) then
    FResources.Free;

  inherited;
end;

function TgtPDForm.GetBBox: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FBBox) then
  begin
    if Assigned(BaseObject) and BaseObject.IsStream then
    begin
      LObj := TgtPDDictionary(TgtPDStream(BaseObject).GetDict).
        LookUp(PDF_BBOX);
      if Assigned(LObj) and LObj.IsArray then
        FBBox := TgtPDRect.Create(TgtPDArray(LObj));
    end;
  end;
  Result := FBBox;
end;

function TgtPDForm.GetFormType: Integer;
var
  LObj: TgtPDBaseObject;
begin
  if FFormType = -1 then
  begin
    if Assigned(BaseObject) and BaseObject.IsStream then
    begin
      LObj := TgtPDDictionary(TgtPDStream(BaseObject).GetDict).
        LookUp(PDF_FORMTYPE);
      if Assigned(LObj) and LObj.IsInteger then
        FFormType := TgtPDInteger(LObj).Value;
    end;
  end;
  Result := FFormType;
end;

function TgtPDForm.GetMatrix: TgtPDMatrix;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FMatrix) then
  begin
    if Assigned(BaseObject) and BaseObject.IsStream then
    begin
      LObj := TgtPDDictionary(TgtPDStream(BaseObject).GetDict).
        LookUp(PDF_MATRIX);
      if Assigned(LObj) and LObj.IsArray then
        FMatrix := TgtPDMatrix.Create(TgtPDArray(LObj));
    end;
  end;
  Result := FMatrix;
end;

function TgtPDForm.GetResources: TgtPDElement;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FResources) then
  begin
    if Assigned(BaseObject) and BaseObject.IsStream then
    begin
      LObj := TgtPDDictionary(TgtPDStream(BaseObject).GetDict).
        LookUp(PDF_RESOURCES);
      if Assigned(LObj) then
        FResources := TgtPDResource.Create(ParentDoc, Self, LObj)
      else
      begin
        Result := FParentElement;
        Exit;
      end;
    end;
  end;
  Result := FResources;
end;

procedure TgtPDForm.Update;
begin
  inherited;

end;

end.
