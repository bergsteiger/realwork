{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit CoPDPage;

interface

uses
  PDPageIntf, PDAnnotIntf, PDPage, CoPDAnnot, gtObjectIntf, PDElementIntf,
  PDBaseObjectIntf, PDBaseObject, PDElement, gtObject, CoPDElement,
  CoPDDocument, CoPDBaseObject, PDRectIntf, CoPDRect, PDRect, gtMethods, Contnrs,
  PDTypes;
type

  TgtCoPDPage = class(TgtPDCoPDElement, IgtPDPage)
  private
    FObjectList: TObjectList;
  public
    constructor Create(AParentDoc: IgtObject; AParentElement: IgtPDElement;
      ABaseObject: IgtPDBaseObject); overload;override;
    constructor Create(APage: TgtPDPage); overload;override;
    procedure Update; override;
    procedure AddAnnot(AddAfter: Integer; Annot: IgtPDAnnot); override;
//    function AddNewAnnot(AddAfter: Integer; AnnotType: TgtPDAnnotType;
//      InitialRect: TgtPDRect): TgtPDAnnot;
//    function CreateAnnot(AnnotType: TgtPDAnnotType;
//      InitialLocation: TgtPDRect): TgtPDAnnot;

    function GetPageSize: TPageSize;override;
    function GetPageHeight: Double;override;
    function GetPageWidth: Double;override;
//    function GetAnnots: TgtPDAnnotList;
//    function GetActions: TgtPDAction;
    procedure ReplaceContents(NewContents: IgtPDBaseObject);override;
//    procedure AddResource(ResType: TgtPDResourceType; const ResName: string;
//      ResObject: TgtPDBaseObject);
//
//    procedure EnumFontResources(FontEnumEvent: TgtPDEnumFontEvent);
//    procedure EnumXObjectResources(XObjectEnumEvent: TgtPDEnumXObjectEvent);
//    procedure EnumColorSpaceResources(ColorSpaceEnumEvent:
//      TgtPDEnumColorSpaceEvent);
//    procedure EnumProcSetResources(ProcSetEnumEvent: TgtPDEnumProcSetEvent);

//    procedure Display(OutDev: TgtPDExportDevice; hDPI, vDPI: Double;
//      Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean; Printing: Boolean);
//    procedure DisplaySlice(OutDev: TgtPDExportDevice; hDPI: Double; vDPI: Double;
//      Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean; SliceX: Integer;
//      SliceY: Integer; SliceW: Integer; SliceH: Integer; Printing:Boolean);
//    procedure MakeBox(hDPI: Double; vDPI: Double; Rotate: Integer;
//      UseMediaBox: Boolean; UpsideDown: Boolean; SliceX: Integer;
//      SliceY: Integer; SliceW: Integer; SliceH: Integer; Box: TgtPDRect;
//      var Crop: Boolean);
//    procedure ProcessLinks(OutDev: TgtPDExportDevice; Catatlog: TgtPDElement);
//    procedure GetDefaultCTM(Matix: TgtPDMatrix; hDPI: Double; vDPI: Double;
//      Rotate: Integer; uSeMediaBox, UpsideDown: Boolean);


    function GetPageNum: Integer;override;
    function GetMediaBox: IgtPDRect;override;
    function GetCropBox: IgtPDRect;override;
    function GetBleedBox: IgtPDRect;override;
    function GetTrimBox: IgtPDRect;override;
    function GetRotate: Integer;override;
    procedure SetRotate(ARotate: Integer);override;
    function GetDuration: Integer;override;
    procedure SetDuration(ADuration: Integer);override;
//    function GetContents: IgtPDContents;
//    function GetResources: IgtPDResources;
    procedure Delete;override;
    Destructor Destroy;override;
  end;

  TgtHackCoPDAnnot = class(TgtCoPDAnnot)

  end;

  TgtHackCoPDDocument = class(TgtCoPDDocument)

  end;

  TgtHackPDCoPDElement = class(TgtPDCoPDElement)

  end;

  TgtHackCoPDBaseObject = class(TgtCoPDBaseObject)

  end;

  function NewPDPage(AParentDoc: IgtObject; AParentElement: IgtPDElement;
      ABaseObject: IgtPDBaseObject): IgtPDPage; export; stdcall;
  procedure FreePDPage(Apage: IgtPDPage); export; stdcall;

implementation

uses
  PDDocument;

{ TgtCoPDPage }

procedure TgtCoPDPage.AddAnnot(AddAfter: Integer; Annot: IgtPDAnnot);
begin
  TgtPDPage(PDElement).AddAnnot(AddAfter, TgtHackCoPDAnnot(Annot).GetAnnot);
end;

constructor TgtCoPDPage.Create(AParentDoc: IgtObject;
  AParentElement: IgtPDElement; ABaseObject: IgtPDBaseObject);
begin
  PDElement := TgtPDPage.Create(TgtHackCoPDDocument(AParentDoc).GetDocument,
    TgtHackPDCoPDElement(AParentElement).PDElement, TgtHackCoPDBaseObject(ABaseObject).
    BaseObject);
  if not Assigned(FObjectList) then
    FObjectList := TObjectList.Create;
end;

constructor TgtCoPDPage.Create(APage: TgtPDPage);
begin
  if not Assigned(FObjectList) then
    FObjectList := TObjectList.Create;
  PDElement := APage;
end;

procedure TgtCoPDPage.Delete;
begin
//  if Assigned(PDElement) then PDElement.Free;
//  if Assigned(self) then self.Free;
end;

destructor TgtCoPDPage.Destroy;
begin
//  if Assigned(PDElement) then PDElement.Free;
  if Assigned (FObjectList) then
    FreeObject(FObjectList);
end;

function TgtCoPDPage.GetBleedBox: IgtPDRect;
var
  LBleedBox: TgtPDRect;
  LCoBleedBox: TgtCoPDRect;
begin
  LBleedBox := TgtPDPage(PDElement).Bleedbox;
  LCoBleedBox := TgtCoPDRect.Create(LBleedBox.Left, LBleedBox.Top, LBleedBox.Right,
    LBleedBox.Bottom);
  FreeObject(LBleedBox);
  Result := LCoBleedBox;
  FObjectList.Add(LCoBleedBox);
end;

function TgtCoPDPage.GetCropBox: IgtPDRect;
var
  LCropBox: TgtPDRect;
  LCoCropBox: TgtCoPDRect;
begin
  LCropBox := TgtPDPage(PDElement).Cropbox;
  LCoCropBox := TgtCoPDRect.Create(LCropBox.Left, LCropBox.Top, LCropBox.Right,
    LCropBox.Bottom);
  FreeObject(LCropBox);
  Result := LCoCropBox;
  FObjectList.Add(LCoCropBox);
end;

function TgtCoPDPage.GetDuration: Integer;
begin
  Result := TgtPDPage(PDElement).Duration;
end;

function TgtCoPDPage.GetMediaBox: IgtPDRect;
var
  LCoMediaBox: TgtCoPDRect;
begin
  LCoMediaBox := TgtCoPDRect.Create(TgtPDPage(PDElement).Mediabox.Left,
    TgtPDPage(PDElement).Mediabox.Top, TgtPDPage(PDElement).Mediabox.Right,
    TgtPDPage(PDElement).Mediabox.Bottom);

  Result := LCoMediaBox;
  FObjectList.Add(LCoMediaBox);
end;

function TgtCoPDPage.GetPageHeight: Double;
begin
  Result := TgtPDPage(PDElement).GetPageHeight;
end;

function TgtCoPDPage.GetPageNum: Integer;
begin
  Result := TgtPDPage(PDElement).PageNum;
end;

function TgtCoPDPage.GetPageSize: TPageSize;
var
  LPageSize: TgtPagesize;
begin
  LPageSize := TgtPDPage(PDElement).GetPageSize;
  Result.Width :=  LPageSize.Width;
  Result.Height := LPageSize.Height;
end;

function TgtCoPDPage.GetPageWidth: Double;
begin
  Result := TgtPDPage(PDElement).GetPageWidth;
end;

function TgtCoPDPage.GetRotate: Integer;
begin
  Result := TgtPDPage(PDElement).Rotate;
end;

function TgtCoPDPage.GetTrimBox: IgtPDRect;
var
  LTrimBox: TgtPDRect;
  LCoTrimBox: TgtCoPDRect;
begin
  LTrimBox := TgtPDPage(PDElement).TrimBox;
  LCoTrimBox := TgtCoPDRect.Create(LTrimBox.Left, LTrimBox.Top, LTrimBox.Right,
    LTrimBox.Bottom);
  FreeObject(LTrimBox);
  Result := LCoTrimBox;
  FObjectList.Add(LCoTrimBox);
end;

procedure TgtCoPDPage.ReplaceContents(NewContents: IgtPDBaseObject);
begin
  TgtPDPage(PDElement).ReplaceContents(TgtHackCoPDBaseObject(NewContents).BaseObject);
end;

procedure TgtCoPDPage.SetDuration(ADuration: Integer);
begin
  TgtPDPage(PDElement).Duration := ADuration;
end;

procedure TgtCoPDPage.SetRotate(ARotate: Integer);
begin
  TgtPDPage(PDElement).Rotate := ARotate;
end;

procedure TgtCoPDPage.Update;
begin
  TgtPDPage(PDElement).Update;
end;

function NewPDPage(AParentDoc: IgtObject; AParentElement: IgtPDElement;
  ABaseObject: IgtPDBaseObject): IgtPDPage; export; stdcall;
begin
  Result := TgtCoPDPage.Create(AParentDoc, AParentElement, ABaseObject);
end;

procedure FreePDPage(Apage: IgtPDPage); export; stdcall;
begin
  TgtCoPDPage(Apage).Free;
end;

end.
