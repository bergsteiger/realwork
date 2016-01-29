unit PDPolygonAnnot;

interface

uses
  Classes, gtObject, PDTypes, PDElement, PDBaseObject, PDAnnot, gtConstants,
  gtMethods;

type
    //A name describing the intent of the polygon or polyline annotation
  TgtPolygonIntent = (
    //PolygonCloud, which means that the annotation is intended to function as a
    //cloud object
    itPolygonCloud,

    //PolygonDimension , which indicates that the polygon annotation is
    //intended to function as a dimension
    itPolygonDimension);

  TgtPDPolygonAnnot = class(TgtPDAnnot)
  private
    FInteriorColor: TgtPDColorValue;
    FIntensity: Double;
    FIsCloudy: Boolean;
    FVertices: TStringList;
    FIntent: TgtPolygonIntent;
    FLineBeginningStyle: TgtLineStyle;
    FLineEndingStyle: TgtLineStyle;

    function GetInteriorColor: TgtPDColorValue;
    function GetIntensity: Double;
    function GetIsCloudy: Boolean;
    function GetIntent: TgtPolygonIntent;

    procedure SetInteriorColor(const Value: TgtPDColorValue);
    procedure SetIntensity(const Value: Double);
    procedure SetIsCloudy(const Value: Boolean);
    procedure SetIntent(const Value: TgtPolygonIntent);
    function GetLineBeginningStyle: TgtLineStyle;
    function GetLineEndingStyle: TgtLineStyle;
    procedure SetLineBeginningStyle(const Value: TgtLineStyle);
    procedure SetLineEndingStyle(const Value: TgtLineStyle);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    procedure SetVertices(AVertices: AnsiString);
    function GetVertices: AnsiString;
    property InteriorColor: TgtPDColorValue read GetInteriorColor write SetInteriorColor;
    property Intensity: Double read GetIntensity write SetIntensity;
    property IsCloudy: Boolean read GetIsCloudy write SetIsCloudy default False;
    property Intent: TgtPolygonIntent read GetIntent write SetIntent;
    property LineBeginningStyle: TgtLineStyle read GetLineBeginningStyle write SetLineBeginningStyle;
    property LineEndingStyle: TgtLineStyle read GetLineEndingStyle write SetLineEndingStyle;
  end;

implementation

{ TgtPDPolygonAnnot }

uses
  PDDictionary, PDReal, PDInteger, PDName, PDArray, PDDocument, PDPage;

constructor TgtPDPolygonAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotPolygon;
  FIntensity := -1;
end;

constructor TgtPDPolygonAnnot.Create;
begin
  inherited;
  AnnotType := annotPolygon;
  FIntensity := 0;
  FIsCloudy := False;
  FInteriorColor.Value[0] := 1;
  FInteriorColor.Value[1] := 1;
  FInteriorColor.Value[2] := 1;
end;

destructor TgtPDPolygonAnnot.Destroy;
begin
  if Assigned(FVertices) then
    FVertices.Free;
  inherited;
end;

function TgtPDPolygonAnnot.GetIntensity: Double;
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

function TgtPDPolygonAnnot.GetIntent: TgtPolygonIntent;
begin
  Result := FIntent;
end;

function TgtPDPolygonAnnot.GetInteriorColor: TgtPDColorValue;
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
        FInteriorColor.Value[0] := TgtPDReal(LColor).Value;
      LColor := TgtPDArray(LObj).Get(1);
      if LColor.IsReal then
        FInteriorColor.Value[1] := TgtPDReal(LColor).Value;
      LColor := TgtPDArray(LObj).Get(2);
      if LColor.IsReal then
        FInteriorColor.Value[2] := TgtPDReal(LColor).Value;
    end;
  end;
  Result := FInteriorColor;
end;

function TgtPDPolygonAnnot.GetIsCloudy: Boolean;
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

function TgtPDPolygonAnnot.GetLineBeginningStyle: TgtLineStyle;
var
  LObj: TgtPDBaseObject;
  LStyle: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    if FLineBeginningStyle <> laNone then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LE);
      if Assigned(LObj) and LObj.IsArray then
      begin
        if Assigned(TgtPDArray(LObj).Get(1)) and TgtPDArray(LObj).Get(1).IsName then
        begin
          LStyle := TgtPDName(TgtPDArray(LObj).Get(1)).Value;
          if LStyle = 'PDF_SQUARE' then
            FLineBeginningStyle := laSquare
          else if LStyle = 'PDF_CIRCLE' then
            FLineBeginningStyle := laCircle
          else if LStyle = 'PDF_DIAMOND' then
            FLineBeginningStyle := laDiamond
          else if LStyle = 'PDF_OPENARROW' then
            FLineBeginningStyle := laOpenArrow
          else if LStyle = 'PDF_CLOSEDARROW' then
            FLineBeginningStyle := laClosedArrow
          else if LStyle = 'PDF_NONE' then
            FLineBeginningStyle := laNone
          else if LStyle = 'PDF_BUTT' then
            FLineBeginningStyle := laButt
          else if LStyle = 'PDF_ROPENARROW' then
            FLineBeginningStyle := laOpenArrow
          else if LStyle = 'PDF_RCLOSEDARROW' then
            FLineBeginningStyle := laRClosedArrow
          else if LStyle = 'PDF_SLASH' then
            FLineBeginningStyle := laSlash;
        end;
      end;
    end;
  end;
  Result := FLineBeginningStyle;
end;

function TgtPDPolygonAnnot.GetLineEndingStyle: TgtLineStyle;
var
  LObj: TgtPDBaseObject;
  LStyle: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    if FLineEndingStyle <> laNone then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LE);
      if Assigned(LObj) and LObj.IsArray then
      begin
        if Assigned(TgtPDArray(LObj).Get(1)) and TgtPDArray(LObj).Get(1).IsName then
        begin
          LStyle := TgtPDName(TgtPDArray(LObj).Get(1)).Value;
          if LStyle = 'PDF_SQUARE' then
            FLineEndingStyle := laSquare
          else if LStyle = 'PDF_CIRCLE' then
            FLineEndingStyle := laCircle
          else if LStyle = 'PDF_DIAMOND' then
            FLineEndingStyle := laDiamond
          else if LStyle = 'PDF_OPENARROW' then
            FLineEndingStyle := laOpenArrow
          else if LStyle = 'PDF_CLOSEDARROW' then
            FLineEndingStyle := laClosedArrow
          else if LStyle = 'PDF_NONE' then
            FLineEndingStyle := laNone
          else if LStyle = 'PDF_BUTT' then
            FLineEndingStyle := laButt
          else if LStyle = 'PDF_ROPENARROW' then
            FLineEndingStyle := laOpenArrow
          else if LStyle = 'PDF_RCLOSEDARROW' then
            FLineEndingStyle := laRClosedArrow
          else if LStyle = 'PDF_SLASH' then
            FLineEndingStyle := laSlash;
        end;
      end;
    end;
  end;
  Result := FLineEndingStyle;
end;

function TgtPDPolygonAnnot.GetVertices: AnsiString;
var
  LObj: TgtPDBaseObject;
  I: Integer;
  LVertice: TgtPDBaseObject;
begin
  Result := '';
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_VERTICES);
    if Assigned(LObj) and LObj.IsArray then
    begin
      if not Assigned(FVertices) then
        FVertices := TStringList.Create;
      for I := 0 to TgtPDArray(LObj).GetLength - 1 do
      begin
        LVertice := TgtPDArray(LObj).Get(I);
        if LObj.IsInteger then
          FVertices.Add(IntegerToString(TgtPDInteger(LVertice).Value))
        else if LObj.IsReal then
          FVertices.Add(FloatToStringLocale(TgtPDReal(LVertice).Value))
      end;
    end;
  end;
  if Assigned(FVertices) then
    Result := FVertices.CommaText;
end;

procedure TgtPDPolygonAnnot.SetIntensity(const Value: Double);
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

procedure TgtPDPolygonAnnot.SetIntent(const Value: TgtPolygonIntent);
begin

end;

procedure TgtPDPolygonAnnot.SetInteriorColor(const Value: TgtPDColorValue);
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
    end;
  end
  else
  begin
    LObj := TgtPDArray.Create;
    LRealObj := TgtPDReal.Create(Value.Value[0]);
    TgtPDArray(LObj).Add(LRealObj);
    LRealObj := TgtPDReal.Create(Value.Value[1]);
    TgtPDArray(LObj).Add(LRealObj);
    LRealObj := TgtPDReal.Create(Value.Value[2]);
    TgtPDArray(LObj).Add(LRealObj);
    TgtPDDictionary(FBaseObject).Add(PDF_IC, LObj);
  end;
  FInteriorColor := Value;
end;

procedure TgtPDPolygonAnnot.SetIsCloudy(const Value: Boolean);
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
  FIsCloudy := Value;
end;

procedure TgtPDPolygonAnnot.SetLineBeginningStyle(const Value: TgtLineStyle);
var
  LObj: TgtPDBaseObject;
  LArrayObj: TgtPDArray;
  LStyle: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    case Value of
      laSquare:
        LStyle := PDF_SQUARE;
      laCircle:
        LStyle := PDF_CIRCLE;
      laDiamond:
        LStyle := PDF_DIAMOND;
      laOpenArrow:
        LStyle := PDF_OPENARROW;
      laClosedArrow:
        LStyle := PDF_CLOSEDARROW;
      laNone:
        LStyle := PDF_NONE;
      laButt:
        LStyle := PDF_BUTT;
      laROpenArrow:
        LStyle := PDF_ROPENARROW;
      laRClosedArrow:
        LStyle := PDF_RCLOSEDARROW;
      laSlash:
        LStyle := PDF_SLASH;
    end;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LE);
    if Assigned(LObj) then
    begin
      TgtPDName(TgtPDArray(LObj).Get(0)).Value := LStyle;
    end
    else
    begin
      LArrayObj := TgtPDArray.Create;
      LObj := TgtPDName.Create(LStyle);
      LArrayObj.Add(LObj);
      LObj := TgtPDName.Create(PDF_None); // setting 2nd value to default value
      LArrayObj.Add(LObj);
      TgtPDDictionary(FBaseObject).Add(PDF_LE, LArrayObj);
    end;
  end;
  FLineBeginningStyle := Value;
end;

procedure TgtPDPolygonAnnot.SetLineEndingStyle(const Value: TgtLineStyle);
var
  LObj: TgtPDBaseObject;
  LArrayObj: TgtPDArray;
  LStyle: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    case Value of
      laSquare:
        LStyle := PDF_SQUARE;
      laCircle:
        LStyle := PDF_CIRCLE;
      laDiamond:
        LStyle := PDF_DIAMOND;
      laOpenArrow:
        LStyle := PDF_OPENARROW;
      laClosedArrow:
        LStyle := PDF_CLOSEDARROW;
      laNone:
        LStyle := PDF_NONE;
      laButt:
        LStyle := PDF_BUTT;
      laROpenArrow:
        LStyle := PDF_ROPENARROW;
      laRClosedArrow:
        LStyle := PDF_RCLOSEDARROW;
      laSlash:
        LStyle := PDF_SLASH;
    end;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LE);
    if Assigned(LObj) then
    begin
      TgtPDName(TgtPDArray(LObj).Get(1)).Value := LStyle;
    end
    else
    begin
      LArrayObj := TgtPDArray.Create;
      LObj := TgtPDName.Create(LStyle);
      LArrayObj.Add(LObj);
      LObj := TgtPDName.Create(PDF_None); // setting 2nd value to default value
      LArrayObj.Add(LObj);
      TgtPDDictionary(FBaseObject).Add(PDF_LE, LArrayObj);
    end;
  end;
  FLineEndingStyle := Value;
end;

procedure TgtPDPolygonAnnot.SetVertices(AVertices: AnsiString);
var
  LObj: TgtPDBaseObject;
  I: Integer;
  LVertice: TgtPDBaseObject;
  LPageHt: Double;
begin
  if not Assigned(FVertices) then
    FVertices := TStringList.Create;
  FVertices.CommaText := AVertices;
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_VERTICES);
    if Assigned(LObj) and LObj.IsArray then
    begin
      LPageHt := 0;
      if Assigned(Page) then
        LPageHt := TgtPDPage(Page).GetPageHeight;
      for I := 0 to FVertices.Count - 1 do
      begin
        // odd entries will be Y - cord, convert it to windows cord
        LVertice := TgtPDArray(LObj).Get(I);
        if LVertice.IsReal then
        begin
          if (I mod 2) <> 0 then
            TgtPDReal(LVertice).Value := LPageHt - StringToFloatLocale(FVertices[I])
          else
            TgtPDReal(LVertice).Value := StringToFloatLocale(FVertices[I])
        end
        else if LVertice.IsInteger then
        begin
          TgtPDArray(LObj).Remove(I);
          if (I mod 2) <> 0 then
            LVertice := TgtPDReal.Create(LPageHt - StringToFloatLocale(FVertices[I]))
          else
            LVertice := TgtPDReal.Create(StringToFloatLocale(FVertices[I]));
          TgtPDArray(LObj).Insert(LVertice, I);
        end;
      end;
    end;
  end;
end;

end.
