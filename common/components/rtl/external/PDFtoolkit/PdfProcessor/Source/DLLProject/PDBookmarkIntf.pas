unit PDBookmarkIntf;

interface

uses
  PDElementIntf, PDActionIntf;

  //constants for enum TgtPDColorSpaceType
const
  Transparent = $00000000;
  DeviceGray = $00000001;
  DeviceRGB = $00000002;
  DeviceCMYK = $00000003;

type

  TPDColorValue = packed record
    ColorSpace: Integer;
    Value: array[0..3] of Double;
  end;

  TPDOutlineFlags = packed record
    Italic: Boolean;
    Bold: Boolean;
  end;

  IgtPDBookmark = Class(IgtPDElement)
    procedure Update; virtual;abstract;//override;
    function AddNewChild(const InitialText: Widestring): IgtPDBookmark;virtual;abstract;
    function AddNewSibling(const InitialText: Widestring): IgtPDBookmark;virtual;abstract;
    procedure AddChild(Bookmark: IgtPDBookmark);virtual;abstract;
    procedure AddNext(NewNext: IgtPDBookmark);virtual;abstract;
    procedure AddPrev(NewPrev: IgtPDBookmark);virtual;abstract;
    procedure AddSubTree(Source: IgtPDBookmark; const SourceTitle: Widestring);virtual;abstract;

    function GetByTitle(const Name: Widestring; MaxDepth: Integer): IgtPDBookmark;virtual;abstract;
    function GetColor(var Color: TPDColorValue): WordBool;virtual;abstract;
    function GetIndent: Integer;virtual;abstract;
    function HasChildren: WordBool;virtual;abstract;

    procedure RemoveAction;virtual;abstract;
    procedure SetColor(const Color: TPDColorValue);virtual;abstract;
    procedure UnLink;virtual;abstract;

    function GetLevel: Integer;virtual;abstract;
    procedure SetLevel(ALevel: Integer);virtual;abstract;
    function GetBookmarkIndex: Integer;virtual;abstract;
    procedure SetBookmarkIndex(AIndex: Integer);virtual;abstract;
    function GetAction: IgtPDAction;virtual;abstract;
    procedure SetAction(Action: IgtPDAction);virtual;abstract;
    function GetTitle: Widestring;virtual;abstract;
    procedure SetTitle(const Title: Widestring);virtual;abstract;
    function GetFlags: TPDOutlineFlags;virtual;abstract;
    procedure SetFlags(const Flags: TPDOutlineFlags);
    function GetCount: Integer;virtual;abstract;
    function GetFirstChild: IgtPDBookmark;virtual;abstract;
    function GetLastChild: IgtPDBookmark;virtual;abstract;
    function GetParent: IgtPDBookmark;virtual;abstract;
    function GetNext: IgtPDBookmark;virtual;abstract;
    function GetPrev: IgtPDBookmark;virtual;abstract;
  End;

  {$IFDEF DLLIMPORT}
    function NewPDBookmark: IgtPDBookmark; stdcall;
    procedure FreePDBookmark(ABookmark: IgtPDBookmark); stdcall;
  {$ENDIF}

implementation

  {$IFDEF DLLIMPORT}
    function NewPDBookmark; external 'PDFProcessor.dll';
    procedure FreePDBookmark(ABookmark: IgtPDBookmark); external 'PDFProcessor.dll';
  {$ENDIF}

end.
