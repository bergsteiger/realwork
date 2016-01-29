unit PDWatermarkAnnot;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAnnot, PDMatrix;

type
  TgtPDWatermarkAnnot = class(TgtPDAnnot)
  private
    FMatrix: TgtPDMatrix;
    FHTranslation: Double;
    FVTranslation: Double;

    function GetMatrix: TgtPDMatrix;
    function GetHTranslation: Double;
    function GetVTranslation: Double;

    procedure SetMatrix(Value: TgtPDMatrix);
    procedure SetHTranslation(Value: Double);
    procedure SetVTranslation(Value: Double);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    property Matrix: TgtPDMatrix read GetMatrix write SetMatrix;
    property HTranslation: Double read GetHTranslation write SetHTranslation;
    property VTranslation: Double read GetVTranslation write SetVTranslation;
  end;

implementation

{ TgtPDWatermarkAnnot }

constructor TgtPDWatermarkAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin

end;

destructor TgtPDWatermarkAnnot.Destroy;
begin

  inherited;
end;

function TgtPDWatermarkAnnot.GetHTranslation: Double;
begin
  Result := FHTranslation;
end;

function TgtPDWatermarkAnnot.GetMatrix: TgtPDMatrix;
begin
  Result := FMatrix;
end;

function TgtPDWatermarkAnnot.GetVTranslation: Double;
begin
  Result := FVTranslation;
end;

procedure TgtPDWatermarkAnnot.SetHTranslation(Value: Double);
begin

end;

procedure TgtPDWatermarkAnnot.SetMatrix(Value: TgtPDMatrix);
begin

end;

procedure TgtPDWatermarkAnnot.SetVTranslation(Value: Double);
begin

end;

end.
