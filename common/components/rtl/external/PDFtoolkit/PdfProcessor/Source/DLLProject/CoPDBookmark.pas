unit CoPDBookmark;

interface

uses
  PDBookmarkIntf, PDActionIntf, PDBookmark, gtObjectIntf, PDElementIntf,
    PDBaseObjectIntf, Contnrs, CogtObject, CoPDElement, CoPDBaseObject,
    CoPDAction, PDAction, PDTypes;

type

  TgtCoPDBookmark = class(IgtPDBookmark)
  private
    FPDBookmark: TgtPDBookmark;
    FObjectList: TObjectList;
  public
    constructor Create(AParentDoc: IgtObject; AParentElement: IgtPDElement;
      ABaseObject: IgtPDBaseObject); overload;override;
    constructor Create(APDBookmark: TgtPDBookmark); overload;override;
    destructor Destroy; override;
    procedure Update; override;
    function AddNewChild(const InitialText: Widestring): IgtPDBookmark;override;
    function AddNewSibling(const InitialText: Widestring): IgtPDBookmark;override;
    procedure AddChild(Bookmark: IgtPDBookmark);override;
    procedure AddNext(NewNext: IgtPDBookmark);override;
    procedure AddPrev(NewPrev: IgtPDBookmark);override;
    procedure AddSubTree(Source: IgtPDBookmark; const SourceTitle: Widestring);override;
    function GetByTitle(const Name: Widestring; MaxDepth: Integer): IgtPDBookmark;override;
    function GetColor(var Color: TPDColorValue): WordBool;override;
    function GetIndent: Integer;override;
    function HasChildren: WordBool;override;
    procedure RemoveAction;override;
    procedure SetColor(const Color: TPDColorValue);override;
    procedure UnLink;override;

    function GetLevel: Integer;override;
    procedure SetLevel(ALevel: Integer);override;
    function GetBookmarkIndex: Integer;override;
    procedure SetBookmarkIndex(AIndex: Integer);override;
    function GetAction: IgtPDAction;override;
    procedure SetAction(Action: IgtPDAction);override;
    function GetTitle: Widestring;override;
    procedure SetTitle(const Title: Widestring);override;
    function GetFlags: TPDOutlineFlags;override;
    procedure SetFlags(const Flags: TPDOutlineFlags);override;
    function GetCount: Integer;override;
    function GetFirstChild: IgtPDBookmark;override;
    function GetLastChild: IgtPDBookmark;override;
    function GetParent: IgtPDBookmark;override;
    function GetNext: IgtPDBookmark;override;
    function GetPrev: IgtPDBookmark;override;
    constructor Create; overload;override;
  end;

  function NewPDBookmark: IgtPDBookmark; export; stdcall;
  procedure FreePDBookmark(APDBookmark: IgtPDBookmark); export; stdcall;

type

  TgtHackCogtObject = class(TgtCoObject)

  end;

  TgtHackPDCoPDElement = class(TgtPDCoPDElement)

  end;

  TgtHackCoPDBaseObject = class(TgtCoPDBaseObject)

  end;

  TgtHackCoPDAction = class(TgtCoPDAction)

  end;

implementation

function NewPDBookmark: IgtPDBookmark; export; stdcall;
begin

end;

procedure FreePDBookmark(APDBookmark: IgtPDBookmark); export; stdcall;
begin

end;

{ TgtCoPDBookmark }

procedure TgtCoPDBookmark.AddChild(Bookmark: IgtPDBookmark);
begin
  FPDBookmark.AddChild(TgtCoPDBookmark(Bookmark).FPDBookmark);
end;

function TgtCoPDBookmark.AddNewChild(
  const InitialText: Widestring): IgtPDBookmark;
begin
  FPDBookmark.AddNewChild(InitialText);
end;

function TgtCoPDBookmark.AddNewSibling(
  const InitialText: Widestring): IgtPDBookmark;
begin
  FPDBookmark.AddNewSibling(InitialText);
end;

procedure TgtCoPDBookmark.AddNext(NewNext: IgtPDBookmark);
begin
  FPDBookmark.AddNext(TgtCoPDBookmark(NewNext).FPDBookmark);
end;

procedure TgtCoPDBookmark.AddPrev(NewPrev: IgtPDBookmark);
begin
  FPDBookmark.AddPrev(TgtCoPDBookmark(NewPrev).FPDBookmark);
end;

procedure TgtCoPDBookmark.AddSubTree(Source: IgtPDBookmark;
  const SourceTitle: Widestring);
begin
  FPDBookmark.AddSubTree(TgtCoPDBookmark(Source).FPDBookmark, SourceTitle);
end;

constructor TgtCoPDBookmark.Create;
begin
  FObjectList := TObjectList.Create(False);
end;

constructor TgtCoPDBookmark.Create(APDBookmark: TgtPDBookmark);
begin
  FPDBookmark := APDBookmark;
end;

constructor TgtCoPDBookmark.Create(AParentDoc: IgtObject;
  AParentElement: IgtPDElement; ABaseObject: IgtPDBaseObject);
begin
  FPDBookmark.Create(TgtHackCogtObject(AParentDoc).gtObject,
    TgtHackPDCoPDElement(AParentElement).PDElement,
    TgtHackCoPDBaseObject(ABaseObject).BaseObject);
end;

destructor TgtCoPDBookmark.Destroy;
begin

  inherited;
end;

function TgtCoPDBookmark.GetAction: IgtPDAction;
var
  LCoPDAction: TgtCoPDAction;
  LPDAction: TgtPDAction;
begin
  LPDAction := FPDBookmark.Action;
  LCoPDAction := TgtCoPDAction.Create(LPDAction);
  FObjectList.Add(LCoPDAction);
  Result := LCoPDAction;
end;

function TgtCoPDBookmark.GetBookmarkIndex: Integer;
begin
  Result := FPDBookmark.BookmarkIndex;
end;

function TgtCoPDBookmark.GetByTitle(const Name: Widestring;
  MaxDepth: Integer): IgtPDBookmark;
var
  LPDBookmark: TgtPDBookmark;
  LCoPDBookmark: TgtCoPDBookmark;
begin
  LPDBookmark := FPDBookmark.GetByTitle(Name, MaxDepth);
  LCoPDBookmark := TgtCoPDBookmark.Create(LPDBookmark);
  Result := LCoPDBookmark;
end;

function TgtCoPDBookmark.GetColor(var Color: TPDColorValue): WordBool;
var
  LgtPDColorValue: TgtPDColorValue;
  LI: Integer;
begin
  LgtPDColorValue.ColorSpace := TgtPDColorSpaceType(Color.ColorSpace);
  for LI := 0 to 3 do
  begin
    LgtPDColorValue.Value[LI] := Color.Value[LI];
  end;
  FPDBookmark.GetColor(LgtPDColorValue)
end;

function TgtCoPDBookmark.GetCount: Integer;
begin
  Result := FPDBookmark.Count;
end;

function TgtCoPDBookmark.GetFirstChild: IgtPDBookmark;
var
  LPDBookmark: TgtPDBookmark;
  LCoPDBookmark: TgtCoPDBookmark;
begin
  LPDBookmark := FPDBookmark.FirstChild;
  LCoPDBookmark := TgtCoPDBookmark.Create(LPDBookmark);
  Result := LCoPDBookmark;
end;

function TgtCoPDBookmark.GetFlags: TPDOutlineFlags;
var
  LgtPDOutlineFlags: TgtPDOutlineFlags;
begin
  LgtPDOutlineFlags := FPDBookmark.Flags;
  Result.Italic := LgtPDOutlineFlags.Italic;
  Result.Bold := LgtPDOutlineFlags.Bold;
end;

function TgtCoPDBookmark.GetIndent: Integer;
begin
  Result := FPDBookmark.GetIndent;
end;

function TgtCoPDBookmark.GetLastChild: IgtPDBookmark;
var
  LPDBookmark: TgtPDBookmark;
  LCoPDBookmark: TgtCoPDBookmark;
begin
  LPDBookmark := FPDBookmark.LastChild;
  LCoPDBookmark := TgtCoPDBookmark.Create(LPDBookmark);
  Result := LCoPDBookmark;
end;

function TgtCoPDBookmark.GetLevel: Integer;
begin
  Result := FPDBookmark.Level;
end;

function TgtCoPDBookmark.GetNext: IgtPDBookmark;
var
  LPDBookmark: TgtPDBookmark;
  LCoPDBookmark: TgtCoPDBookmark;
begin
  LPDBookmark := FPDBookmark.Next;
  LCoPDBookmark := TgtCoPDBookmark.Create(LPDBookmark);
  Result := LCoPDBookmark;
end;

function TgtCoPDBookmark.GetParent: IgtPDBookmark;
var
  LPDBookmark: TgtPDBookmark;
  LCoPDBookmark: TgtCoPDBookmark;
begin
  LPDBookmark := FPDBookmark.Parent;
  LCoPDBookmark := TgtCoPDBookmark.Create(LPDBookmark);
  Result := LCoPDBookmark;
end;

function TgtCoPDBookmark.GetPrev: IgtPDBookmark;
var
  LPDBookmark: TgtPDBookmark;
  LCoPDBookmark: TgtCoPDBookmark;
begin
  LPDBookmark := FPDBookmark.Prev;
  LCoPDBookmark := TgtCoPDBookmark.Create(LPDBookmark);
  Result := LCoPDBookmark;
end;

function TgtCoPDBookmark.GetTitle: Widestring;
begin
  Result := FPDBookmark.Title;
end;

function TgtCoPDBookmark.HasChildren: WordBool;
begin
  Result := FPDBookmark.HasChildren;
end;

procedure TgtCoPDBookmark.RemoveAction;
begin
  FPDBookmark.RemoveAction;
end;

procedure TgtCoPDBookmark.SetAction(Action: IgtPDAction);
begin
  FPDBookmark.Action := TgtHackCoPDAction(Action).PDAction;
end;

procedure TgtCoPDBookmark.SetBookmarkIndex(AIndex: Integer);
begin
  FPDBookmark.BookmarkIndex := AIndex;
end;

procedure TgtCoPDBookmark.SetColor(const Color: TPDColorValue);
var
  LgtPDColorValue: TgtPDColorValue;
  LI: Integer;
begin
  LgtPDColorValue.ColorSpace := TgtPDColorSpaceType(Color.ColorSpace);
  for LI := 0 to 3 do
  begin
    LgtPDColorValue.Value[LI] := Color.Value[LI];
  end;
  FPDBookmark.SetColor(LgtPDColorValue);
end;

procedure TgtCoPDBookmark.SetFlags(const Flags: TPDOutlineFlags);
var
  LPDOutlineFlags: TgtPDOutlineFlags;
begin
  LPDOutlineFlags := FPDBookmark.Flags;
  LPDOutlineFlags.Italic := Flags.Italic;
  LPDOutlineFlags.Bold := Flags.Bold;
end;

procedure TgtCoPDBookmark.SetLevel(ALevel: Integer);
begin
  FPDBookmark.Level := ALevel;
end;

procedure TgtCoPDBookmark.SetTitle(const Title: Widestring);
begin
  FPDBookmark.Title := Title;
end;

procedure TgtCoPDBookmark.UnLink;
begin
  FPDBookmark.UnLink;
end;

procedure TgtCoPDBookmark.Update;
begin
  inherited;
  FPDBookmark.Update;
end;

end.
