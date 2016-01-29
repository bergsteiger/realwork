unit PDInheritedProperty;

interface

uses
  gtObject, PDElement, PDBaseObject, PDInteger, PDResource, PDRect;

type
  TgtPDInheritedProperty = class(TgtPDElement)
  private
    FRef: Integer;

    //Page attributes
    FResource: TgtPDResource;
    FMediaBox: TgtPDRect;
    FCropBox: TgtPDRect;
    FRotate: Integer;

    //FormField attributes
    FFormFieldValue: TgtPDBaseObject;
    FFormFieldDefaultValu: TgtPDBaseObject;
    FFormFieldName: TgtPDBaseObject;

    function DecReference: Integer;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      AInheritedObj: TgtPDBaseObject);
    destructor Destroy; override;
    //Can be used by Page class and its children
    function GetResource: TgtPDResource;
    function GetMediaBox: TgtPDRect;
    function GetCropBox: TgtPDRect;
    function GetRotate: Integer;

    //Should be used by only FormFields
    function GetFormFieldType: TgtPDBaseObject;
    function GetFormFieldFlag: TgtPDBaseObject;
    function GetFormFieldValue: TgtPDBaseObject;
    function GetFormFieldDefaultValue: TgtPDBaseObject;
    function GetFormFiledName: TgtPDBaseObject;
    procedure Update; override;
  end;

implementation

uses
  gtMethods, gtConstants, PDDictionary, PDArray, PDName;

{ TgtPDInheritedProperty }

constructor TgtPDInheritedProperty.Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
  AInheritedObj: TgtPDBaseObject);
var
  LRect: TgtPDRect;
begin
  FRef := 0;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := AInheritedObj;
  LRect := nil;

  if Assigned(FParentElement) then
  begin
    //Increment the reference count for each assignnment
    TgtPDInheritedProperty(FParentElement).FRef :=
      TgtPDInheritedProperty(FParentElement).FRef + 1;
    //Get the attributes from the previous objects
    LRect := TgtPDInheritedProperty(FParentElement).GetMediaBox;
    if Assigned(LRect) then
    begin
      FMediaBox := TgtPDRect.Create;
      FMediaBox.Assign(LRect);
    end;
    LRect := TgtPDInheritedProperty(FParentElement).GetCropBox;
    if Assigned(LRect) then
    begin
      FCropBox := TgtPDRect.Create;
      FCropBox.Assign(LRect);
    end;
    FRotate := TgtPDInheritedProperty(FParentElement).GetRotate;
    FResource := TgtPDInheritedProperty(FParentElement).GetResource;
  end;
end;

function TgtPDInheritedProperty.DecReference: Integer;
begin
  Dec(FRef);
  Result := FRef;
end;

destructor TgtPDInheritedProperty.Destroy;
begin
  //for every Inherited property object, it will be created with an inherited
  //object other than the first one which is created with nil object. Free all
  //the Inherited object through the leaf node
  if Assigned(FParentElement) then
    if (TgtPDInheritedProperty(FParentElement).DecReference = 0) then
      FreeObject(FParentElement);

  if Assigned(FMediaBox) then
    FreeObject(FMediaBox);
  if Assigned(FCropBox) then
    FreeObject(FCropBox);
//  if Assigned(FResource) then
//    FreeObject(FResource);
    
  inherited;
end;

function TgtPDInheritedProperty.GetCropBox: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FCropBox) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_CROPBOX);
    if Assigned(LObj) then
    begin
      FCropBox := TgtPDRect.Create(TgtPDArray(LObj));
    end;
  end;

  Result := FCropBox;
end;

function TgtPDInheritedProperty.GetFormFieldDefaultValue: TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DV);
  if Assigned(LObj) then
  begin
    FFormFieldDefaultValu := LObj;
  end;
  Result := FFormFieldDefaultValu;
end;

function TgtPDInheritedProperty.GetFormFieldFlag: TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  Result := nil;
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
  if Assigned(LObj) then
  begin
    Result := LObj;
    Exit;
  end;
end;

function TgtPDInheritedProperty.GetFormFieldType: TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  Result := nil;
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FT);
  if Assigned(LObj) then
  begin
    Result := LObj;
    Exit;
  end;
end;

function TgtPDInheritedProperty.GetFormFieldValue: TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FFormFieldValue) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_V);
    if Assigned(LObj) then
    begin
      FFormFieldValue := LObj;
    end;
  end;
  Result := FFormFieldValue;
end;

function TgtPDInheritedProperty.GetFormFiledName: TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_T);
  if Assigned(FFormFieldName) then
  begin
    if Assigned(LObj) then
    begin
      FFormFieldName := LObj;
    end;
  end;
  Result := FFormFieldName;
end;

function TgtPDInheritedProperty.GetMediaBox: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FMediaBox) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MEDIABOX);
    if Assigned(LObj) then
    begin
      FMediaBox := TgtPDRect.Create(TgtPDArray(LObj));
    end;
  end;

  Result := FMediaBox;
end;

function TgtPDInheritedProperty.GetResource: TgtPDResource;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FResource) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_RESOURCES);
    if Assigned(LObj) then
    begin
      FResource := TgtPDResource.Create(FParentDoc, FParentElement, LObj);
    end;
  end;

  Result := FResource;
end;

function TgtPDInheritedProperty.GetRotate: Integer;
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ROTATE);
  if Assigned(LObj) and (LObj.IsInteger) then
    FRotate := TgtPDInteger(LObj).Value;
  Result := FRotate;
end;

procedure TgtPDInheritedProperty.Update;
begin
  inherited;

end;

end.
