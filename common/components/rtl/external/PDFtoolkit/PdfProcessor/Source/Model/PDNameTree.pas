unit PDNameTree;

interface

uses
  PDElement, iniFiles, SysUtils, PDBaseObject, gtObject;

type

  TgtPDNameTreeType = (nttDests, nttAppearence, nttJavaScript, nttPages,
    nttTemplates, nttIds, nttUrls, nttEmbeddedFiles, nttAlternatePresentations,
    nttRenditions);

  TgtPDNameTreeAddType = (ntaReplaced, ntaCreated, ntaAlreadyExists);

  TgtPDNameTree = class(TgtPDElement)
  private
  protected
    FTreeType: TgtPDNameTreeType;
//    FNameTreeList: THashedStringList;
  public
    property TreeType: TgtPDNameTreeType read FTreeType;
    function GetByName(AName: AnsiString): TgtPDElement; virtual;
    destructor Destroy; virtual;
  end;

implementation

{ TgtPDNameTree }

uses
  {PDDestTree,} PDDictionary;

destructor TgtPDNameTree.Destroy;
begin
//  if Assigned(FNameTreeList) then FreeAndNil(FNameTreeList);

end;

function TgtPDNameTree.GetByName(AName: AnsiString): TgtPDElement;
begin
  // raise exception
end;


end.
