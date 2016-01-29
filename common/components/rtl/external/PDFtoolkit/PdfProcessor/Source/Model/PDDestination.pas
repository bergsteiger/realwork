{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDDestination;

interface

uses
  PDElement, PDBaseObject, gtObject, PDTypes, PDRect;

type
  TgtPDDestination = class(TgtPDElement)
  private
    FPage: TgtObject;
    FDisplayOption: TgtPageDisplayOptions;
    FRect: TgtPDRect;
    FIsRectSet: Boolean;

    function GetPage: TgtObject;
    function GetDisplayOption: TgtPageDisplayOptions;
    function GetRect: TgtPDRect;

    procedure SetPage(Value: TgtObject);
    procedure SetDisplayOption(Value: TgtPageDisplayOptions);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create(AParentDoc: TgtObject; APage: TgtObject; ADisplayOption:
      TgtPageDisplayOptions; ARect: TgtPDRect); overload;
    constructor Create; overload;

    destructor Destroy; override;
    procedure Update; override;

    property Page: TgtObject read GetPage write SetPage;
    property DisplayOptions: TgtPageDisplayOptions read GetDisplayOption
      write SetDisplayOption;
    property Rect: TgtPDRect read GetRect;
  end;

implementation

uses
  gtMethods, gtConstants, PDArray, PDReal, PDInteger, PDName, PDDocument, PDPage;

{ TgtPDDestination }

constructor TgtPDDestination.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FRect := TgtPDRect.Create;
  FIsRectSet := False;
end;

constructor TgtPDDestination.Create(AParentDoc: TgtObject; APage: TgtObject;
  ADisplayOption: TgtPageDisplayOptions; ARect: TgtPDRect);
begin
  FParentDoc := AParentDoc;
  FPage := APage;
  FDisplayOption := ADisplayOption;
  FRect := TgtPDRect.Create;
  if Assigned(ARect) then
  begin
    with ARect do
    begin
      FRect.Left := Left;
      FRect.Top := Top;
      FRect.Right := Right;
      FRect.Bottom := Bottom;
    end;
    FIsRectSet := True;
  end
  else
    FIsRectSet := False;
end;

constructor TgtPDDestination.Create;
begin
  FPage := nil;
  FBaseObject := nil;
  FDisplayOption := None;
  FRect := TgtPDRect.Create;
  FIsRectSet := False;
end;

destructor TgtPDDestination.Destroy;
begin
  if Assigned(FRect) then
    FreeObject(FRect);
  inherited;
end;

function TgtPDDestination.GetDisplayOption: TgtPageDisplayOptions;
var
  LObj: TgtPDBaseObject;
  LDisplayType: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    if FDisplayOption = None then
    begin
      LObj := TgtPDArray(FBaseObject).Get(1);
      LDisplayType := TgtPDName(LObj).Value;
      if LDisplayType = PDF_XYZ then
        FDisplayOption := FitZoom
      else if LDisplayType = PDF_FIT then
        FDisplayOption := FitAll
      else if LDisplayType = PDF_FITH then
        FDisplayOption := FitHeight
      else if LDisplayType = PDF_FITV then
        FDisplayOption := FitWidth
      else if LDisplayType = PDF_FITR then
        FDisplayOption := FitRect
      else if LDisplayType = PDF_FITB then
        FDisplayOption := FitBoundingBox
      else if LDisplayType = PDF_FITBH then
        FDisplayOption := FitBoundingBoxHeight
      else if LDisplayType = PDF_FITBV then
        FDisplayOption := FitBoundingBoxWidth;
    end;
  end;

  Result := FDisplayOption;
end;

function TgtPDDestination.GetPage: TgtObject;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FPage) then
    begin
      LObj := TgtPDArray(FBaseObject).GetRefObj(0);
      FPage := TgtPDDocument(FParentDoc).GetPageByIndRef(LObj) as TgtPDPage;
    end;
  end;

  Result := FPage;
end;

function TgtPDDestination.GetRect: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if not (FIsRectSet) then
    begin
      case GetDisplayOption of
        FitZoom:
          begin
            LObj := TgtPDArray(FBaseObject).Get(2); //Left
            if LObj.IsReal then
              FRect.Left := TgtPDReal(LObj).Value
            else
              FRect.Left := TgtPDInteger(LObj).Value;

            LObj := TgtPDArray(FBaseObject).Get(3); //Top
            if LObj.IsReal then
              FRect.Top := TgtPDReal(LObj).Value
            else
              FRect.Top := TgtPDInteger(LObj).Value;

            LObj := TgtPDArray(FBaseObject).Get(4); //Zoom (Right is used for storing Zoom value)
            if LObj.IsReal then
              FRect.Right := TgtPDReal(LObj).Value
            else
              FRect.Right := TgtPDInteger(LObj).Value;

            FRect.Bottom := 0; //No Right and Bottom in this case
          end;
        FitAll:
          begin
            FRect.Left := 0;
            FRect.Top := 0;
            FRect.Right := 0;
            FRect.Bottom := 0;
          end;
        FitHeight:
          begin
            LObj := TgtPDArray(FBaseObject).Get(2); //Top
            if LObj.IsReal then
              FRect.Top := TgtPDReal(LObj).Value
            else
              FRect.Top := TgtPDInteger(LObj).Value;

            FRect.Left := 0;
            FRect.Right := 0;
            FRect.Bottom := 0;
          end;
        FitWidth:
          begin
            LObj := TgtPDArray(FBaseObject).Get(2); //Top
            if LObj.IsReal then
              FRect.Left := TgtPDReal(LObj).Value
            else
              FRect.Left := TgtPDInteger(LObj).Value;

            FRect.Top := 0;
            FRect.Right := 0;
            FRect.Bottom := 0;
          end;
        FitRect:
          begin
            LObj := TgtPDArray(FBaseObject).Get(2); //Left
            if LObj.IsReal then
              FRect.Left := TgtPDReal(LObj).Value
            else
              FRect.Left := TgtPDInteger(LObj).Value;

            LObj := TgtPDArray(FBaseObject).Get(3); //Top
            if LObj.IsReal then
              FRect.Top := TgtPDReal(LObj).Value
            else
              FRect.Top := TgtPDInteger(LObj).Value;

            LObj := TgtPDArray(FBaseObject).Get(4); //Right
            if LObj.IsReal then
              FRect.Right := TgtPDReal(LObj).Value
            else
              FRect.Right := TgtPDInteger(LObj).Value;

            LObj := TgtPDArray(FBaseObject).Get(5); //Bottom
            if LObj.IsReal then
              FRect.Bottom := TgtPDReal(LObj).Value
            else
              FRect.Bottom := TgtPDInteger(LObj).Value;
          end;
        FitBoundingBox:
          begin
            FRect.Left := 0;
            FRect.Top := 0;
            FRect.Right := 0;
            FRect.Bottom := 0;
          end;
        FitBoundingBoxHeight:
          begin
            LObj := TgtPDArray(FBaseObject).Get(2); //Top
            if LObj.IsReal then
              FRect.Top := TgtPDReal(LObj).Value
            else
              FRect.Top := TgtPDInteger(LObj).Value;

            FRect.Left := 0;
            FRect.Right := 0;
            FRect.Bottom := 0;
          end;
        FitBoundingBoxWidth:
          begin
            LObj := TgtPDArray(FBaseObject).Get(2); //Left
            if LObj.IsReal then
              FRect.Left := TgtPDReal(LObj).Value
            else
              FRect.Left := TgtPDInteger(LObj).Value;

            FRect.Top := 0;
            FRect.Right := 0;
            FRect.Bottom := 0;
          end;
      end;
      FIsRectSet := True;
    end;
  end;
  Result := FRect;
end;

procedure TgtPDDestination.SetDisplayOption(Value: TgtPageDisplayOptions);
begin
  FDisplayOption := Value;
end;

procedure TgtPDDestination.SetPage(Value: TgtObject);
begin
  FPage := Value;
end;

procedure TgtPDDestination.Update;
begin
  inherited;

end;

end.
