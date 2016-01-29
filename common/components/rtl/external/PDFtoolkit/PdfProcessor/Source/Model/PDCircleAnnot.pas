unit PDCircleAnnot;

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDAnnot, gtConstants;

type
  TgtPDCircleAnnot = class(TgtPDAnnot)
  private
    FInteriorColor: TgtPDColorValue;
    FIntensity: Double;
    FIsCloudy: Boolean;

    function GetInteriorColor: TgtPDColorValue;
    function GetIntensity: Double;
    function GetIsCloudy: Boolean;

    procedure SetInteriorColor(const Value: TgtPDColorValue);
    procedure SetIntensity(const Value: Double);
    procedure SetIsCloudy(const Value: Boolean);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;
    property InteriorColor: TgtPDColorValue read GetInteriorColor write SetInteriorColor;
    property Intensity: Double read GetIntensity write SetIntensity;
    property IsCloudy: Boolean read GetIsCloudy write SetIsCloudy default False;
  end;

implementation

{ TgtPDCircleAnnot }

uses
  PDDictionary, PDReal, PDInteger, PDName, PDArray, PDDocument;

constructor TgtPDCircleAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotCircle;
  FIntensity := -1;
end;

constructor TgtPDCircleAnnot.Create;
begin
  inherited;
  AnnotType := annotCircle;
  FIntensity := 0;
  FIsCloudy := False;
  FInteriorColor.Value[0] := 1;
  FInteriorColor.Value[1] := 1;
  FInteriorColor.Value[2] := 1;
end;

destructor TgtPDCircleAnnot.Destroy;
begin

  inherited;
end;

function TgtPDCircleAnnot.GetIntensity: Double;
var
  LObj: TgtPDBaseObject;
  LIntensity: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if FIntensity = -1 then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BE);
      if Assigned(LObj) and LObj.IsDict then
      begin
        LIntensity := TgtPDDictionary(LObj).LookUp(PDF_I);
        if Assigned(LIntensity) then
        begin
          if LIntensity.IsReal then
            FIntensity := TgtPDReal(LIntensity).Value
          else if LIntensity.IsInteger then
            FIntensity := TgtPDInteger(LIntensity).Value
        end;
      end;
    end;
  end;
  Result := FIntensity;
end;

function TgtPDCircleAnnot.GetInteriorColor: TgtPDColorValue;
var
  LObj: TgtPDBaseObject;
  LColor: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_IC);
    if Assigned(LObj) and LObj.IsArray then
    begin
      FInteriorColor.ColorSpace := DeviceRGB;
      LColor := TgtPDArray(LObj).Get(0);
      if LColor.IsReal then
        FInteriorColor.Value[0] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FInteriorColor.Value[0] := TgtPDInteger(LColor).Value;

      LColor := TgtPDArray(LObj).Get(1);
      if LColor.IsReal then
        FInteriorColor.Value[1] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FInteriorColor.Value[1] := TgtPDInteger(LColor).Value;

      LColor := TgtPDArray(LObj).Get(2);
      if LColor.IsReal then
        FInteriorColor.Value[2] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FInteriorColor.Value[2] := TgtPDInteger(LColor).Value;
    end;
  end;
  Result := FInteriorColor;
end;

function TgtPDCircleAnnot.GetIsCloudy: Boolean;
var
  LObj: TgtPDBaseObject;
  LCloudy: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BE);
    if Assigned(LObj) and LObj.IsDict then
    begin
      LCloudy := TgtPDDictionary(LObj).LookUp(PDF_S);
      if Assigned(LCloudy) and LCloudy.IsName then
      begin
        if TgtPDName(LCloudy).Value = PDF_C then
          FIsCloudy := True
      end;
    end;
  end;
  Result := FIsCloudy;
end;

procedure TgtPDCircleAnnot.SetIntensity(const Value: Double);
var
  LObj: TgtPDBaseObject;
  LIntensity: TgtPDBaseObject;
  LRealObj: TgtPDReal;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BE);
    if Assigned(LObj) and LObj.IsDict then
    begin
      LIntensity := TgtPDDictionary(LObj).LookUp(PDF_I);
      if Assigned(LIntensity) then
      begin
        if LIntensity.IsReal then
          TgtPDReal(LIntensity).Value := Value
        else if LIntensity.IsInteger then
        begin
          LRealObj := TgtPDReal.Create(Value);
          TgtPDDictionary(LIntensity).SetKeyValue(PDF_I, LRealObj);
        end;
      end
      else
      begin
        LIntensity := TgtPDReal.Create(Value);
        TgtPDDictionary(LObj).Add(PDF_I, LIntensity);
      end;
    end
    else
    begin
      LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_BE, LObj);
      LIntensity := TgtPDReal.Create(Value);
      TgtPDDictionary(LObj).Add(PDF_I, LIntensity);
    end;
  end;
  FIntensity := Value;
end;

procedure TgtPDCircleAnnot.SetInteriorColor(const Value: TgtPDColorValue);
var
  LObj: TgtPDBaseObject;
  LColor: TgtPDBaseObject;
  LRealObj: TgtPDReal;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_IC);
    if Assigned(LObj) then
    begin
      LColor := TgtPDArray(LObj).Get(0);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Value.Value[0];
      end
      else
      begin
        TgtPDArray(LObj).Remove(0);
        LColor := TgtPDReal.Create(Value.Value[0]);
        TgtPDArray(LObj).Insert(LColor, 0);
      end;
      LColor := TgtPDArray(LObj).Get(1);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Value.Value[1];
      end
      else
      begin
        TgtPDArray(LObj).Remove(1);
        LColor := TgtPDReal.Create(Value.Value[1]);
        TgtPDArray(LObj).Insert(LColor, 1);
      end;
      LColor := TgtPDArray(LObj).Get(2);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Value.Value[2];
      end
      else
      begin
        TgtPDArray(LObj).Remove(2);
        LColor := TgtPDReal.Create(Value.Value[2]);
        TgtPDArray(LObj).Add(LColor);
      end;
    end
    else
    begin
      LObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LRealObj := TgtPDReal.Create(Value.Value[0]);
      TgtPDArray(LObj).Add(LRealObj);
      LRealObj := TgtPDReal.Create(Value.Value[1]);
      TgtPDArray(LObj).Add(LRealObj);
      LRealObj := TgtPDReal.Create(Value.Value[2]);
      TgtPDArray(LObj).Add(LRealObj);
      TgtPDDictionary(FBaseObject).Add(PDF_IC, LObj);
    end;
  end;
  FInteriorColor := Value;
end;

procedure TgtPDCircleAnnot.SetIsCloudy(const Value: Boolean);
var
  LObj: TgtPDBaseObject;
  LCloudy: TgtPDBaseObject;
  LValue: AnsiString;
begin
  if Value then
    LValue := PDF_C
  else
    LValue := PDF_S;
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BE);
    if Assigned(LObj) and LObj.IsDict then
    begin
      LCloudy := TgtPDDictionary(LObj).LookUp(PDF_S);
      if Assigned(LCloudy) and LCloudy.IsName then
        TgtPDName(LCloudy).Value := LValue
      else
      begin
        LCloudy := TgtPDName.Create(LValue);
        TgtPDDictionary(FBaseObject).Add(PDF_S, LCloudy);
      end;
    end
    else
    begin
      LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_BE, LObj);
      LCloudy := TgtPDName.Create(LValue);
      TgtPDDictionary(FBaseObject).Add(PDF_S, LCloudy);
    end;
  end;
  FIsCloudy := True;
end;

end.
