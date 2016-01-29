{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit CoPDAnnot;

interface

uses
  PDAnnotIntf, PDAnnot, gtObjectIntf, PDElementIntf, PDBaseObjectIntf, CoPDElement,
  CoPDBaseObject, CoPDDocument;

type
  TgtCoPDAnnot = class(IgtPDAnnot)
  private
    FPDAnnot: TgtPDAnnot;
  public
//    constructor Create(AParentDoc: IgtObject; AParentElement: IgtPDElement;
//    ABaseObject: IgtPDBaseObject);

//    function MakeAnnot(AParentDoc: IgtObject; AParentElement: IgtPDElement;
//      ABaseObject: IgtPDBaseObject): IgtPDAnnot;     class functiom
    procedure Update;override;
    procedure RemoveOCMD;override;

//    function IsCurrentlyVisible(OCContext: TgtPDOCContext): Boolean;
    function IsValid: WordBool;override;
    Destructor Destroy;override;
  protected
    function GetAnnot: TgtPDAnnot;override;
  end;

  TgtHackPDCoPDElement = class(TgtPDCoPDElement)

  end;

  TgtHackCoPDBaseObject = class(TgtCoPDBaseObject)

  end;

  TgtHackCoPDDocument = class(TgtCoPDDocument)

  end;

  function NewPDAnnot(AParentDoc: IgtObject; AParentElement: IgtPDElement;
  ABaseObject: IgtPDBaseObject): IgtPDAnnot; export; stdcall;

implementation

{ TgtCoPDAnnot }

//constructor TgtCoPDAnnot.Create(AParentDoc: IgtObject;
//  AParentElement: IgtPDElement; ABaseObject: IgtPDBaseObject);
//begin
//  FPDAnnot := TgtPDAnnot.Create(TgtHackCoPDDocument(AParentDoc).GetDocument,
//    TgtHackPDCoPDElement(AParentElement).PDElement, TgtHackCoPDBaseObject(ABaseObject).
//    BaseObject)
//end;

destructor TgtCoPDAnnot.Destroy;
begin
  if Assigned(FPDAnnot) then FPDAnnot.Free;
end;

function TgtCoPDAnnot.GetAnnot: TgtPDAnnot;
begin
  Result := FPDAnnot;
end;

function TgtCoPDAnnot.IsValid: WordBool;
begin
  Result := FPDAnnot.IsValid;
end;

procedure TgtCoPDAnnot.RemoveOCMD;
begin
  FPDAnnot.RemoveOCMD;
end;

procedure TgtCoPDAnnot.Update;
begin
  FPDAnnot.Update;
end;

function NewPDAnnot(AParentDoc: IgtObject; AParentElement: IgtPDElement;
  ABaseObject: IgtPDBaseObject): IgtPDAnnot; export; stdcall;
begin
//  Result := TgtCoPDAnnot.Create(AParentDoc, AParentElement,ABaseObject);
end;

end.
