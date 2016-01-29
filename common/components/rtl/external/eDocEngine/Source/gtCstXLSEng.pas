{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }
{$I gtDefines.inc}
{$I gtDocDefines.inc}
unit gtCstXLSEng;

interface

uses
  Classes, Windows, Graphics, SysUtils, Math, gtCstDocEng, gtCstSpdEng,
  gtUtils3, gtZipPackage, gtOmniXML, gtOmniXMLUtils, Dialogs, gtStringHash,
  gtConsts3, gtDocConsts, gtDocUtils, gtDocResStrs, Printers;

const
  DefaultXMLHeader = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';

type

  TgtCustomExcelEngine = class;

  TgtOnNeedSheetName = procedure(Sender: TgtCustomExcelEngine;
    var SheetName: String; SheetNo: Integer) of object;

  TgtCellItem = class(TObject)
  protected
    FRowData: String;
    FRowNo: Integer;
    FColumnNo: Integer;
    FStyleIndex: Integer;
    FSharedStringIndex: Integer;
    FData: Extended;
    FValue: Integer;
    FIsSharedString: Boolean;
    FFormula: string;
    FHieght: Extended;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TgtSheetItem = class(TObject)
  private
    FSheetName: String;
    FSheetOffset: Int64;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  // TgtFormula = class(TgtCellItem)
  // public
  // constructor create;
  // destructor Destroy; override;
  // property Formula: string read FFormula write FFormula;
  // property Value: Double read FData write FData;
  // property RowNo: integer read FRowNo write FRowNo;
  // property ColNo: integer read  FColumnNo write FColumnNo;
  // property styleIndex: integer read FStyleIndex write FStyleIndex;
  // end;

  { TgtExcelOLEStream }

  // TgtExcelOLEStream = class(TObject)
  // private
  // FBATCount: Longint;
  // FBATBlockCount: Longint;
  // FFirstBlockIndex: Longint;
  // FXBatCount: Longint;
  // FFirstXBatIndex: Longint;
  // FExcelStreamSize: Integer;
  //
  // procedure CalculateBATBlocks;
  // procedure WriteHeader;
  // procedure WriteBlocks;
  // procedure WritePropertyBlock;
  // public
  // FStream: TMemoryStream;
  // FExcelStream: TStream;
  // constructor Create;
  // destructor Destroy; override;
  // procedure MakeExcelStream;
  // end;

  TgtCellBorderStyle = (cbsNone, cbsThin, cbsMedium, cbsDashed, cbsDotted,
    cbsThick, cbsDouble, cbsHair);
  TgtSheetRelationType = (srtNone, srtImage, srtDrawing);
  // added
  TgtDrawingType = (dtNone, dtLine, dtpicture, dtRectangle, dtRoundRect,
    dtPolyLine, dtTextBox, dtEllipse);

  TgtCellBorder = class(TPersistent)
  private
    FEnabled: Boolean;
    FStyle: TgtCellBorderStyle;
    FColor: TColor;
    procedure SetEnabled(const Value: Boolean);
    procedure SetStyle(const Value: TgtCellBorderStyle);
    procedure SetColor(const Value: TColor);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property Style: TgtCellBorderStyle read FStyle write SetStyle
      default cbsNone;
    property Color: TColor read FColor write SetColor default clBlack;
  end;

  { TgtExcelPreferences }

  TgtWorksheetPagesType = 0 .. MaxInt;

  TgtExcelPreferences = class(TgtSpreadSheetPreferences)
  private
    FPrintGridLines: Boolean;
    FPagesPerWorksheet: TgtWorksheetPagesType;
    FPageMargins: Boolean;
    FMetafileAsImage: Boolean;
    procedure SetPagesPerWorksheet(const Value: TgtWorksheetPagesType);
    procedure SetPageMargins(const Value: Boolean);
    procedure SetPrintGridLines(const Value: Boolean);
    procedure SetMetafileAsImage(const Value: Boolean);
  public
    constructor Create; override;
  published
    property PagesPerWorksheet: TgtWorksheetPagesType read FPagesPerWorksheet
      write SetPagesPerWorksheet default 0;
    property PrintGridLines: Boolean read FPrintGridLines
      write SetPrintGridLines default False;
    property PageMargins: Boolean read FPageMargins write SetPageMargins
      default False;
    property MetafileAsImage: Boolean read FMetafileAsImage
      write SetMetafileAsImage default False;
  end;

  { Added }
  TgtStyle = class(TObject)
  private
    FNumFmtIndex: Integer;
    FFontIndex: Integer;
    FBorderIndex: Integer;
    FFillID: Integer;
    FAlignment: TgtHAlignment;
    FCellHieght: Double;
    FCellWidth: Double;
    IsCurrency: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TgtColor = class(TObject)
  private
    FRGB: string;
    FIsRGB: Boolean;
  public
    property RGB: string read FRGB write FRGB;
    constructor Create;
    destructor Destroy; override;
  end;

  TgtFont = class(TObject)
  private
    FSize: Integer;
    FColor: TgtColor;
    FName: TFontName;
    FFamily: Integer;
    FScheme: string;
    FStyle: TFontStyles;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TgtSheetRelation = class(TObject)
  private
    FRelType: TgtSheetRelationType;
    FTarget: string;
    FsrID: String;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TgtDrawingRelation = class(TObject)
  private
    FTarget: string;
    FDrId: string;
  public
    property Target: string read FTarget write FTarget;
    property DrID: string read FDrId write FDrId;
    constructor Create;
    destructor Destroy; override;
  end;

  TgtDrawing = class(TObject)
  private
    FFromColNo: Integer;
    FFromRowNo: Integer;
    FFromColOffset: Integer;
    FFromRowOffset: Integer;
    FToColNo: Integer;
    FToRowNo: Integer;
    FToColOffset: Integer;
    FToRowOffset: Integer;
    FDrawingType: TgtDrawingType;
    FRId: string;
    FISFill: Boolean;
    FPenColor: string;
    FBrushColor: string;
    FFillColor: string;
    FLines: string;
    FFont: TFont;
    FHAlignment: TgtHAlignment;
    FVAlignment: TgtVAlignment;
    FSheetNo: Integer;
    FImageIndex: Integer;
  public
    property FromColNo: Integer read FFromColNo write FFromColNo;
    property FromRowNo: Integer read FFromRowNo write FFromRowNo;
    property FromColOffset: Integer read FFromColOffset write FFromColOffset;
    property FromRowOffset: Integer read FFromRowOffset write FFromRowOffset;
    property ToColNo: Integer read FToColNo write FToColNo;
    property ToRowNo: Integer read FToRowNo write FToRowNo;
    property ToColOffset: Integer read FToColOffset write FToColOffset;
    property ToRowOffset: Integer read FToRowOffset write FToRowOffset;
    property DrawingType: TgtDrawingType read FDrawingType write FDrawingType;
    property Rid: string read FRId write FRId;
    property IsFill: Boolean read FISFill write FISFill;
    property FillColor: string read FFillColor write FFillColor;
    property PenColor: string read FPenColor write FPenColor;
    property BrushColor: string read FBrushColor write FBrushColor;
    property SheetNo: Integer read FSheetNo write FSheetNo;
    property Lines: string read FLines write FLines;
    property Font: TFont read FFont write FFont;
    property HAlignment: TgtHAlignment read FHAlignment write FHAlignment;
    property VAlignment: TgtVAlignment read FVAlignment write FVAlignment;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    constructor Create;
    destructor Destroy; override;
  end;

  { TgtCustomExcelEngine }

  TgtCustomExcelEngine = class(TgtCustomSpreadSheetEngine)
  private
    FExcelStream: TMemoryStream;
    FOutputStream: TStream;
    FSheetNamesSize: Int64;
    FSheetCount: Integer;
    FImageCount: Integer;
    FDrawingCount: Integer;
    FdrawRelationRemainscount: Integer;
    FSpreadSheetItemList: TList;
    FOnNeedSheetName: TgtOnNeedSheetName;
    FCellBorder: TgtCellBorder;
    FShapeTransparency: Extended;
    FApplyTransparency: Boolean;
    FMinRowNo: Integer;
    FMaxRowNo: Integer;
    FMinColNo: Integer;
    FMaxColNo: Integer;
    FZipPackage: TgtZipPackage;
    FRId: Integer;
    FStringHash: TgtStringHash;
    FRowItemList: TList;
    FStringCount: Integer;
    // added
    FStylesList: TList;
    FFontList: TList;
    FFillColorList: TList;
    FBorderList: TList;
    FColorList: TList;
    FDrawingList: TList;
    FSheetRelationList: TList;
    FDrawingRelationList: TList;
    FFormuleaList: TList;
    FCompletedImageIndexList: array [0 .. 1000] of Integer;
    FCompletedImageIndexcount: Integer;

    // FSharedStringList: TStringList;
    FSharedStrings: String;
    FSharedStringList: TgtStringHash;
    FDateTimeFormatCode: string;
    FCurrencyFormatCode: string;
    FTimeForamtCode: string;
    FFlag: Boolean;
    Function GetSheetID(SheetNo: Integer): String;
    Function GetRelID(Value: Integer): String;
    // procedure WriteWindow1Record(AStream: TStream);
    // procedure WriteWorkBookHeader(AStream: TStream);
    function GetPreferences: TgtExcelPreferences;
    procedure SetPreferences(const Value: TgtExcelPreferences);
    procedure SetCellBorder(const Value: TgtCellBorder);
    procedure InitDimensionVars;
    procedure CreatePackageRelationship;
    procedure CreateDocPropCore;
    procedure CreateDocPropApp;
    Procedure CreateWorkBookPart;
    Procedure CreateContentTypePart;
    Procedure CreateWorkBookRelationShip;
    Procedure CreateStylesPart;
    Procedure CreateThemesPart;

    function GetNumFrmtText: string;
    function GetFontText: string;
    function GetBorderText: string;
    function GetFillText: string;
    function GetCellStyleXfsText: string;
    function GetCellXfsText: string;
    function GetCellStylesText: string;
    function GetRGBColorsText: string;
    function GetFontChieldText(AFont: TgtFont): string;
    function GetEachXfsText(AStyle: TgtStyle): string;
    // function GetPatternType(Astyle: TBrushStyle): string;
    procedure SetImageIndex(Index: Integer; const Value: Integer);
    function GetImageIndex(Index: Integer): Integer;
  protected
    procedure Start; override;
    procedure BeginPage; override;
    procedure EndPage; override;
    procedure Finish; override;

    procedure EndSheet(SheetNo: Integer);
    procedure EncodeText(AObject: TgtTextItem); override;
    function GetFillStyle(AValue: Byte): Byte;
    procedure WriteBackgroundImage; overload; virtual;

    property ExcelStream: TMemoryStream read FExcelStream write FExcelStream;
    property DrawingList: TList read FDrawingList write FDrawingList;
    property ImageCount: Integer read FImageCount write FImageCount;
    property SheetCount: Integer read FSheetCount write FSheetCount;
    property DrawingRelationList: TList read FDrawingRelationList
      write FDrawingRelationList;
    property Drawingcount: Integer read FDrawingCount write FDrawingCount;
    property ZipPackage: TgtZipPackage read FZipPackage write FZipPackage;
    property CompletedImageIndexList[Index: Integer]: Integer read GetImageIndex
      write SetImageIndex;
    property CompletedImageIndexcount: Integer read FCompletedImageIndexcount
      write FCompletedImageIndexcount;
    property FormuleaList: TList read FFormuleaList write FFormuleaList;
    property ShapeTransparency: Extended read FShapeTransparency
      write FShapeTransparency;
    property ApplyTransparency: Boolean read FApplyTransparency
      write FApplyTransparency;

    function GetPreferencesClassName: TgtPreferencesClass; override;
    function ShowSetupModal: Word; override;
    procedure UpdateDimensionVars(const ARowNo, AColNo: Integer);

    function FillStyle(AFormatIndex: Integer; AFont: TFont; ABrush: TBrush;
      ATextAlign: TgtHAlignment; AcellType: TgtCellType): Integer;
    function StyleFound(AFormatIndex: Integer; AFont: TFont; ABrush: TBrush;
      ATextAlign: TgtHAlignment; AcellType: TgtCellType): Integer;
    function SameFont(AFont: TFont; AFontIndex: Integer): Boolean;
    function SameColor(AColor: string; AIndex: Integer): Boolean;
    function CreateBorderForStyle(AFont: TFont): Integer;
    function CreateFontForStyle(AFont: TFont): Integer;
    function GetFillColor(ABrush: TBrush): Integer;
    function AddFillStyle(ABrush: TBrush): Integer;
    // function commonfont(AFont: TFont): Boolean;
    function GetXLSXColor(AColor: TColor): TgtColor;
    function GetXLSXDrawingColor(AColor: TColor): string;
    function RevrseString(AString: string): string;

    function WrtitesharedStringList(AString: string): Integer;
    procedure WriteSharedstrings;

    procedure AddSheetRelation(ARelType: TgtSheetRelationType);

    function EncodeDrawing(ADrawing: TgtDrawing): string;
    function GetCurrencyFormatId: Integer;
    function GetTimeFormatId: Integer;
    function GetDateTimeFormatId: Integer;
    procedure AppendList(var AIndexCellItem: Integer;
      AIndexFormulaItem: Integer);
    procedure SortAndCombineFormulaListToCurrent;
    procedure AdjustCellsAcordingToRowNumbers;
    Procedure CreateworkSheets(SheetNo: Integer); virtual;
    procedure WriteSheetRelations(ASheetNo: Integer);
    procedure WriteDrawingRelations(ASheetNo: Integer);
    procedure WriteDrawingsXml(ASheetNo: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginDoc; override;
    procedure NewPage; override;

    procedure TextBox(TextRect: TgtRect; Text: WideString;
      HAlignment: TgtHAlignment; VAlignment: TgtVAlignment); override;
    procedure SetColumnWidth(ColumnNumber: Integer; Width: Double); override;
    procedure NewSheet(AAddNewPage: Boolean = True); override;
    property TableSettings;
    property Frame;
  published
    property BackgroundImage;
    property BackgroundColor;
    property Pen;
    property Brush;
    property Preferences: TgtExcelPreferences read GetPreferences
      write SetPreferences;
    property OnNeedSheetName: TgtOnNeedSheetName read FOnNeedSheetName
      write FOnNeedSheetName;
    property CellBorder: TgtCellBorder read FCellBorder write SetCellBorder;
    function GetColumnLabel(AColNo: Integer): String;
  end;

  // function CompareByRowNumber(Item1: Pointer; Item2: Pointer): Integer;
  // function CompareByColumnNumber(Item1: Pointer; Item2: Pointer): Integer;

implementation

uses gtXLSEngDlg;

{ TgtCustomExcelEngine }
{
  function CompareByRowNumber(Item1: Pointer; Item2: Pointer): Integer;
  var
  Temp1, Temp2: TgtCellItem;
  begin
  // We start by viewing the object pointers as TCustomer objects
  Temp1 := TgtCellItem(Item1);
  Temp2 := TgtCellItem(Item2);

  // Now compare by string
  if Temp1.FRowNo > Temp2.FRowNo then
  Result := 1
  else if Temp1.FRowNo = Temp2.FRowNo then
  Result := 0
  else
  Result := -1;
  end;

  function CompareByColumnNumber(Item1: Pointer; Item2: Pointer): Integer;
  var
  Temp1, Temp2: TgtCellItem;
  begin
  // We start by viewing the object pointers as TCustomer objects
  Temp1 := TgtCellItem(Item1);
  Temp2 := TgtCellItem(Item2);

  // Now compare by string
  if Temp1.FColumnNo > Temp2.FColumnNo then
  Result := 1
  else if Temp1.FColumnNo = Temp2.FColumnNo then
  Result := 0
  else
  Result := -1;
  end;
}
procedure TgtCustomExcelEngine.Start;
begin
  inherited;
  if FileExists(FileName) then
    SysUtils.DeleteFile(FileName);

  if not Preferences.OutputToUserStream then
  begin
    FOutputStream := CreateFile(FileName + '.' + FileExtension);
    EngineFileNames.Add(FileName + '.' + FileExtension);
  end
  else
    FOutputStream := UserStream;
  FZipPackage := TgtZipPackage.CreateFromStream(FOutputStream, '');
  FStringHash := TgtStringHash.Create;
  CreatePackageRelationship;
  FExcelStream := TMemoryStream.Create;
  FSpreadSheetItemList := TList.Create;
  FRowItemList := TList.Create;
  FFormuleaList := TList.Create;
  FFillColorList := TList.Create;
  FSheetNamesSize := 0;
  FSheetCount := 0;
  FRId := 0;
  InitDimensionVars;
  CreateResourceItems;
end;

function TgtCustomExcelEngine.StyleFound(AFormatIndex: Integer; AFont: TFont;
  ABrush: TBrush; ATextAlign: TgtHAlignment; AcellType: TgtCellType): Integer;
Var
  LBIndex: Integer;
  LFillStyle: Integer;
  LI: Integer;
  LCurrency: Boolean;
begin
  LCurrency := False;
  Result := 0;
  // LI := 0;
  LBIndex := CreateBorderForStyle(AFont);
  LFillStyle := GetFillColor(ABrush);
  if LFillStyle = -1 then
    LFillStyle := -2;
  if AcellType = ctCurrency then
    LCurrency := True;
  for LI := 0 to FStylesList.Count - 1 do
  begin
    with TgtStyle(FStylesList.Items[LI]) do
    begin
      if (AFormatIndex = FNumFmtIndex) and (LBIndex = FBorderIndex) and
        (LFillStyle = FFillID) and (ATextAlign = FAlignment) and
        (LCurrency = IsCurrency) then
      begin
        if FFontIndex = 1 then
          if SameFont(AFont, FFontIndex - 1) then
          begin
            Result := LI + 1;
            Exit;
          end;

        if FFontIndex > 1 then
          if SameFont(AFont, FFontIndex - 1) then
          begin
            Result := LI + 1;
            Exit;
          end;
      end;
    end;

  end;

end;

procedure TgtCustomExcelEngine.BeginPage;
begin
  inherited;
end;

constructor TgtCustomExcelEngine.Create(AOwner: TComponent);
begin
  inherited;
  FileExtension := 'xlsx';

  FileDescription := SExcelDescription;
  ItemsToRender := [irText, irImage];
  ImageSettings.OutputImageFormat := ifMetafile;
  FCellBorder := TgtCellBorder.Create;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 105);
{$ENDIF}
  // FSharedStringList := TStringList.Create;
  FSharedStringList := TgtStringHash.Create(1000);
  FStylesList := TList.Create;
  FFontList := TList.Create;
  FBorderList := TList.Create;
  FColorList := TList.Create;
  FDrawingList := TList.Create;
  FSheetRelationList := TList.Create;
  FDrawingRelationList := TList.Create;
  FDateTimeFormatCode := '';
  FCurrencyFormatCode := '';
  FTimeForamtCode := '';
  FShapeTransparency := 0.0;
  FApplyTransparency := True;
  FFlag := False;
end;

function TgtCustomExcelEngine.CreateBorderForStyle(AFont: TFont): Integer;
begin
  // border has to be caliculated
  Result := 0;
end;

procedure TgtCustomExcelEngine.CreateContentTypePart;
  function AddWorksheets: String;
  var
    LI: Integer;
  begin
    Result := '';

    for LI := 0 to FSheetCount - 1 do
      Result := Result + '<Override PartName="/xl/worksheets/sheet' +
        IntToStr(LI + 1) + '.xml"' +
        ' ContentType="application/vnd.openxmlformats-officedocument.' +
        'spreadsheetml.worksheet+xml"/>';
  end;

var
  ContentTypeStream: TStringStream;
  LS: String;
  I: Integer;
begin
  LS := DefaultXMLHeader + CRLF +
    '<Types xmlns="http://schemas.openxmlformats.org/package/2006/' +
    'content-types"><Override PartName="/xl/theme/theme1.xml" ContentType' +
    '="application/vnd.openxmlformats-officedocument.theme+xml"/>' +
    '<Override PartName="/xl/styles.xml" ContentType="application' +
    '/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>' +
    '<Default Extension="rels" ContentType="application/vnd.openxmlformats' +
    '-package.relationships+xml"/>' +
    '<Default Extension="xml" ContentType="application/xml"/>' +
    '<Override PartName="/xl/workbook.xml" ContentType="application/vnd' +
    '.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>' +
    '<Override PartName="/docProps/app.xml" ContentType="application/' +
    'vnd.openxmlformats-officedocument.extended-properties+xml"/>' +
    '<Override PartName="/docProps/core.xml" ContentType="application/vnd' +
    '.openxmlformats-package.core-properties+xml"/>' + AddWorksheets +
    '<Override PartName="/xl/sharedStrings.xml" ContentType="application/vnd' +
    '.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml"/>' +
    '<Default Extension="jpeg" ContentType="image/jpeg"/>';
  for I := 1 to CurrentPage do
  begin
    LS := LS + '<Override PartName="/xl/drawings/drawing' + IntToStr(I) +
      '.xml" ContentType' +
      '="application/vnd.openxmlformats-officedocument.drawing+xml"/>';
  end;
  LS := LS + '</Types>';
{$IFDEF gtDelphi2009Up}
  ContentTypeStream := TStringStream.Create(LS, TEncoding.UTF8);
{$ELSE}
  ContentTypeStream := TStringStream.Create(LS);
{$ENDIF}
  FZipPackage.CreateParts('[Content_Types].xml', ContentTypeStream);
  ContentTypeStream.Free;
end;

procedure TgtCustomExcelEngine.CreateDocPropApp;
Var
  LS, LS1, LS2, LS3: String;
  LI: Integer;
  AppStream: TStringStream;
begin
  LS1 := DefaultXMLHeader + CRLF +
    ' <Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/'
    + 'extended-properties" xmlns:vt="http://schemas.openxmlformats.org/' +
    'officeDocument/2006/docPropsVTypes"> ' +
    '<Application>Microsoft Excel</Application>' +
    '<DocSecurity>0</DocSecurity>' + '<ScaleCrop>false</ScaleCrop> ' +
    '<HeadingPairs>' + '<vt:vector size="2" baseType="variant">' +
    '<vt:variant>	<vt:lpstr>Worksheets</vt:lpstr>	</vt:variant> ' +
    '<vt:variant> <vt:i4>' + IntToStr(FSheetCount) + ' </vt:i4>	</vt:variant>' +
    '</vt:vector> </HeadingPairs> <TitlesOfParts> ' + '<vt:vector size="' +
    IntToStr(FSheetCount) + '" baseType="lpstr"> ';
  LS2 := '';
  for LI := 0 to FSheetCount - 1 do
  begin
    with FSpreadSheetItemList do
    begin
      LS2 := LS2 + '<vt:lpstr>' + TgtSheetItem((Items[LI])).FSheetName +
        '</vt:lpstr>';
    end;
  end;
  LS3 := '</vt:vector>	</TitlesOfParts>' + '<Company></Company>' +
    '<LinksUpToDate>false</LinksUpToDate> ' + '<SharedDoc>false</SharedDoc>' +
    '<HyperlinksChanged>false</HyperlinksChanged>' +
    '<AppVersion>12.0000</AppVersion>' + '</Properties>';
  LS := LS1 + LS2 + LS3;
{$IFDEF gtDelphi2009Up}
  AppStream := TStringStream.Create(LS, TEncoding.UTF8);
{$ELSE}
  AppStream := TStringStream.Create(LS);
{$ENDIF}
  FZipPackage.CreateParts('docProps/app.xml', AppStream);
  AppStream.Free;
end;

procedure TgtCustomExcelEngine.CreateDocPropCore;
Var
  XDOc: IXMLDocument;
  FRoot: IXMLElement;
  Element: IXMLElement;
  PI: IXMLProcessingInstruction;
  CoreStream: TMemoryStream;
begin
  XDOc := CreateXMLDoc;
  PI := XDOc.CreateProcessingInstruction('xml',
    'version="1.0" encoding="UTF-8" standalone="yes"');
  XDOc.AppendChild(PI);
  FRoot := XDOc.CreateElement('cp:coreProperties');
  FRoot.SetAttribute('xmlns:cp',
    'http://schemas.openxmlformats.org/package/2006/metadata/core-properties');
  FRoot.SetAttribute('xmlns:dc', 'http://purl.org/dc/elements/1.1/');
  FRoot.SetAttribute('xmlns:dcterms', 'http://purl.org/dc/terms/');
  FRoot.SetAttribute('xmlns:dcmitype', 'http://purl.org/dc/dcmitype/');
  FRoot.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
  XDOc.DocumentElement := FRoot;
  Element := XDOc.CreateElement('dc:creator');
  Element.Text := 'Gnostice eDocEngine';
  FRoot.AppendChild(Element);
  CoreStream := TMemoryStream.Create;
  XMLSaveToStream(XDOc, CoreStream, ofNone);
  FZipPackage.CreateParts('docProps/core.xml', CoreStream);
  CoreStream.Free;
end;

function TgtCustomExcelEngine.CreateFontForStyle(AFont: TFont): Integer;
var
  LFont: TgtFont;
  // LI: Integer;
begin
  // for LI := 0 to FFontList.Count - 1 do
  // if SameFont(AFont, LI) then
  // begin
  // Result := LI + 1;
  // Exit;
  // end;
  LFont := TgtFont.Create;
  if fsUnderline in AFont.Style then
    LFont.FStyle := [fsUnderline];
  if fsItalic in AFont.Style then
    LFont.FStyle := LFont.FStyle + [fsItalic];
  if fsBold in AFont.Style then
    LFont.FStyle := LFont.FStyle + [fsBold];
  if fsStrikeOut in AFont.Style then
    LFont.FStyle := LFont.FStyle + [fsStrikeOut];
  LFont.FSize := AFont.Size;
  LFont.FName := AFont.Name;
  LFont.FFamily := 2;
  LFont.FScheme := 'minor';
  LFont.FColor := GetXLSXColor(AFont.Color);
  if LFont.FColor.FRGB = 'FFFFFFFF' then
    LFont.FColor.FRGB := 'FF000000';
  FFontList.Add(LFont);
  Result := FFontList.Count;
end;

procedure TgtCustomExcelEngine.CreatePackageRelationship;
Var
  XDOc: IXMLDocument;
  FRoot: IXMLElement;
  Element: IXMLElement;
  PI: IXMLProcessingInstruction;
  RelStream: TMemoryStream;
begin
  XDOc := CreateXMLDoc;
  PI := XDOc.CreateProcessingInstruction('xml',
    'version="1.0" encoding="UTF-8" standalone="yes"');
  XDOc.AppendChild(PI);
  FRoot := XDOc.CreateElement('Relationships');
  FRoot.SetAttribute('xmlns',
    'http://schemas.openxmlformats.org/package/2006/relationships');
  XDOc.DocumentElement := FRoot;
  Element := XDOc.CreateElement('Relationship');
  Element.SetAttribute('Id', 'rId3');
  Element.SetAttribute('Type',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/' +
    'extended-properties');
  Element.SetAttribute('Target', 'docProps/app.xml');
  FRoot.AppendChild(Element);
  Element := XDOc.CreateElement('Relationship');
  Element.SetAttribute('Id', 'rId2');
  Element.SetAttribute('Type',
    'http://schemas.openxmlformats.org/package/2006/relationships/metadata/' +
    'core-properties');
  Element.SetAttribute('Target', 'docProps/core.xml');
  FRoot.AppendChild(Element);
  Element := XDOc.CreateElement('Relationship');
  Element.SetAttribute('Id', 'rId1');
  Element.SetAttribute('Type',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/' +
    'officeDocument');
  Element.SetAttribute('Target', 'xl/workbook.xml');
  FRoot.AppendChild(Element);
  RelStream := TMemoryStream.Create;
  XMLSaveToStream(XDOc, RelStream, ofNone);
  FZipPackage.CreateParts('_rels/.rels', RelStream);
  RelStream.Free;
end;

procedure TgtCustomExcelEngine.WriteSheetRelations(ASheetNo: Integer);
Var
  LStringStream: TStringStream;
  LS: string;
  LI: Integer;
  Flag: Boolean;
begin
  Flag := False;
  if FSheetRelationList.Count <> 0 then
  begin
    LS := LS + DefaultXMLHeader + CRLF +
      '<Relationships xmlns="http://schemas.openxmlformats.org/package' +
      '/2006/relationships">';
    for LI := 0 to FSheetRelationList.Count - 1 do
    begin
      with TgtSheetRelation(FSheetRelationList.Items[LI]) do
      begin
        if FRelType = srtImage then
        begin
          LS := LS + '<Relationship ';
          LS := LS + 'Id="' + FsrID + '" ';
          LS := LS + 'Type="http://schemas.openxmlformats.org/officeDocument/' +
            '2006/relationships/';
          LS := LS + 'image" ';
          LS := LS + 'Target="' + FTarget + '"';
          LS := LS + '/>';
        end
        else if not Flag then
        begin
          LS := LS + '<Relationship ';
          LS := LS + 'Id="rId' + IntToStr(CurrentPage) +
            IntToStr(SheetCount) + '" ';
          LS := LS + 'Type="http://schemas.openxmlformats.org/officeDocument/' +
            '2006/relationships/';
          LS := LS + 'drawing" ';
          LS := LS + 'Target="' + FTarget + '"';
          LS := LS + '/>';
          Flag := True;
        end;
      end;
    end;
    LS := LS + '</Relationships>';
{$IFDEF gtDelphi2009Up}
    LStringStream := TStringStream.Create(LS, TEncoding.UTF8);
{$ELSE}
    LStringStream := TStringStream.Create(LS);
{$ENDIF}
    FZipPackage.CreateParts('xl\worksheets\_rels\sheet' + IntToStr(ASheetNo) +
      '.xml.rels', LStringStream);
    LStringStream.Free;
  end;
  FreeAndNil(FSheetRelationList);
  FSheetRelationList := TList.Create;
end;

procedure TgtCustomExcelEngine.CreateStylesPart;
Var
  LS: String;
  StylesStream: TStringStream;
begin
  LS := '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml' +
    '/2006/main">';
  LS := LS + GetNumFrmtText;
  LS := LS + GetFontText;
  LS := LS + GetFillText;
  LS := LS + GetBorderText;
  LS := LS + GetCellStyleXfsText;
  LS := LS + GetCellXfsText;
  LS := LS + GetCellStylesText;
  LS := LS + GetRGBColorsText;
  LS := LS + '</styleSheet>';

{$IFDEF gtDelphi2009Up}
  StylesStream := TStringStream.Create(LS, TEncoding.UTF8);
{$ELSE}
  StylesStream := TStringStream.Create(LS);
{$ENDIF}
  { code has to be inserted }

  FZipPackage.CreateParts('xl\styles.xml', StylesStream);
  StylesStream.Free;
end;

procedure TgtCustomExcelEngine.CreateThemesPart;
var
  ThemeStream: TStringStream;
  LS: String;
begin
  LS := DefaultXMLHeader + CRLF +
    '<a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Office Theme">'
    + '<a:themeElements><a:clrScheme name="Office"><a:dk1><a:sysClr val="windowText" lastClr="000000"/>'
    + '</a:dk1><a:lt1><a:sysClr val="window" lastClr="FFFFFF"/></a:lt1><a:dk2><a:srgbClr val="1F497D"/>'
    + '</a:dk2><a:lt2><a:srgbClr val="EEECE1"/></a:lt2><a:accent1><a:srgbClr val="4F81BD"/>'
    + '</a:accent1><a:accent2><a:srgbClr val="C0504D"/></a:accent2><a:accent3><a:srgbClr val="9BBB59"/>'
    + '</a:accent3><a:accent4><a:srgbClr val="8064A2"/></a:accent4><a:accent5><a:srgbClr val="4BACC6"/>'
    + '</a:accent5><a:accent6><a:srgbClr val="F79646"/></a:accent6><a:hlink><a:srgbClr val="0000FF"/>'
    + '</a:hlink><a:folHlink><a:srgbClr val="800080"/></a:folHlink></a:clrScheme><a:fontScheme name="Office">'
    + '<a:majorFont><a:latin typeface="Cambria"/><a:ea typeface=""/><a:cs typeface=""/>'
    + '<a:font script="Jpan" typeface="ＭＳ Ｐゴシック"/>' +
    '<a:font script="Hang" typeface="맑은 고딕"/>' +
    '<a:font script="Hans" typeface="宋体"/>' +
    '<a:font script="Hant" typeface="新細明體"/>' +
    '<a:font script="Arab" typeface="Times New Roman"/>' +
    '<a:font script="Hebr" typeface="Times New Roman"/><a:font script="Thai" typeface="Tahoma"/>'
    + '<a:font script="Ethi" typeface="Nyala"/><a:font script="Beng" typeface="Vrinda"/><a:font script="Gujr" typeface="Shruti"/>'
    + '<a:font script="Khmr" typeface="MoolBoran"/><a:font script="Knda" typeface="Tunga"/>'
    + '<a:font script="Guru" typeface="Raavi"/><a:font script="Cans" typeface="Euphemia"/><a:font script="Cher" typeface="Plantagenet Cherokee"/>'
    + '<a:font script="Yiii" typeface="Microsoft Yi Baiti"/><a:font script="Tibt" typeface="Microsoft Himalaya"/>'
    + '<a:font script="Thaa" typeface="MV Boli"/><a:font script="Deva" typeface="Mangal"/>'
    + '<a:font script="Telu" typeface="Gautami"/><a:font script="Taml" typeface="Latha"/>'
    + '<a:font script="Syrc" typeface="Estrangelo Edessa"/><a:font script="Orya" typeface="Kalinga"/>'
    + '<a:font script="Mlym" typeface="Kartika"/><a:font script="Laoo" typeface="DokChampa"/>'
    + '<a:font script="Sinh" typeface="Iskoola Pota"/><a:font script="Mong" typeface="Mongolian Baiti"/>'
    + '<a:font script="Viet" typeface="Times New Roman"/><a:font script="Uigh" typeface="Microsoft Uighur"/>'
    + '</a:majorFont><a:minorFont><a:latin typeface="Calibri"/><a:ea typeface=""/><a:cs typeface=""/>'
    + '<a:font script="Jpan" typeface="ＭＳ Ｐゴシック"/>' +
    '<a:font script="Hang" typeface="맑은 고딕"/>' +
    '<a:font script="Hans" typeface="宋体"/>' +
    '<a:font script="Hant" typeface="新細明體"/>' +
    '<a:font script="Arab" typeface="Times New Roman"/>' +
    '<a:font script="Arab" typeface="Arial"/><a:font script="Hebr" typeface="Arial"/><a:font script="Thai" typeface="Tahoma"/>'
    + '<a:font script="Ethi" typeface="Nyala"/><a:font script="Beng" typeface="Vrinda"/>'
    + '<a:font script="Gujr" typeface="Shruti"/><a:font script="Khmr" typeface="DaunPenh"/><a:font script="Knda" typeface="Tunga"/>'
    + '<a:font script="Guru" typeface="Raavi"/><a:font script="Cans" typeface="Euphemia"/>'
    + '<a:font script="Cher" typeface="Plantagenet Cherokee"/><a:font script="Yiii" typeface="Microsoft Yi Baiti"/>'
    + '<a:font script="Tibt" typeface="Microsoft Himalaya"/><a:font script="Thaa" typeface="MV Boli"/>'
    + '<a:font script="Deva" typeface="Mangal"/><a:font script="Telu" typeface="Gautami"/><a:font script="Taml" typeface="Latha"/>'
    + '<a:font script="Syrc" typeface="Estrangelo Edessa"/><a:font script="Orya" typeface="Kalinga"/>'
    + '<a:font script="Mlym" typeface="Kartika"/><a:font script="Laoo" typeface="DokChampa"/><a:font script="Sinh" typeface="Iskoola Pota"/>'
    + '<a:font script="Mong" typeface="Mongolian Baiti"/><a:font script="Viet" typeface="Arial"/><a:font script="Uigh" typeface="Microsoft Uighur"/>'
    + '</a:minorFont></a:fontScheme><a:fmtScheme name="Office"><a:fillStyleLst><a:solidFill><a:schemeClr val="phClr"/>'
    + '</a:solidFill><a:gradFill rotWithShape="1"><a:gsLst><a:gs pos="0"><a:schemeClr val="phClr">'
    + '<a:tint val="50000"/><a:satMod val="300000"/></a:schemeClr></a:gs><a:gs pos="35000"><a:schemeClr val="phClr"><a:tint val="37000"/>'
    + '<a:satMod val="300000"/></a:schemeClr></a:gs><a:gs pos="100000"><a:schemeClr val="phClr"><a:tint val="15000"/>'
    + '<a:satMod val="350000"/></a:schemeClr></a:gs></a:gsLst><a:lin ang="16200000" scaled="1"/></a:gradFill>'
    + '<a:gradFill rotWithShape="1"><a:gsLst><a:gs pos="0"><a:schemeClr val="phClr"><a:shade val="51000"/>'
    + '<a:satMod val="130000"/></a:schemeClr></a:gs><a:gs pos="80000"><a:schemeClr val="phClr"><a:shade val="93000"/>'
    + '<a:satMod val="130000"/></a:schemeClr></a:gs><a:gs pos="100000"><a:schemeClr val="phClr"><a:shade val="94000"/>'
    + '<a:satMod val="135000"/></a:schemeClr></a:gs></a:gsLst><a:lin ang="16200000" scaled="0"/></a:gradFill>'
    + '</a:fillStyleLst><a:lnStyleLst><a:ln w="9525" cap="flat" cmpd="sng" algn="ctr"><a:solidFill><a:schemeClr val="phClr">'
    + '<a:shade val="95000"/><a:satMod val="105000"/></a:schemeClr></a:solidFill><a:prstDash val="solid"/></a:ln><a:ln w="25400" cap="flat" cmpd="sng" algn="ctr">'
    + '<a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:prstDash val="solid"/></a:ln><a:ln w="38100" cap="flat" cmpd="sng" algn="ctr"><a:solidFill>'
    + '<a:schemeClr val="phClr"/></a:solidFill><a:prstDash val="solid"/></a:ln></a:lnStyleLst><a:effectStyleLst><a:effectStyle><a:effectLst>'
    + '<a:outerShdw blurRad="40000" dist="20000" dir="5400000" rotWithShape="0"><a:srgbClr val="000000">'
    + '<a:alpha val="38000"/></a:srgbClr></a:outerShdw></a:effectLst></a:effectStyle><a:effectStyle>'
    + '<a:effectLst><a:outerShdw blurRad="40000" dist="23000" dir="5400000" rotWithShape="0">'
    + '<a:srgbClr val="000000"><a:alpha val="35000"/></a:srgbClr></a:outerShdw></a:effectLst>'
    + '</a:effectStyle><a:effectStyle><a:effectLst><a:outerShdw blurRad="40000" dist="23000" dir="5400000" rotWithShape="0">'
    + '<a:srgbClr val="000000"><a:alpha val="35000"/></a:srgbClr></a:outerShdw></a:effectLst><a:scene3d>'
    + '<a:camera prst="orthographicFront"><a:rot lat="0" lon="0" rev="0"/></a:camera><a:lightRig rig="threePt" dir="t">'
    + '<a:rot lat="0" lon="0" rev="1200000"/></a:lightRig></a:scene3d><a:sp3d>'
    + '<a:bevelT w="63500" h="25400"/></a:sp3d></a:effectStyle></a:effectStyleLst>'
    + '<a:bgFillStyleLst><a:solidFill><a:schemeClr val="phClr"/></a:solidFill>'
    + '<a:gradFill rotWithShape="1"><a:gsLst><a:gs pos="0"><a:schemeClr val="phClr">'
    + '<a:tint val="40000"/><a:satMod val="350000"/></a:schemeClr></a:gs><a:gs pos="40000">'
    + '<a:schemeClr val="phClr"><a:tint val="45000"/><a:shade val="99000"/><a:satMod val="350000"/>'
    + '</a:schemeClr></a:gs><a:gs pos="100000"><a:schemeClr val="phClr"><a:shade val="20000"/><a:satMod val="255000"/>'
    + '</a:schemeClr></a:gs></a:gsLst><a:path path="circle"><a:fillToRect l="50000" t="-80000" r="50000" b="180000"/>'
    + '</a:path></a:gradFill><a:gradFill rotWithShape="1"><a:gsLst><a:gs pos="0"><a:schemeClr val="phClr">'
    + '<a:tint val="80000"/><a:satMod val="300000"/></a:schemeClr></a:gs><a:gs pos="100000">'
    + '<a:schemeClr val="phClr"><a:shade val="30000"/><a:satMod val="200000"/></a:schemeClr></a:gs>'
    + '</a:gsLst><a:path path="circle"><a:fillToRect l="50000" t="50000" r="50000" b="50000"/>'
    + '</a:path></a:gradFill></a:bgFillStyleLst></a:fmtScheme></a:themeElements><a:objectDefaults/><a:extraClrSchemeLst/></a:theme>';
{$IFDEF gtDelphi2009Up}
  ThemeStream := TStringStream.Create(LS, TEncoding.UTF8);
{$ELSE}
  ThemeStream := TStringStream.Create(LS);
{$ENDIF}
  FZipPackage.CreateParts('xl\theme\theme1.xml', ThemeStream);
  ThemeStream.Free;
end;

procedure TgtCustomExcelEngine.CreateWorkBookPart;
Var
  LS, LS1, LS2, LS3, LS4: String;
  LI: Integer;
  WorkBookStream: TStringStream;
begin
  LS1 := DefaultXMLHeader + CRLF +
    '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/' +
    'main" xmlns:r="http://schemas.openxmlformats.org/officeDocument' +
    '/2006/relationships"><fileVersion appName="xl" lastEdited="4"' +
    ' lowestEdited="4" rupBuild="4507"/><workbookPr filterPrivacy="1"' +
    ' defaultThemeVersion="124226"/>' + '<bookViews>' + '<workbookView';
  if FSheetCount > 3 then
    LS2 := ' xWindow="240" yWindow="105" windowWidth="14805" windowHeight="8010"'
      + ' activeTab="0"/></bookViews><sheets>'
  else
    LS2 := ' xWindow="240" yWindow="105" windowWidth="14805" windowHeight="8010"/>'
      + '</bookViews><sheets>';
  LS3 := '';
  for LI := 0 to FSheetCount - 1 do
  begin
    with FSpreadSheetItemList do
    begin
      LS3 := LS3 + '<sheet name="' + TgtSheetItem((Items[LI])).FSheetName + '"'
        + ' sheetId="' + GetSheetID(LI + 1) + '" r:id="' +
        GetRelID(LI + 1) + '"/>'
    end;
  end;
  LS4 := '</sheets><calcPr calcId="125725"/></workbook>';
  LS := LS1 + LS2 + LS3 + LS4;
{$IFDEF gtDelphi2009Up}
  WorkBookStream := TStringStream.Create(LS, TEncoding.UTF8);
{$ELSE}
  WorkBookStream := TStringStream.Create(LS);
{$ENDIF}
  FZipPackage.CreateParts('xl\workbook.xml', WorkBookStream);
  WorkBookStream.Free;
end;

procedure TgtCustomExcelEngine.CreateWorkBookRelationShip;
Var
  LS1, LS2, LS3, LS, LS4: String;
  LI: Integer;
  WorkBookRelStream: TStringStream;
begin
  LS1 := DefaultXMLHeader + CRLF +
    '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006' +
    '/relationships">';
  LS2 := '';
  for LI := 0 to FSheetCount - 1 do
    LS2 := LS2 + '<Relationship Id="' + GetRelID(LI + 1) +
      '" Type="http://schemas.openxmlformats.org/officeDocument/2006/' +
      'relationships/worksheet" Target="worksheets/sheet' + IntToStr(LI + 1) +
      '.xml"/>';
  LS3 := '<Relationship Id="' + GetRelID(FRId) +
    '" Type="http://schemas.openxmlformats.org/officeDocument/2006/' +
    'relationships/styles" Target="styles.xml"/>' + '<Relationship Id="' +
    GetRelID(FRId) + '" Type="http://schemas.openxmlformats.org/office' +
    'Document/2006/relationships/theme" Target="theme/theme1.xml"/>';
  LS4 := '<Relationship Id="' + GetRelID(FRId) +
    '" Type="http://schemas.openxmlformats.org/officeDocument/2006/' +
    'relationships/sharedStrings" Target="sharedStrings.xml"/>' +
    '</Relationships>';
  LS := LS1 + LS2 + LS3 + LS4;

  WorkBookRelStream := TStringStream.Create(LS);
  FZipPackage.CreateParts('xl\_rels\workbook.xml.rels', WorkBookRelStream);
  FRId := 0;
  WorkBookRelStream.Free;
end;

procedure TgtCustomExcelEngine.CreateworkSheets(SheetNo: Integer);
var
  WorkSheetStream: TStringStream;
  WorksheetXML, RowsXML: IXMLDocument;
  LDimensionNode, LSheetViewsNode, LSheetViewNode, LSheetFormatPrNode,
    LSheetDataNode, LRowNode, LCellNode, LPageMarginsNode, LBackImageNode,
    LDrwaingNode, LPageOrientationNode: IXMLElement;
  I: Integer;
  WorksheetXMLStr, RowsXMLStr: String;
  xSheetDataBegin, xSheetDataEnd: Integer;
  LprevRowNo: Integer;
  LClabel: String;
  E: Double;
  procedure GetRowsXMLStr;
  begin

    if Assigned(RowsXML) then
    begin
      RowsXMLStr := RowsXMLStr + RowsXML.GetXML;
    end;
    RowsXML := CreateXMLDoc;
  end;

const
  cSheetDataText = '{96C15ADC-8247-42E4-A5CD-659EA20A8AC0}';
  CPaperSizeTable: array [TgtPaperSize] of Word = (1, 2, 3, 4, 5, 6, 7, 8, 9,
    10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
    30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 42, 0);
begin

  WorksheetXML := CreateXMLDoc('worksheet', True);

  WorksheetXML.DocumentElement.SetAttribute('xmlns',
    'http://schemas.openxmlformats.org/spreadsheetml/2006/main');
  WorksheetXML.DocumentElement.SetAttribute('xmlns:r',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
  LDimensionNode := WorksheetXML.DocumentElement.AddChild('dimension');
  LSheetViewsNode := WorksheetXML.DocumentElement.AddChild('sheetViews');
  LSheetViewNode := LSheetViewsNode.AddChild('sheetView');
  LSheetViewNode.SetAttribute('tabSelected', '1');
  LSheetViewNode.SetAttribute('workbookViewId', '0');
  LSheetFormatPrNode := WorksheetXML.DocumentElement.AddChild('sheetFormatPr');
  LSheetFormatPrNode.SetAttribute('defaultRowHeight', '15');
  LSheetDataNode := WorksheetXML.DocumentElement.AddChild('sheetData');
  LSheetDataNode.Text := cSheetDataText;
  RowsXML := nil;
  LprevRowNo := -1;
  LClabel := 'A1';

  GetRowsXMLStr;
  for I := 0 to FRowItemList.Count - 1 do
  begin
    with FRowItemList do
    begin
      if (LprevRowNo = -1) or (LprevRowNo <> TgtCellItem((Items[I]))
        .FRowNo) then
      begin
        LRowNode := RowsXML.AddChild('row');
        LRowNode.SetAttribute('r',
          IntToStr(TgtCellItem((Items[I])).FRowNo + 1));
        LRowNode.SetAttribute('spans', '2:14');
        if TgtCellItem((Items[I])).FHieght > 15.0 then
          LRowNode.SetAttribute('ht',
            GetNumberStringLocale(FloatToStr(TgtCellItem((Items[I])).FHieght)));
      end;
      LCellNode := LRowNode.AddChild('c');
      LClabel := GetColumnLabel(TgtCellItem((Items[I])).FColumnNo + 1) +
        IntToStr(TgtCellItem((Items[I])).FRowNo + 1);
      LCellNode.SetAttribute('r', LClabel);
      if TgtCellItem((Items[I])).FStyleIndex <> -1 then
        LCellNode.SetAttribute('s',
          IntToStr(TgtCellItem((Items[I])).FStyleIndex));
      if TgtCellItem((Items[I])).FIsSharedString then
      begin
        // LCellNode.SetAttribute('t', 'inlineStr');
        // LCellNode.SelectSingleElementCreate('is').SelectSingleElementCreate('t').Text :=
        // FSharedStringList[TgtCellItem((Items[I])).FValue];
        LCellNode.SetAttribute('t', 's');
        LCellNode.SelectSingleElementCreate('v').Text :=
          IntToStr(TgtCellItem((Items[I])).FValue);

      end
      else
      begin
        if TgtCellItem((Items[I])).FFormula <> '' then
          LCellNode.SelectSingleElementCreate('f').Text :=
            TgtCellItem((Items[I])).FFormula;
        if (TgtCellItem((Items[I])).FData <> 0) then
          LCellNode.SelectSingleElementCreate('v').Text :=
            GetNumberStringLocale(FloatToStr(TgtCellItem((Items[I])).FData))
        else if ((TgtCellItem((Items[I])).FStyleIndex <> -1)) then
          LCellNode.SelectSingleElementCreate('v').Text :=
            GetNumberStringLocale(FloatToStr(TgtCellItem((Items[I])).FData));
      end;
      LprevRowNo := TgtCellItem((Items[I])).FRowNo;
    end;
  end;
  GetRowsXMLStr;
  LDimensionNode.SetAttribute('ref', LClabel);
  LPageMarginsNode := WorksheetXML.DocumentElement.AddChild('pageMargins');

  E := (PAge.LeftMargin * NativeConversionFactor) / CPixelsPerInch;
  LPageMarginsNode.SetAttribute('left', GetNumberStringLocale(FloatToStr(E)));

  E := (PAge.RightMargin * NativeConversionFactor) / CPixelsPerInch;
  LPageMarginsNode.SetAttribute('right', GetNumberStringLocale(FloatToStr(E)));

  E := (PAge.TOPMargin * NativeConversionFactor) / CPixelsPerInch;
  LPageMarginsNode.SetAttribute('top', GetNumberStringLocale(FloatToStr(E)));

  E := (PAge.BottomMargin * NativeConversionFactor) / CPixelsPerInch;
  LPageMarginsNode.SetAttribute('bottom', GetNumberStringLocale(FloatToStr(E)));

  E := (PAge.HeaderHeight * NativeConversionFactor) / CPixelsPerInch;
  LPageMarginsNode.SetAttribute('header', GetNumberStringLocale(FloatToStr(E)));

  E := (PAge.FooterHeight * NativeConversionFactor) / CPixelsPerInch;
  LPageMarginsNode.SetAttribute('footer', GetNumberStringLocale(FloatToStr(E)));

  LPageOrientationNode := WorksheetXML.DocumentElement.AddChild('pageSetup');
  LPageOrientationNode.SetAttribute('paperSize',
    IntToStr(CPaperSizeTable[PAge.PaperSize]));
  if (PAge.Orientation = poLandscape) then
    LPageOrientationNode.SetAttribute('orientation', 'landscape');

  FdrawRelationRemainscount := FDrawingCount;
  if (FDrawingList.Count <> 0) then
  begin
    LDrwaingNode := WorksheetXML.DocumentElement.AddChild('drawing');
    LDrwaingNode.SetAttribute('r:id', 'rId' + IntToStr(CurrentPage) +
      IntToStr(FSheetCount));
    AddSheetRelation(srtDrawing);
  end;
  if BackgroundImage.Graphic <> nil then
  begin
    Inc(FImageCount);
    LBackImageNode := WorksheetXML.DocumentElement.AddChild('picture');
    LBackImageNode.SetAttribute('r:id', 'rId' + IntToStr(FSheetCount) +
      IntToStr(FImageCount));
    AddSheetRelation(srtImage);
  end;
  WorksheetXMLStr := WorksheetXML.XML;
  xSheetDataBegin := Pos(cSheetDataText, WorksheetXMLStr);
  xSheetDataEnd := xSheetDataBegin + Length(cSheetDataText);

  WorksheetXMLStr := Copy(WorksheetXMLStr, 1, xSheetDataBegin - 1) + RowsXMLStr
    + Copy(WorksheetXMLStr, xSheetDataEnd, High(Integer));
{$IFDEF gtDelphi2009Up}
  WorkSheetStream := TStringStream.Create(WorksheetXMLStr, TEncoding.UTF8);
{$ELSE}
  WorkSheetStream := TStringStream.Create(WorksheetXMLStr);
{$ENDIF}
  WorksheetXMLStr := ''; // Free Memory
  FZipPackage.CreateParts('xl\worksheets\sheet' + IntToStr(SheetNo) + '.xml',
    WorkSheetStream);
  WorkSheetStream.Free;
  FreeAndNil(FRowItemList);
  FRowItemList := TList.Create;

  { FreeAndNil(FFormuleaList);
    FFormuleaList := TList.Create; }

end;

destructor TgtCustomExcelEngine.Destroy;
begin
  FCellBorder.Free;
  FreeAndNil(FFillColorList);
  FreeAndNil(FDrawingList);
  FreeAndNil(FSpreadSheetItemList);
  FreeAndNil(FRowItemList);
  FreeAndNil(FStylesList);
  FreeAndNil(FFontList);
  FreeAndNil(FBorderList);
  FreeAndNil(FColorList);
  if Assigned(FSheetRelationList) then
    FreeAndNil(FSheetRelationList);
  if Assigned(FDrawingRelationList) then
    FreeAndNil(FDrawingRelationList);
  if Assigned(FFormuleaList) then
    FreeAndNil(FFormuleaList);
  FSharedStringList.Free;
  inherited;
end;

function TgtCustomExcelEngine.EncodeDrawing(ADrawing: TgtDrawing): string;
begin
  with ADrawing do
  begin
    case FDrawingType of
      dtpicture:
        begin
          Result := '<xdr:twoCellAnchor editAs="oneCell">' + '<xdr:from>';
          Result := Result + '<xdr:col>' + IntToStr(FFromColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FFromColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FFromRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FFromRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:from>';

          Result := Result + '<xdr:to>';
          Result := Result + '<xdr:col>' + IntToStr(FToColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FToColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FToRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FToRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:to>';

          Result := Result + '<xdr:sp macro="" textlink="">';
          Result := Result + '<xdr:nvSpPr>';
          Result := Result + '<xdr:cNvPr id="2" name="Rectangle 1"/>';
          Result := Result + '<xdr:cNvSpPr/></xdr:nvSpPr><xdr:spPr>';
          Result := Result + '<a:xfrm><a:off x="0" y="0"/>' +
            '<a:ext cx="00" cy="00"/></a:xfrm>';
          Result := Result + '<a:prstGeom prst="rect"><a:avLst/>';
          Result := Result + '</a:prstGeom>' +
            '<a:blipFill dpi="0" rotWithShape="1">';
          Result := Result + '<a:blip xmlns:r="http://schemas.openxmlfo' +
            'rmats.org/officeDocument/2006/relationships" r:embed="' +
            FRId + '">';
          Result := Result + '<a:alphaModFix amt="' +
            FloatToStr((100 - ShapeTransparency) * 1000) + '"/>';
          Result := Result + '</a:blip><a:srcRect/><a:stretch>';
          Result := Result + '<a:fillRect/></a:stretch></a:blipFill>';
          Result := Result + '<a:ln><a:noFill/></a:ln></xdr:spPr>';
          Result := Result + '<xdr:style><a:lnRef idx="2">';
          Result := Result + '<a:schemeClr val="accent1">';
          Result := Result + '<a:shade val="50000"/></a:schemeClr>';
          Result := Result + '</a:lnRef><a:fillRef idx="1">';
          Result := Result + '<a:schemeClr val="accent1"/></a:fillRef>';
          Result := Result + '<a:effectRef idx="0">' +
            '<a:schemeClr val="accent1"/>';
          Result := Result + '</a:effectRef><a:fontRef idx="minor">';
          Result := Result + '<a:schemeClr val="lt1"/></a:fontRef>';
          Result := Result + '</xdr:style><xdr:txBody>';
          Result := Result + '<a:bodyPr vertOverflow="clip" horzOverflo' +
            'w="clip" rtlCol="0" anchor="t"/>';
          Result := Result + '<a:lstStyle/><a:p><a:pPr algn="l"/>';
          Result := Result + '<a:endParaRPr lang="en-US" sz="1100"/>';
          Result := Result + '</a:p></xdr:txBody></xdr:sp>';
          Result := Result + '<xdr:clientData/></xdr:twoCellAnchor>';

          { To make image transperent }

          // Result := Result + '<xdr:cNvSpPr/>';
          // Result := Result + '</xdr:cNvPicPr></xdr:nvPicPr>'
          // + '<xdr:blipFill>';
          // Result := Result + '<a:blip ';
          // Result := Result + 'xmlns:r="http://schemas.openxmlformats.'
          // + 'org/officeDocument/2006/relationships" ';
          // Result := Result + 'r:embed="' + FRId + '" cstate="print">';
          // Result := Result + '<a:clrChange><a:clrFrom>';
          // Result := Result + '<a:srgbClr val="FFFFFF"/></a:clrFrom>';
          // Result := Result + '<a:clrTo><a:srgbClr val="FFFFFF">';
          // Result := Result + '<a:alpha val="'+FloatToStr((0) * 1000)
          // +'"/>';
          // Result := Result + '</a:srgbClr></a:clrTo></a:clrChange>';
          //
          // Result := Result + '<a:clrChange><a:clrFrom>';
          // Result := Result + '<a:srgbClr val="'+ BrushColor
          // + '"/></a:clrFrom>';
          // Result := Result + '<a:clrTo><a:srgbClr val="' + BrushColor
          // + '">';
          // Result := Result + '<a:alpha val="'+FloatToStr((0) * 1000)
          // +'"/>';
          // Result := Result + '</a:srgbClr></a:clrTo></a:clrChange>';
          //
          // Result := Result + '<a:clrChange><a:clrFrom>';
          // Result := Result + '<a:srgbClr val="' + PenColor
          // +'"/></a:clrFrom>';
          // Result := Result + '<a:clrTo><a:srgbClr val="'+ PenColor
          // +'">';
          // Result := Result + '<a:alpha val="'+FloatToStr((0) * 1000)
          // +'"/>';
          // Result := Result + '</a:srgbClr></a:clrTo></a:clrChange>'
          // + '</a:blip>';
          //
          // Result := Result + '<a:stretch><a:fillRect/></a:stretch>';
          // Result := Result + '</xdr:blipFill><xdr:spPr>';
          // Result := Result + '<a:xfrm><a:off x="00" y="00"/>';
          // Result := Result + '<a:ext cx="4292600" cy="3219450"/>'
          // + '</a:xfrm>';
          // Result := Result + '<a:prstGeom prst="rect"><a:avLst/>';
          // Result := Result + '</a:prstGeom></xdr:spPr></xdr:pic>';
          // Result := Result + '<xdr:clientData/>';
          // Result := Result + '</xdr:twoCellAnchor>';
        end;
      dtLine:
        begin
          Result := '<xdr:twoCellAnchor>' + '<xdr:from>';
          Result := Result + '<xdr:col>' + IntToStr(FFromColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FFromColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FFromRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FFromRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:from>';

          Result := Result + '<xdr:to>';
          Result := Result + '<xdr:col>' + IntToStr(FToColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FToColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FToRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FToRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:to>';

          Result := Result + '<xdr:cxnSp macro=""><xdr:nvCxnSpPr>';
          Result := Result + '<xdr:cNvPr id="5" name="Straight ' +
            'Connector 4"/>';
          Result := Result + '<xdr:cNvCxnSpPr/></xdr:nvCxnSpPr>' + '<xdr:spPr>';
          Result := Result + '<a:xfrm><a:off x="0" y="0"/>';
          Result := Result + '<a:ext cx="0" cy="0"/></a:xfrm>';
          Result := Result + '<a:prstGeom prst="line"><a:avLst/>' +
            '</a:prstGeom>';
          Result := Result + '<a:ln w="22225" cap="flat"><a:solidFill>';
          if FApplyTransparency then
          begin
            Result := Result + '<a:srgbClr val="' + PenColor + '">' +
              '<a:alpha val="' + FloatToStr((100 - FShapeTransparency) * 1000) +
              '"/></a:srgbClr>';
          end
          else
          begin
            if PenColor = '' then
              Result := Result + '<a:schemeClr val="tx1"/>'
            else
              Result := Result + '<a:srgbClr val="' + PenColor + '"/>';
          end;
          Result := Result + '</a:solidFill></a:ln>';
          Result := Result + '</xdr:spPr><xdr:style><a:lnRef idx="1">';
          Result := Result + '<a:schemeClr val="dk1"/></a:lnRef>';
          Result := Result + '<a:fillRef idx="0"><a:schemeClr val="dk1"/>';
          Result := Result + '</a:fillRef><a:effectRef idx="0">';
          Result := Result + '<a:schemeClr val="dk1"/></a:effectRef>';
          Result := Result + '<a:fontRef idx="minor">';
          Result := Result + '<a:schemeClr val="tx1"/></a:fontRef>';
          Result := Result + '</xdr:style></xdr:cxnSp><xdr:clientData/>';
          Result := Result + '</xdr:twoCellAnchor>';

        end;
      dtRectangle:
        begin
          Result := '<xdr:twoCellAnchor>' + '<xdr:from>';
          Result := Result + '<xdr:col>' + IntToStr(FFromColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FFromColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FFromRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FFromRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:from>';
          Result := Result + '<xdr:to>';
          Result := Result + '<xdr:col>' + IntToStr(FToColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FToColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FToRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FToRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:to>';

          Result := Result + '<xdr:sp macro="" textlink="">' + '<xdr:nvSpPr>';
          Result := Result + '<xdr:cNvPr id="2" name="Rectangle 1"/>';
          Result := Result + '<xdr:cNvSpPr/></xdr:nvSpPr><xdr:spPr>';
          Result := Result + '<a:xfrm><a:off x="00" y="00"/>';
          Result := Result + '<a:ext cx="00" cy="00"/></a:xfrm>';
          Result := Result + '<a:prstGeom prst="rect"><a:avLst/>';
          Result := Result + '</a:prstGeom>';
          If not IsFill then
            Result := Result + '<a:noFill/>';
          if FApplyTransparency and IsFill then
          begin
            if BrushColor = 'FFFFFF' then
              Result := Result + '<a:solidFill><a:schemeClr val="dk1">' +
                '<a:alpha val="21000"/></a:schemeClr>' + '</a:solidFill>'
            else
              Result := Result + '<a:solidFill><a:srgbClr val="' + BrushColor +
                '">' + '<a:alpha val="' +
                FloatToStr((100 - FShapeTransparency) * 1000) +
                '"/></a:srgbClr></a:solidFill>'
          end;
          Result := Result + '<a:ln><a:solidFill><a:srgbClr val="' +
            PenColor + '">';
          if FApplyTransparency then
            Result := Result + '<a:alpha val="' +
              FloatToStr((100 - FShapeTransparency) * 1000) + '"/>';
          Result := Result + '</a:srgbClr></a:solidFill></a:ln>';
          Result := Result + '</xdr:spPr>';
          Result := Result + '<xdr:style><a:lnRef idx="2">' +
            '<a:schemeClr val="dk1">';
          Result := Result + '<a:shade val="50000"/></a:schemeClr>' +
            '</a:lnRef>';
          Result := Result + '<a:fillRef idx="1">' + '<a:schemeClr val="dk1"/>';
          Result := Result + '</a:fillRef><a:effectRef idx="0">';
          Result := Result + '<a:schemeClr val="dk1"/></a:effectRef>';
          Result := Result + '<a:fontRef idx="minor"><a:schemeClr ' +
            'val="lt1"/>';
          Result := Result + '</a:fontRef></xdr:style><xdr:txBody>';
          Result := Result + '<a:bodyPr vertOverflow="clip" ' +
            'rtlCol="0" anchor="ctr"/>';
          Result := Result + '<a:lstStyle/><a:p><a:pPr algn="ctr"/>';
          Result := Result + '<a:endParaRPr lang="en-US" sz="1100"/>';
          Result := Result + '</a:p></xdr:txBody></xdr:sp>';
          Result := Result + '<xdr:clientData/></xdr:twoCellAnchor>';
        end;
      dtRoundRect:
        begin
          Result := '<xdr:twoCellAnchor>' + '<xdr:from>';
          Result := Result + '<xdr:col>' + IntToStr(FFromColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FFromColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FFromRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FFromRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:from>';

          Result := Result + '<xdr:to>';
          Result := Result + '<xdr:col>' + IntToStr(FToColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FToColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FToRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FToRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:to>';

          Result := Result + '<xdr:sp macro="" textlink="">' + '<xdr:nvSpPr>';
          Result := Result + '<xdr:cNvPr id="3" name="Rounded ' +
            'Rectangle 2"/>';
          Result := Result + '<xdr:cNvSpPr/></xdr:nvSpPr><xdr:spPr>';
          Result := Result + '<a:xfrm><a:off x="00" y="00"/>';
          Result := Result + '<a:ext cx="00" cy="00"/></a:xfrm>';
          Result := Result + '<a:prstGeom prst="roundRect"><a:avLst/>';
          Result := Result + '</a:prstGeom>';
          If not IsFill then
            Result := Result + '<a:noFill/>';
          if FApplyTransparency and IsFill then
          begin
            if BrushColor = 'FFFFFF' then
              Result := Result + '<a:solidFill><a:schemeClr val="dk1">' +
                '<a:alpha val="' + FloatToStr((100 - FShapeTransparency) * 1000)
                + '"/></a:schemeClr>' + '</a:solidFill>'
            else
              Result := Result + '<a:solidFill><a:srgbClr val="' + BrushColor +
                '">' + '<a:alpha val="' +
                FloatToStr((100 - FShapeTransparency) * 1000) +
                '"/></a:srgbClr>' + '</a:solidFill>'
          end;
          Result := Result + '<a:ln><a:solidFill><a:srgbClr val="' +
            PenColor + '">';
          if True then
            Result := Result + '<a:alpha val="' +
              FloatToStr((100 - ShapeTransparency) * 1000) + '"/>';
          Result := Result + '</a:srgbClr></a:solidFill></a:ln>';
          Result := Result + '</xdr:spPr>';
          Result := Result + '<xdr:style><a:lnRef idx="2"><a:scheme' +
            'Clr val="dk1">';
          Result := Result + '<a:shade val="50000"/></a:schemeClr>' +
            '</a:lnRef>';
          Result := Result + '<a:fillRef idx="1"><a:schemeClr ' + 'val="dk1"/>';
          Result := Result + '</a:fillRef><a:effectRef idx="0">';
          Result := Result + '<a:schemeClr val="dk1"/></a:effectRef>';
          Result := Result + '<a:fontRef idx="minor"><a:schemeClr ' +
            'val="lt1"/>';
          Result := Result + '</a:fontRef></xdr:style><xdr:txBody>';
          Result := Result + '<a:bodyPr vertOverflow="clip" ' +
            'rtlCol="0" anchor="ctr"/>';
          Result := Result + '<a:lstStyle/><a:p><a:pPr algn="ctr"/>';
          Result := Result + '<a:endParaRPr lang="en-US" sz="1100"/>';
          Result := Result + '</a:p></xdr:txBody></xdr:sp>';
          Result := Result + '<xdr:clientData/></xdr:twoCellAnchor>';
        end;
      dtEllipse:
        Begin
          Result := '<xdr:twoCellAnchor>' + '<xdr:from>';
          Result := Result + '<xdr:col>' + IntToStr(FFromColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FFromColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FFromRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FFromRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:from>';

          Result := Result + '<xdr:to>';
          Result := Result + '<xdr:col>' + IntToStr(FToColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FToColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FToRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FToRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:to>';

          Result := Result + '<xdr:sp macro="" textlink="">' + '<xdr:nvSpPr>';
          Result := Result + '<xdr:cNvPr id="2" name="Oval 1"/>' +
            '<xdr:cNvSpPr/>';
          Result := Result + '</xdr:nvSpPr><xdr:spPr><a:xfrm>';
          Result := Result + '<a:off x="0" y="0"/><a:ext cx="0" ' + 'cy="0"/>';
          Result := Result + '</a:xfrm><a:prstGeom prst="ellipse">' +
            '<a:avLst/>';
          Result := Result + '</a:prstGeom>';
          If not IsFill then
            Result := Result + '<a:noFill/>';
          if True and IsFill then
          begin
            if BrushColor = 'FFFFFF' then
              Result := Result + '<a:solidFill><a:schemeClr' +
                'val="dk1"><a:alpha val="' +
                FloatToStr((100 - ShapeTransparency) * 1000) +
                '"/></a:schemeClr>' + '</a:solidFill>'
            else
              Result := Result + '<a:solidFill><a:srgbClr val="' + BrushColor +
                '">' + '<a:alpha val="' +
                FloatToStr((100 - ShapeTransparency) * 1000) + '"/></a:srgbClr>'
                + '</a:solidFill>'
          end;
          Result := Result + '<a:ln><a:solidFill><a:srgbClr val="' +
            PenColor + '">';
          if True then
            Result := Result + '<a:alpha val="' +
              FloatToStr((100 - ShapeTransparency) * 1000) + '"/>';
          Result := Result + '</a:srgbClr></a:solidFill></a:ln>';
          Result := Result + '</xdr:spPr>';
          Result := Result + '<xdr:style><a:lnRef idx="2">';
          Result := Result + '<a:schemeClr val="accent1"><a:shade ' +
            'val="50000"/>';
          Result := Result + '</a:schemeClr></a:lnRef>' + '<a:fillRef idx="1">';
          Result := Result + '<a:schemeClr val="accent1"/>' + '</a:fillRef>';
          Result := Result + '<a:effectRef idx="0"><a:schemeClr ' +
            'val="accent1"/>';
          Result := Result + '</a:effectRef><a:fontRef idx="minor">';
          Result := Result + '<a:schemeClr val="lt1"/></a:fontRef>';
          Result := Result + '</xdr:style><xdr:txBody>';
          Result := Result + '<a:bodyPr vertOverflow="clip" ' +
            'rtlCol="0" anchor="ctr"/>';
          Result := Result + '<a:lstStyle/><a:p><a:pPr algn="ctr"/>';
          Result := Result + '<a:endParaRPr lang="en-US" sz="1100"/>';
          Result := Result + '</a:p></xdr:txBody></xdr:sp>';
          Result := Result + '<xdr:clientData/></xdr:twoCellAnchor>';
        end;
      dtTextBox:
        begin
          Result := '<xdr:twoCellAnchor>' + '<xdr:from>';
          Result := Result + '<xdr:col>' + IntToStr(FFromColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FFromColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FFromRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FFromRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:from>';

          Result := Result + '<xdr:to>';
          Result := Result + '<xdr:col>' + IntToStr(FToColNo) + '</xdr:col>';
          Result := Result + '<xdr:colOff>' + IntToStr(FToColOffset) +
            '</xdr:colOff>';
          Result := Result + '<xdr:row>' + IntToStr(FToRowNo) + '</xdr:row>';
          Result := Result + '<xdr:rowOff>' + IntToStr(FToRowOffset) +
            '</xdr:rowOff>';
          Result := Result + '</xdr:to>';
          Result := Result + '<xdr:sp macro="" textlink="">' + '<xdr:nvSpPr>';
          Result := Result + '<xdr:cNvPr id="2" name="TextBox 1"/>';
          Result := Result + '<xdr:cNvSpPr txBox="1"/></xdr:nvSpPr>';
          Result := Result + '<xdr:spPr><a:xfrm>';
          Result := Result + '<a:off x="0" y="0"/><a:ext cx="0" ' + 'cy="0"/>';
          Result := Result + '</a:xfrm><a:prstGeom prst="rect">';
          Result := Result + '<a:avLst/></a:prstGeom>';
          If not False then
            Result := Result + '<a:noFill/>';
          if False then
          begin
            if BrushColor = 'FFFFFF' then
              Result := Result + '<a:solidFill><a:schemeClr val="dk1">' +
                '<a:alpha val="' + FloatToStr((100 - ShapeTransparency) * 1000)
                + '"/></a:schemeClr>' + '</a:solidFill>'
            else
              Result := Result + '<a:solidFill><a:srgbClr val="' + BrushColor +
                '">' + '</a:srgbClr>' + '</a:solidFill>'
          end;
          Result := Result + '<a:ln><a:solidFill><a:srgbClr val="' +
            PenColor + '"/>';
          Result := Result + '</a:solidFill></a:ln>';
          Result := Result + '</xdr:spPr><xdr:style>';
          Result := Result + '<a:lnRef idx="0">';
          Result := Result + '<a:scrgbClr r="0" g="0" b="0"/>' + '</a:lnRef>';
          Result := Result + '<a:fillRef idx="0">';
          Result := Result + '<a:scrgbClr r="0" g="0" b="0"/>' + '</a:fillRef>';
          Result := Result + '<a:effectRef idx="0">';
          Result := Result + '<a:scrgbClr r="0" g="0" b="0"/>';
          Result := Result + '</a:effectRef><a:fontRef idx="minor">';
          Result := Result + '<a:schemeClr val="dk1"/></a:fontRef>';
          Result := Result + '</xdr:style>';
          Result := Result + '<xdr:txBody>';
          Result := Result + '<a:bodyPr vertOverflow="clip"';
          Result := Result + ' horzOverflow="clip" vert="horz"';
          Result := Result + ' wrap="square" rtlCol="0" anchor="';
          { VAlignment } case VAlignment of
            vaTop:
              Result := Result + 't"/>';
            vaBottom:
              Result := Result + 'b"/>';
            vaCenter:
              Result := Result + 'ctr"/>';
          end;
          Result := Result + '<a:lstStyle/><a:p>';
          { HAlignment } Result := Result + '<a:pPr algn="';
          case HAlignment of
            haLeft:
              Result := Result + 'l"/>';
            haRight:
              Result := Result + 'r"/>';
            haCenter:
              Result := Result + 'ctr"/>';
            haGeneral:
              Result := Result + 'ctr"/>';
            haJustify:
              Result := Result + 'l"/>';
          end;
          Result := Result + '<a:r>';
          { Size of text }
          Result := Result + '<a:rPr lang="en-US" sz="' +
            IntToStr(Font.Size * 100) + '">';
          Result := Result + '<a:solidFill>';
          Result := Result + '<a:srgbClr val="' + GetXLSXDrawingColor
            (Font.Color) + '"/></a:solidFill>';
          Result := Result + '<a:latin typeface="' + Font.Name +
            '" pitchFamily="34" charset="0"/>';
          Result := Result + '<a:cs typeface="' + Font.Name +
            '" pitchFamily="34" charset="0"/></a:rPr>';
          Result := Result + '<a:t>' + Lines + '</a:t>';
          Result := Result + '</a:r></a:p></xdr:txBody>';
          Result := Result + '</xdr:sp><xdr:clientData/>';
          Result := Result + '</xdr:twoCellAnchor>';
        end;
    end;
  end;

end;

procedure TgtCustomExcelEngine.EncodeText(AObject: TgtTextItem);
var
  LFormatIndex { , LFontIndex } : Integer;
  LCellType: TgtCellType;
  LTextAlign: TgtHAlignment;
  LBuf: array [0 .. 1] of Integer;
  LXLSString, LS: WideString;
  // LATemp: WideString;
  LStringSize: Word;
  LCellData: Extended;
  // LWordWrap: Boolean;
  LRowitem: TgtCellItem;
  // For Trailing -ve Sign
  function WPStrIsNumeric(const s: String): Boolean;
  var
    I: Integer;
    s1, s2: String;
  begin
    Result := False;
    s1 := trim(s);
    { no leading or trailing blanks }
    s2 := '';
    for I := 1 to Length(s1) do
{$IFDEF gtDelphi2009Up}
      if not(SysUtils.CharInSet(s1[I], ['.', ',', '-']))
      { no formatting characters }
{$ELSE}
        if not(s1[I] in ['.', ',', '-']) { no formatting characters }
{$ENDIF}
      then
        s2 := s2 + s1[I];
    if (Length(s2) = 0) then
      Exit;
    { blank isn't numeric }
    for I := 1 to Length(s2) do
{$IFDEF gtDelphi2009Up}
      if not(SysUtils.CharInSet(s2[I], ['0' .. '9'])) then
{$ELSE}
      if not(s2[I] in ['0' .. '9']) then
{$ENDIF}
        Exit;
    Result := True;
  end;

begin
  inherited EncodeText(AObject);
  // Eliminate the item marked for exclusion
  // This item was overwritten by another item (with same x, y) so we don't want
  // to encode it (else we get a "Data may have been lost" error)
  if TgtFmTextItem(AObject).ColumnNo = -1 then
    Exit;
  with AObject do
  begin
    LFormatIndex := $0;
    LS := trim(ReplacePlaceHolders(Lines[0], True));
    LCellType := ctString;
    if LS = '' then
      Exit;
    // For Trailing -ve Sign
    if WPStrIsNumeric(LS) and (Length(trim(LS)) > 0) and
      (Copy(trim(LS), Length(trim(LS)), 1) = '-') then
    begin
      LS := trim(LS);
      // LS := Copy(LS, 1, Length(LS) - 1);
    end;

    // LWordWrap := Preferences.WordWrap;
    if AObject is TgtSheetTextItem then
    begin
      LCellType := TgtSheetTextItem(AObject).CellType;
      // LTextAlign := TgtSheetTextItem(AObject).Alignment;
      // LWordWrap := TgtSheetTextItem(AObject).WordWrap;
    end
    else if LS <> '$' then

      LCellType := GetCellType(LS);
    // Add font
    // LFontIndex := AddFontInfoToFontTable(Font) + 5;
    case LCellType of
      ctString: // General
        LFormatIndex := $0;
      ctInteger:
        if Preferences.NumberFormatDecimalPlaces > 2 then
        begin
          LFormatIndex := XLSX_NUMBER_DECIMAL_PLACES;
          FFlag := True;
        end
        else
          LFormatIndex := $1;
      ctDouble:
        if Preferences.NumberFormatDecimalPlaces > 2 then
        begin
          LFormatIndex := XLSX_NUMBER_DECIMAL_PLACES;
          FFlag := True;
        end
        else
          LFormatIndex := $2;
      ctInteger_TS:
        if Preferences.NumberFormatDecimalPlaces > 2 then
        begin
          LFormatIndex := XLSX_NUMBER_DECIMAL_PLACES;
          FFlag := True;
        end
        else
          LFormatIndex := $3;
      ctDouble_TS:
        if Preferences.NumberFormatDecimalPlaces > 2 then
        begin
          LFormatIndex := XLSX_NUMBER_DECIMAL_PLACES;
          FFlag := True;
        end
        else
          LFormatIndex := $4;
      ctCurrency:
        LFormatIndex := $7;
      ctTime:
        LFormatIndex := $13;
      ctDate:
        LFormatIndex := $0F;
      ctDateTime:
        LFormatIndex := $16;
      ctPercentage:
        LFormatIndex := $9;
      ctPercentage_FP:
        LFormatIndex := $A;
    end;
    LRowitem := TgtCellItem.Create;
    with TgtFmTextItem(AObject) do
    begin
      LRowitem.FRowNo := RowNo + FLastPageHeight;
      LRowitem.FColumnNo := ColumnNo;
      UpdateDimensionVars(RowNo + FLastPageHeight, ColumnNo);
      LTextAlign := Alignment;
    end;
    LRowitem.FStyleIndex := FillStyle(LFormatIndex, Font, Brush, LTextAlign,
      LCellType);

    LXLSString := '';
    // LStringSize := 0;
    // LCellData := 0.0;

    with TgtFmTextItem(AObject) do
    begin
      LBuf[0] := RowNo + FLastPageHeight;
      LBuf[1] := ColumnNo;

      UpdateDimensionVars(RowNo + FLastPageHeight, ColumnNo);
    end;

    if LCellType in [ctInteger, ctDouble, ctCurrency, ctInteger_TS,
      ctDouble_TS] then
    begin
      If ((LS[1] = '(') and (LS[Length(LS)] = ')')) then
      begin
        LS := ReplaceString(LS, '(', '');
        LS := ReplaceString(LS, ')', '');
      end;
      LCellData := StrToFloat(GetNumberString(LS));
      LRowitem.FData := LCellData;
      LRowitem.FIsSharedString := False;
    end
    else if (LCellType in [ctTime, ctDate, ctDateTime]) then
    begin
      LCellData := StrToDateTime(LS);
      LRowitem.FData := LCellData;
      LRowitem.FIsSharedString := False;
    end
    else if (LCellType in [ctPercentage, ctPercentage_FP]) then
    begin
      LS := LeftStr(LS, Length(LS) - 1);
      LCellData := StrToFloat(GetNumberString(LS)) / 100;
      LRowitem.FData := LCellData;
      LRowitem.FIsSharedString := False;
    end
    else
    begin
      LStringSize := Length(LS);
      if LStringSize > 255 then
        // LStringSize := 255;
        LXLSString := LS;
      LRowitem.FIsSharedString := True;
      LS := StringReplace(LS, '&', '&amp;', [rfReplaceAll]);
      LS := StringReplace(LS, '<', '&lt;', [rfReplaceAll]);
      LS := StringReplace(LS, '>', '&gt;', [rfReplaceAll]);
      LS := StringReplace(LS, '"', '&quot;', [rfReplaceAll]);
      LS := StringReplace(LS, #39, '&apos;', [rfReplaceAll]);
      LRowitem.FValue := WrtitesharedStringList(LS);
    end;
    LRowitem.FHieght := TextSizeW(' ', Font).cy - 3.25;
    FRowItemList.Add(LRowitem);
  end;
end;

function TgtCustomExcelEngine.FillStyle(AFormatIndex: Integer; AFont: TFont;
  ABrush: TBrush; ATextAlign: TgtHAlignment; AcellType: TgtCellType): Integer;
var
  LStyle: TgtStyle;
  I: Integer;
begin
  I := StyleFound(AFormatIndex, AFont, ABrush, ATextAlign, AcellType);
  if I <> 0 then
    Result := I
  else
  begin
    LStyle := TgtStyle.Create;
    LStyle.FNumFmtIndex := AFormatIndex;
    LStyle.FBorderIndex := CreateBorderForStyle(AFont);
    // if commonfont(AFont) then     //checking whether font inforamtion already exists
    // LStyle.FFontIndex := 1
    // else
    LStyle.FFontIndex := CreateFontForStyle(AFont);
    if ABrush.Color <> clWhite then
      LStyle.FFillID := AddFillStyle(ABrush)
    else
      LStyle.FFillID := -2;
    LStyle.FAlignment := ATextAlign;
    if AcellType = ctCurrency then
      LStyle.IsCurrency := True;
    // cell hieght hieght and width depend on the style has to be caliculated
    FStylesList.Add(LStyle);
    Result := FStylesList.Count;
  end;
end;

procedure TgtCustomExcelEngine.Finish;
var
  // LStream: TgtExcelOLEStream;
  I: Integer;
begin
  with Preferences do
    if (PagesPerWorksheet = 0) or ((PageCount mod PagesPerWorksheet) <> 0) then
    begin
      Inc(FSheetCount);
      EndSheet(FSheetCount);
    end;
  CreateDocPropCore;
  CreateDocPropApp;
  CreateWorkBookPart;
  CreateContentTypePart;
  CreateWorkBookRelationShip;
  CreateStylesPart;
  CreateThemesPart;
  WriteSharedstrings;
  if (Preferences.PagesPerWorksheet = 0) then
  begin
    // TODO: Why we need sort and combine
    SortAndCombineFormulaListToCurrent;
    CreateworkSheets(1);
    WriteSheetRelations(1);
    WriteDrawingRelations(1);
    WriteDrawingsXml(1);
    for I := 0 to FCompletedImageIndexcount do
      FCompletedImageIndexList[I] := 0;
    FCompletedImageIndexcount := 0;
  end;
  inherited;
  FZipPackage.Save;
  if Preferences.OutputToUserStream = False then
    FOutputStream.Free;
end;

procedure TgtCustomExcelEngine.EndPage;
var
  LI: Integer;
begin
  inherited;
  { with Pages[CurrentPage - 1].Settings do
    LHeight := Round(Round(Height) / FDefaultCellHeight); }

  with Preferences do
    if (((PagesPerWorksheet <> 0) and ((CurrentPage mod PagesPerWorksheet)
      = 0))) then
    begin
      Inc(FSheetCount);
      EndSheet(FSheetCount);
    end;
  if (Preferences.PagesPerWorksheet <> 0) then
  begin
    SortAndCombineFormulaListToCurrent;
    CreateworkSheets(CurrentPage);
    WriteSheetRelations(CurrentPage);
    WriteDrawingRelations(CurrentPage);
    WriteDrawingsXml(CurrentPage);
    for LI := 0 to FCompletedImageIndexcount do
      FCompletedImageIndexList[LI] := 0;
    FCompletedImageIndexcount := 0;
  end;
  // FreeLists
end;

procedure TgtCustomExcelEngine.EndSheet(SheetNo: Integer);
var
  LSheetItem: TgtSheetItem;
  I: Integer;
  // LColWidth: PgtColumnWidth;
  // LByte: Byte;
  // E: Double;
  LSheetName: String;
  // LOrientation, LCopies: Word;
begin
  with FSpreadSheetItemList do
  begin
    LSheetItem := TgtSheetItem.Create;
    LSheetItem.FSheetOffset := FOutputStream.Size;

    LSheetName := 'Sheet' + IntToStr(FSheetCount);

    if (Assigned(FOnNeedSheetName)) then
      FOnNeedSheetName(Self, LSheetName, FSheetCount);

    for I := 0 to FSpreadSheetItemList.Count - 1 do
      if TgtSheetItem((Items[I])).FSheetName = LSheetName then
      begin
        LSheetName := String('Sheet' + IntToStr(FSheetCount));
        Break;
      end;

    LSheetItem.FSheetName := LSheetName;
    Add(LSheetItem);
  end;
  FLastPageHeight := 0;
  FPrevRowNo := 0;
  InitDimensionVars;
  WriteBackgroundImage;
end;

function TgtCustomExcelEngine.GetBorderText: string;
var
  LStyle, LColor: string;
  LColorObj: TgtColor;
begin
  if (CellBorder.Enabled) and (CellBorder.FStyle <> cbsNone) then
  begin
    // Calculating color for border
    // LColorObj := TgtColor.Create;
    LColorObj := GetXLSXColor(CellBorder.FColor);
    LColor := LColorObj.FRGB;
    FColorList.Add(LColorObj);

    // Caliculating style for boder
    case CellBorder.FStyle of
      cbsThin:
        LStyle := 'thin';
      cbsMedium:
        LStyle := 'medium';
      cbsThick:
        LStyle := 'thick';
      cbsDashed:
        LStyle := 'dashed';
      cbsDotted:
        LStyle := 'dotted';
      cbsHair:
        LStyle := 'hair';
      cbsDouble:
        LStyle := 'double';
    end;

    Result := '<borders count="2">';
    Result := Result + '<border><left/><right/><top/><bottom/><diagonal/>' +
      '</border>';
    Result := Result + '<border>';

    Result := Result + '<left style="' + LStyle + '">' + '<color rgb="' + LColor
      + '"/>' + '</left>';
    Result := Result + '<right style="' + LStyle + '">' + '<color rgb="' +
      LColor + '"/>' + '</right>';
    Result := Result + '<top style="' + LStyle + '">' + '<color rgb="' + LColor
      + '"/>' + '</top>';
    Result := Result + '<bottom style="' + LStyle + '">' + '<color rgb="' +
      LColor + '"/>' + '</bottom>';
    Result := Result + '<diagonal/></border></borders>';
  end
  else
  begin
    Result := '<borders count="1"><border><left/><right/><top/><bottom/>';
    Result := Result + '<diagonal/></border></borders>';
  end;
end;

function TgtCustomExcelEngine.GetCellStylesText: string;
begin
  Result := '<cellStyles count="1">';
  Result := Result + '<cellStyle name="Normal" xfId="0" builtinId="0"/>' +
    '</cellStyles>' + '<dxfs count="0"/>' +
    '<tableStyles count="0" defaultTableStyle="TableStyleMedium9"' +
    ' defaultPivotStyle="PivotStyleLight16"/>';
end;

function TgtCustomExcelEngine.GetCellStyleXfsText: string;
begin
  Result := '<cellStyleXfs count="1">';
  Result := Result + '<xf numFmtId="0" fontId="0" fillId="0" borderId="0"/>' +
    '</cellStyleXfs>';
end;

function TgtCustomExcelEngine.GetCellXfsText: string;
Var
  LS: string;
  LI, LBorderID, LFillID: Integer;
begin
  LFillID := 0;
  LBorderID := 0;
  if CellBorder.Enabled and (CellBorder.FStyle <> cbsNone) then
    LBorderID := 1;
  if BackgroundColor <> clWhite then
    LFillID := 2;
  LS := '<cellXfs count="' + IntToStr(FStylesList.Count + 1) + '">';
  LS := LS + '<xf numFmtId="0" fontId="0"' + ' fillId="' + IntToStr(LFillID) +
    '" borderId="' + IntToStr(LBorderID) + '" xfId="0"/>';
  for LI := 0 to FStylesList.Count - 1 do
  begin
    LS := LS + GetEachXfsText(FStylesList.Items[LI]);
  end;
  LS := LS + '</cellXfs>';
  Result := LS;

end;

function TgtCustomExcelEngine.GetColumnLabel(AColNo: Integer): String;
begin
  if AColNo > 0 then
  begin
    Dec(AColNo);
    Result := GetColumnLabel(Trunc(AColNo / 26)) + Char(AColNo mod 26 + 65);
  end;
end;

function TgtCustomExcelEngine.GetCurrencyFormatId: Integer;
begin
  FCurrencyFormatCode := '<numFmt numFmtId="' + IntToStr(XLSX_CURRENCY_FORMATID)
    + '" formatCode=""$"#,##0.00"/>';
  Result := XLSX_CURRENCY_FORMATID;
end;

function TgtCustomExcelEngine.GetDateTimeFormatId: Integer;
begin
  FDateTimeFormatCode := '<numFmt numFmtId="' + IntToStr(XlSX_DATETIME_FORMATID)
    + '" formatCode="[$-409]m/d/yy\ h:mm\ AM/PM;@"/>';
  Result := XlSX_DATETIME_FORMATID;
end;

function TgtCustomExcelEngine.GetEachXfsText(AStyle: TgtStyle): string;
Var
  LS: string;
begin
  LS := LS + '<xf ' + 'numFmtId="' + IntToStr(AStyle.FNumFmtIndex) + '" ' +
    'fontId="' + IntToStr(AStyle.FFontIndex) + '" ';
  // Caliculating fill color based on Brush abd Background color
  // if (Brush.Color <> clWhite) and (Brush.Style <> bsSolid) then
  // begin
  // if (BackgroundColor = clWhite) and (Brush.Color = clWhite) then
  // LS := LS + 'fillId="1" '
  // if BackgroundColor = clWhite  then
  // LS := LS + 'fillId="2" '
  // else
  // LS := LS + 'fillId="3" ' ;
  // end
  // else
  // begin
  // if BackgroundColor <> clWhite then
  // LS := LS +'fillId="2" '
  // else
  // LS := LS +'fillId="0" '
  // end;
  LS := LS + 'fillId="' + (IntToStr(AStyle.FFillID + 2)) + '" ';
  LS := LS + 'borderId="' + IntToStr(AStyle.FBorderIndex) + '" ';
  if AStyle.IsCurrency then
    LS := LS + 'xfId="1" '
  else
    LS := LS + 'xfId="0" ';
  LS := LS + 'applyNumberFormat="1" applyFont="1" applyBorder="0" ';
  if AStyle.FAlignment in [haGeneral, haLeft, haCenter] then
    LS := LS + '/>'
  else
  begin
    LS := LS + 'applyAlignment="1">';
    LS := LS + '<alignment horizontal="';
    case AStyle.FAlignment of
      haRight:
        LS := LS + 'right"/></xf>';
      // haCenter:
      // LS := LS + 'center"/></xf>';
      haJustify:
        LS := LS + 'justify"/></xf>';
    end;
  end;
  Result := LS;
end;

function TgtCustomExcelEngine.GetFillColor(ABrush: TBrush): Integer;
Var
  LI: Integer;
  LColor: TgtColor;
  // LFlag: Boolean;
begin
  Result := -1;
  LColor := GetXLSXColor(ABrush.Color);
  for LI := 0 to FFillColorList.Count - 1 do
  begin
    if (TgtColor(FFillColorList.Items[LI]).RGB = LColor.RGB) then
    begin
      Result := LI;
      Break;
    end;
  end;
  LColor.Free;
end;

function TgtCustomExcelEngine.GetFillStyle(AValue: Byte): Byte;
begin
  Result := 0;
  case AValue of
    05:
      Result := $08;
    06:
      Result := $0F;
    07:
      Result := $09;
    04:
      Result := $07;
    02:
      Result := $0B;
    00:
      Result := $01;
    03:
      Result := $0C;
  end;
end;

function TgtCustomExcelEngine.GetFillText: string;
var
  // LColor: TgtColor;
  // LBColor: TgtColor;
  LI: Integer;
begin
  Result := '<fills count="' + IntToStr(FFillColorList.Count + 2) + '">';
  Result := Result + '<fill><patternFill patternType="none"/></fill>' +
    '<fill><patternFill patternType="gray125"/></fill>';
  for LI := 0 to FFillColorList.Count - 1 do
  begin
    Result := Result + '<fill>' + '<patternFill patternType="solid">' +
      '<fgColor rgb="' + TgtColor(FFillColorList.Items[LI]).FRGB + '"/>' +
      '</patternFill>' + '</fill>';
  end;
  Result := Result + '</fills>';

  /// /To be handle all the fill entries
  // if (Brush.Color <> clWhite) and (BackgroundColor <> clWhite) then
  // begin
  /// /      LColor := TgtColor.Create;
  // LColor := GetXLSXColor(BackgroundColor);
  // FColorList.Add(LColor);
  // Result := '<fills count="4"><fill><patternFill patternType="none"/></fill>' +
  // '<fill><patternFill patternType="gray125"/></fill>';
  //
  // Result := Result + '<fill><patternFill patternType="solid"><fgColor rgb="';
  // Result := Result + LColor.FRGB +'"/>' + '<bgColor rgb="'
  // +LColor.FRGB + '"/>';
  // Result := Result + '</patternFill></fill>';
  //
  // //     LBColor := TgtColor.Create;
  // LBColor := GetXLSXColor(Brush.Color);
  // FColorList.Add(LBColor);
  // Result := Result + '<fill><patternFill patternType="'
  // + getPatternType(Brush.Style) + '">';
  // Result := Result + ' <fgColor rgb="';
  // Result := Result + LBColor.FRGB +'"/>' + '<bgColor rgb="'
  // +LBColor.FRGB + '"/>';
  // Result := Result + '</patternFill></fill>';
  //
  // Result := Result + '</fills>';
  // end
  // else if BackgroundColor <> clWhite then
  // begin
  /// /    LColor := TgtColor.Create;
  // LColor := GetXLSXColor(BackgroundColor);
  // FColorList.Add(LColor);
  // Result := '<fills count="3"><fill><patternFill patternType="none"/></fill>' +
  // '<fill><patternFill patternType="gray125"/></fill>';
  // Result := Result + '<fill><patternFill patternType="solid"><fgColor rgb="';
  // Result := Result + LColor.FRGB +'"/>' + '<bgColor rgb="'
  // +LColor.FRGB + '"/>';
  // Result := Result + '</patternFill></fill></fills>';
  // end
  // else if Brush.Color <> clWhite then
  // begin
  // Result := '<fills count="3"><fill><patternFill patternType="none"/></fill>' +
  // '<fill><patternFill patternType="gray125"/></fill>';
  //
  /// /      LBColor := TgtColor.Create;
  // LBColor := GetXLSXColor(BackgroundColor);
  // FColorList.Add(LBColor);
  // Result := Result + '<fill><patternFill patternType="'
  // + getPatternType(Brush.Style) + '">';
  // Result := Result + ' <fgColor rgb="';
  // Result := Result + LBColor.FRGB +'"/>' + '<bgColor rgb="'
  // +LBColor.FRGB + '"/>';
  // Result := Result + '</patternFill></fill>';
  //
  // Result := Result + '</fills>';
  //
  // end
  // else
  // begin
  // Result := '<fills count="2"><fill><patternFill patternType="none"/></fill>' +
  // '<fill><patternFill patternType="gray125"/></fill></fills>';
  // end;
end;

function TgtCustomExcelEngine.GetFontChieldText(AFont: TgtFont): string;
begin

  Result := '';
  if fsUnderline in AFont.FStyle then
    Result := '<u/>';
  if fsBold in AFont.FStyle then
    Result := '<b/>';
  if fsItalic in AFont.FStyle then
    Result := '<i/>';
  if fsStrikeOut in AFont.FStyle then
    Result := '<s/>';
  Result := Result + '<sz val="' + IntToStr(AFont.FSize) + '"/>';
  FColorList.Add(AFont.FColor);
  Result := Result + '<color rgb="' + AFont.FColor.FRGB + '"/>';
  Result := Result + '<name val="' + AFont.FName + '"/>';
  Result := Result + '<family val="' + IntToStr(AFont.FFamily) + '"/>';
end;

function TgtCustomExcelEngine.GetFontText: string;
var
  LI: Integer;
  LS: WideString;
  // LColor: TgtColor;
begin
  // Default cell style As per the Microsoft XSLS standerds
  LS := LS + '<fonts count="' + IntToStr(FFontList.Count + 1) + '">';
  LS := LS + '<font><sz val="11"/><color theme="1"/><name val="Calibri"/>' +
    '<family val="2"/></font>';

  // Writing Engine Font values
  // LS := LS + '<font>';
  // LS := LS + '<sz val="' + IntTostr(Font.Size) + '"/>';
  // LColor := GetXLSXColor(Font.Color);
  // FColorList.add(LColor);
  // LS := LS + '<color rgb="' + LColor.FRGB + '"/>' ;
  // LS := LS + '<name val="' + Font.Name + '"/>';
  // LS := LS + '<family val="2"/></font>';

  for LI := 0 to FFontList.Count - 1 do
  begin
    LS := LS + '<font>';
    LS := LS + GetFontChieldText(FFontList.Items[LI]);
    LS := LS + '</font>';
  end;

  LS := LS + '</fonts>';
  Result := LS;
end;

function TgtCustomExcelEngine.GetImageIndex(Index: Integer): Integer;
begin
  Result := FCompletedImageIndexList[Index];
end;

function TgtCustomExcelEngine.GetNumFrmtText: string;
var
  // LS: string;
  I: Integer;
begin
  if (Preferences.NumberFormatDecimalPlaces > 2) and (FFlag) then
  begin
    Result := '<numFmts count="1"><numFmt numFmtId="';
    Result := Result + IntToStr(XLSX_NUMBER_DECIMAL_PLACES) +
      '" formatCode="0.';
    for I := 0 to Preferences.NumberFormatDecimalPlaces - 1 do
      Result := Result + '0';
    Result := Result + '"/></numFmts>';
  end;
  { Already handeled }
  // Result :='';
  // count := 0;
  // if (FDateTimeFormatCode <> '') or (FCurrencyFormatCode <> '') or
  // (FTimeForamtCode <> '') then
  // begin
  // if FDateTimeFormatCode <> '' then
  // begin
  // LS := LS + FDateTimeFormatCode;
  // Inc(count);
  // end;
  // if FCurrencyFormatCode <> '' then
  // begin
  // LS := LS + FCurrencyFormatCode;
  // Inc(count);
  // end;
  // if FTimeForamtCode <> '' then
  // begin
  // LS := LS + FTimeForamtCode;
  // Inc(count);
  // end;
  // Result := '<numFmts count="' + IntToStr(count) + '">' + LS +
  // '</numFmts>';
  // end;

end;

procedure TgtCustomExcelEngine.NewPage;
begin
  inherited;

end;

procedure TgtCustomExcelEngine.SetColumnWidth(ColumnNumber: Integer;
  Width: Double);
begin
  inherited;

end;

procedure TgtCustomExcelEngine.SetImageIndex(Index: Integer;
  const Value: Integer);
begin
  FCompletedImageIndexList[Index] := Value;
end;

procedure TgtCustomExcelEngine.SetPreferences(const Value: TgtExcelPreferences);
begin
  inherited Preferences := Value;
end;

function TgtCustomExcelEngine.ShowSetupModal: Word;
begin
  with TgtExcelEngineDlg.Create(nil) do
    try
      Engine := Self;
      Result := ShowModal;
    finally
      Free;
    end;
end;

// TODO: Should optimize this
// Check the complete row for FRowNo and exchange it if required
procedure TgtCustomExcelEngine.SortAndCombineFormulaListToCurrent;
var
  I, J: Integer;
begin
  // FRowItemList.Sort(CompareByColumnNumber) ;

  AdjustCellsAcordingToRowNumbers;
  for I := 0 to FRowItemList.Count - 1 do
  begin
    for J := I + 1 to FRowItemList.Count - 1 do
    begin
      if (TgtCellItem(FRowItemList.Items[I]).FColumnNo >
        TgtCellItem(FRowItemList.Items[J]).FColumnNo) and
        (TgtCellItem(FRowItemList.Items[I]).FRowNo = TgtCellItem
        (FRowItemList.Items[J]).FRowNo) then
      begin
        FRowItemList.Exchange(I, J);
      end;
    end;
  end;
  // FRowItemList.Sort(CompareByRowNumber) ;
end;

procedure TgtCustomExcelEngine.TextBox(TextRect: TgtRect; Text: WideString;
  HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);
begin
  inherited;

end;

procedure TgtCustomExcelEngine.UpdateDimensionVars(const ARowNo,
  AColNo: Integer);
begin
  FMinRowNo := Min(FMinRowNo, ARowNo);
  FMaxRowNo := Max(FMaxRowNo, ARowNo);
  FMinColNo := Min(FMinColNo, AColNo);
  FMaxColNo := Max(FMaxColNo, AColNo);
end;

procedure TgtCustomExcelEngine.WriteBackgroundImage;
begin

end;

procedure TgtCustomExcelEngine.WriteDrawingRelations(ASheetNo: Integer);
Var
  LStringStream: TStringStream;
  LS: string;
  LI: Integer;
begin
  if FDrawingRelationList.Count <> 0 then
  begin
    LS := LS + DefaultXMLHeader + CRLF +
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relat'
      + 'ionships">';
    for LI := 0 to FDrawingRelationList.Count - 1 do
    begin
      with TgtDrawingRelation(FDrawingRelationList.Items[LI]) do
      begin
        LS := LS + '<Relationship ';
        LS := LS + 'Id="' + FDrId + '" ';
        LS := LS + 'Type="http://schemas.openxmlformats.org/officeDocument/2006'
          + '/relationships/';
        LS := LS + 'image" ';
        LS := LS + 'Target="' + FTarget + '"';
        LS := LS + '/>';
      end;
    end;
    LS := LS + '</Relationships>';
    LStringStream := TStringStream.Create(LS);
    FZipPackage.CreateParts('xl\drawings\_rels\drawing' + IntToStr(ASheetNo) +
      '.xml.rels', LStringStream);
    LStringStream.Free;
  end;
  FreeAndNil(FDrawingRelationList);
  FDrawingRelationList := TList.Create;
end;

// procedure TgtCustomExcelEngine.WriteWindow1Record(AStream: TStream);
// const
// Win1Rec: array [0 .. 21] of Byte = ($3D, $00, $12, $00, $E0, $01, $78, $00,
// $5B, $3B, $FA, $23, $38, $00, $00, $00, $00, $00, $01, $00, $58, $02);
// begin
// AStream.Write(Win1Rec, SizeOf(Win1Rec));
{ To be Implemented }
// end;

function TgtCustomExcelEngine.WrtitesharedStringList(AString: string): Integer;
var
  LPrevCount: Integer;
begin
  Inc(FStringCount); // Total string count including duplicates
  LPrevCount := FSharedStringList.Items.Count;
  // To check if string already exists
  Result := FSharedStringList.Find(AString);
  if LPrevCount < FSharedStringList.Items.Count then
    // if unique string, form the XML tag
    FSharedStrings := FSharedStrings + '<si><t>' + AString + '</t></si>';
end;

procedure TgtCustomExcelEngine.WriteDrawingsXml(ASheetNo: Integer);
var
  I: Integer;
  LS: string;
  LStringStream: TStringStream;
begin
  if FDrawingList.Count <> 0 then
  begin
    LS := LS + DefaultXMLHeader + CRLF;
    LS := LS + '<xdr:wsDr ' +
      'xmlns:xdr="http://schemas.openxmlformats.org/drawingml/2006/spreadsheetDrawing" '
      + 'xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">';
    for I := 0 to FDrawingList.Count - 1 do
    begin
      LS := LS + EncodeDrawing(TgtDrawing(FDrawingList[I]));
    end;
    LS := LS + '</xdr:wsDr>';
{$IFDEF gtDelphi2009Up}
    LStringStream := TStringStream.Create(LS, TEncoding.UTF8);
{$ELSE}
    LStringStream := TStringStream.Create(LS);
{$ENDIF}
    ZipPackage.CreateParts('xl\drawings\drawing' + IntToStr(ASheetNo) + '.xml',
      LStringStream);
    LStringStream.Free;
    FreeAndNil(FDrawingList);
    FDrawingList := TList.Create;
  end;

end;

procedure TgtCustomExcelEngine.WriteSharedstrings;
var
  ContentTypeStream: TStringStream;
  LS: WideString;
  LSTmp: UTF8String;
begin
  // Reusing all strings.
  // if FSharedStringList.Count <> 0 then
  if FSharedStringList.Items.Count <> 0 then
  begin
    LS := LS + DefaultXMLHeader;
    LS := LS + '<sst xmlns="http://schemas.openxmlformats.org/spreadsheetml' +
      '/2006/main"';
    LS := LS + ' count="' + IntToStr(FStringCount);
    LS := LS + '" uniqueCount="' +
      IntToStr(FSharedStringList.Items.Count) + '">';
    // Removed the for loop here. The shared string XML is constructed as
    // -we add each unique strings into the list
    LS := LS + '<si><t></t></si>' + FSharedStrings;
    LS := LS + '</sst>';
  end;
{$IFDEF gtDelphi2009Up}
  ContentTypeStream := TStringStream.Create(LS, TEncoding.UTF8);
{$ELSE}
  LSTmp := UTF8Encode(LS);
  ContentTypeStream := TStringStream.Create('');
  ContentTypeStream.Write(LSTmp[1], Length(LSTmp) * SizeOf(AnsiChar));
{$ENDIF}
  FZipPackage.CreateParts('xl\sharedStrings.xml', ContentTypeStream);
  ContentTypeStream.Free;
end;

// function TgtCustomExcelEngine.GetPatternType(Astyle: TBrushStyle): string;
// begin
// case Astyle of
// bsSolid: Result := 'solid';
// bsClear: Result := 'clear';
// bsHorizontal: Result := 'horizontal';
// bsVertical: Result := 'vertical';
// bsFDiagonal: Result := 'fdiagonal';
// bsBDiagonal: Result := 'bdiagonal';
// bsCross: Result := 'cross';
// bsDiagCross: Result := 'DiagCross';
// end;
// end;

function TgtCustomExcelEngine.GetPreferences: TgtExcelPreferences;
begin
  Result := TgtExcelPreferences( inherited Preferences);
end;

function TgtCustomExcelEngine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtExcelPreferences;
end;

function TgtCustomExcelEngine.GetRelID(Value: Integer): String;
begin
  Result := 'rID' + IntToStr(Value);
  Inc(FRId);
end;

function TgtCustomExcelEngine.GetRGBColorsText: string;
var
  I: Integer;
  LCompleted: Integer;
begin
  Result := '<colors><mruColors>';
  LCompleted := -1;
  for I := 0 to FColorList.Count - 1 do
  begin
    if not(SameColor(TgtColor(FColorList.Items[I]).FRGB, LCompleted)) then
    begin
      Result := Result + '<color rgb="' + TgtColor(FColorList.Items[I])
        .FRGB + '"/>';
    end;
    Inc(LCompleted);

  end;
  Result := Result + ' </mruColors></colors>';
end;

function TgtCustomExcelEngine.GetSheetID(SheetNo: Integer): String;
begin
  Result := IntToStr(SheetNo);
end;

function TgtCustomExcelEngine.GetTimeFormatId: Integer;
begin
  FCurrencyFormatCode := '<numFmt numFmtId="' + IntToStr(XLSX_TIME_FORMATID) +
    '" formatCode="[$-F400]h:mm:ss\ AM/PM"/>';
  Result := XLSX_TIME_FORMATID;
end;

function TgtCustomExcelEngine.GetXLSXColor(AColor: TColor): TgtColor;
var
  LgtColor: TgtColor;
  I: LongInt;
  LRGBVal: string;
begin
  I := LongInt(AColor);
  if AColor < 0 then
  begin
    I := ColorToRGB(AColor);
  end;
  LgtColor := TgtColor.Create;
  LRGBVal := IntToHex(I, 6);
  LgtColor.FIsRGB := True;
  LgtColor.FRGB := 'FF' + RevrseString(LRGBVal);
  Result := LgtColor;
end;

function TgtCustomExcelEngine.GetXLSXDrawingColor(AColor: TColor): string;
var
  I: Integer;
  LRGBVal: string;
begin
  I := LongInt(AColor);
  if AColor < 0 then
  begin
    I := ColorToRGB(AColor);
  end;
  LRGBVal := IntToHex(I, 6);
  Result := RevrseString(LRGBVal);
end;

function TgtCustomExcelEngine.AddFillStyle(ABrush: TBrush): Integer;
var
  LColor: TgtColor;
begin
  LColor := GetXLSXColor(ABrush.Color);
  FFillColorList.Add(LColor);
  Result := FFillColorList.Count - 1;
end;

procedure TgtCustomExcelEngine.AddSheetRelation(ARelType: TgtSheetRelationType);
var
  LSheetRelation: TgtSheetRelation;
begin
  LSheetRelation := TgtSheetRelation.Create;
  LSheetRelation.FRelType := ARelType;
  if ARelType = srtImage then
  begin
    LSheetRelation.FTarget := '../media/image' + IntToStr(FImageCount)
      + '.jpeg';
    LSheetRelation.FsrID := 'rId' + IntToStr(CurrentPage) +
      IntToStr(FImageCount);
  end
  else
  begin
    Dec(FdrawRelationRemainscount);
    LSheetRelation.FTarget := '../drawings/drawing' +
      IntToStr(SheetCount) + '.xml';
    LSheetRelation.FsrID := 'rId' + IntToStr(CurrentPage) +
      IntToStr(FDrawingCount - FdrawRelationRemainscount);
  end;
  FSheetRelationList.Add(LSheetRelation);

end;

// TODO: Should optimize this
procedure TgtCustomExcelEngine.AdjustCellsAcordingToRowNumbers;
var
  I, J: Integer;
begin
  for I := 0 to FRowItemList.Count - 1 do
  begin
    for J := 0 to FRowItemList.Count - 2 do
    begin
      if ((TgtCellItem(FRowItemList.Items[J]).FRowNo) >
        (TgtCellItem(FRowItemList.Items[J + 1]).FRowNo)) then
        FRowItemList.Exchange(J, J + 1);
    end;
  end;
end;

procedure TgtCustomExcelEngine.AppendList(var AIndexCellItem: Integer;
  AIndexFormulaItem: Integer);
var
  // LCellItem: TgtCellItem;
  I: Integer;
begin
  // LCellItem := FRowItemList.Items[AIndexCellItem];
  // FRowItemList.Insert(AIndexCellItem, FormuleaList.Items[AIndexFormulaItem]);
  FRowItemList.Add(FormuleaList.Items[AIndexFormulaItem]);
  // if FRowItemList.Count <> 2 then
  // begin
  for I := AIndexCellItem to FRowItemList.Count - 1 do
  begin
    FRowItemList.Exchange(I, FRowItemList.Count - 1);
  end;
  // end;

end;

procedure TgtCustomExcelEngine.BeginDoc;
begin
  inherited;
end;

function TgtCustomExcelEngine.SameColor(AColor: string;
  AIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AIndex = -1 then
    Exit;
  for I := 0 to AIndex do
  begin
    if (TgtColor(FColorList.Items[I]).FRGB = AColor) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TgtCustomExcelEngine.SameFont(AFont: TFont;
  AFontIndex: Integer): Boolean;
begin
  Result := False;
  with TgtFont(FFontList.Items[AFontIndex]) do
  begin
    if (FName = AFont.Name) and (FSize = AFont.Size) and
      (FColor.FRGB = 'FF' + GetXLSXDrawingColor(AFont.Color)) and
      (FStyle = AFont.Style) then
      Result := True;
  end;
end;

procedure TgtCustomExcelEngine.SetCellBorder(const Value: TgtCellBorder);
begin
  FCellBorder := Value;
end;

procedure TgtCustomExcelEngine.NewSheet(AAddNewPage: Boolean);
// var I: Integer;
begin
  inherited;
  if (AAddNewPage) then
    NewPage;
  Inc(FSheetCount);
  EndSheet(FSheetCount);
end;

function TgtCustomExcelEngine.RevrseString(AString: string): string;
Var
  LI: Integer;
Begin
  Result := '';
  For LI := Length(AString) DownTo 1 Do
  Begin
    Result := Result + Copy(AString, LI, 1);
  End;
End;

procedure TgtCustomExcelEngine.InitDimensionVars;
begin
  FMinRowNo := MaxInt;
  FMaxRowNo := -1;
  FMinColNo := MaxInt;
  FMaxColNo := -1;
end;
{ TgtExcelPreferences }

constructor TgtExcelPreferences.Create;
begin
  inherited;
  FPageMargins := False;
  FPrintGridLines := False;
  FPagesPerWorksheet := 0;
  ApplyAlignment := False;
  MultiPass := False;
  WordWrap := False;
  UseDefaultPalette := False;
  ContinuousMode := False;
end;

procedure TgtExcelPreferences.SetMetafileAsImage(const Value: Boolean);
begin
  FMetafileAsImage := Value;
end;

procedure TgtExcelPreferences.SetPageMargins(const Value: Boolean);
begin
  FPageMargins := Value;
end;

procedure TgtExcelPreferences.SetPagesPerWorksheet
  (const Value: TgtWorksheetPagesType);
begin
  FPagesPerWorksheet := Value;
end;

procedure TgtExcelPreferences.SetPrintGridLines(const Value: Boolean);
begin
  FPrintGridLines := Value;
end;

{ TgtCellBorder }

constructor TgtCellBorder.Create;
begin
  FEnabled := False;
  FStyle := cbsNone;
  FColor := clBlack;
end;

destructor TgtCellBorder.Destroy;
begin

  inherited;
end;

procedure TgtCellBorder.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

procedure TgtCellBorder.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TgtCellBorder.SetStyle(const Value: TgtCellBorderStyle);
begin
  FStyle := Value;
end;

{ TgtStyle }

constructor TgtStyle.Create;
begin
  inherited;
  FNumFmtIndex := -1;
  FFontIndex := -1;
  FBorderIndex := 0;
  FAlignment := haJustify;
  FCellHieght := 0;
  FCellWidth := 0;
  IsCurrency := False;
end;

destructor TgtStyle.Destroy;
begin

  inherited;
end;

{ TgtFont }

constructor TgtFont.Create;
begin
  inherited;
  FSize := 11;
  FName := 'Calibri';
  FFamily := 2;
  FScheme := 'minor';
  // FUnderLine := False;
  FStyle := [];
end;

destructor TgtFont.Destroy;
begin

  inherited;
end;

{ TgtColor }

constructor TgtColor.Create;
begin
  inherited;
  FRGB := '00000000';
  FIsRGB := True;
end;

destructor TgtColor.Destroy;
begin

  inherited;
end;

{ TgtCellItem }

constructor TgtCellItem.Create;
begin
  FRowNo := 0;
  FStyleIndex := -1;
  FSharedStringIndex := -1;
  FColumnNo := 0;
  FIsSharedString := False;
  FFormula := '';
  inherited;
end;

destructor TgtCellItem.Destroy;
begin

  inherited;
end;

{ TgtSheetItem }

constructor TgtSheetItem.Create;
begin
  FSheetName := '';
  FSheetOffset := 0;
  inherited;
end;

destructor TgtSheetItem.Destroy;
begin

  inherited;
end;

{ TgtSheetRelation }

constructor TgtSheetRelation.Create;
begin
  FRelType := srtNone;
  FTarget := '';

end;

destructor TgtSheetRelation.Destroy;
begin

  inherited;
end;

{ TgtDrawing }

constructor TgtDrawing.Create;
begin
  FromColNo := -1;
  FromRowNo := -1;
  ToColNo := -1;
  ToRowNo := -1;
  FromColOffset := 0;
  FromRowOffset := 0;
  ToColOffset := 0;
  ToRowOffset := 0;
  IsFill := False;
  DrawingType := dtNone;
  FRId := '';
end;

destructor TgtDrawing.Destroy;
begin

  inherited;
end;

{ TgtDrawingRelation }

constructor TgtDrawingRelation.Create;
begin

end;

destructor TgtDrawingRelation.Destroy;
begin

  inherited;
end;

{ TgtFromula }

// constructor TgtFormula.create;
// begin
// FFormula := '';
// FValue := 0;
// end;
//
// destructor TgtFormula.Destroy;
// begin
//
// inherited;
// end;

end.
