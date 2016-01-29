unit PDPolyLineAnnot;

interface

uses
  Classes, gtObject, PDTypes, PDElement, PDBaseObject, PDAnnot, gtMethods,
  gtConstants;

type
  TgtPolyLineIntent = (
    //which indicates that the polyline annotation is intended to
    //function as a dimension (To be used only for PolyLine)
    itPolyLineDimension,
    itNone);

  TgtPDPolyLineAnnot = class(TgtPDAnnot)
  private
    FInteriorColor: TgtPDColorValue;
    FVertices: TStringList;
    FIntent: TgtPolyLineIntent;
    FLineBeginningStyle: TgtLineStyle;
    FLineEndingStyle: TgtLineStyle;

    function GetInteriorColor: TgtPDColorValue;
    function GetIntent: TgtPolyLineIntent;

    procedure SetInteriorColor(const Value: TgtPDColorValue);
    procedure SetIntent(const Value: TgtPolyLineIntent);
    function GetLineBeginningStyle: TgtLineStyle;
    function GetLineEndingStyle: TgtLineStyle;
    procedure SetLineBeginningStyle(const Value: TgtLineStyle);
    procedure SetLineEndingStyle(const Value: TgtLineStyle);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    function GetVertices: AnsiString;
    procedure SetVertices(AVertices: AnsiString);

    property InteriorColor: TgtPDColorValue read GetInteriorColor write SetInteriorColor;
    property Intent: TgtPolyLineIntent read GetIntent write SetIntent default itPolyLineDimension;
    property LineBeginningStyle: TgtLineStyle read GetLineBeginningStyle write SetLineBeginningStyle;
    property LineEndingStyle: TgtLineStyle read GetLineEndingStyle write SetLineEndingStyle;
  end;

implementation

{ TgtPDPolyLineAnnot }

uses
  PDDictionary, PDReal, PDInteger, PDName, PDArray, PDDocument, PDPage;

constructor TgtPDPolyLineAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotPolyLine
end;

constructor TgtPDPolyLineAnnot.Create;
begin
  inherited;
  AnnotType := annotPolyLine;
  FInteriorColor.Value[0] := 1;
  FInteriorColor.Value[1] := 1;
  FInteriorColor.Value[2] := 1;
end;

destructor TgtPDPolyLineAnnot.Destroy;
begin
  if Assigned(FVertices) then
    FVertices.Free;
  inherited;
end;

function TgtPDPolyLineAnnot.GetIntent: TgtPolyLineIntent;
begin
  Result := FIntent;
end;

function TgtPDPolyLineAnnot.GetInteriorColor: TgtPDColorValue;
begin
  Result := FInteriorColor;
end;

function TgtPDPolyLineAnnot.GetLineBeginningStyle: TgtLineStyle;
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

function TgtPDPolyLineAnnot.GetLineEndingStyle: TgtLineStyle;
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

function TgtPDPolyLineAnnot.GetVertices: AnsiString;
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

procedure TgtPDPolyLineAnnot.SetIntent(const Value: TgtPolyLineIntent);
begin

end;

procedure TgtPDPolyLineAnnot.SetInteriorColor(const Value: TgtPDColorValue);
begin

end;

procedure TgtPDPolyLineAnnot.SetLineBeginningStyle(const Value: TgtLineStyle);
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

procedure TgtPDPolyLineAnnot.SetLineEndingStyle(const Value: TgtLineStyle);
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

procedure TgtPDPolyLineAnnot.SetVertices(AVertices: AnsiString);
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
