unit PDInkAnnot;

interface

uses
  Classes, gtObject, PDTypes, PDElement, PDBaseObject, PDAnnot;

type
  TgtPDInkAnnot = class(TgtPDAnnot)
  private
    FInkList: AnsiString;

    function GetInkList: AnsiString;

    procedure SetInkList(const Value: AnsiString);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

//  An array of n arrays, each representing a stroked path. Each array is a
//  series of alternating horizontal and vertical coordinates in default user space,
//  specifying points along the path. When drawn, the points are connected by
//  straight lines or curves in an implementation-dependent way.
// ** Current implementation takes care of only one complete stroke

    property InkList: AnsiString read GetInkList write SetInkList;
  end;

implementation

{ TgtPDInkAnnot }

constructor TgtPDInkAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotInk;
end;

constructor TgtPDInkAnnot.Create;
begin
  inherited;
  AnnotType := annotInk;
end;

destructor TgtPDInkAnnot.Destroy;
begin

  inherited;
end;

function TgtPDInkAnnot.GetInkList: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin

  end;
  Result := FInkList;
end;

procedure TgtPDInkAnnot.SetInkList(const Value: AnsiString);
begin
  if Assigned(FBaseObject) then
  begin

  end;

  FInkList := Value;
end;

end.
