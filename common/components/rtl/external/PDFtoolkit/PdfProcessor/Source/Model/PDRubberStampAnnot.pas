unit PDRubberStampAnnot;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAnnot;

type
  //The name of an icon to be used in displaying the annotation.
  TgtRubberStampIcon = (riApproved, riExperimental, riNotApproved, riAsIs,
    riExpired, riNotForPublicRelease, riConfidential, riFinal, riSold,
    riDepartmental, riForComment, riTopSecret, riDraft, riForPublicRelease);

  TgtPDRubberStampAnnot = class(TgtPDAnnot)
  private
    FIconName: TgtRubberStampIcon;

    function GetIconName: TgtRubberStampIcon;

    procedure SetIconName(const Value: TgtRubberStampIcon);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    property IconName: TgtRubberStampIcon read GetIconName
      write SetIconName default riDraft;
  end;

implementation

{ TgtPDRubberStampAnnot }

constructor TgtPDRubberStampAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotStamp;
end;

constructor TgtPDRubberStampAnnot.Create;
begin
  inherited;
  AnnotType := annotStamp;
  FIconName := riDraft;
end;

destructor TgtPDRubberStampAnnot.Destroy;
begin
  inherited;
end;

function TgtPDRubberStampAnnot.GetIconName: TgtRubberStampIcon;
begin
  Result := riDraft;
end;

procedure TgtPDRubberStampAnnot.SetIconName(const Value: TgtRubberStampIcon);
begin

end;

end.
