{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }
{$I ..\Utils\gtCompilerDefines.inc}

unit PDDocument;

interface

uses
  Classes, gtObject, PDBaseDoc, PDPage, PDTypes, PDBaseObject, PDPageTree,
  PDCatalog, PDThread, PDNameTree, PDTextSelect, PDThumb, PDFont, PDOCConfig,
  PDOCG, PDResource, PDXObject, PDColorSpace, PDAnnot, PDOCContext, PDBookmark,
  PDAction, PDPageLabel, PDRect, PDColorValue, PDExportDevice, PDDocInfo,
  PDViewerPreference, PDFormField, PDDictionary, gtFont, PDStream, PDDestination,
  EncryptionSettings, Contnrs, Windows, Graphics, SysUtils, PDSignature,
  PDSignatureField;

type
  TgtPDVersion = (v10, v11, v12, v13, v14, v15, v16, v17);

  //A callback used by LoadDocument. It is called when an encrypted document is
  //being opened to determine whether the user is authorized to open the file.
  TgtPDAuthorizeDocEvent = procedure(Document: TgtObject) of object;

  TgtPDCancelEvent = procedure(var Cancel: Boolean) of object;

  TgtPDSaveFlags = record
    //Save only those portions of the document that have changed. This is
    //provided only as the opposite of Full
    Incremental: Boolean;

    //Save the entire document.
    Full: Boolean;

    //Save a copy of the document(the PDDocument continues to use the old file).
    //This flag is ignored if PDSaveFull is off.
    Copy: Boolean;

    //Write the PDF file in a format that is optimized for page-served remote
    //(network) access (linearized). This flag is ignored if Full is off.
    Linearize: Boolean;

    //Save the document parts once the operations on it is completed
    UniDirectional: Boolean;

    //Do not update ModDate in InfoDict.
    KeepModDate: Boolean;

    //Do not use object streams when saving the document (decompress all
    //objects). The result is compatible with all versions of PDF and Acrobat.
    //This flag is ignored if Full is off.
    UnCompressed: Boolean;

    //Compress objects, without restrictions about which objects to compress.
    //The result is compatible only with PDF 1.5 (Acrobat 6) or later. This flag
    //is ignored if Full is off.
    Compressed: Boolean;

    //Compress only those objects that are related to logical structure (for
    //example, tagged PDF). The result is compatible with any version of PDF or
    //Acrobat, but the compressed objects are usable only in PDF 1.5 (Acrobat 6).
    //This flag is ignored if Full is off.
    CompressStructureOnly: Boolean;

    //Remove ASCII85 filters from all streams. This flag is ignored if Full is off.
    RemoveASCIIFilters: Boolean;

    //Encode any unencoded stream with Flate, except for metadata streams, which
    //are never encoded, and for streams that would be larger if encoded. This
    //flag is ignored if Full is off.
    AddFlate: Boolean;

    //Replace all LZW filters with FlateEncode filters. This flag is ignored if
    //Full is off.
    ReplaceLZW: Boolean;

    //Merge identical forms and images, as determined by an MD5 hash of their
    //contents (it causes OptimizeXObjects() to be called).
    OptimizeXObjects: Boolean;

    //Looks for common initial sub-sequences among content streams (the
    //sequences of marking operators), and generate substreams that can be
    //shared (it causes OptimizeGraphics() to be called).
    OptimizeContentStreams: Boolean;

    //Merge identical font descriptors and encodings. Does not merge the
    //top-level font dictionary (it causes OptimizeFonts() to be called).
    OptimizeFonts: Boolean;

    //Delete symbols specific to deleted images from JBIG2 dictionaries that
    //could not be processed at the time of image deletion(it causes
    //OptimizeMarkedJBIG2Dictionaries() to be called).
    OptimizeMarkedJBIG2Dictionaries: Boolean;
  end;

//  TgtsigInsertEvent = procedure (ASignature: TgtPDSignature; AStatusCode: )
//    of object;
//    TgtSignedDocAlteredEvent = procedure(ASignature: TgtPDSignature; var AAction:
//    (saRemove, saForce, saAbort));
  TgtFormField = class of TgtPDFormField;

 (**
  * A PDDocument object represents a PDF document.
  *
  *
  *
  *)
  TgtPDDocument = class(TgtObject)
  private
    FBaseDoc: TgtPDBaseDoc;

    FCatalog: TgtPDCatalog;

    FVersion: TgtPDVersion;
    FAuthorizeEvent: TgtPDAuthorizeDocEvent;
    FPageRequestEvent: TgtRequestPagesEvent;
    FFileName: AnsiString;
//    FFontName: AnsiString;
//    FFont: TgtPDFont;
    FStream: TStream;
    FFontDir: TStringList;
    FDocInfo: TgtPDDocInfo;
    FViewerPreference: TgtPDViewerPref;
    FOnEnumFontEvent: TgtPDEnumFontEvent;
    FFreeStream: Boolean;

    FPassword: AnsiString; // Password for the document
    FTries: Integer; // Number of Tries
    FPermissions: TgtPDPermissions;
    FUserEncryptionSettings: TgtEncryptionSettings;

    FFontList: TStrings;
    FgtPDFontList: TObjectList;
    FIsEncrypted: Boolean;
    FCMapDict: AnsiString;
    FMetadata: AnsiString;
    FCMapPath: string;

    FSignatures: TgtPDSignatures;
    FSignatureFields: TgtPDSignatureFields;
    FIsSigned: Boolean;

    FUseDualEMFPlus: Boolean;
    FBlankDocStrm: TStringStream;
    function GetLastObjectNumber: Cardinal;
    procedure SetLastObjectNumber(const Value: Cardinal);
    function GetBaseDoc: TgtPDBaseDoc;
    function GetPDFVersion: TgtPDVersion;
    function GetVersion: TgtPDVersion;
    procedure SetVersion(const Value: TgtPDVersion);
    function GetAuthorizeEvent: TgtPDAuthorizeDocEvent;
    procedure SetAuthorizeEvent(const Value: TgtPDAuthorizeDocEvent);
    function GetPageCount: Integer;
    function GetPage(Index: Integer): TgtPDPage;
//    procedure FontEventCallBack(Font: TgtPDFont; var Name: AnsiString; var Continue: Boolean);
    function GetIsOwner: Boolean;
    function GetDocInfo: TgtPDDocInfo;
    function MapUserpermissions(AuserPerm: TgtPDPermissions): TgtUserPermissions;
    procedure SetIsEncrypted(const Value: Boolean);
    function GetIsEncrypted: Boolean;
    function GetPermission: TgtPDPermissions;
    function GetSigFields: TgtPDSignatureFields;
    {$IFNDEF DLLPROJECT}
    function GetFonts: TStrings;
    procedure RenderImage(AStream: TStream; APageNum: Integer;
      AxDPI, AyDPI: Double; ARotationAngle: Integer; AntiAliasing, APrinting: Boolean);
    procedure RenderRotatedImage(AHDC: HDC; AStream: TStream; APageNum: Integer; AWidth,
      AHeight: Cardinal; AxDPI, AyDPI: Double; ARotationAngle: Integer;
      AntiAliasing, APrinting: Boolean);
    function GetCMapPath: string;
    procedure SetCMapPath(const Value: string);
    {$ENDIF}
    function GetIsSigned: Boolean;
    function GetSignatures: TgtPDSignatures;
    function GetSignatureCount: Integer;
    function GetSignatureFieldCount: Integer;
    procedure SetUseDualEMFPlus(value: Boolean);
    function GetUseDualEMFPlus: Boolean;
  public
    constructor Create; overload;
    constructor Create(ABaseDoc: TgtPDBaseDoc); overload;
    destructor Destroy; override;

    procedure NewDocument(Rect: TgtPDRect);
    procedure LoadDocument(const FileName: AnsiString; DoRepair: Boolean); overload;
    procedure LoadDocument(Stream: TStream; DoRepair: Boolean;
      FreeStream: Boolean = False); overload;

    procedure SaveDocument(const FileName: AnsiString; SaveFlags: TgtPDSaveFlags); overload;
    procedure SaveDocument(Stream: TStream; SaveFlags: TgtPDSaveFlags); overload;

    procedure CloseDocument;
    procedure CopyToFile(const FileName: AnsiString; SaveChanges: Boolean;
      CancelEvent: TgtPDCancelEvent);
    function GetFileName: AnsiString;

    function GetPageByIndRef(APageRef: TgtPDBaseObject): TgtPDPage;
    function GetFormFieldByRef(AFormFieldRef: TgtPDBaseObject): TgtPDFormField;
    function CreatePage(AfterPage: Integer; MediaBox: TgtPDRect): TgtPDPage;
    procedure DeletePages(FirstPage: Integer; LastPage: Integer);
    procedure DeletePage(PageNumber: Integer);
    function GetPageBaseObject(PageNumber: Integer): TgtPDBaseObject;
    procedure InsertPages(AfterPage: Integer; SourceDoc: TgtPDDocument;
      SourceStartPage, NumOfPages: Integer; InsertFlags: TgtPageInsertFlages);
    procedure MovePage(MoveToAfterPage: Integer; PageToMove: Integer);
    procedure ReplacePages(StartPage: Integer; SourceDoc: TgtPDDocument;
      SourceStartPage, NumOfPages: Integer; MergeTextAnnots: Boolean);
    procedure RequestPages(StartPage: Integer; NumOfPages: Integer;
      RequestPagesEvent: TgtRequestPagesEvent);
    procedure MergeDocs(SourceDoc: TgtPDDocument; InsertFlags: TgtPageInsertFlages);
    procedure AppendPages(SourceDoc: TgtPDDocument; SourceStartPage,
      NumOfPages: Integer; InsertFlags: TgtPageInsertFlages);

    procedure DisplayPages(ExportDev: TgtPDExportDevice; FirstPage: Integer;
      LastPage: Integer; hDPI, vDPI: Double; Rotate: Integer; UseMediaBox:
      Boolean; Crop: Boolean; Printing: Boolean; RenderAnnots: Boolean = True);
    procedure DisplayPage(ExportDev: TgtPDExportDevice; PageNum: Integer; hDPI,
      vDPI: Double; Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean;
      Printing: Boolean; RenderAnnots: Boolean = True);
    procedure DisplaySlice(ExportDev: TgtPDExportDevice; PageNum: Integer; DPI,
      vDPI: Double; Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean;
      Printing: Boolean; SliceX: Integer; SliceY: Integer; SliceW: Integer;
      SliceH: Integer; RenderAnnots: Boolean = True);

    {$IFNDEF DLLPROJECT}
    procedure RenderToCanvas(AHDC: HDC; APageNum: Integer;
      AWidth, AHeight: Cardinal; AxDPI: Double = 72; AyDPI: Double = 72;
      ARotationAngle: Integer = 0; AntiAliasing: Boolean = True;
      APrinting: Boolean = False);
    procedure RenderImageToDC(AEMFPlusStream: TStream; AHDC: HDC; AWidth,
      AHeight: Cardinal; AxDPI: Double = 72; AyDPI: Double = 72;
      ARotationAngle: Integer = 0; AntiAliasing: Boolean = True;
      APrinting: Boolean = False);
    procedure RenderToMetafile(AEMFPlusStream: TStream; APageNum: Integer;
      AWidth, AHeight: Cardinal; AxDPI: Double = 72; AyDPI: Double = 72;
      ARotationAngle: Integer = 0; AntiAliasing: Boolean = True;
      APrinting: Boolean = False);

    //These functions should be called by using application before calling any
    //functions of this lib(StartGDIPlus) and after the use of the lib (StopGDIPlus)
    class procedure StartGDIPlus;
    class procedure StopGDIPlus;
    {$ENDIF}

    procedure AddThread(AddAfterIndex: Integer; Thread: TgtPDThread);
    function GetNumThreads: Integer;
    function GetThread(Index: Integer): TgtPDThread;
    procedure RemoveThread(Index: Integer);

    procedure AddWatermarkFromPage(Page: TgtPDPage;
      WatermarkParams: TgtPDAddWatermarkParams);
    procedure AddWatermarkFromText(TextParams: TgtPDWatermarkTextParams;
      WatermarkParams: TgtPDAddWatermarkParams);

    function Authorize(var PermsWanted: TgtPDPermissions; var APassword: AnsiString): TgtPDPermissions;
    function GetPermissions: TgtPDPermissions;

    procedure GetInfo(const InfoKey: AnsiString; var Value: AnsiString);
    procedure SetDocInfo(const InfoKey: AnsiString; const Value: AnsiString);
    function GetViewerPref: TgtPDViewerPref;

    function CountXMPMetadataArrayItems(const NameSpace: AnsiString;
      const Path: AnsiString): Integer;
    function GetXMPMetadataArrayItem(const NameSpaceName: AnsiString; const Path:
      AnsiString; Index: Integer): AnsiString;
    procedure SetXMPMetadataArrayItem(const NameSpace: AnsiString; const
      NamespacePrefix: AnsiString; const Path: AnsiString; Index: Integer;
      const NewValue: AnsiString);
    function GetXMPMetadataProperty(const NameSpaceName: AnsiString; const Path:
      AnsiString): AnsiString;
    procedure SetXMPMetadataProperty(const NameSpace: AnsiString; const
      NamespacePrefix: AnsiString; const Path: AnsiString; const NewValue: AnsiString);
    function GetMergedXMPKeywords: AnsiString;
    procedure MergeXMPKeywords;
    function GetTrapped: TgtPDTrapped;
    procedure SetTrapped(Value: TgtPDTrapped);
    function GetXMPMetadata: AnsiString;
    procedure SetXMPMetadata(const Metadata: AnsiString);

    function CreateNameTree(const TreeName: AnsiString): TgtPDNameTree;
    function GetNameTree(const TreeName: AnsiString): TgtPDNameTree;
    procedure RemoveNameTree(const TreeName: AnsiString);

    function CreateTextSelect(PageNum: Integer; BoundingRect:
      TgtPDRect): TgtPDTextSelect;

    procedure AddThumbnails(FirstPage: Integer; LastPage: Integer;
      Server: TgtPDThumbsCreationServer; ColorSpace: TgtPDColorSpaceType;
      BitsPerComp: Integer; HiVal: Integer; const LookupTable: AnsiString);
    procedure DeleteThumbs(FirstPage: Integer; LastPage: Integer);

    procedure EnumFonts(FirstPage: Integer; LastPage: Integer;
      FontEnumEvent: TgtPDEnumFontEvent);
    procedure EnumLoadedFonts(FontEnumEvent: TgtPDEnumFontEvent);
    procedure EnumXObjectResources(StartPage, EndPage: Integer;
      XObjectEnumEvent: TgtPDEnumXObjectEvent);
    procedure EnumColorSpaceResources(StartPage, EndPage: Integer;
      ColorSpaceEnumEvent: TgtPDEnumColorSpaceEvent);
    procedure EnumProcSetResources(StartPage, EndPage: Integer;
      ProcSetEnumEvent: TgtPDEnumProcSetEvent);
    //Give for Other resources also

    function ExportNotes: TgtPDDocument;
    function ExportSomeNotes(AnnotArray: TgtPDAnnotType): TgtPDDocument;
    function ImportNotes(SourceDoc: TgtPDDocument; Color:
      TgtPDColorValue): Integer; overload;
    function ImportNotes(SourceDoc: TgtPDDocument; ImportFilterEvent:
      TgtPDAnnotImportFilterEvent): Integer; overload;

    function HasOC: Boolean;
    procedure EnumOCConfigs(OCConfigEnumEvent: TgtPDEnumOCConfigEvent);
    function GetOCConfig: TgtPDOCConfig;

    procedure EnumOCGs(OCGEnumEvent: TgtPDEnumOCGEvent);
    function GetNumOCGs: Integer;
    function GetOCGs: TgtPDOCGArray;
    procedure ReplaceOCG(ReplaceOCG, KeepOCG: TgtPDOCG);

    function FlattenOC(OCContext: TgtPDOCContext): Boolean;
    function GetOCContext: TgtPDOCContext;

    function GetBookmarkRoot: TgtPDBookmark;
    function CreateBookmarkRoot(const Title: AnsiString; var ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;
    function CreateBookmarkRoot(const Title: AnsiString; Action: TgtPDAction;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;

    function FindPageNumForLabel(const LabelStr: AnsiString): Integer;
    procedure GetLabelForPage(PageNum: Integer; var LabelStr: AnsiString);
    function GetPageLabel(PageNum: Integer; var FirstPage: Integer;
      var LastPage: Integer): TgtPDPageLabel;
    procedure SetPageLabel(PageNum: Integer; PageLabel: TgtPDPageLabel);
    procedure RemovePageLabel(PageNum: Integer);

    //FormField related function
    procedure AddFormField(AFormField: TgtPDFormField; APageNo: Integer);
    function GetFormField(ApageNo: Integer; Index: Integer): TgtPDFormField; overload;
    function GetFormField(APageNo: Integer; AFieldName: AnsiString): TgtPDFormField; overload;
    function GetFormFieldByTabOrder(APageNo: Integer; ATabOrder: Integer): TgtPDFormField;
    procedure RemoveFormField(ApageNo: Integer; Index: Integer); overload;
    procedure RemoveFormField(ApageNo: Integer; AFieldName: AnsiString); overload;
    function ExportToFDF(FDFDocumentPath: AnsiString): Boolean;

    procedure Stitch(AStitchToPage, AStitchFromPage: Integer);
    procedure StitchPagesSideBySide(AStitchToPage, AStitchFromPage: Integer);

    function GetOpenAction: TgtPDAction;
    procedure RemoveOpenAction;
    procedure SetOpenAction(Action: TgtPDAction);

    procedure AddAction(AAction: TgtPDAction; ATriggerType: TgtDocActionTrigger);
    procedure RemoveAction(ATriggerType: TgtDocActionTrigger);

    function GetLayoutMode: TgtPDLayoutMode;
    procedure SetLayoutMode(Mode: TgtPDLayoutMode);
    function GetPageMode: TgtPDPageMode;
    procedure SetPageMode(Mode: TgtPDPageMode);

    procedure GetDocID(var PermenantID: AnsiString; var ChangingID: AnsiString);
    procedure SaveAttachments(ADirectory: AnsiString); overload;
    procedure SaveAttachments(AStream: TStream; PageIndex: Integer; AttachmentIndex: Integer); overload;

    function AddSignature(APFXFileName, APFXPassword: AnsiString;
      APageNumber: Integer; APosition: TgtPDRect; AFieldName, AReason, ALocation,
      AContactInfo: AnsiString; ADateTime: TDateTime;
      ATextDIsplayOptions: TgtSigDisplayOptions;
      ABackGroundColor: TgtPDColorValue; AFont: TFont): Integer;

    function GetFontList(): TObjectList; overload;
    function GetFontList(APageNum: Integer): TObjectList; overload;
    procedure EmbedUsedTrueTypeFonts(); overload;
    procedure EmbedUsedTrueTypeFonts(AFontName: AnsiString; AFontStyles: TFontStyles); overload;

    property BaseDoc: TgtPDBaseDoc read GetBaseDoc;
    property Pages[Index: Integer]: TgtPDPage read GetPage;
    property PageCount: Integer read GetPageCount;
    property Version: TgtPDVersion read GetVersion write SetVersion;
    property LastObjectNumber: Cardinal read GetLastObjectNumber write
      SetLastObjectNumber;
    property AuthorizeEvent: TgtPDAuthorizeDocEvent read GetAuthorizeEvent
      write SetAuthorizeEvent;
    property OnPageRequest: TgtRequestPagesEvent read FPageRequestEvent
      write FPageRequestEvent;
    property OnEnumFontEvent: TgtPDEnumFontEvent read FOnEnumFontEvent
      write FOnEnumFontEvent;
    property BookmarkRoot: TgtPDBookmark read GetBookmarkRoot;
//    property FontDirectory: TStringList read FFontDir write FFontDir;
    property ViewerPreference: TgtPDViewerPref read GetViewerPref;
    property DocInfo: TgtPDDocInfo read GetDocInfo;
    property Catalog: TgtPDCatalog read FCatalog;

    property FontList: TStrings read FFontList write FFontList;
    property CMapDict: AnsiString read FCMapDict write FCMapDict;
    property IsOwner: Boolean read GetIsOwner;
    property IsEncrypted: Boolean read GetIsEncrypted write SetIsEncrypted;
    property Permission: TgtPDPermissions read GetPermission;
    {$IFNDEF DLLPROJECT}
    property CMapPath: string read GetCMapPath write SetCMapPath;
    {$ENDIF}
    property Signatures: TgtPDSignatures read GetSignatures;
    property SignatureFields: TgtPDSignatureFields read GetSigFields;
    property SignatureCount: Integer read GetSignatureCount;
    property SignatureFieldCount: Integer read GetSignatureFieldCount;
    property IsSigned: Boolean read GetIsSigned;
    property UseDualEMFPlus: Boolean read GetUseDualEMFPlus write SetUseDualEMFPlus;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtConstants, PDBaseExceptions, PDModelException, gtMethods, PDFormTextField,
  PDName, PDString, PDArray, PDReal, PDIndirectRef, PDInteger, PDFormListBox,
  MemoryStream, PDContents, PDContentStream, PDFileAttachmentAnnot, PD8bitFont,
  FontProcessor, PDFDFDocument, gtTypes, gtStreamAdpt
  {$IFNDEF DLLPROJECT}, PDImageDev, Forms, PDIGDIPlus, ActiveX {$ENDIF};

type
  THackHandleStream = class(THandleStream)

  end;

function GetPDFHeader(Version: TgtPDVersion): AnsiString;
var
  LVersion: AnsiString;
begin
  LVersion := '%PDF-1.';
  case Version of
    v10: LVersion := LVersion + '0' + CRLF;
    v11: LVersion := LVersion + '1' + CRLF;
    v12: LVersion := LVersion + '2' + CRLF;
    v13: LVersion := LVersion + '3' + CRLF;
    v14: LVersion := LVersion + '4' + CRLF;
    v15: LVersion := LVersion + '5' + CRLF;
    v16: LVersion := LVersion + '6' + CRLF;
    v17: LVersion := LVersion + '7' + CRLF;
  end;
  Result := LVersion;
end;

{ TgtPDDocument }

  (**
  * Adds an article thread to a document after the specified thread index.
  *
  * @param AddAfterIndex The index of the thread after which thread is added.
  * @param Thread The thread to add.
  *)

procedure TgtPDDocument.AddAction(AAction: TgtPDAction;
  ATriggerType: TgtDocActionTrigger);
begin
  if Assigned(FCatalog) then
    FCatalog.AddAction(AAction, ATriggerType);
end;

procedure TgtPDDocument.AddFormField(AFormField: TgtPDFormField;
  APageNo: Integer);
begin
  if AFormField is TgtPDSignatureField then
  begin
    // if not pfx file name is given, add a blank signature
    if TgtPDSignatureField(AFormField).Signature.PFXFileName <> '' then
      BaseDoc.SignDoc := True;
  end;
  Pages[ApageNo].AddFormField(AFormField);
    // Intermediate save
end;


function TgtPDDocument.AddSignature(APFXFileName, APFXPassword: AnsiString;
  APageNumber: Integer; APosition: TgtPDRect; AFieldName, AReason, ALocation,
  AContactInfo: AnsiString; ADateTime: TDateTime;
  ATextDIsplayOptions: TgtSigDisplayOptions;
  ABackGroundColor: TgtPDColorValue; AFont: TFont): Integer;
var
  LSigField: TgtPDSignatureField;
  LFont: TFont;
begin
  Result := 0;
  LSigField := TgtPDSignatureField.Create;
  try
    LSigField.FieldName := AFieldName;
    LSigField.Rect.SetValues(APosition.Left, APosition.Top, APosition.Right,
      APosition.Bottom);
    LSigField.BackgroundColor := ABackGroundColor;
    LFont := AFont;
    if not Assigned(LFont) then
    begin
      LFont := TFont.Create;
    end;
    LSigField.Font.Name := LFont.Name;
    LSigField.Font.Color := LFont.Color;
    LSigField.Font.Size := LFont.Size;
    LSigField.Font.Style := LFont.Style;
    with LSigField.Signature do
    begin
      Reason := AReason;
      Location := ALocation;
      ContactInfo := AContactInfo;
      PFXFileName := APFXFileName;
      PFXPassWord := APFXPassword;
      DateTime := ADateTime;
      SigDispOptions := ATextDIsplayOptions;
      // Add Certification Level
    end;
    AddFormField(LSigField, APageNumber);
  finally
    LSigField.Free;
    if not Assigned(AFont) then LFont.Free;
  end;
end;

procedure TgtPDDocument.AddThread(AddAfterIndex: Integer; Thread: TgtPDThread);
begin

end;

 (**
  * Creates thumbnail images for the specified range of pages. Thumbnail images
  * are only created for pages that have none.
  * Use as large a page range as possible, because the color space object is
  * shared by all the thumbnails created by a single invocation of this method.
  * This means that if you call this method separately for each page, there will
  * be duplicate color space objects.
  *
  * @param FirstPage The page number of the first page for which thumbnails are
  *        created. The first page is 0.
  * @param LastPage The page number of the last page for which thumbnails are
  *        created.
  * @param Server (set of Events) that provides the sampled image used as the
  *        thumbnail image.
  * @param ColorSpace The color space in which the thumbnail data is represented.
  *        It must be DeviceRGB. Thumbnails may be created in either a direct or
  *        an indexed color space; however, it is strongly recommended that you
  *        use indexed color spaces over direct color spaces. Using direct color
  *        spaces with this version of Acrobat may cause bad looking thumbnails.
  *        To specify a direct color space, pass 0 for hiVal and NULL('') for
  *        lookupTable. To specify an indexed color space, pass the appropriate
  *        values in hiVal and lookupTable.
  * @param BitsPerComp The number of bits per color component in the thumbnail
  *        image's data. 8 is the only valid value.
  * @param HiVal Used only for indexed color space; pass 0 for direct color
  *        spaces, as described in colorSpace. hiVal specifies the highest valid
  *        index in lookupTable. Because indices start at 0, the number of
  *        entries in lookupTable is hiVal + 1. hiVal must be 0 for device color
  *        spaces.
  * @param LookupTable Used only for indexed color space; pass 0 for direct
  *        color spaces, as described in colorSpace. hiVal specifies the highest
  *        valid index in lookupTable. Because indices start at 0, the number of
  *        entries in lookupTable is hiVal + 1. hiVal must be 0 for device color
  *        spaces.
  *)

procedure TgtPDDocument.AddThumbnails(FirstPage, LastPage: Integer;
  Server: TgtPDThumbsCreationServer; ColorSpace: TgtPDColorSpaceType;
  BitsPerComp, HiVal: Integer; const LookupTable: AnsiString);
begin

end;

 (**
  * Adds a Page as a watermark to a page range in the given document.
  *
  * @param Page The page to be added as a watermark
  * @param WatermarkParams Record specifying how the watermark should be added
  *        to the document.
  *)

procedure TgtPDDocument.AddWatermarkFromPage(Page: TgtPDPage;
  WatermarkParams: TgtPDAddWatermarkParams);
begin

end;

 (**
  * Adds a text-based watermark to a page range in the given document.
  *
  * @param TextParams Record describing the text-based watermark to be added.
  * @param WatermarkParams Record specifying how the watermark should be added
  *        to the document.
  *)

procedure TgtPDDocument.AddWatermarkFromText(
  TextParams: TgtPDWatermarkTextParams;
  WatermarkParams: TgtPDAddWatermarkParams);
begin

end;

procedure TgtPDDocument.AppendPages(SourceDoc: TgtPDDocument; SourceStartPage,
  NumOfPages: Integer; InsertFlags: TgtPageInsertFlages);
begin
  InsertPages(GetPageCount, SourceDoc, SourceStartPage, NumOfPages, InsertFlags);
end;

(**
  * Adds permissions to the specified document, if permitted. It calls the
  * CryptAuthorizeEvent() of the document's security handler to determine which
  * of the specified permissions will actually be granted. After calling this
  * method, the document's permissions will be the OR of the previous permissions
  * and the permissions granted by the CryptAuthorizeEvent().
  *
  * Use PermRequest() to determine if a document's permissions allow a
  * particular operation for a particular object.
  *
  * @param PermsWanted The new permissions being requested.
  * @param APassword the password to authenticate the document
  *
  * @return The OR of the previous value of the document's permissions field,
  *         and the permissions granted by the CryptAuthorizeEvent() of the
  *         document's security handler.
  *)

function TgtPDDocument.Authorize(var PermsWanted: TgtPDPermissions;
  var APassword: AnsiString): TgtPDPermissions;
begin
  FPassword := APassword;

  if PermsWanted.Enable then
  begin
    if Assigned(FUserEncryptionSettings) then
      FreeObject(FUserEncryptionSettings);

    FUserEncryptionSettings := TgtEncryptionSettings.Create;
    FUserEncryptionSettings.Enabled := PermsWanted.Enable;
    FUserEncryptionSettings.OwnerPassword := PermsWanted.OwnerPassword;
    FUserEncryptionSettings.UserPassword := PermsWanted.UserPassword;
    case PermsWanted.Level of
      el40Bits: FUserEncryptionSettings.Level := el40Bit;
      el128Bits: FUserEncryptionSettings.Level := el128Bit;
    end;
    FUserEncryptionSettings.UserPermissions := MapUserpermissions(PermsWanted);
  end;
end;

(**
  * Closes a document and releases its resources. Changes are not saved. You
  * must use SaveDocument() to save any modifications before calling
  * CloseDocument().
  * @algorithm
  *          1.	Satrt
  *          2.	IF Assigned FBaseDoc Then
  *            a.	Free FBaseDoc
  *          3.	IF Assigned FCatalog Then
  *            a.	Free FCatalog
  *          4.	IF Assigned FStream Then
  *            a.	Free FStream
  *          5.	End
  *
  *)

procedure TgtPDDocument.CloseDocument;
begin
  if Assigned(FBaseDoc) then
    FreeAndNil(FBaseDoc);
  if Assigned(FCatalog) then
    FreeAndNil(FCatalog);
  if Assigned(FSignatureFields) then FreeAndNil(FSignatureFields);
  if Assigned(FSignatures) then FreeAndNil(FSignatures);

  if FFreeStream then
  begin
    if Assigned(FStream) then
      FreeAndNil(FStream);
  end;
  if Assigned(FBlankDocStrm) then
    FreeAndNil(FBlankDocStrm);
end;

(**
  * Documents that are not dirty, this method copies the bytes from the source
  * file to the specified location. This also occurs if the SaveChanges field is
  * false. If saveChanges is true, the document is dirty, a full save is performed
  * to the specified file. The resulting file is linearized (optimized for the
  * web). If the file already exists, it is overwritten.
  *
  * @param FileName The desination Filename to where the source document has to
  *        be copied.
  * @param SaveChanges Boolean value specifing if the changes made to document
  *        has to be to saved
  * @param CancelEvent A callback event which helps in cancelling the operation
  *
  * @exception EAlreadyOpen is raised if the target and source files are the same.
  * @exception EDiskFull is raised if there is no space for the copy.
  * @exception ECancelSave is raised if the save was canceled
  * @exception EUnableToRead is raised if a read error occurred on the source.
  * @exception EUnableToWrite is raised if a write error occurred on the destination.
  * @algorithm
  *          1.	Start
  *          2.	IF SaveChanges Then
  *          3.	begin
  *            a.	SaveFlags.Full := True
  *            b.	SaveDocument(FileName, SaveFlags)
  *          4.	End
  *          5.	ELSE
  *          6.	begin
  *            a.	 IF FileName = ‘’ Then
  *              i.	Raise ExInvalidFileName Exception
  *            b.	Create FileStream with LStream(FileName, Create mode)
  *            c.	On EFCreateError Exception
  *              i.	Raise ExFileCreateError Exception
  *            d. FStream.Position := 0
  *            e.	LStream.CopyFrom(FStream, FStream.Size)
  *            f. Free LStream
  *          7.	End
  *          8.	End
  *
  *)

procedure TgtPDDocument.CopyToFile(const FileName: AnsiString; SaveChanges: Boolean;
  CancelEvent: TgtPDCancelEvent);
var
  LStream: TStream;
  LSaveFlags: TgtPDSaveFlags;
begin
  if SaveChanges then
  begin
    LSaveFlags.Full := True;
    SaveDocument(FileName, LSaveFlags);
  end
  else
  begin
    if Filename = '' then
    begin
      raise ExInvalidFileName.Create(ErrInvalidFileName);
    end;

    try
      LStream := TFileStream.Create(FileName, fmCreate);
    except
      on E: EFCreateError do
        raise ExFileCreateError.Create(ErrFileCreateError + E.Message);
    end;
    FStream.Position := 0;
    LStream.CopyFrom(FStream, FStream.Size);
    FreeAndNil(LStream);
  end;
end;

(**
  * Returns the number of array items in a property array
  *
  * @param NameSpace The XML namespace URI for the schema in which the property
  *        is to be found.
  * @param Path The name of the simple property to be modified.
  *
  * @return An Integer which is the number of array items in the property array.
  *
  * @exception ECouldntCreateMetaXAP Is raised if any Error ocours
  *)

function TgtPDDocument.CountXMPMetadataArrayItems(const NameSpace,
  Path: AnsiString): Integer;
begin
  Result := 0;
end;

(**
  * Constructor
  *
  * @param ABaseDoc is the document base through which all operations are done
  * @algorithm
  *           1. Start
  *           2. Assign ABaseDoc to FPDBaseDoc
  *           3. FTries := 1
  *           4. End
  *
    *)

constructor TgtPDDocument.Create(ABaseDoc: TgtPDBaseDoc);
begin
  FBaseDoc := ABaseDoc;
  FTries := 1;
  FIsEncrypted := False;
  FUseDualEMFPlus := True;
  {$IFDEF COPYPROTECT}
    // activateLicense will take care
  {$ELSE}
    // the switches will determine whether to put trial mark or not
    {$IFDEF gtRegistered}
      IsReg := True;
    {$ELSE}
      IsReg := False;
    {$ENDIF}
  {$ENDIF}
end;




function TgtPDDocument.CreateBookmarkRoot(const Title: AnsiString;
  var ADestination: TgtPDDestination;
  var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
begin
  Result := FCatalog.CreateNewBookmark(Title, ADestination, AOutlineFlag);
end;

function TgtPDDocument.CreateBookmarkRoot(const Title: AnsiString;
  Action: TgtPDAction; var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
begin
  Result := FCatalog.CreateNewBookmark(Title, Action, AOutlineFlag);
end;

(**
  * Retrieves the name tree inside the Names dictionary with the specified key
  * name, or creates it if it does not exist.
  *
  * @param TreeName The name of the name tree to create.
  *
  * @return The newly created TgtPDNameTree for the Document. It returns a nil
  *         if the Document has no root dictionary.
  *)

function TgtPDDocument.CreateNameTree(const TreeName: AnsiString): TgtPDNameTree;
begin
  Result := nil;
end;

(**
  *  This function creates a blank page and insert it in the given position
  *
  *  @param AfterPage is the index of the page from where it need to start
  *         inserting blank page
  *  @param MediaBox is the mediabox rect for this page
  *  @return Page object is returned
  *  @algorithm
  *          1.	Start
  *          2.	Return FCatalog.PageTree.CreatePage(AfterPage, Mediabox)
  *          3.	End
  *
  *)

function TgtPDDocument.CreatePage(AfterPage: Integer;
  MediaBox: TgtPDRect): TgtPDPage;
begin
  Result := FCatalog.PageTree.CreatePage(AfterPage, MediaBox);
end;

(**
  * Creates a text selection that includes all words totally or partially
  * enclosed by a rectangle.
  *
  * @param PageNum The page number on which the text selection is created.
  * @param BoundingRect A rectangle specifying the text selection's bounding
  *        rectangle, specified in user space coordinates.
  *
  * @return The newly created text selection.
  *)

function TgtPDDocument.CreateTextSelect(PageNum: Integer;
  BoundingRect: TgtPDRect): TgtPDTextSelect;
begin
  Result := nil;
end;

(**
  * Deletes a pages in a document.
  *
  * @param PageNumber The page number of the page in document that
  *        need to be deleted. The first page is 1.
  * @algorithm
  *        1.	Start
  *        2.	FCatalog.PageTree.DeletePage(PageNumber)
  *        3.	End
  *
  *)

procedure TgtPDDocument.DeletePage(PageNumber: Integer);
begin
  FCatalog.PageTree.DeletePage(PageNumber);
end;

(**
  * Deletes a range of pages in a document.
  *
  * @param FirstPage The page number of the first page in document that
  *        need to be deleted. The first page is 1.
  * @param LastPage The page number of the last page in doc that need
  *        to be deleted.
  * @algorithm
  *        1.	Start
  *        2.	FCatalog.PageTree.DeletePages(StartPage, EndPage)
  *        3.	End
  *
  *)

procedure TgtPDDocument.DeletePages(FirstPage, LastPage: Integer);
begin
  FCatalog.PageTree.DeletePages(FirstPage, LastPage);
end;

(**
  * Deletes thumbnail images for a range of pages in a document.
  *
  * @param FirstPage The page number of the first page in document whose
  *        thumbnail image is deleted. The first page is 1.
  * @param LastPage The page number of the last page in doc whose thumbnail
  *        image is deleted.
  *
  *)

procedure TgtPDDocument.DeleteThumbs(FirstPage, LastPage: Integer);
begin

end;

(**
  * Destructor
  *
  *)

destructor TgtPDDocument.Destroy;
begin
  SetLength(FMetadata, 0);
  if Assigned(FBaseDoc) then
    FreeAndNil(FBaseDoc);
  if Assigned(FCatalog) then
    FreeAndNil(FCatalog);
  if Assigned(FDocInfo) then
    FreeAndNil(FDocInfo);
  if FFreeStream then
  begin
    if Assigned(FStream) then
      FStream.Free;
  end;
//  if Assigned(FontDirectory) then
//    FontDirectory.Free;

  if Assigned(FFontList) then
    FFontList.Free;

  if Assigned(FgtPDFontList) then
    FreeObject(FgtPDFontList);
  if Assigned(FSignatureFields) then FSignatureFields.Free;
  if Assigned(FSignatures) then FSignatures.Free;

  inherited;
end;

type
  THackPage = class(TgtPDPage)
  
  end;

procedure TgtPDDocument.DisplayPage(ExportDev: TgtPDExportDevice;
  PageNum: Integer; hDPI, vDPI: Double; Rotate: Integer; UseMediaBox, Crop,
  Printing: Boolean; RenderAnnots: Boolean);
var
  LPage: TgtPDPage;
begin
  Pages[PageNum].Display(ExportDev, hDPI, vDPI, Rotate, UseMediaBox, Crop,
    Printing, RenderAnnots);
  LPage := Pages[PageNum];
  if not Assigned(THackPage(LPage).FInheritedProp) then
    //Frees all the resources allocated in a page
    Pages[PageNum].FreeResources;
end;

procedure TgtPDDocument.DisplayPages(ExportDev: TgtPDExportDevice; FirstPage,
  LastPage: Integer; hDPI, vDPI: Double; Rotate: Integer; UseMediaBox, Crop,
  Printing: Boolean; RenderAnnots: Boolean);
var
  I: Integer;
begin
  for I := FirstPage to LastPage do
    DisplayPage(ExportDev, I, hDPI, vDPI, Rotate, UseMediaBox, Crop, Printing, RenderAnnots);
end;

procedure TgtPDDocument.DisplaySlice(ExportDev: TgtPDExportDevice;
  PageNum: Integer; DPI, vDPI: Double; Rotate: Integer; UseMediaBox, Crop,
  Printing: Boolean; SliceX, SliceY, SliceW, SliceH: Integer; RenderAnnots: Boolean);
begin

end;

(**
  * Enumerates the ColorSpace of page resources, for a specified range of pages.
  * This method enumerates ColorSpace resources in each page's Resources dictionary.
  * In addition, it looks inside in-line images and page contents to enumerate
  * ColorSpace resources that are not in the Resources dictionary, such as
  * DeviceGray, DeviceRGB, and DeviceCMYK.
  *
  * @param StartPage The page number of the first page for which ColorSpace are
  *        enumerated. The first page is 0.
  * @param EndPage The page number of the last page for which ColorSpace are
  *        enumerated.
  * @param ColorSpaceEnumEvent A user-supplied Event to call for each ColorSpace.
  *)

procedure TgtPDDocument.EmbedUsedTrueTypeFonts;
begin
  EmbedUsedTrueTypeFonts('', []);
end;

procedure TgtPDDocument.EmbedUsedTrueTypeFonts(AFontName: AnsiString;
  AFontStyles: TFontStyles);
var
  LFontList: TObjectList;
  LFontObj: TgtPDBaseObject;
  LFDDict: TgtPDDictionary;
  LI: Integer;
  LFont: TFont;
  LEC: ErrorCodes;
  LFontProcObj: TgtFontProcessor;
begin
  LFontList := GetFontList();
  for LI := 0 to LFontList.Count - 1 do
  begin
    if ((TgtPD8bitFont(LFontList.Items[LI]).FontType = TrueType) and
      (TgtPD8bitFont(LFontList.Items[LI]).EmbeddedFontStream = nil)) then
    begin
      LFont := TFont.Create;
      LFont.Name := TgtPDFont(LFontList.Items[LI]).Name;
      LFont.Name := StringReplace(LFont.Name, ' ', '', [rfReplaceAll]);
      LFont.Name := StringReplace(LFont.Name, '-', '', [rfReplaceAll]);
      LFont.Name := StringReplace(LFont.Name, ',', '', [rfReplaceAll]);
      LFont.Name := StringReplace(LFont.Name, 'Bold', '', [rfIgnoreCase]);
      LFont.Name := StringReplace(LFont.Name, 'Italic', '', [rfIgnoreCase]);
      if TgtPDFont(LFontList.Items[LI]).IsItalic then
        LFont.Style := [fsItalic];
      if TgtPDFont(LFontList.Items[LI]).IsBold then
        LFont.Style := [fsBold];
      if (((LFont.Name = AFontName) and (LFont.Style = AFontStyles)) or
        ((AFontName = '') and (AFontStyles = []))) then
      begin
        LFontProcObj := TgtFontProcessor.Create(LFont, LEC);
        LFontObj := TgtPD8bitFont(LFontList.Items[LI]).BaseObject;
        if Assigned(LFontObj) then
        begin
          LFDDict := TgtPDDictionary(LFontObj).LookUp(PDF_FONTDESCRIPTOR)
            as TgtPDDictionary;
          if ((Assigned(LFDDict)) and (LFontProcObj.FontStream <> nil)) then
          begin
            TgtPD8bitFont(LFontList.Items[LI]).
              EmbedFontFile(LFDDict, LFontProcObj.FontStream);
          end
          else
          begin
{$IFDEF DEBUG}
            Logger.LogError('The FontStream for the Font %s cannot be embedded',
              [LFont.Name]);
{$ENDIF}
          end;
        end;
        FreeAndNil(LFont);
      end;
    end;
  end;
end;

procedure TgtPDDocument.EnumColorSpaceResources(StartPage, EndPage: Integer;
  ColorSpaceEnumEvent: TgtPDEnumColorSpaceEvent);
begin

end;

 (**
  * Enumerates all the fonts in the specified page range. This may take a
  * considerable amount of time for a large page range.
  *
  * @param FirstPage The page number of the first page for which fonts are
  *        enumerated. The first page is 0.
  * @param LastPage The page number of the last page for which fonts are
  *        enumerated.
  * @param FontEnumEvent A user-supplied Event to call for each font.
  *)

procedure TgtPDDocument.EnumFonts(FirstPage, LastPage: Integer;
  FontEnumEvent: TgtPDEnumFontEvent);
var
  LI: Integer;
  LFont: TgtPDFont;
  LJ: Integer;
  LContinue: Boolean;
  LFontName: AnsiString;
begin
  if Assigned(FOnEnumFontEvent) then
  begin
    LContinue := True;
    for LI := FirstPage to LastPage do
    begin
      for LJ := 0 to Pages[LI].Resource.FontCount - 1 do
      begin
        LFont := Pages[LI].Resource.GetFont(LJ);
        while LContinue do
        begin
          LFontName := LFont.Name;
          FOnEnumFontEvent(LFont, LFontName, LContinue);
        end;
      end;
    end;
  end;
end;

 (**
  * Enumerates all the fonts that have been encountered so far. A font is loaded
  * when a page that uses it is processed. This typically happens when a page is
  * drawn or its thumbnail image is created.
  *
  * @param FontEnumEvent A user-supplied Event to call for each loaded font.
  *)

procedure TgtPDDocument.EnumLoadedFonts(FontEnumEvent: TgtPDEnumFontEvent);
begin

end;

 (**
  * Enumerates the optional-content configurations for the document, calling the
  * supplied procedure for each one. These include the configuration for the D
  * configuration dictionary and those for all entries in the Configs array
  * dictionary.
  *
  * @param OCConfigEnumEvent A user-supplied Event to call for each loaded OCConfig.
  *)

procedure TgtPDDocument.EnumOCConfigs(
  OCConfigEnumEvent: TgtPDEnumOCConfigEvent);
begin

end;

 (**
  * Enumerates the optional-content groups for the document, calling the
  * supplied procedure for each one. Each group is reported once, even if it is
  * referenced multiple times in a page, or on multiple pages.
  *
  * @param OCGEnumEvent A user-supplied Event to call for each OCG.
  *)

procedure TgtPDDocument.EnumOCGs(OCGEnumEvent: TgtPDEnumOCGEvent);
begin

end;

 (**
  * Enumerates the ProcSet of page resources, for a specified range of pages.
  * This method enumerates ProcSet resources in each page's Resources dictionary.
  *
  * @param StartPage The page number of the first page for which ProcSets are
  *        enumerated. The first page is 0.
  * @param EndPage The page number of the last page for which ProcSets are
  *        enumerated.
  * @param ProcSetEnumEvent A user-supplied Event to call for each ProcSet.
  *)

procedure TgtPDDocument.EnumProcSetResources(StartPage, EndPage: Integer;
  ProcSetEnumEvent: TgtPDEnumProcSetEvent);
begin

end;

 (**
  * Enumerates the XObject of page resources, for a specified range of pages.
  * This method enumerates XObject resources in each page's Resources dictionary.
  *
  * @param StartPage The page number of the first page for which XObjects are
  *        enumerated. The first page is 0.
  * @param EndPage The page number of the last page for which XObjects are
  *        enumerated.
  * @param XObjectEnumEvent A user-supplied Event to call for each XObject.
  *)

procedure TgtPDDocument.EnumXObjectResources(StartPage, EndPage: Integer;
  XObjectEnumEvent: TgtPDEnumXObjectEvent);
begin

end;


function TgtPDDocument.ExportNotes: TgtPDDocument;
begin
  Result := nil;
end;

 (**
  * Like ExportNotes(), but the caller provides the list of annotations to export.
  * This is useful in scenarios when it may be inappropriate to use ExportNotes()
  * and look for annotations on every page.
  *
  * @param AnnotArray Ann array of TgtPDAnnot
  * @return The document created to hold the exported notes.
  *)

function TgtPDDocument.ExportSomeNotes(
  AnnotArray: TgtPDAnnotType): TgtPDDocument;
begin
  Result := nil;
end;

function TgtPDDocument.ExportToFDF(FDFDocumentPath: AnsiString): Boolean;
var
  LFDFDoc: TgtPDFDFDocument;
begin
  LFDFDoc := TgtPDFDFDocument.Create(Self, FDFDocumentPath);
  try
    Result := LFDFDoc.ExportToFDFDocument;
  finally
    FreeObject(LFDFDoc);
  end;
end;

(**
  * Finds the first page in the document with a specified label.
  *
  * @param LabelStr The label of the page to find.
  * @return The page number of the first page with the specified label, or -1 if
  *         no such page exists.
  *)

function TgtPDDocument.FindPageNumForLabel(const LabelStr: AnsiString): Integer;
begin
  Result := 0;
end;

 (**
  * Replaces the contents of every page in the document with a version that has
  * no optional content, containing only what was visible on the page when the
  * call was made, and removes all other optional-content information.
  *
  * @param OCContext The optional-content context in which content is checked
  *        for visibility.
  * @return True if the operation is successful, false otherwise.
  *)

function TgtPDDocument.FlattenOC(OCContext: TgtPDOCContext): Boolean;
begin
  Result := False;
end;

(*
 procedure TgtPDDocument.FontEventCallBack(Font: TgtPDFont; var Name: AnsiString;
  var Continue: Boolean);
begin
  FFont:= nil;
  if Name = Font.Name then
  begin
    FFont := Font;
    Continue := False;
  end;
end;
*)

(**
  * Gets the root of the document's bookmark tree. The return value is valid
  * even if the document's bookmark tree is empty (meaning that there is no
  * Outlines key in the underlying PDF file).
  *
  * @return The document's root bookmark.
  *)

function TgtPDDocument.GetAuthorizeEvent: TgtPDAuthorizeDocEvent;
begin
  Result := FAuthorizeEvent;
end;

function TgtPDDocument.GetBaseDoc: TgtPDBaseDoc;
begin
  Result := FBaseDoc;
end;

function TgtPDDocument.GetBookmarkRoot: TgtPDBookmark;
begin
  Result := FCatalog.BookmarkRoot;
end;

{$IFNDEF DLLPROJECT}
function TgtPDDocument.GetCMapPath: string;
begin
  Result := FCMapPath;
end;
{$ENDIF}

(**
  * Gets the document's file identifier
  *
  * @param PermenantID (Filled by the function) The Permenant File ID
  * @param ChangingID (Filled by the function) The Changing File ID
  *)

procedure TgtPDDocument.GetDocID(var PermenantID, ChangingID: AnsiString);
begin

end;


(**
  * Gets the filename coresponding to this Document
  *
  * @return The name of the loaded document
  * @algorithm
  *        1.	Start
  *        2.	Return FFileName
  *        3.	End
  *)

function TgtPDDocument.GetFileName: AnsiString;
begin
  Result := FFileName;
end;

function TgtPDDocument.GetFormField(ApageNo, Index: Integer): TgtPDFormField;
begin
  Result := Pages[APageNo].GetFormField(Index);
end;

function TgtPDDocument.GetFontList: TObjectList;
var
  LI, LJ: Integer;
  LPageFontList: TObjectList;
begin
//  Result := nil;
  if not Assigned(FgtPDFontList) then
    FgtPDFontList := TObjectList.Create(False);
  for LI := 1 to PageCount do
  begin
    //fetch List of fonts in each page
    LPageFontList := GetFontList(LI);
    //Add the list of fonts in the entire document to FgtPDFontList
    for LJ := 0 to LPageFontList.Count - 1 do
    begin
      FgtPDFontList.Add(LPageFontList.Items[LJ]);
    end;
  end;
  Result := FgtPDFontList;
end;

function TgtPDDocument.GetFontList(APageNum: Integer): TObjectList;
begin
  Result := nil;
  if Assigned(Pages[APageNum].Resource) then
    Result := Pages[APageNum].Resource.FontList;
end;

{$IFNDEF DLLPROJECT}
function TgtPDDocument.GetFonts: TStrings;
var
  I: Integer;
  LS: AnsiString;
begin
  Result := TStringList.Create;
//{$IFDEF VCL7ORABOVE}
//  Result.NameValueSeparator := ':';
//{$ENDIF}
  for I := 0 to Screen.Fonts.Count - 1 do
  begin
    LS := StringReplace(Screen.Fonts.Strings[I], ' ', '', [rfReplaceAll]);
    Result.Values[LS] := Screen.Fonts.Strings[I];
  end;
end;
{$ENDIF}

function TgtPDDocument.GetFormField(APageNo: Integer;
  AFieldName: AnsiString): TgtPDFormField;
begin
  Result := Pages[APageNo].GetFormField(AFieldName);
end;

function TgtPDDocument.GetFormFieldByRef(
  AFormFieldRef: TgtPDBaseObject): TgtPDFormField;
begin
  Result := FCatalog.GetAcroFormField(AFormFieldRef);
end;

function TgtPDDocument.GetFormFieldByTabOrder(APageNo,
  ATabOrder: Integer): TgtPDFormField;
begin
  Result := nil;
end;

function TgtPDDocument.GetDocInfo: TgtPDDocInfo;
begin
  if not Assigned(FDocInfo) then
    FDocInfo := TgtPDDocInfo.Create(Self, FCatalog);

  Result := FDocInfo;
end;

(**
  * Gets the value of a key in a document's Info dictionary, or the value of
  * this same key in the XMP metadata, whichever is later. However, it is
  * preferable to use GetXMPMetadataProperty(), because it also allows accessing
  * XMP properties that are not duplicated in the Info dictionary.
  *
  * @param InfoKey The name of the Info dictionary key whose value is obtained.
  * @param Value (Filled by the method) The AnsiString containing the value
  *        associated with InfoKey.
  *)

procedure TgtPDDocument.GetInfo(const InfoKey: AnsiString; var Value: AnsiString);
begin

end;

function TgtPDDocument.GetIsEncrypted: Boolean;
begin
  Result := FIsEncrypted;
end;

function TgtPDDocument.GetIsOwner: Boolean;
begin
  Result := FBaseDoc.IsOwner;
end;

function TgtPDDocument.GetIsSigned: Boolean;
var
  I: Integer;
begin
  Result := False;
  if not Assigned(FSignatureFields) then
    GetSigFields;
  if Assigned(FSignatureFields) then
  begin
    for I := 0 to FSignatureFields.Count - 1 do
    begin
      if Assigned(FSignatureFields[I].Signature) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

(**
  * Retrieves the label AnsiString associated with the given page number.
  *
  * @param PageNum The number of the page whose label is requested.
  * @param LabelStr (Filled by the method) If a label exists for PageNum, it
  * will be placed in this AnsiString.
  *)

procedure TgtPDDocument.GetLabelForPage(PageNum: Integer; var LabelStr: AnsiString);
begin

end;

function TgtPDDocument.GetLastObjectNumber: Cardinal;
begin
  Result := BaseDoc.Reader.XRef.LastObjectNumber;
end;

 (**
  * Gets the value of the PageLayout key in the Catalog dictionary.
  *
  * @return Layout mode value from the PDF Catalog dictionary.
  *)

function TgtPDDocument.GetLayoutMode: TgtPDLayoutMode;
begin
  Result := FCatalog.PageLayout;
end;

(**
  * Yields a AnsiString containing a semicolon-separated list of fields. The first
  * such field is the entire contents of the pdf:Keywords property of the
  * document XMP; the remaining fields are the contents of successive items in
  * the xmp:Keywords bag of keyword items.
  * The document's metadata is not modified as a result of this call.
  *
  * @return A AnsiString containing the textual representation of the merged list
  *         of keywords.
  *)

function TgtPDDocument.GetMergedXMPKeywords: AnsiString;
begin

end;

(**
  * Retrieves a name tree, with the key name specified in TreeName, from the
  * Names dictionary of Document.
  *
  * @return The TgtPDNameTree requested.
  *)

function TgtPDDocument.GetNameTree(const TreeName: AnsiString): TgtPDNameTree;
begin
  Result := nil;
end;

(**
  * Returns the number of optional-content groups associated with a document,
  * which is the number of unique entries in the document's OCProperties OCGs
  * array.
  *
  * @return The number of OCGs for the document.
  *)

function TgtPDDocument.GetNumOCGs: Integer;
begin
  Result := 0;
end;

(**
  * Gets the number of article threads in a document.
  *
  * @return The number of article threads in the document.
  *)

function TgtPDDocument.GetNumThreads: Integer;
begin
  Result := 0;
end;

(**
  * Gets the built-in default optional-content configuration for the document
  * from the OCProperties D entry.
  *
  * @return The document's current optional-content configuration.
  *)

function TgtPDDocument.GetOCConfig: TgtPDOCConfig;
begin
  Result := nil;
end;

(**
  * Gets the built-in default optional-content context for the document. This
  * context is used by all content drawing and enumeration calls that do not
  * take an optional-content context parameter, or for which no context is
  * specified.
  *
  * @return The document's current optional-content context.
  *)

function TgtPDDocument.GetOCContext: TgtPDOCContext;
begin
  Result := nil;
end;

(**
  * Gets the optional-content groups for the document. The order of the groups
  * is not guaranteed to be the creation order, and is not the same as the
  * display order.
  *
  * @return An array of OCGs.
  *)

function TgtPDDocument.GetOCGs: TgtPDOCGArray;
begin

end;

(**
  * Gets the value of the OpenAction key in the Catalog dictionary, which is the
  * action performed when the document is opened.
  *
  * @return The document's open action. It is nil if there is no OpenAction key
  *         in the Catalog dictionary
  *)

function TgtPDDocument.GetOpenAction: TgtPDAction;
begin
  Result := nil;
end;

(**
  * Gets the value of the OpenAction key in the Catalog dictionary, which is the
  * action performed when the document is opened.
  *
  * @return The document's open action. It is nil if there is no OpenAction key
  *         in the Catalog dictionary
  * @param Index is the Page index in the Document
  * @algorithm
  *        1.	Start
  *        2.	Return FCatalog.PageTree.GetPage(Index: Integer)
  *        3.	End
  *
  *)

function TgtPDDocument.GetPage(Index: Integer): TgtPDPage;
begin
  Result := FCatalog.PageTree.GetPage(Index);
end;

(**
  * Returns the page Base object corresponding to the given page number.
  *
  * @return A base object representing the page, or nil if the page does not
  *         exist.
  *)

function TgtPDDocument.GetPageBaseObject(PageNumber: Integer): TgtPDBaseObject;
begin
  Result := FCatalog.PageTree.GetPageBaseObject(PageNumber);
end;

function TgtPDDocument.GetPageByIndRef(APageRef: TgtPDBaseObject): TgtPDPage;
begin
  Result := FCatalog.PageTree.GetPageByIndRef(APageRef);
end;

(**
  * Gets the number of pages in a document.
  *
  * @return The number of pages in the document. Remember to subtract 1 from
  *         this value if you are going to pass it to a PD- level method that takes a
  *         zero-based page number.
  * @algorithm
  *          1.	Start
  *          2.	FCatalog.PageTree.Count
  *          3.	End
  *
  *)

function TgtPDDocument.GetPageCount: Integer;
begin
  Result := FCatalog.PageTree.Count;
end;

(**
  * Returns the label that is in effect for the given page.
  *
  * @param PageNum The page number of the page for which a label is requested.
  * @param FirstPage (Filled by the method) The number of the first page that
  *        the page label is attached to.
  * @param LastPage (Filled by the method) The number of the last page that the
  *        page label is attached to.
  * @return The label that is in effect for the given page. If there is no label
  *         object in effect, this method returns nil, and FirstPage and
  *         LastPage will be set to -1.
  *)

function TgtPDDocument.GetPageLabel(PageNum: Integer; var FirstPage,
  LastPage: Integer): TgtPDPageLabel;
begin
  Result := nil;
end;

(**
  * Gets the value of the PageMode key in the Catalog dictionary.
  *
  * @return Page mode value from PDF Catalog dictionary.
  *)

function TgtPDDocument.GetPageMode: TgtPDPageMode;
begin
  Result := FCatalog.PageMode;
end;

function TgtPDDocument.GetPDFVersion: TgtPDVersion;
var
  LChar: AnsiChar;
  LVersion: AnsiString;
begin
  LVersion := '';
  FBaseDoc.Reader.FileStream.Position := 0;
  FBaseDoc.Reader.FileStream.Read(LChar, 1);
  while not (LChar in [' ', '/', '<', '>', '(', ')', '[', ']', #13,
    #10, #09, #0]) do
  begin
    LVersion := LVersion + LChar;
    FBaseDoc.Reader.FileStream.Read(LChar, 1);
  end;

  FBaseDoc.Reader.FileStream.Position := Pos(LVersion, '%PDF-1.') + 7;
  FBaseDoc.Reader.FileStream.Read(LChar, 1);

  case LChar of
    '0': FVersion := v10;
    '1': FVersion := v11;
    '2': FVersion := v12;
    '3': FVersion := v13;
    '4': FVersion := v14;
    '5': FVersion := v15;
    '6': FVersion := v16;
    '7': FVersion := v17;
  end;
  Result := FVersion;
end;

(**
  * Gets the permissions for the specified document
  *
  * @return The document's permissions
  *)

function TgtPDDocument.GetPermission: TgtPDPermissions;
begin
  Result := FPermissions;
end;

function TgtPDDocument.GetPermissions: TgtPDPermissions;
var
//  LBaseDoc: TgtPDBaseDoc;
  LPermissions: TgtUserPermissions;
begin
//  LBaseDoc := BaseDoc;
//  LPermissions := LBaseDoc.GetPermissions(MapUserpermissions(FPermissions));
  if AllowCopy in LPermissions then
    Result.CopyText := True
  else
    Result.CopyText := False;
  if AllowModify in LPermissions then
    Result.ModifyContents := True
  else
    Result.ModifyContents := False;
  if AllowPrint in LPermissions then
    Result.Print := True
  else
    Result.Print := False;
  if AllowAnnotation in LPermissions then
    Result.ModifyTextAnnots := True
  else
    Result.ModifyTextAnnots := False;
  if AllowFormFill in LPermissions then
    Result.FillForms := True
  else
    Result.FillForms := False;
  if AllowDocAssembly in LPermissions then
    Result.AssmbleDoc := True
  else
    Result.AssmbleDoc := False;
  if AllowHighResPrint in LPermissions then
    Result.PrintHighQuality := True
  else
    Result.PrintHighQuality := False;
  if AllowAccessibility in LPermissions then
    Result.PrintToDigitalCopy := True
  else
    Result.PrintToDigitalCopy := False;
end;

function TgtPDDocument.GetSigFields: TgtPDSignatureFields;
var
  LSignature: TgtPDSignature;
  I, J: Integer;
  LFormField: TgtPDFormField;
  LPage: TgtPDPage;
begin
  if not Assigned(FSignatureFields) then
  begin
    FSignatureFields := TgtPDSignatureFields.Create(False);
    for I := 1 to PageCount do
    begin
      LPage := Pages[I];
      for J := 1 to LPage.GetFormFieldCount do
      begin
        LFormField := LPage.GetFormField(J);
        if LFormField is TgtPDSignatureField then
          FSignatureFields.Add(LFormField);
      end;
    end;
  end;
  Result := FSignatureFields;
end;

function TgtPDDocument.GetSignatureCount: Integer;
begin
  Result := 0;
  if Assigned(SignatureFields) then
    Result := SignatureFields.Count;
end;

function TgtPDDocument.GetSignatureFieldCount: Integer;
begin
  Result := 0;
  if Assigned(Signatures) then
    Result := Signatures.Count;
end;

function TgtPDDocument.GetSignatures: TgtPDSignatures;
var
  I: Integer;
begin
  if not Assigned(FSignatures) then
  begin
    if not Assigned(FSignatureFields) then
      GetSigFields;
    if Assigned(FSignatureFields) then
    begin
      FSignatures := TgtPDSignatures.Create(False);
      for I := 0 to FSignatureFields.Count - 1 do
      begin
        if Assigned(FSignatureFields[I].Signature) then
          FSignatures.Add(FSignatureFields[I].Signature);
      end;
    end;
  end;
  Result := FSignatures;
end;

(**
  * Gets an article thread having the specified index.
  *
  * @param Index The index of the article thread to obtain.
  * @return The specified article thread.
  *)

function TgtPDDocument.GetThread(Index: Integer): TgtPDThread;
begin
  Result := nil;
end;

(**
  * Gets the value of the Trapped key in the Info dictionary.
  *
  * @return The value of the Trapped key in the Info dictionary if the entry
  *         exists and is a name, or trapUnknown if the entry does not exist or
  *         is not a name.
  *)

function TgtPDDocument.GetTrapped: TgtPDTrapped;
begin
  Result := trapUnknown;
end;

function TgtPDDocument.GetVersion: TgtPDVersion;
begin
  Result := FVersion;
end;

function TgtPDDocument.GetViewerPref: TgtPDViewerPref;
begin
  if not Assigned(FViewerPreference) then
    FViewerPreference := FCatalog.ViewerPref;
  Result := FViewerPreference;
end;

(**
  * Gets the XMP metadata associated with a document. It returns the XML text of
  * the XMP metadata associated with the document.
  * The XMP metadata returned always represents all the properties in the
  * Documents object's Info dictionary, and can also contain properties not
  * present in the Info dictionary.
  *
  * @return The XMP metadata associated with the document.
  *)

function TgtPDDocument.GetXMPMetadata: AnsiString;
var
  LMemStrm: TMemoryStream;
begin
  Result := '';
  LMemStrm := FCatalog.Metadata as TMemoryStream;
  if Assigned(LMemStrm) then
  begin
    LMemStrm.Position := 0;
    try
      try
        SetLength(FMetadata, LMemStrm.Size);
        LMemStrm.Read(FMetadata[1], LMemStrm.Size);
        Result := FMetadata;
      except
      end;
    finally
      LMemStrm.Free;
    end;
  end;
end;

(**
  * Gets the value of an XMP metadata array item, associated with a document,
  * based on an index. It returns the XML text of the value of the specified
  * property in the XMP metadata array associated with the document.
  *
  * @param NameSpaceName The XML namespace URI for the schema in which the
  *        property is to be found.
  * @param Path The name of the desired simple property.
  * @param Index The index in the metadata property array associated with the
  *        property.
  * @return The XMP metadata associated with the document.
  * @exception ECouldNotCreatXMPMetadata Is raosed when the XMP Metadata could
  *            not be created
  *)

function TgtPDDocument.GetXMPMetadataArrayItem(const NameSpaceName,
  Path: AnsiString; Index: Integer): AnsiString;
begin

end;

(**
  * Gets the value of an XMP metadata property associated with a document. It
  * returns the XML text of the value of the specified property in the XMP
  * metadata associated with the document.
  *
  * @param NameSpaceName The XML namespace URI for the schema in which the
  *        property is to be found.
  * @param Path The name of the desired simple property. Note that XMP
  *        properties can have an XML substructure; this method can only
  *        retrieve values from simple textual properties.
  * @return The XML text of the value of the specified property in the XMP
  *         metadata associated with the document.
  * @exception ECouldNotCreatXMPMetadata Is raosed when the XMP Metadata could
  *            not be created
  *)

function TgtPDDocument.GetXMPMetadataProperty(const NameSpaceName,
  Path: AnsiString): AnsiString;
begin

end;

(**
  * Determines whether the optional content feature is associated with the
  * document. The document is considered to have optional content if there is an
  * OCProperties dictionary in the document's catalog, and that dictionary has
  * one or more entries in the OCGs array.
  *
  * @return True if the document has optional content, false otherwise.
  *)

function TgtPDDocument.HasOC: Boolean;
begin
  Result := False;
end;

(**
  * Adds text annotations from SourceDoc to document.
  *
  * @param SourceDoc The document from which the annotations will be imported.
  * @param Color the color attribute of imported annotations. color indicates
  *        the color space (DeviceGray, DeviceRGB, DeviceCMYK), and color
  *        values for the annotation.
  * @return The number of notes imported.
  *)

function TgtPDDocument.ImportNotes(SourceDoc: TgtPDDocument;
  Color: TgtPDColorValue): Integer;
begin
  Result := 0;
end;

(**
  * Adds text annotations from SourceDoc to document.
  *
  * @param SourceDoc The document from which the annotations will be imported.
  * @param ImportFilterEvent A user-supplied filter which determines what type
  *        of notes will be exported.
  * @return The number of notes imported.
  *)

function TgtPDDocument.ImportNotes(SourceDoc: TgtPDDocument;
  ImportFilterEvent: TgtPDAnnotImportFilterEvent): Integer;
begin
  Result := 0;
end;

(**
  * Inserts NumOfPages pages from SourceDoc into document. All annotations, and
  * anything else associated with the page (such as a thumbnail image) are
  * copied from the SourceDoc pages to the new pages in document. This method
  * does not insert pages if SourceDoc equals document.
  * The InsertFlags parameter controls whether bookmarks and threads are
  * inserted along with the specified pages. Setting The InsertAll flag has two
  * effects:
  *   The parameters indicating which pages to insert are ignored: all the pages
  *    of SourceDoc are inserted.
  *   In addition to inserting the pages themselves, it also merges other
  *    document data from SourceDoc into document:
  *     Named destinations from SourceDoc (of PDF 1.1 and later) are copied into
  *      the document . If there are named destinations in SourceDoc with the same
  *      name as some named destination in the document , the ones in document
  *      retain their names and the copied named destinations are given new names
  *      based on the old ones, with distinguishing digits added. Actions and
  *      bookmarks referring to the old names are made to refer to the new names
  *      after being copied into the document.
 * 	  If it is also the case that AfterPage denotes the last page of the
  *      document, then document metadata is merged, and the optional content
  *      properties are merged in a more symmetrical manner than would otherwise
  *      be the case.
  * Document logical structure from SourceDoc is copied into the document. If
  * less than the whole of SourceDoc is being inserted, only those structure
  * elements having content on the copied pages, and the ancestors of those
  * elements, are copied into the logical structure tree of the document. The
  * top-level children of the structure tree root of SourceDoc are copied as new
  * top-level children of the structure tree root of the document; a structure
  * tree root is created in the document if there was none before. The role maps
  * of the two structure trees are merged, with name conflicts resolved in favor
  * of the role mappings present in doc. Attribute objects having scalar values,
  * or values that are arrays of scalar values, are copied. Class map information
  * from SourceDoc is also merged into that for the document.
  *
  * @param AfterPage The page number in the document after which pages from
  *        SourceDoc are inserted. The first page is 0.
  * @param SourceDoc The document containing the pages that are inserted into
  *        the document.
  * @param SourceStartPage The page number of the first page in SourceDoc to
  *        insert into the document. The first page is 0.
  * @param NumOfPages The number of pages in SourceDoc to insert into the document.
  * @param InsertFlags Flags that determine what additional information is
  *        copied from SourceDoc into the document.
  *)

procedure TgtPDDocument.InsertPages(AfterPage: Integer;
  SourceDoc: TgtPDDocument; SourceStartPage, NumOfPages: Integer;
  InsertFlags: TgtPageInsertFlages);
begin
  FCatalog.PageTree.InsertPages(AfterPage, SourceDoc, SourceStartPage,
    NumOfPages, InsertFlags);
end;
 (**
  * Loads a document from disk. You should call CloseDocument after all
  * operations on the document.
  *
  * @param FileName The File path and name of the document to be loaded
  * @param AuthorizeEvent An authorization callback, called only if the file has
  *        been secured (that is, if the file has either the user or the master
  *        password set). This callback should obtain whatever information is
  *        needed to determine whether the user is authorized to open the file,
  *        then call Authorize() (which returns the permissions that the
  *        authentication data enables).
  * @param DoRepair If true, attempt to repair the file if it is damaged. If
  *        false, do not attempt to repair the file if it is damaged.
  * @exception ExInvalidPassword if the Authorize() didnt suceed
  * @exception ENeedRebuild if the document needs to be rebuilt and doRepair is
  *            false.
  * @exception EBadRootObj if the Catalog object (as returned by
  *            BaseDoc.GetDocRoot()) is not a dictionary.
  * @exception ENoHeader if the document's header appears to be bad.
  * @exception ENoStartXRef if no end-of-file line can be located.
  * @exception ERebuildFailed if doRepair is true and rebuild failed.
  * @algorithm
  *            1. Start
  *            2.	IF NOT FileExists(FileName)
  *              a.	Raise ExFileNotFound Exception
  *            3. FFileName := FileName
  *            4.	Create FileStream With FStream((Filename, Open read and Share Exclusive mode)
  *            5.	On EFOpenError
  *              a.	Raise ExFileOpenError Exception
  *            6.	LoadDocument(FStream, DoRepair)
  *            7. End
  *
  *)

procedure TgtPDDocument.LoadDocument(const FileName: AnsiString; DoRepair: Boolean);
begin
  if Assigned(FStream) then
  begin
    FileClose(TFileStream(FStream).Handle);
    {$IFDEF VCL6ORABOVE}
    THackHandleStream(FStream).FHandle := 0;
    {$ENDIF}
    FStream.Free;
  end;
  if not FileExists(Filename) then
  begin
    raise ExFileNotFound.Create(ErrFileNotFound);
  end;

  FFileName := FileName;
  try
    FStream := TFileStream.Create(FileName, fmOpenRead + fmShareDenyNone);
  except
    on E: EFOpenError do
      raise ExFileOpenError.Create(ErrFileOpenError);
  end;
  LoadDocument(FStream, DoRepair, True);
end;

 (**
  * Loads a document from Stream. You should call CloseDocument after all
  * operations on the document.
  *
  * @param Stream The File Stream of the document to be loaded
  * @param AuthorizeEvent An authorization callback, called only if the file has
  *        been secured (that is, if the file has either the user or the master
  *        password set). This callback should obtain whatever information is
  *        needed to determine whether the user is authorized to open the file,
  *        then call Authorize() (which returns the permissions that the
  *        authentication data enables).
  * @param DoRepair If true, attempt to repair the file if it is damaged. If
  *        false, do not attempt to repair the file if it is damaged.
  * @exception EIncorrectPassword if the Authorize() didnt suceed
  * @exception ENeedRebuild if the document needs to be rebuilt and doRepair is
  *            false.
  * @exception EBadRootObj if the Catalog object (as returned by
  *            BaseDoc.GetDocRoot()) is not a dictionary.
  * @exception ENoHeader if the document's header appears to be bad.
  * @exception ENoStartXRef if no end-of-file line can be located.
  * @exception ERebuildFailed if doRepair is true and rebuild failed.
  * @algorithm
  *        1.	Start
  *        2.	IF Assigned FBaseDoc Then
  *          a.	Free FBaseDoc
  *        3.	Create FBaseDoc
  *        4.	With FBaseDoc do
  *          a.	LoadDocument(Stream, DoRepair)
  *          b.	ExInvalidPassword
  *          c.	begin
  *            i.	IF Assigned(FOnAuthorizeEvent) Then
  *              1.	Call OnAuthorizeEvent(Self)
  *              2.	IF FTries <= 3 Then
  *              3.	begin
  *                a.	FTries := FTries + 1
  *                b.	LoadDocument(Stream, DoRepair)
  *              4.	End
  *              5.	Else
  *                a.	Raise ExPasswordRequired Exception
  *            ii.	Else
  *              1.	Raise ExPasswordRequired Exception
  *          d.	End
  *        5.	End
  *        6.	IF Assigned FCatalog Then
  *          a.	Free FCatalog
  *        7.	Create FCatalog(Self, nil, FBaseDoc.GetDocRoot)
  *        8.	End
  *
  *)

procedure TgtPDDocument.LoadDocument(Stream: TStream; DoRepair: Boolean;
  FreeStream: Boolean);
begin
  FFreeStream := FreeStream;
  if Assigned(FBaseDoc) then FBaseDoc.Free;
  FBaseDoc := TgtPDBaseDoc.Create;
  try
    FBaseDoc.LoadDocument(Stream, FPassword); //DoRepair
    FIsEncrypted := FBaseDoc.IsEncrypted;
//    FBaseDoc.UserEncryptionSettings := FUserEncryptionSettings;
    if FIsEncrypted then
      FPermissions := GetPermissions;
  except
    on E: ExInvalidPassword do
    begin
      raise ExPasswordRequired.Create(ErrPasswordRequired);
    end;
  end;

  if Assigned(FCatalog) then FCatalog.Free;
  FCatalog := TgtPDCatalog.Create(Self, nil, FBaseDoc.GetDocRoot);
  GetDocInfo;
  GetPDFVersion;
end;

function TgtPDDocument.MapUserpermissions(
  AuserPerm: TgtPDPermissions): TgtUserPermissions;
begin
  Result := [];
  if AuserPerm.Print then
    Result := Result + [AllowPrint];
  if AuserPerm.PrintHighQuality then
    Result := Result + [AllowHighResPrint];
  if AuserPerm.ModifyContents then
    Result := Result + [AllowModify];
  if AuserPerm.CopyText then
    Result := Result + [AllowCopy];
  if AuserPerm.ModifyTextAnnots then
    Result := Result + [AllowAnnotation];
  if AuserPerm.FillForms then
    Result := Result + [AllowFormFill];
  if AuserPerm.AssmbleDoc then
    Result := Result + [AllowDocAssembly];
end;

procedure TgtPDDocument.MergeDocs(SourceDoc: TgtPDDocument;
  InsertFlags: TgtPageInsertFlages);
begin
  InsertPages(GetPageCount, SourceDoc, 1, (SourceDoc.GetPageCount - 1), InsertFlags);
end;

 (**
  * Causes a AnsiString produced as by GetMergedXAPKeywords() to be stored as the
  * new value of the pdf:Keywords property, and the former value of the
  * pdf:Keywords property to be stored as an item in the xmp:Keywords bag of
  * keyword items.
  *
  *)

procedure TgtPDDocument.MergeXMPKeywords;
begin

end;

 (**
  * Moves one page in a document.
  *
  * @param MoveToAfterPage The new location of the page to move. The first page
  *        is 1.
  * @param PageToMove The page number of the page to move.
  * @exception EBadParams Is raised if the Parameters are invalid
  * @algorithm
  *        1.	Start
  *        2.	FCatalog.PageTree.MovePage(MoveToAfterPage, PageToMove)
  *        3.	End
  *
  *)

procedure TgtPDDocument.MovePage(MoveToAfterPage, PageToMove: Integer);
begin
  FCatalog.PageTree.MovePage(MoveToAfterPage, PageToMove);
end;

procedure TgtPDDocument.NewDocument(Rect: TgtPDRect);
begin
  if not Assigned(FBlankDocStrm) then
    FBlankDocStrm := TStringStream.Create(PDBlankDocTemplate);
  LoadDocument(FBlankDocStrm, False);
  Pages[1].SetMediaBox(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
end;

(**
  * Removes the name tree inside the Names dictionary with the specified key
  * name. It does nothing if no object with that name exists.
  *
  * @param TreeName The name tree to remove.
  *)

procedure TgtPDDocument.RemoveFormField(ApageNo, Index: Integer);
begin
  Pages[ApageNo].RemoveFormField(Index);
end;

function TgtPDDocument.GetUseDualEMFPlus: Boolean;
begin
  Result := FUseDualEMFPlus;
end;

procedure TgtPDDocument.RemoveAction(ATriggerType: TgtDocActionTrigger);
begin
  if Assigned(FCatalog) then
    FCatalog.RemoveAction(ATriggerType);
end;

procedure TgtPDDocument.RemoveFormField(ApageNo: Integer; AFieldName: AnsiString);
begin
  Pages[ApageNo].RemoveFormField(AFieldName);
end;

procedure TgtPDDocument.RemoveNameTree(const TreeName: AnsiString);
begin

end;

 (**
  * Removes the value of the OpenAction key in the Catalog dictionary. The value
  * is the action performed when the document is opened.
  *
  * @exception EOpNotPermitted Is raised if operation not permitted
  *)

procedure TgtPDDocument.RemoveOpenAction;
begin

end;

 (**
  * Removes the page label that is attached to the specified page, effectively
  * merging the specified range with the previous page label sequence.
  *
  * @param PageNum The page from which the page label is removed.
  *)

procedure TgtPDDocument.RemovePageLabel(PageNum: Integer);
begin

end;

 (**
  * Removes an article thread from a document.
  *
  * @param Index The index of the thread to remove.
  *)

procedure TgtPDDocument.RemoveThread(Index: Integer);
begin

end;

{$IFNDEF DLLPROJECT}
 procedure TgtPDDocument.RenderImage(AStream: TStream; APageNum: Integer;
  AxDPI, AyDPI: Double; ARotationAngle: Integer; AntiAliasing, APrinting: Boolean);
var
  LRenderDev: TgtPDImageDevice;
begin
  LRenderDev := TgtPDImageDevice.Create(AStream, AntiAliasing, False, FUseDualEMFPlus);
  try
    if not Assigned(FontList) then
      FontList := GetFonts;
    LRenderDev.FontList := FontList;
    DisplayPage(LRenderDev, APageNum, AyDPI, AxDPI, ARotationAngle, True,
      False, False);
    AStream.Position := 0;
  finally
    LRenderDev.Free;
  end;
end;


procedure TgtPDDocument.RenderRotatedImage(AHDC: HDC; AStream: TStream;
  APageNum: Integer; AWidth, AHeight: Cardinal; AxDPI, AyDPI: Double;
  ARotationAngle: Integer; AntiAliasing, APrinting: Boolean);
var
  LRStream: TStream;
  LGraphics, LRGraphics: IGPGraphics;
  LBrush: IGPSolidBrush;
  LIStream, LRIStream: IStream;
  LMetafile, LRImage: IGPMetafile;
  LDC: HDC;
begin
  //Renders the image into the stream provided
  RenderImage(AStream, APageNum, AxDPI, AyDPI, ARotationAngle, AntiAliasing, APrinting);
  AStream.Position := 0;

  if AHDC <> 0 then
    LGraphics := TGPGraphics.Create(AHDC);              //Create graphic object with HDC provided

  LBrush := TGPSolidBrush.Create(MakeColor(255, 255, 255));
  LIStream := TgtStreamAdapter.Create(AStream);         //IStream for LMetafile
  LMetafile := TGPMetafile.Create(LIStream);          //Metafile for final image
  LRStream := TMemoryStream.Create;                   //Stream for rotation of image
  LRIStream := TgtStreamAdapter.Create(LRStream);       //IStream for rotation
  LDC := GetDC(0);
  LRImage := TGPMetafile.Create(LRIStream, LDC); //Metafile for rotation
  ReleaseDC(0, LDC);
  LRGraphics := TGPGraphics.Create(LRImage);          //Graphics for rotation

  //Set the Unit for Graphics
  if AHDC <> 0 then
    LGraphics.SetPageUnit(UnitPixel);
  LRGraphics.SetPageUnit(UnitPixel);
  //Fill the area with white rect in case of any exception, this white portion will be shown
  if AHDC <> 0 then
    LGraphics.FillRectangle(LBrush, MakeRect(0, 0, AWidth, AHeight));
  try
    case ARotationAngle of   //Drawing using different rotation
      0:
        begin
        if AHDC <> 0 then
            LGraphics.DrawImage(LMetafile, MakeRect(0, 0, AWidth, AHeight));
          LRGraphics := nil;
        end;
      -90:
        begin
          LRGraphics.TranslateTransform(0, LMetafile.GetWidth);
          LRGraphics.RotateTransform(-90);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          if AHDC <> 0 then
            LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      -180:
        begin
          LRGraphics.TranslateTransform(LMetafile.GetWidth, LMetafile.GetHeight);
          LRGraphics.RotateTransform(-180);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          if AHDC <> 0 then
            LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      -270:
        begin
          LRGraphics.TranslateTransform(LMetafile.GetWidth, 0);
          LRGraphics.RotateTransform(-270);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          if AHDC <> 0 then
            LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      90:
        begin
          LRGraphics.TranslateTransform(0, -LMetafile.GetWidth);
          LRGraphics.RotateTransform(90);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

         if AHDC <> 0 then
            LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      180:
        begin
          LRGraphics.TranslateTransform(-LMetafile.GetWidth, -LMetafile.GetHeight);
          LRGraphics.RotateTransform(180);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          if AHDC <> 0 then
            LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      270:
        begin
            LRGraphics.TranslateTransform(-LMetafile.GetWidth, 0);
            LRGraphics.RotateTransform(270);
            LRGraphics.DrawImage(LMetafile, 0, 0);
            LRGraphics := nil;

            if AHDC <> 0 then
              LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
    end;
  finally
    LRStream.Free;
//    IStream(LRIStream)._Release;
    LRImage := nil;
    LMetafile := nil;
    LBrush := nil;
    LGraphics := nil;
  end;
end;

procedure TgtPDDocument.RenderToCanvas(AHDC: HDC; APageNum: Integer; AWidth,
  AHeight: Cardinal; AxDPI, AyDPI: Double; ARotationAngle: Integer;
  AntiAliasing, APrinting: Boolean);
var
  LStream: TStream;
begin
  LStream := TMemoryStream.Create;  //Memorystream into which Metafile will be stored
  try
    RenderRotatedImage(AHDC, LStream, APageNum, AWidth, AHeight, AxDPI, AyDPI,
      ARotationAngle, AntiAliasing, APrinting);
  finally
    LStream.Free;
  end;
end;

procedure TgtPDDocument.RenderImageToDC(AEMFPlusStream: TStream; AHDC: HDC;
  AWidth, AHeight: Cardinal; AxDPI, AyDPI: Double;
  ARotationAngle: Integer; AntiAliasing, APrinting: Boolean);
var
  LRStream: TStream;
  LGraphics, LRGraphics: IGPGraphics;
  LBrush: IGPSolidBrush;
  LIStream, LRIStream: IStream;
  LMetafile, LRImage: IGPMetafile;
  LWidth, LHeight: Single;
  LDC: HDC;
begin
  LGraphics := TGPGraphics.Create(AHDC);              //Create graphic object with HDC provided
  LBrush := TGPSolidBrush.Create(MakeColor(255, 255, 255));
  LIStream := TgtStreamAdapter.Create(AEMFPlusStream);         //IStream for LMetafile
  LMetafile := TGPMetafile.Create(LIStream);          //Metafile for final image
  LRStream := TMemoryStream.Create;                   //Stream for rotation of image
  LRIStream := TgtStreamAdapter.Create(LRStream);       //IStream for rotation
  LDC := GetDC(0);
  LRImage := TGPMetafile.Create(LRIStream, LDC); //Metafile for rotation
  ReleaseDC(0, LDC);
  LRGraphics := TGPGraphics.Create(LRImage);          //Graphics for rotation

  LGraphics.SetPageUnit(UnitPixel);
  LRGraphics.SetPageUnit(UnitPixel);
  //Fill the area with white rect in case of any exception, this white portion will be shown
  LGraphics.FillRectangle(LBrush, MakeRect(0, 0, AWidth, AHeight));
  try
    case ARotationAngle of   //Drawing using different rotation
      0:
        begin
          LGraphics.DrawImage(LMetafile, MakeRect(0, 0, AWidth, AHeight));
          LRGraphics := nil;
        end;
      -90:
        begin
          LRGraphics.TranslateTransform(0, LMetafile.GetWidth);
          LRGraphics.RotateTransform(-90);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      -180:
        begin
          LRGraphics.TranslateTransform(LMetafile.GetWidth, LMetafile.GetHeight);
          LRGraphics.RotateTransform(-180);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      -270:
        begin
          LRGraphics.TranslateTransform(LMetafile.GetWidth, 0);
          LRGraphics.RotateTransform(-270);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      90:
        begin
          LWidth := LMetafile.GetWidth;
          LRGraphics.TranslateTransform(0, -LWidth);
          LRGraphics.RotateTransform(90);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      180:
        begin
          LWidth := LMetafile.GetWidth;
          LHeight := LMetafile.GetHeight;
          LRGraphics.TranslateTransform(-LWidth, -LHeight);
          LRGraphics.RotateTransform(180);
          LRGraphics.DrawImage(LMetafile, 0, 0);
          LRGraphics := nil;

          LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
      270:
        begin
            LWidth := LMetafile.GetWidth;
            LRGraphics.TranslateTransform(-LWidth, 0);
            LRGraphics.RotateTransform(270);
            LRGraphics.DrawImage(LMetafile, 0, 0);
            LRGraphics := nil;

            LGraphics.DrawImage(LRImage, MakeRect(0, 0, AWidth, AHeight));
        end;
    end;
  finally
    LRStream.Free;
  //  IStream(LRIStream)._Release;
    LRImage := nil;
    LMetafile := nil;
    LBrush := nil;
    LGraphics := nil;
  end;
end;

procedure TgtPDDocument.RenderToMetafile(AEMFPlusStream: TStream;
  APageNum: Integer; AWidth, AHeight: Cardinal; AxDPI, AyDPI: Double;
  ARotationAngle: Integer; AntiAliasing, APrinting: Boolean);
begin
  RenderRotatedImage(0, AEMFPlusStream, APageNum, AWidth, AHeight, AxDPI,
    AyDPI, ARotationAngle, AntiAliasing, APrinting);
end;
{$ENDIF}

(**
  * Replaces that group with another group, In the document associated with a
  * specified optional-content group.
  *
  * @param ReplaceOCG The OCG to replace
  * @param KeepOCG The replacement OCG.
  *)

procedure TgtPDDocument.ReplaceOCG(ReplaceOCG, KeepOCG: TgtPDOCG);
begin

end;

 (**
  * Replaces the specified range of pages in one document with pages from
  * another. The contents, resources, size and rotation of the pages are
  * replaced. The bookmarks are not copied, because they are attached to the
  * document, not to individual pages.
  * Note:Annotations in the replaced pages are not replaced and remain with the
  * page. Use DeletePages() to remove annotations.
  *
  * @param StartPage The first page number in the document to replace. The first
  *        page is 1.
  * @param SourceDoc The document from which pages are copied into the document.
  * @param SourceStartPage The page number of the first page in SourceDoc to
  *        copy. The first page is 1.
  * @param NumOfPages The number of pages to replace.
  * @param MergeTextAnnots If true, text annotations from SourceDoc are appended
  *        if they are different than all existing annotations on the page in
  *        the document. No other types of annotations are copied.
  * @exception EOpNotPermitted is raised unless the document is editable and
  *            SourceDoc is not encrypted or the owner opened it.
  * @exception EBadParm is raised if one of the following conditions is
  *            true:
  *                numPages < 1
  *                startPage < 1
  *                startPage + numPages is greater than the number of pages in
  *                     the document
  *                SourceStartPage < 1
  *                SourceStartPage + numPages is greater than the number of
  *                     pages in SourceDoc
  *)

procedure TgtPDDocument.ReplacePages(StartPage: Integer;
  SourceDoc: TgtPDDocument; SourceStartPage, NumOfPages: Integer;
  MergeTextAnnots: Boolean);
begin
  FCatalog.PageTree.ReplacePages(StartPage, SourceDoc, SourceStartPage,
    NumOfPages, MergeTextAnnots);
end;

 (**
  * Requests NumOfPages starting at StartPage, and performs a specified
  * procedure on them.
  *
  * @param StartPage The first page requested.
  * @param NumOfPages The number of pages requested.
  * @param RequestPagesEvent The Event called for each page
  * @algorithm
  *          1.	Start
  *          2.	Return FCatalog.PageTree.RequestPages(StartPage, NumOfPages)
  *          3.	End
  *
  *)

procedure TgtPDDocument.RequestPages(StartPage, NumOfPages: Integer;
  RequestPagesEvent: TgtRequestPagesEvent);
begin
  FCatalog.PageTree.RequestPages(StartPage, NumOfPages, RequestPagesEvent);
end;

 (**
  * Saves a document to disk. If a full save is requested to the original path,
  * the file is saved to a file system-determined temporary file, and the
  * temporary file is renamed to newPath. You must call CloseDocument() to
  * release resources;
  *
  * A full save optimizes the PDF file. During optimization, all objects in a
  * PDF file are rearranged, many of them acquiring not only a new file
  * position, but also a new Base object number.
  *
  * All PDModel level objects and Base objects derived from the PDDocument are
  * no longer valid after the save. Attempting to use these objects after a save
  * produces undefined results.
  *
  * @param Filename The path to which the file is saved.
  * @param SaveFlags The SAve Flags determining how to save the file
  *
  * @exception ENotPermitted if saving is not permitted. Saving is permitted if
  *            either edit or editNotes (see PDPerms) is allowed, or you are doing
  *             a full save and saveAs is allowed.
  * @exception EAlreadyOpen if the document in destination path is alredy open.
  * @algorithm
  *            1.	Start
  *            2.	Create FileStream with LStream(FileName, Create mode)
  *            3.	IF Assigned LStream Then
  *              a.	Free LStream;
  *            9.	End
  *
  *)

procedure TgtPDDocument.SaveDocument(const FileName: AnsiString;
  SaveFlags: TgtPDSaveFlags);
var
  LStream: TStream;
begin
  if Filename = '' then
  begin
    raise ExInvalidFileName.Create(ErrInvalidFileName);
  end;
  try
    LStream := TFileStream.Create(FileName, fmCreate);
  except
    on E: EFCreateError do
      raise ExFileCreateError.Create(ErrFileCreateError + E.Message);
  end;

  SaveDocument(LStream, SaveFlags);
  if Assigned(LStream) then
    LStream.Free;
end;

 (**
  * Saves a document to Stream. You must call CloseDocument() to
  * release resources;
  *
  * A full save optimizes the PDF file. During optimization, all objects in a
  * PDF file are rearranged, many of them acquiring not only a new file
  * position, but also a new Base object number.
  *
  * All PDModel level objects and Base objects derived from the PDDocument are
  * no longer valid after the save. Attempting to use these objects after a save
  * produces undefined results.
  *
  * @param Stream The Stream to which the document is saved.
  * @param SaveFlags The SAve Flags determining how to save the file
  *
  * @exception ENotPermitted if saving is not permitted. Saving is permitted if
  *            either edit or editNotes (see PDPerms) is allowed, or you are doing
  *             a full save and saveAs is allowed.
  * @exception EAlreadyOpen if the document in destination path is alredy open.
  * @algorithm
  *          1.	Start
  *          2.	IF Assigned FBaseDoc Then
  *            a.	With FBaseDoc, SaveFlags do
  *              i.	SetSaveOptions(FVersion, Incremental, Full, Copy, Linearize,
  *                  UniDirectional, UnCompressed, Compressed, KeepModDate )
  *            b.	End
  *          3.	With FCatalog do
  *            a.	Update
  *          4.	End
  *          5.	With FBaseDoc do
  *            a.	SaveDocument(Stream)
  *          6.	End
  *          7.	CloseDocument
  *          8.	End
  *
  *)

procedure TgtPDDocument.SaveAttachments(ADirectory: AnsiString);
var
  I, J: Integer;
  LList: TObjectList;
  LStream: TFileStream;
  LAnnot: TgtPDAnnot;
begin
  for I := 1 to PageCount do
  begin
    LList := Pages[I].GetAnnots;
    for J := 0 to LList.Count - 1 do
    begin
      LAnnot := TgtPDAnnot(LList[J]);
      if LAnnot.AnnotType = annotFileAttachment then
      begin
        LStream := TFileStream.Create(ADirectory + '\\' + TgtPDFileAttachmentAnnot(LAnnot)
          .Filename, fmCreate);
        TgtPDFileAttachmentAnnot(LAnnot).SaveToStream(LStream);
      end;
    end;
    FileClose(LStream.Handle);
    FreeAndNil(LStream);
  end;
end;

procedure TgtPDDocument.SaveAttachments(AStream: TStream; PageIndex: Integer; AttachmentIndex: Integer);
begin
  Pages[PageIndex].FileAttachment[AttachmentIndex].SaveToStream(AStream);
end;

procedure TgtPDDocument.SaveDocument(Stream: TStream;
  SaveFlags: TgtPDSaveFlags);
begin
  if Assigned(FBaseDoc) then
  begin
    FBaseDoc.SetSaveOptions(GetPDFHeader(Version), SaveFlags.Incremental,
      SaveFlags.Full, SaveFlags.Copy, SaveFlags.Linearize,
      SaveFlags.UniDirectional, SaveFlags.UnCompressed, SaveFlags.Compressed,
      SaveFlags.KeepModDate);

    FCatalog.Update;

    //Set the encryption settings
    FBaseDoc.UserEncryptionSettings := FUserEncryptionSettings;
    FBaseDoc.SaveDocument(Stream);
  end;
 // CloseDocument;
end;

 (**
  * Sets the value of a key in a document's Info dictionary. However, it is
  * preferable to use SetXMPMetadataProperty
  *
  * @param InfoKey The name of the Info dictionary key whose value is set.
  * @param Value The buffer containing the value to associate with infoKey.
  * @algorithm
  *         1. Start
  *         2. FAuthorizeEvent := Value
  *         3. End
  *)

procedure TgtPDDocument.SetAuthorizeEvent(const Value: TgtPDAuthorizeDocEvent);
begin
  FAuthorizeEvent := Value;
end;

{$IFNDEF DLLPROJECT}
procedure TgtPDDocument.SetCMapPath(const Value: string);
begin
  FCMapPath := Value;
end;
{$ENDIF}

procedure TgtPDDocument.SetDocInfo(const InfoKey, Value: AnsiString);
begin

end;

procedure TgtPDDocument.SetIsEncrypted(const Value: Boolean);
begin
  FIsEncrypted := Value;
end;

procedure TgtPDDocument.SetLastObjectNumber(const Value: Cardinal);
begin
  BaseDoc.Reader.XRef.LastObjectNumber := Value;
end;

 (**
  * Sets the value of the PageLayout key in the Catalog dictionary.
  *
  * @param Mode The layout mode to set.
  *)

procedure TgtPDDocument.SetLayoutMode(Mode: TgtPDLayoutMode);
begin
  FCatalog.PageLayout := Mode;
end;

 (**
  * Sets the value of the OpenAction key in the Catalog dictionary, which is the
  * action performed when the document is opened.
  *
  * @param Action The open action you want to set.
  *)

procedure TgtPDDocument.SetOpenAction(Action: TgtPDAction);
begin

end;

 (**
  * Attaches a label to a page. This establishes the numbering scheme for that
  * page and all pages following it, until another page label is encountered.
  * If pageNum is less than 1 or greater than the number of pages in the document,
  * the method does nothing.
  *
  * @param PageNum The number of the page to label.
  * @param PageLabel The label for the page specified by PageNum.
  *)

procedure TgtPDDocument.SetPageLabel(PageNum: Integer;
  PageLabel: TgtPDPageLabel);
begin

end;

 (**
  * Sets the value of the PageMode key in the Catalog dictionary.
  *
  * @param Mode The page mode to set.
  *)

procedure TgtPDDocument.SetPageMode(Mode: TgtPDPageMode);
begin
  FCatalog.PageMode := Mode;
end;

 (**
  * Sets the value of the Trapped key in the Info dictionary to the specified
  * AnsiString.
  *
  * @param Value The new value of the Trapped key in the Info dictionary, or ''
  *              to remove the existing entry.
  *)

procedure TgtPDDocument.SetTrapped(Value: TgtPDTrapped);
begin

end;

procedure TgtPDDocument.SetUseDualEMFPlus(value: Boolean);
begin
  FUseDualEMFPlus := value;
end;

(**
   * Sets the version of PDF
   *
   * @param Value The new version to set
   *)

procedure TgtPDDocument.SetVersion(const Value: TgtPDVersion);
begin
  FVersion := Value;
end;

(**
  * Sets the XMP metadata associated with a document. It replaces the XMP
  * metadata associated with the document pdDoc with the XMP metadata stored in
  * <Metadata>.
  * The contents of the <Metadata> must be well-formed XML and Resource
  * Description Format (RDF), as defined by the W3C (see http://www.w3.org/RDF),
  * that also forms valid XMP. If AnsiString Metadata is ill-formed, an error is
  * raised.
  * Calling SetXMPMetadata() changes the contents of the documents Info
  * dictionary to reflect the values of corresponding metadata properties
  * represented in <Metadata>. The XMP metadata can also contain properties that
  * are not reflected in the Info dictionary.
  * Note:This method raises an exception if the user does not have permission to
  * change the document.
  * Note:If you use this method to set metadata that does not respect the
  * requirement that aliased metadata items (such as pdf:Title and xap:Title) be
  * equal, then the mechanism that maintains this equality when you set metadata
  * via SetDocInfo() is disabled.
  *
  *
  * @param Metadata The metadata to be stored in the document.
  * @exception EOpNotPermitted is raised if the document is not writable.
  *)

procedure TgtPDDocument.SetXMPMetadata(const Metadata: AnsiString);
begin
  FCatalog.SetXMPMetadata(Metadata);
end;

 (**
  * Sets the value of an XMP metadata array item, associated with a document,
  * based on an index.
  * Note:XMP properties can have an XML substructure; this method can only set a
  * value for simple textual properties.
  *
  * @param NameSpace The XML namespace URI for the schema in which the property
  *        is to be found.
  * @param NamespacePrefix A brief AnsiString to be used as an abbreviation when
  *        creating the XML representation of the property. This AnsiString must not
  *        be empty.
  * @param Path The name of the simple property to be modified.
  * @param Index The index in the metadata property array associated with the
  *        property.
  * @param NewValue The new XML text value for the property.
  *)

procedure TgtPDDocument.SetXMPMetadataArrayItem(const NameSpace,
  NamespacePrefix, Path: AnsiString; Index: Integer; const NewValue: AnsiString);
begin

end;

 (**
  * Sets the value of an XMP metadata property associated with a document. The
  * XMP metadata represents all the properties in the documents Info dictionary,
  * and can also contain properties that are not in the Info dictionary. This
  * call is preferred to SetDocInfo(), which only allows access to properties
  * that are in the Info dictionary.
  * Note:XMP properties can have an XML substructure; this method can only set a
  * value for simple textual properties.
  *
  * @param NameSpace The XML namespace URI for the schema in which the property
  *        is to be found.
  * @param NamespacePrefix A brief AnsiString to be used as an abbreviation when
  *        creating the XML representation of the property. This AnsiString must not
  *        be empty.
  * @param Path The name of the simple property to be modified.
  * @param NewValue The new XML text value for the property.
  *)

procedure TgtPDDocument.SetXMPMetadataProperty(const NameSpace, NamespacePrefix,
  Path, NewValue: AnsiString);
begin

end;
{$IFNDEF DLLPROJECT}
class procedure TgtPDDocument.StartGDIPlus;
begin
  StartIGDIPlus;
end;

class procedure TgtPDDocument.StopGDIPlus;
begin
  StopIGDIPlus;
end;
{$ENDIF}

procedure TgtPDDocument.Stitch(AStitchToPage, AStitchFromPage: Integer);
begin
  FCatalog.PageTree.StitchPages(AStitchToPage, AStitchFromPage);
end;

procedure TgtPDDocument.StitchPagesSideBySide(AStitchToPage,
  AStitchFromPage: Integer);
begin
  FCatalog.PageTree.StitchPagesSideBySide(AStitchToPage, AStitchFromPage);
end;

(**
  * Constructor
  *
  * @algorithm
  *           1. Start
  *           2. FTries := 1
  *           3. End
  *
  *)

constructor TgtPDDocument.Create;
begin
  FTries := 1;
  FIsEncrypted := False;
  with FPermissions do
  begin
    Print := False;
    PrintHighQuality := False;
    ModifyContents := False;
    CopyText := False;
    ModifyTextAnnots := False;
    FillForms := False;
    AssmbleDoc := False;
    PrintToDigitalCopy := False;
    OwnerPassword := '';
    UserPassword := '';
    Level := el128Bits;
    Enable := False;
  end;
  FUseDualEMFPlus := True;
  {$IFDEF COPYPROTECT}
    // activateLicense will take care
  {$ELSE}
    // the switches will determine whether to put trial mark or not
    {$IFDEF gtRegistered}
      IsReg := True;
    {$ELSE}
      IsReg := False;
    {$ENDIF}
  {$ENDIF}
end;

initialization
  Randomize;

end.
