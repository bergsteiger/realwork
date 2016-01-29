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

{$I ..\gtDefines.inc}
{$I ..\gtDocDefines.inc}
{$I ..\gtExpIntf.inc}
// TO ENABLE: Remove the dot(.) before $DEFINE to look as {$DEFINE ...}
// TO DISABLE: Add a dot(.) before $DEFINE to look as {.$DEFINE ...}

// --- ReportBuilder Version Support ---
// Below v7.0: DISABLE RB70Up, RB90Up.
// v7.0 and above, but below v9.0: ENABLE RB70Up & DISABLE RB90Up.
// v9.0 and above: ENABLE RB70Up, RB90Up.
// v11.0 and above: ENABLE RB70Up, RB90Up, RB110Up.
{ .$DEFINE RB70Up }
{ .$DEFINE RB90Up }
{ .$DEFINE RB110Up }
// --- Builder Controls Add-on Support ---
// http://www.cooldev.com/freeware.html
// If Enabled: Supports Builder Controls Add-on.
// If Disabled: Does not support Builder Controls Add-on.
{ .$DEFINE BUILDER_CONTROLS }

// --- WPRichText Controls Add-on Support ---
// http://www.wptools.de
// WpTools support is NOT completely tested as we do not have access to WpTools.
// The basic provisions have been made for supporting it, to which users can
// make modifications.
// Thanks to Pat Williams (pat@patwilliams.com.au) for the code snippet related
// to WPRICHTEXT5.
// If Enabled: Supports WPRichText Controls Add-on.
// If Disabled: Does not support WPRichText Controls Add-on.
// v4.0 and above, but below v5.0: ENABLE WPRICHTEXT & DISABLE WPRICHTEXT5.
// v5.0 and above, ENABLE WPRICHTEXT, WPRICHTEXT5.
{ .$DEFINE WPRICHTEXT }
{ .$DEFINE WPRICHTEXT5 }

// --- TRichView Controls Add-on Support ---
// http://www.trichview.com
// If Enabled: Supports RichView Controls Add-on.
// If Disabled: Does not support RichView Controls Add-on.
{ .$DEFINE RICHVIEW }

// --- GridPack Controls Add-on Support ---
// http://planitek.netfirms.com
// If Enabled: Supports RichView Controls Add-on.
// If Disabled: Does not support RichView Controls Add-on.
{ .$DEFINE GRIDPACK }

unit gtRBXportIntf;

interface

uses
  Classes, Dialogs, Windows, Graphics, Forms, ExtCtrls, SysUtils, Math,
  ppDevice,
  ppTypes, ppUtils, ppFilDev, ppForms, ppDrwCmd, ppReport, ComCtrls, RichEdit,
  gtCstDocEng, gtXportIntf, gtConsts3, gtDocResStrs, gtDocUtils, gtUtils3
{$IFDEF RB90Up}
    , ppRichTx, ppBarCodDrwCmd, ppRichTxDrwCmd
{$ENDIF RB90Up}
{$IFDEF BUILDER_CONTROLS}
    , BuilderControls
{$ENDIF}
{$IFDEF WPRICHTEXT}
    , ppWPTools
{$IFDEF WPRICHTEXT5}
    , WPCTRRich, WPCTRMemo, WPRTEDefs
{$ELSE}
    , WPRich, WPPrint, WPDefs
{$ENDIF}
{$ENDIF}
{$IFDEF RICHVIEW}
    , ppRichView
{$ENDIF}
{$IFDEF GRIDPACK}
    , RBTableGrid, RBCheckBox
{$ENDIF}
    ;

type
  TNewTextMetricEx = packed record
    NewTextMetric: TNewTextMetric;
    FontSignature: TFontSignature end;

    TgtRBXportClass = class of TgtRBXport;

    TgtDrawTextEvent = procedure(Sender: TppDrawText;
      Engine: TgtCustomDocumentEngine; var Text: WideString; X, Y: Double;
      var DontTextOut: Boolean) of object;
    TgtEncodeGraphicEvent = procedure(AObject: TObject;
      var UniqueImage: Boolean; var ReuseImageIndex: Integer) of object;
    TgtEncodeGraphicDoneEvent = procedure(AObject: TObject;
      ObjectImageIndex: Integer) of object;

    TgtRBXport = class(TppFileDevice)private FParent: TObject;
    FCanvas: TCanvas;
    FEngine: TgtCustomDocumentEngine;
    FConversionFactor: Double;
    FOffset: TPoint;
    FCurrentPage: TppPage;
    function GetEngine: IgtDocumentEngine;

{$IFDEF BUILDER_CONTROLS}
    function CalcRect(ACanvas: TCanvas; MaxWidth: Integer;
      const AText: string): TRect;
    function CalcClientRect(Canvas: TCanvas; Angle: Integer; ARect: TRect;
      var APoint: TPoint): TRect;
{$ENDIF}
  protected
    procedure BeginPage(aPage: TppPage);
    procedure EndPage(aPage: TppPage);

    procedure DrawShape(aDrawShape: TppDrawShape); virtual;
    procedure DrawLine(aDrawLine: TppDrawLine); virtual;
    procedure DrawImage(aDrawImage: TppDrawImage); virtual;
{$IFDEF BUILDER_CONTROLS}
    procedure DrawRotatedText(aDrawRotatedText: TDrawRotatedText); virtual;
    procedure DrawSimpleGrid(aDrawSimpleGrid: TDrawSimpleGrid); virtual;
{$ENDIF}
{$IFDEF WPRICHTEXT}
    procedure DrawWpRichText(aDrawWPRichText: TppDrawWPTRichText); virtual;
{$ENDIF}
{$IFDEF RICHVIEW}
    procedure DrawRichView(aDrawRichView: TppDrawRichView); virtual;
{$ENDIF}
{$IFDEF GRIDPACK}
    procedure DrawGridPackTableGrid(ADrawTableGrid: TrbDrawTableGrid); virtual;
    procedure DrawCheckBox(aDrawCheckBox: TrbDrawCheckBox); virtual;
{$ENDIF}
    procedure DrawText(aDrawText: TppDrawText); virtual;
    procedure DrawBarcode(aDrawBarcode: TppDrawBarcode); virtual;
    procedure DrawRichText(aDrawRichText: TppDrawRichText); virtual;

    property Engine: IgtDocumentEngine read GetEngine;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AEngine: TgtCustomDocumentEngine);
      reintroduce; overload;
    destructor Destroy; override;

    procedure EndJob; override;
    procedure ReceivePage(aPage: TppPage); override;
    procedure CancelJob; override;
    procedure StartJob; override;
    function Draw(aDrawCommand: TppDrawCommand): Boolean; override;
    procedure CalcDrawPosition(aDrawCommand: TppDrawCommand);
  end;

  { PlainSheet Formats }
  TgtRBPDFXport = class(TgtRBXport)
  public
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBRTFXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBHTMLXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBXHTMLXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

{$IFDEF gtPro}

  TgtRBSVGXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;
{$ENDIF}
  { SpreadSheet Formats }

  TgtRBExcelXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBXLSXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBQuattroProXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBLotusXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBDIFXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBSYLKXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  { SpreadSheet Formats }
{$IFDEF gtPro}

  TgtRBTIFFXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBPNGXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;
{$ENDIF}

  TgtRBJPEGXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBGIFXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBBMPXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBEMFXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBWMFXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  { PlainText Format }

  TgtRBTextXport = class(TgtRBXport)
    constructor Create(AOwner: TComponent); override;
    class function DefaultExt: string; override;
    class function DefaultExtFilter: string; override;
    class function DeviceDescription(aLanguageIndex: Longint): string; override;
  end;

  TgtRBExportInterface = class(TgtExportInterface)
  private
    FFilterClass: TgtRBXportClass;
    FEncodeGraphic: TgtEncodeGraphicEvent;
    FEncodeGraphicDone: TgtEncodeGraphicDoneEvent;
    FMetafileAsRasterImage: Boolean;

    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);
    function GetEncodeGraphic: TgtEncodeGraphicEvent;
    function GetOnEncodeGraphicDone: TgtEncodeGraphicDoneEvent;
    procedure SetOnEncodeGraphic(const Value: TgtEncodeGraphicEvent);
    procedure SetOnEncodeGraphicDone(const Value: TgtEncodeGraphicDoneEvent);
    procedure SetMetafileAsRasterImage(const Value: Boolean);
    function GetOnDrawText: TgtDrawTextEvent;
    procedure SetOnDrawText(const Value: TgtDrawTextEvent);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(Report: TppReport);
  published
    property Engine write SetEngine;
    property Visible write SetVisible;
    property OnEncodeGraphic: TgtEncodeGraphicEvent read GetEncodeGraphic
      write SetOnEncodeGraphic;
    property OnEncodeGraphicDone: TgtEncodeGraphicDoneEvent
      read GetOnEncodeGraphicDone write SetOnEncodeGraphicDone;
    property MetafileAsRasterImage: Boolean read FMetafileAsRasterImage
      write SetMetafileAsRasterImage default False;
    property OnDrawText: TgtDrawTextEvent read GetOnDrawText
      write SetOnDrawText;
  end;

var
  EncodeGraphic: TgtEncodeGraphicEvent;
  EncodeGraphicDone: TgtEncodeGraphicDoneEvent;
  GlobalOnDrawText: TgtDrawTextEvent;
  MetafileAsRaster: Boolean;

implementation

uses
  ppPlainText, ppPrintr,
  gtDocConsts,

  gtPDFEng, gtRTFEng, gtHTMLEng, gtXHTMLEng,
  gtTXTEng,
  gtXLSEng, gtQProEng, gtSLKEng, gtDIFEng, gtLotusEng,
  gtBMPEng, gtJPEGEng, gtGIFEng, gtEMFEng, gtWMFEng, gtXLS95Eng
{$IFDEF gtPro}
, gtTIFFEng, gtPNGEng, gtSVGEng
{$ENDIF}
{$IFNDEF gtRE}
    , gtClipboard
{$ENDIF}
    ;

{$IFNDEF NOGlobalSettingsVar}

var
  PDFEngine: TgtPDFEngine;
  RTFEngine: TgtRTFEngine;
  HTMLEngine: TgtHTMLEngine;
  XHTMLEngine: TgtXHTMLEngine;
  TextEngine: TgtTextEngine;
  ExcelEngine: TgtExcelEngine;
  XLSEngine: TgtXLSEngine;
  QuattroProEngine: TgtQuattroProEngine;
  SYLKEngine: TgtSYLKEngine;
  DIFEngine: TgtDIFEngine;
  LotusEngine: TgtLotusEngine;
  BMPEngine: TgtBMPEngine;
  JPEGEngine: TgtJPEGEngine;
  GIFEngine: TgtGIFEngine;
  EMFEngine: TgtEMFEngine;
  WMFEngine: TgtWMFEngine;
{$IFDEF gtPro}
  TIFFEngine: TgtTIFFEngine;
  PNGEngine: TgtPNGEngine;
  SVGEngine: TgtSVGEngine;
{$ENDIF}
{$ENDIF}
  { TgtRB_Document }

procedure TgtRBXport.BeginPage(aPage: TppPage);
var
  LUnit: TppUnitType;
begin
  Engine.Page.PaperSize := Custom;
  FEngine.MeasurementUnit := muInches;
  with aPage.PrinterSetup do
  begin
    LUnit := Units;
    Units := ppTypes.utInches;
    with Engine.Page do
    begin
      LeftMargin := MarginLeft;
      RightMargin := MarginRight;
      TopMargin := MarginTop;
      BottomMargin := MarginBottom;
      Engine.Page.Orientation := aPage.PrinterSetup.Orientation;
      Width := PrintableWidth + MarginLeft + MarginRight;
      Height := PrintableHeight + MarginTop + MarginBottom;
    end;
    Units := LUnit;
  end;

  FEngine.MeasurementUnit := muPixels;

  if FParent is TgtRBExportInterface then
    TgtRBExportInterface(FParent).StartDocument
  else if aPage.AbsolutePageNo <> 1 then
    Engine.NewPage
  else
    Engine.BeginDoc;

  FCanvas := FEngine.Canvas;
end;

procedure TgtRBXport.CalcDrawPosition(aDrawCommand: TppDrawCommand);
begin
  aDrawCommand.DrawLeft := Trunc(FOffset.X + aDrawCommand.Left *
    FConversionFactor);
  aDrawCommand.DrawTop := Trunc(FOffset.Y + aDrawCommand.Top *
    FConversionFactor);
  aDrawCommand.DrawRight :=
    Trunc(FOffset.X + (aDrawCommand.Left + aDrawCommand.Width) *
    FConversionFactor);
  aDrawCommand.DrawBottom :=
    Trunc(FOffset.Y + (aDrawCommand.Top + aDrawCommand.Height) *
    FConversionFactor);
end;

constructor TgtRBXport.Create(AOwner: TComponent);
begin
  inherited;
  FCurrentPage := nil;
  FConversionFactor := 1 / 25400 * Screen.PixelsPerInch;
end;

procedure TgtRBXport.CancelJob;
begin
  inherited;
  if FParent is TgtRBExportInterface then
    TgtRBExportInterface(FParent).EndDocument
  else
    Engine.EndDoc;
end;

constructor TgtRBXport.Create(AOwner: TComponent;
  AEngine: TgtCustomDocumentEngine);
begin
  inherited Create(AOwner);
  FCurrentPage := nil;
  FParent := AOwner;
  FEngine := AEngine;
  FConversionFactor := 1 / 25400 * Screen.PixelsPerInch;
end;

destructor TgtRBXport.Destroy;
begin

  inherited;
end;

function TgtRBXport.Draw(aDrawCommand: TppDrawCommand): Boolean;
begin
  Result := True;

  CalcDrawPosition(aDrawCommand);

{$IFDEF BUILDER_CONTROLS}
  if (aDrawCommand is TDrawSimpleGrid) then
    DrawSimpleGrid(TDrawSimpleGrid(aDrawCommand))
  else if (aDrawCommand is TDrawRotatedText) then
    DrawRotatedText(TDrawRotatedText(aDrawCommand))
  else
{$ENDIF}
{$IFDEF WPRICHTEXT}
    if (aDrawCommand is TppDrawWPTRichText) then
    DrawWpRichText(TppDrawWPTRichText(aDrawCommand))
  else
{$ENDIF}
{$IFDEF RICHVIEW}
    if (aDrawCommand is TppDrawRichView) then
    DrawRichView(TppDrawRichView(aDrawCommand))
  else
{$ENDIF}
{$IFDEF GRIDPACK}
    if (aDrawCommand is TrbDrawTableGrid) then
    DrawGridPackTableGrid(TrbDrawTableGrid(aDrawCommand))
  else if (aDrawCommand is TrbDrawCheckBox) then
    DrawCheckBox(TrbDrawCheckBox(aDrawCommand))
  else
{$ENDIF}
    if (aDrawCommand is TppDrawText) then
    DrawText(TppDrawText(aDrawCommand))
  else if (aDrawCommand is TppDrawShape) then
    DrawShape(TppDrawShape(aDrawCommand))
  else if (aDrawCommand is TppDrawBarcode) then
    DrawBarcode(TppDrawBarcode(aDrawCommand))
  else if (aDrawCommand is TppDrawLine) then
    DrawLine(TppDrawLine(aDrawCommand))
  else if (aDrawCommand is TppDrawImage) then
    DrawImage(TppDrawImage(aDrawCommand))
  else if (aDrawCommand is TppDrawRichText) then
    DrawRichText(TppDrawRichText(aDrawCommand))
  else
    Result := False;
end;

procedure TgtRBXport.DrawBarcode(aDrawBarcode: TppDrawBarcode);
var
  LPoint: TPoint;
begin
  if FEngine.EngineStatus = esCancelled then
    Exit;
  LPoint := Point(CPixelsPerInch, CPixelsPerInch);
  with aDrawBarcode do
  begin
    CalcBarCodeSize(FEngine.Canvas);
    DrawBarcode(FEngine.Canvas, DrawLeft, DrawTop, LPoint, True);
  end;

{$IFDEF RB90Up}
  if aDrawBarcode.Border.Visible then
  begin
    Engine.Pen.Color := aDrawBarcode.Border.Color;
    Engine.Pen.Style := aDrawBarcode.Border.Style;
    Engine.Pen.Width := Round(aDrawBarcode.Border.Weight * CPixelsPerInch /
      CInchesToPoints);
    if (bpLeft in aDrawBarcode.Border.BorderPositions) then
      IgtDocumentEngine(Engine).Line(aDrawBarcode.DrawLeft,
        aDrawBarcode.DrawTop, aDrawBarcode.DrawLeft, aDrawBarcode.DrawBottom);
    if (bpTop in aDrawBarcode.Border.BorderPositions) then
      IgtDocumentEngine(Engine).Line(aDrawBarcode.DrawLeft,
        aDrawBarcode.DrawTop, aDrawBarcode.DrawRight, aDrawBarcode.DrawTop);
    if (bpRight in aDrawBarcode.Border.BorderPositions) then
      IgtDocumentEngine(Engine).Line(aDrawBarcode.DrawRight,
        aDrawBarcode.DrawTop, aDrawBarcode.DrawRight, aDrawBarcode.DrawBottom);
    if (bpBottom in aDrawBarcode.Border.BorderPositions) then
      IgtDocumentEngine(Engine).Line(aDrawBarcode.DrawLeft,
        aDrawBarcode.DrawBottom, aDrawBarcode.DrawRight,
        aDrawBarcode.DrawBottom);
  end;
{$ENDIF}
end;

procedure TgtRBXport.DrawImage(aDrawImage: TppDrawImage);
var
  LUniqueImage: Boolean;
  LReuseImageIndex: Integer;
  LMetafile: TMetafile;
  LMetafileCanvas: TMetafileCanvas;
  LRect: TgtRect;
  LTRect: TRect;
  LX, LY: Integer;
  LHalfLineWidth: Double;
  LW, LH, LDW, LDH: Double;
  LAspectRatio: Double;

begin
  if FEngine.EngineStatus = esCancelled then
    Exit;
  if (aDrawImage = nil) or (aDrawImage.Picture = nil) or
    (aDrawImage.Picture.Graphic = nil) or
    (aDrawImage.Picture.Graphic.Empty) then
    Exit;

  Engine.Brush.Style := bsClear;
  Engine.Pen.Style := psClear;
  Engine.ImageSettings.Stretch := aDrawImage.Stretch;
{$IFNDEF RB110Up}
  Engine.ImageSettings.Center := aDrawImage.Center;
{$ENDIF}
{$IFDEF RB110Up}
  if (aDrawImage.AlignHorizontal = ahCenter) and
    (aDrawImage.AlignVertical = avCenter) then
    Engine.ImageSettings.Center := True
  else
    Engine.ImageSettings.Center := False;
{$ENDIF}
  Engine.ImageSettings.KeepAspectRatio := aDrawImage.MaintainAspectRatio;
  Engine.ImageSettings.Transparent := aDrawImage.Transparent;

  if ((not MetafileAsRaster) and (aDrawImage.Picture.Graphic is TMetafile)) then
  begin
{$IFNDEF RB110Up}
    if (not aDrawImage.Stretch) and (not aDrawImage.Center) then
    begin
      with aDrawImage.DrawRect do
        IgtDocumentEngine(FEngine).PlayMetafile(Left, Top,
          TMetafile(aDrawImage.Picture.Graphic));
{$ENDIF}
{$IFDEF RB110Up}
      if (not aDrawImage.Stretch) then
      begin
        LMetafile := TMetafile.Create;
        LMetafileCanvas := TMetafileCanvas.Create(LMetafile, 0);
        if (aDrawImage.AlignHorizontal = ahLeft) and
          (aDrawImage.AlignVertical = avTop) then
        begin
          LX := aDrawImage.DrawLeft;
          LY := aDrawImage.DrawTop;
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end
        else if (aDrawImage.AlignHorizontal = ahCenter) and
          (aDrawImage.AlignVertical = avTop) then
        begin
          LX := aDrawImage.DrawLeft +
            Round((Abs(aDrawImage.DrawLeft - aDrawImage.DrawRight) -
            aDrawImage.Picture.Graphic.Width) / 2);
          LY := aDrawImage.DrawTop;
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end
        else if (aDrawImage.AlignHorizontal = ahRight) and
          (aDrawImage.AlignVertical = avTop) then
        begin
          LX := aDrawImage.DrawRight - aDrawImage.Picture.Graphic.Width;
          LY := aDrawImage.DrawTop;
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end
        else if (aDrawImage.AlignHorizontal = ahLeft) and
          (aDrawImage.AlignVertical = avCenter) then
        begin
          LY := aDrawImage.DrawTop +
            Round((Abs(aDrawImage.DrawTop - aDrawImage.DrawBottom) -
            aDrawImage.Picture.Graphic.Height) / 2);
          LX := aDrawImage.DrawLeft;
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end
        else if (aDrawImage.AlignHorizontal = ahCenter) and
          (aDrawImage.AlignVertical = avCenter) then
        begin
          LY := aDrawImage.DrawTop +
            Round((Abs(aDrawImage.DrawTop - aDrawImage.DrawBottom) -
            aDrawImage.Picture.Graphic.Height) / 2);
          LX := aDrawImage.DrawLeft +
            Round((Abs(aDrawImage.DrawLeft - aDrawImage.DrawRight) -
            aDrawImage.Picture.Graphic.Width) / 2);
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end
        else if (aDrawImage.AlignHorizontal = ahRight) and
          (aDrawImage.AlignVertical = avCenter) then
        begin
          LY := aDrawImage.DrawTop +
            Round((Abs(aDrawImage.DrawTop - aDrawImage.DrawBottom) -
            aDrawImage.Picture.Graphic.Height) / 2);
          LX := aDrawImage.DrawRight - aDrawImage.Picture.Width;
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end
        else if (aDrawImage.AlignHorizontal = ahLeft) and
          (aDrawImage.AlignVertical = avBottom) then
        begin
          LX := aDrawImage.DrawLeft;
          LY := aDrawImage.DrawBottom - aDrawImage.Picture.Height;
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end
        else if (aDrawImage.AlignHorizontal = ahCenter) and
          (aDrawImage.AlignVertical = avBottom) then
        begin
          LX := aDrawImage.DrawLeft +
            Round((Abs(aDrawImage.DrawLeft - aDrawImage.DrawRight) -
            aDrawImage.Picture.Graphic.Width) / 2);
          LY := aDrawImage.DrawBottom - aDrawImage.Picture.Height;
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end
        else if (aDrawImage.AlignHorizontal = ahRight) and
          (aDrawImage.AlignVertical = avBottom) then
        begin
          LX := aDrawImage.DrawRight - aDrawImage.Picture.Graphic.Width;
          LY := aDrawImage.DrawBottom - aDrawImage.Picture.Height;
          IgtDocumentEngine(FEngine).PlayMetafile(LX, LY,
            TMetafile(aDrawImage.Picture.Graphic));
        end;
        LMetafileCanvas.Free;
        LMetafile.Free;
{$ENDIF}
        Exit;
      end
      else
      begin
        LMetafile := TMetafile.Create;
        LMetafile.Width := Abs(aDrawImage.DrawLeft - aDrawImage.DrawRight);
        LMetafile.Height := Abs(aDrawImage.DrawTop - aDrawImage.DrawBottom);
        LMetafileCanvas := TMetafileCanvas.Create(LMetafile, 0);
        if (aDrawImage.Stretch) then
        begin
          with aDrawImage.DrawRect do
          begin
            if (aDrawImage.MaintainAspectRatio) then
            begin
              LTRect.Left := Left;
              LTRect.Top := Top;
              LTRect.Right := aDrawImage.Picture.Graphic.Width +
                Min((aDrawImage.DrawRight - aDrawImage.Picture.Graphic.Width),
                (aDrawImage.DrawBottom - aDrawImage.Picture.Graphic.Height));
              LTRect.Bottom := aDrawImage.Picture.Graphic.Height +
                Min((aDrawImage.DrawRight - aDrawImage.Picture.Graphic.Width),
                (aDrawImage.DrawBottom - aDrawImage.Picture.Graphic.Height));
              LMetafileCanvas.StretchDraw(LTRect, aDrawImage.Picture.Graphic);
            end
            else
            begin
              LMetafileCanvas.StretchDraw(aDrawImage.DrawRect,
                aDrawImage.Picture.Graphic);
            end;
          end;
          LMetafileCanvas.Free;
          with aDrawImage.DrawRect do
          begin
            LRect.Left := 0;
            LRect.Top := 0;
            LRect.Right := Abs(Right - Left);
            LRect.Bottom := Abs(Bottom - Top);
          end;
          IgtDocumentEngine(FEngine).PlayMetafile(LRect, LMetafile);
        end
        else
{$IFNDEF RB110Up}
          if (aDrawImage.Center) then
        begin
          LX := Round((Abs(aDrawImage.DrawLeft - aDrawImage.DrawRight) -
            aDrawImage.Picture.Graphic.Width) / 2);
          LY := Round((Abs(aDrawImage.DrawTop - aDrawImage.DrawBottom) -
            aDrawImage.Picture.Graphic.Height) / 2);
          LMetafileCanvas.Draw(LX, LY, aDrawImage.Picture.Graphic);
          LMetafileCanvas.Free;
          with aDrawImage.DrawRect do
          begin
            LRect.Left := Left;
            LRect.Top := Top;
            LRect.Right := Right;
            LRect.Bottom := Bottom;
          end;
          IgtDocumentEngine(FEngine).PlayMetafile(LRect, LMetafile);
        end;
{$ENDIF}
        LMetafile.Free;
        Exit;
      end;
    end;

    LUniqueImage := True;
    LReuseImageIndex := -1;
    if Assigned(EncodeGraphic) then
      EncodeGraphic(TObject(aDrawImage.Picture), LUniqueImage,
        LReuseImageIndex);
    if LUniqueImage then
    begin
      if aDrawImage.Stretch
      then { removed comments to fix image drawing twice when stretch=false(rtfengine) }
      begin { removed comments to fix image drawing twice when stretch=false(rtfengine) }
        with aDrawImage.DrawRect do
          Engine.DrawImage(gtRect(Left, Top, Right, Bottom),
            aDrawImage.Picture.Graphic);
{$IFDEF RB110Up}
      end { removed comments to fix image drawing twice when stretch=false(rtfengine) }
      else { removed comments to fix image drawing twice when stretch=false(rtfengine) }
        if not aDrawImage.Stretch then
      begin
        if (aDrawImage.AlignHorizontal = ahCenter) and
          (aDrawImage.AlignVertical = avTop) then
        begin
          LX := aDrawImage.DrawLeft +
            Round((Abs(aDrawImage.DrawLeft - aDrawImage.DrawRight) -
            aDrawImage.Picture.Graphic.Width) / 2);
          LY := aDrawImage.DrawTop;
          Engine.DrawImage(gtRect(LX, LY, aDrawImage.DrawRight,
            aDrawImage.DrawBottom), aDrawImage.Picture.Graphic);
        end
        else if (aDrawImage.AlignHorizontal = ahRight) and
          (aDrawImage.AlignVertical = avTop) then
        begin
          LX := aDrawImage.DrawRight - aDrawImage.Picture.Graphic.Width;
          LY := aDrawImage.DrawTop;
          Engine.DrawImage(gtRect(LX, LY, aDrawImage.DrawRight,
            aDrawImage.DrawBottom), aDrawImage.Picture.Graphic);
        end
        else if (aDrawImage.AlignHorizontal = ahLeft) and
          (aDrawImage.AlignVertical = avTop) then
        begin
          with aDrawImage.DrawRect do
            Engine.DrawImage(gtRect(Left, Top, Right, Bottom),
              aDrawImage.Picture.Graphic);
        end
        else if (aDrawImage.AlignHorizontal = ahLeft) and
          (aDrawImage.AlignVertical = avCenter) then
        begin
          LY := aDrawImage.DrawTop +
            Round((Abs(aDrawImage.DrawTop - aDrawImage.DrawBottom) -
            aDrawImage.Picture.Graphic.Height) / 2);
          LX := aDrawImage.DrawLeft;
          Engine.DrawImage(gtRect(LX, LY, aDrawImage.DrawRight,
            aDrawImage.DrawBottom), aDrawImage.Picture.Graphic);
        end
        else if (aDrawImage.AlignHorizontal = ahCenter) and
          (aDrawImage.AlignVertical = avCenter) then
        begin
          LY := aDrawImage.DrawTop +
            Round((Abs(aDrawImage.DrawTop - aDrawImage.DrawBottom) -
            aDrawImage.Picture.Graphic.Height) / 2);
          LX := aDrawImage.DrawLeft +
            Round((Abs(aDrawImage.DrawLeft - aDrawImage.DrawRight) -
            aDrawImage.Picture.Graphic.Width) / 2);
          Engine.DrawImage(gtRect(LX, LY, aDrawImage.DrawRight,
            aDrawImage.DrawBottom), aDrawImage.Picture.Graphic);
        end
        else if (aDrawImage.AlignHorizontal = ahRight) and
          (aDrawImage.AlignVertical = avCenter) then
        begin
          LY := aDrawImage.DrawTop +
            Round((Abs(aDrawImage.DrawTop - aDrawImage.DrawBottom) -
            aDrawImage.Picture.Graphic.Height) / 2);
          LX := aDrawImage.DrawRight - aDrawImage.Picture.Width;
          Engine.DrawImage(gtRect(LX, LY, aDrawImage.DrawRight,
            aDrawImage.DrawBottom), aDrawImage.Picture.Graphic);
        end
        else if (aDrawImage.AlignHorizontal = ahLeft) and
          (aDrawImage.AlignVertical = avBottom) then
        begin
          LX := aDrawImage.DrawLeft;
          LY := aDrawImage.DrawBottom - aDrawImage.Picture.Height;
          Engine.DrawImage(gtRect(LX, LY, aDrawImage.DrawRight,
            aDrawImage.DrawBottom), aDrawImage.Picture.Graphic);
        end
        else if (aDrawImage.AlignHorizontal = ahCenter) and
          (aDrawImage.AlignVertical = avBottom) then
        begin
          LX := aDrawImage.DrawLeft +
            Round((Abs(aDrawImage.DrawLeft - aDrawImage.DrawRight) -
            aDrawImage.Picture.Graphic.Width) / 2);
          LY := aDrawImage.DrawBottom - aDrawImage.Picture.Height;
          Engine.DrawImage(gtRect(LX, LY, aDrawImage.DrawRight,
            aDrawImage.DrawBottom), aDrawImage.Picture.Graphic);
        end
        else if (aDrawImage.AlignHorizontal = ahRight) and
          (aDrawImage.AlignVertical = avBottom) then
        begin
          LX := aDrawImage.DrawRight - aDrawImage.Picture.Graphic.Width;
          LY := aDrawImage.DrawBottom - aDrawImage.Picture.Height;
          Engine.DrawImage(gtRect(LX, LY, aDrawImage.DrawRight,
            aDrawImage.DrawBottom), aDrawImage.Picture.Graphic);
        end;
      end;
{$ENDIF}
      // end;
    end
    else
    begin
      if LReuseImageIndex = -1 then
        LReuseImageIndex := Engine.AddImageAsResource
          (aDrawImage.Picture.Graphic);
      with aDrawImage.DrawRect do
        Engine.DrawImage(gtRect(Left, Top, Right, Bottom), LReuseImageIndex);
    end;

{$IFDEF RB90Up}
    if aDrawImage.Border.Visible then
    begin

      Engine.Pen.Color := aDrawImage.Border.Color;
      Engine.Pen.Style := aDrawImage.Border.Style;
      Engine.Pen.Width := Round(aDrawImage.Border.Weight * CPixelsPerInch /
        CInchesToPoints);

      // Make sure the border corners are correct. We need to correct for the
      // the line width when drawing.
      LHalfLineWidth := Engine.Pen.Width / 2;

      // Calculate border rect
      if aDrawImage.MaintainAspectRatio or False then
      begin

        LW := aDrawImage.Picture.Graphic.Width;
        LH := aDrawImage.Picture.Graphic.Height;
        LDW := aDrawImage.DrawRight - aDrawImage.DrawLeft;
        LDH := aDrawImage.DrawBottom - aDrawImage.DrawTop;

        if ((LW > LDW) or (LH > LDH)) then
        begin

          if (LW > 0) and (LH > 0) then
          begin

            LAspectRatio := LW / LH;

            if LW > LH then
            begin
              LW := LDW;
              LH := LDW / LAspectRatio;
              if LH > LDH then
              begin
                LH := LDH;
                LW := LDH * LAspectRatio;
              end;
            end
            else
            begin
              LH := LDH;
              LW := LDH * LAspectRatio;
              if LW > LDW then
              begin
                LW := LDW;
                LH := LDW / LAspectRatio;
              end;
            end;
          end
          else
          begin
            LW := LDW;
            LH := LDH;
          end;

        end
        else
        begin
          if (LDW < LW) or (LDH < LH) then
          begin
            LW := LDW;
            LH := LDH;
          end;
        end;
{$IFNDEF RB110Up}
        if aDrawImage.Center then
{$ENDIF}
{$IFDEF RB110Up}
          if (aDrawImage.AlignHorizontal = ahCenter) and
            (aDrawImage.AlignVertical = avCenter) then
{$ENDIF}
          begin
            LTRect.Left := aDrawImage.DrawLeft + Round((LDW - LW) / 2);
            LTRect.Top := aDrawImage.DrawTop + Round((LDH - LH) / 2);
          end
          else
          begin
            LTRect.Left := aDrawImage.DrawLeft;
            LTRect.Top := aDrawImage.DrawTop;
          end;

        LTRect.Right := LTRect.Left + Round(LW);
        LTRect.Bottom := LTRect.Top + Round(LH);

      end
      else
      begin
        LTRect := aDrawImage.DrawRect;
      end;

      if (bpLeft in aDrawImage.Border.BorderPositions) then
        IgtDocumentEngine(Engine).Line(LTRect.Left, LTRect.Top - LHalfLineWidth,
          LTRect.Left, LTRect.Bottom + LHalfLineWidth);

      if (bpTop in aDrawImage.Border.BorderPositions) then
        IgtDocumentEngine(Engine).Line(LTRect.Left - LHalfLineWidth, LTRect.Top,
          LTRect.Right + LHalfLineWidth, LTRect.Top);

      if (bpRight in aDrawImage.Border.BorderPositions) then
        IgtDocumentEngine(Engine).Line(LTRect.Right,
          LTRect.Top - LHalfLineWidth, LTRect.Right,
          LTRect.Bottom + LHalfLineWidth);

      if (bpBottom in aDrawImage.Border.BorderPositions) then
        IgtDocumentEngine(Engine).Line(LTRect.Left - LHalfLineWidth,
          LTRect.Bottom, LTRect.Right + LHalfLineWidth, LTRect.Bottom);

    end;
{$ENDIF}
    if Assigned(EncodeGraphicDone) then
      EncodeGraphicDone(TObject(aDrawImage.Picture), LReuseImageIndex);
  end;

  procedure TgtRBXport.DrawLine(aDrawLine: TppDrawLine);
  var
    liOffset: Integer;
    liLines: Integer;
    liLine: Integer;
    llSize: Longint;
    llPosition: Longint;
  begin
    if FEngine.EngineStatus = esCancelled then
      Exit;

    if (aDrawLine.LinePosition = lpLeft) or
      (aDrawLine.LinePosition = lpRight) then
      llSize := Round(aDrawLine.Weight * CPixelsPerInch / 72)
    else
      llSize := Round(aDrawLine.Weight * CPixelsPerInch / 72);

    { if pen width is zero, print a hairline }
    if llSize = 0 then
      llSize := 1;

    { how many lines to draw? }
    if aDrawLine.LineStyle = lsSingle then
      liLines := 1
    else
      liLines := 2;

    { set actual pen width to one, to honor Pen.Style for wide lines }
    IgtDocumentEngine(FEngine).Pen := aDrawLine.Pen;
    IgtDocumentEngine(FEngine).Pen.Width := 1;

    for liLine := 1 to liLines do
    begin
      if (liLine = 1) then
        liOffset := 0
      else if (aDrawLine.Pen.Width = 0) then
        liOffset := 2
      else
        liOffset := llSize * 2;

      for llPosition := 0 to llSize - 1 do
        case aDrawLine.LinePosition of
          lpTop:
            begin
              IgtDocumentEngine(FEngine).Line(aDrawLine.DrawLeft,
                aDrawLine.DrawTop + liOffset + llPosition, aDrawLine.DrawRight,
                aDrawLine.DrawTop + liOffset + llPosition);
            end;
          lpBottom:
            begin
              IgtDocumentEngine(FEngine).Line(aDrawLine.DrawLeft,
                aDrawLine.DrawBottom - liOffset - llPosition,
                aDrawLine.DrawRight, aDrawLine.DrawBottom - liOffset -
                llPosition);
            end;
          lpLeft:
            begin
              IgtDocumentEngine(FEngine)
                .Line(aDrawLine.DrawLeft + liOffset + llPosition,
                aDrawLine.DrawTop, aDrawLine.DrawLeft + liOffset + llPosition,
                aDrawLine.DrawBottom);
            end;
          lpRight:
            begin
              IgtDocumentEngine(FEngine)
                .Line(aDrawLine.DrawRight - liOffset - llPosition,
                aDrawLine.DrawTop, aDrawLine.DrawRight - liOffset - llPosition,
                aDrawLine.DrawBottom);
            end;
{$IFDEF RB110Up}
          lpDiagRight:
            begin
              IgtDocumentEngine(FEngine)
                .Line(aDrawLine.DrawRight - liOffset - llPosition,
                aDrawLine.DrawTop, aDrawLine.DrawLeft + liOffset + llPosition,
                aDrawLine.DrawBottom);
            end;
          lpDiagLeft:
            begin
              IgtDocumentEngine(FEngine)
                .Line(aDrawLine.DrawLeft + liOffset + llPosition,
                aDrawLine.DrawTop, aDrawLine.DrawRight - liOffset - llPosition,
                aDrawLine.DrawBottom);
            end;
{$ENDIF}
        end; { case, line style }
    end; { for, each line }
  end; { procedure, DrawLine }

  procedure TgtRBXport.DrawShape(aDrawShape: TppDrawShape);
  var
    liXCornerRound: Integer;
    liYCornerRound: Integer;
  begin
    if FEngine.EngineStatus = esCancelled then
      Exit;

    if ((aDrawShape.Pen.Style = psClear) and
      (aDrawShape.Brush.Style = bsClear)) then
      Exit;
    { assign pen and brush }
    IgtDocumentEngine(FEngine).Pen := aDrawShape.Pen;
    IgtDocumentEngine(FEngine).Brush := aDrawShape.Brush;

    { get pen width }
    { convert pen width to printer pixels }
    // IgtDocumentEngine(FEngine).Pen.Width := Trunc(aDrawShape.Pen.Width * FConversionFactor);
    if (IgtDocumentEngine(FEngine).Pen.Width = 0) then
      { if pen width is zero, print a hairline }
      IgtDocumentEngine(FEngine).Pen.Width := 1;

    { draw shape }
    case aDrawShape.ShapeType of
      ExtCtrls.stRectangle:
        if (aDrawShape.Brush.Style = bsClear) then
          IgtDocumentEngine(FEngine)
            .PolyLine([gtPoint(aDrawShape.DrawLeft, aDrawShape.DrawTop),
            gtPoint(aDrawShape.DrawRight, aDrawShape.DrawTop),
            gtPoint(aDrawShape.DrawRight, aDrawShape.DrawBottom),
            gtPoint(aDrawShape.DrawLeft, aDrawShape.DrawBottom),
            gtPoint(aDrawShape.DrawLeft, aDrawShape.DrawTop)])
        else
          IgtDocumentEngine(FEngine).Rectangle(aDrawShape.DrawLeft,
            aDrawShape.DrawTop, aDrawShape.DrawRight,
            aDrawShape.DrawBottom, True);
      ExtCtrls.stEllipse:
        IgtDocumentEngine(FEngine).Ellipse(aDrawShape.DrawLeft,
          aDrawShape.DrawTop, aDrawShape.DrawRight,
          aDrawShape.DrawBottom, True);

      ExtCtrls.stRoundRect:
        begin
          liXCornerRound := Trunc(aDrawShape.XCornerRound * FConversionFactor);
          liYCornerRound := Trunc(aDrawShape.YCornerRound * FConversionFactor);

          IgtDocumentEngine(FEngine).RoundRect(aDrawShape.DrawLeft,
            aDrawShape.DrawTop, aDrawShape.DrawRight, aDrawShape.DrawBottom,
            liXCornerRound, liYCornerRound, True);
        end; { case, RoundRect }
    end; { case, ShapeType }
  end; { procedure, DrawShape }

  procedure TgtRBXport.DrawText(aDrawText: TppDrawText);
  var
    LI, I: Integer;
    LX, LY: Double;
    Val: String;
    Tabs: TStringList;
    LDontTextOut: Boolean;
    LText: WideString;

    function GetMaxTextIndex(LDrawText: TppDrawText): Integer;
    var
      LJ: Integer;
      LK: Double;
    begin
      Result := 0;
      LK := 0;
      for LJ := 0 to LDrawText.WrappedText.Count - 1 do
      begin
        if LK < FEngine.TextWidth(LDrawText.WrappedText.Strings[LJ]) then
        begin
          LK := FEngine.TextWidth(LDrawText.WrappedText.Strings[LJ]);
          Result := LJ;
        end;
      end;
    end;

    function IsSymbolCharset(const FaceName: string): Boolean;
    var
      LList: TList;
    begin
      LList := TList.Create;
      try
        GetSupportedCharSets(FaceName, LList);
        Result := ((LList.Count = 1) and (Byte(LList.Items[0]) = 2));
      finally
        LList.Free;
      end;
    end;

  begin
    if TppDrawText(aDrawText).IsMemo then
    begin
      Tabs := TStringList.Create;
      try
        Tabs.AddStrings(TppDrawText(aDrawText).TabStopPositions);
        for I := 0 to (aDrawText.WrappedText.Count - 1) do
        begin
          Val := ConvertTabsToSpaces(aDrawText.WrappedText.Strings[I],
            TppDrawText(aDrawText).Font, Tabs);
          aDrawText.WrappedText.Strings[I] := Val;
        end;
      finally
        Tabs.Free;
      end;
    end;
    case aDrawText.TextAlignment of
      taRightJustified:
        IgtDocumentEngine(FEngine).TextFormatting.Alignment := haRight;
      taCentered:
        IgtDocumentEngine(FEngine).TextFormatting.Alignment := haCenter;
    else
      IgtDocumentEngine(FEngine).TextFormatting.Alignment := haLeft;
    end;
    IgtDocumentEngine(FEngine).SetTextAlignment(IgtDocumentEngine(FEngine)
      .TextFormatting.Alignment);
    if FEngine.EngineStatus = esCancelled then
      Exit;
    Engine.Font := aDrawText.Font;
    Engine.Font.Size := Abs(aDrawText.Font.Size);

    if aDrawText.WrappedText.Count > 0 then
    begin
      // Adjust for Percentage Magic in RB Preview!
      LI := GetMaxTextIndex(aDrawText);
      // with aDrawText.DrawRect do
      // begin
      // while (((Right - Left) <
      // Round(FEngine.TextWidth(aDrawText.WrappedText.Strings[LI]))) and
      // (Engine.Font.Size >= 8)) do
      // begin
      // Engine.Font.Size := Engine.Font.Size - 1;
      // end;
      // // while (((Bottom - Top) < Round(aDrawText.WrappedText.Count * FEngine.TextHeight(aDrawText.WrappedText.Strings[0]))) and
      // // (Engine.Font.Size >= 5)) do
      // while (((Bottom - Top) <
      // Round(FEngine.TextHeight(aDrawText.WrappedText.Strings[0]))) and
      // (Engine.Font.Size >= 5)) do
      // begin
      // Engine.Font.Size := Engine.Font.Size - 1;
      // end;
      // end;
    end;

{$IFDEF RB90Up}
    Engine.SetTextRotation(aDrawText.Angle);
    if aDrawText.Border.Visible then
    begin
      Engine.Pen.Color := aDrawText.Border.Color;
      Engine.Pen.Style := aDrawText.Border.Style;
      Engine.Pen.Width := Round(aDrawText.Border.Weight * CPixelsPerInch /
        CInchesToPoints);
      if (bpLeft in aDrawText.Border.BorderPositions) then
        IgtDocumentEngine(Engine).Line(aDrawText.DrawLeft, aDrawText.DrawTop,
          aDrawText.DrawLeft, aDrawText.DrawBottom);
      if (bpTop in aDrawText.Border.BorderPositions) then
        IgtDocumentEngine(Engine).Line(aDrawText.DrawLeft, aDrawText.DrawTop,
          aDrawText.DrawRight, aDrawText.DrawTop);
      if (bpRight in aDrawText.Border.BorderPositions) then
        IgtDocumentEngine(Engine).Line(aDrawText.DrawRight, aDrawText.DrawTop,
          aDrawText.DrawRight, aDrawText.DrawBottom);
      if (bpBottom in aDrawText.Border.BorderPositions) then
        IgtDocumentEngine(Engine).Line(aDrawText.DrawLeft, aDrawText.DrawBottom,
          aDrawText.DrawRight, aDrawText.DrawBottom);
    end;
{$ENDIF}
    LY := aDrawText.DrawTop;
{$IFDEF RB90Up}
    if (aDrawText.Angle <> 0) then
      LY := aDrawText.DrawBottom - (FEngine.TextHeight(aDrawText.Text) *
        Cos(aDrawText.Angle * Pi / 180));
{$ENDIF}
    // For Memo and wrapped Label
    if aDrawText.WrappedText.Count > 0 then
    begin
      Engine.Brush.Color := aDrawText.Color;
      if (not aDrawText.Transparent) then
      begin
        Engine.Pen.Style := psClear;
        Engine.Brush.Style := bsSolid;
        Engine.Brush.Color := aDrawText.Color;
        with aDrawText.DrawRect do
          Engine.Rectangle(Left, Top, Right, Bottom, True);
      end;
      Engine.Brush.Style := bsClear;
      LI := 0;
      while (LI < aDrawText.WrappedText.Count) do
      begin
        with aDrawText.WrappedText do
        begin
          // '$¶' means CRLF
          Strings[LI] := ReplaceString(Strings[LI], '$¶', CRLF);
          case aDrawText.TextAlignment of
            taCentered:
              LX := (aDrawText.DrawRight + aDrawText.DrawLeft -
                FEngine.TextWidth(Strings[LI])) / 2;
            taRightJustified:
              LX := aDrawText.DrawRight - FEngine.TextWidth(Strings[LI]);
          else
            LX := aDrawText.DrawLeft;
          end;
          if (aDrawText.TextAlignment = taFullJustified) then
          begin
            if (LI = aDrawText.WrappedText.Count - 1) then
            begin
              if (aDrawText.ForceJustifyLastLine) then
                Strings[LI] := GetJustifiedText(Strings[LI], Engine.Font,
                  aDrawText.DrawRight - aDrawText.DrawLeft);
            end
            // Empty line need not be justified
            else if (Strings[LI] <> CRLF) then
            begin
              if (RightStr(Strings[LI], 2) <> CRLF) then
                Strings[LI] := GetJustifiedText(Strings[LI], Engine.Font,
                  aDrawText.DrawRight - aDrawText.DrawLeft);
            end
            else if (Strings[LI] = CRLF) then
              Insert(LI + 1, '');
          end;

          if (Strings[LI] <> CRLF) then
          begin
            LDontTextOut := False;
            LText := Strings[LI];
            if (Assigned(GlobalOnDrawText)) then
              GlobalOnDrawText(aDrawText, FEngine, LText, LX, LY, LDontTextOut);
            if not LDontTextOut then
              Engine.TextOut(LX, LY, LText);
          end;

          if ((not aDrawText.IsMemo) and (aDrawText.AutoSize)) or
            ((aDrawText.IsMemo) and (not aDrawText.AutoSize)) then
            LY := LY + FEngine.TextHeight(Strings[LI])
          else
            LY := LY + (aDrawText.DrawBottom - aDrawText.DrawTop) / Count;

          Inc(LI);
        end;
      end;
    end
    // For unwrapped Label and Checkbox
    else if aDrawText.Text <> '' then
    begin
      case aDrawText.TextAlignment of
        taCentered:
          begin
{$IFDEF RB90Up}
            LX := (aDrawText.DrawRight + aDrawText.DrawLeft) / 2 -
              (FEngine.TextHeight(aDrawText.Text) * Sin(aDrawText.Angle * Pi /
              180)) / 2 - (FEngine.TextWidth(aDrawText.Text) *
              Cos(aDrawText.Angle * Pi / 180)) / 2;
            if (aDrawText.Angle <> 0) then
              LY := (aDrawText.DrawTop + aDrawText.DrawBottom) / 2 +
                (FEngine.TextWidth(aDrawText.Text) * Sin(aDrawText.Angle * Pi /
                180)) / 2;
{$ELSE}
            LX := (aDrawText.DrawRight + aDrawText.DrawLeft -
              FEngine.TextWidth(aDrawText.Text)) / 2;
{$ENDIF}
          end;
        taRightJustified:
          begin
{$IFDEF RB90Up}
            LX := aDrawText.DrawRight -
              (FEngine.TextHeight(aDrawText.Text) * Sin(aDrawText.Angle * Pi /
              180)) - (FEngine.TextWidth(aDrawText.Text) *
              Cos(aDrawText.Angle * Pi / 180));
            LY := aDrawText.DrawTop + (FEngine.TextWidth(aDrawText.Text) *
              Sin(aDrawText.Angle * Pi / 180));
{$ELSE}
            LX := aDrawText.DrawRight - FEngine.TextWidth(aDrawText.Text);
{$ENDIF}
          end
      else
        LX := aDrawText.DrawLeft;
      end;
{$IFDEF RB90Up}
      if (aDrawText.TextAlignment = taLeftJustified) then
      begin
        if (aDrawText.Angle > 0) and (aDrawText.Angle <= 90) then
        begin
          LX := aDrawText.DrawRect.Left;
          LY := aDrawText.DrawRect.Bottom -
            (FEngine.TextHeight(aDrawText.Text) *
            Cos(aDrawText.Angle * Pi / 180));
        end;
        if (aDrawText.Angle > 90) and (aDrawText.Angle <= 180) then
        begin
          LX := aDrawText.DrawRect.Right -
            (FEngine.TextHeight(aDrawText.Text) *
            Sin(aDrawText.Angle * Pi / 180));
          LY := aDrawText.DrawRect.Bottom;
        end;
        if (aDrawText.Angle > 180) and (aDrawText.Angle <= 270) then
        begin
          LX := aDrawText.DrawRect.Right;
          LY := aDrawText.DrawRect.Top +
            (FEngine.TextHeight(aDrawText.Text) *
            -Cos(aDrawText.Angle * Pi / 180));
        end;
        if (aDrawText.Angle > 270) and (aDrawText.Angle <= 360) then
        begin
          LX := aDrawText.DrawRect.Left +
            (FEngine.TextHeight(aDrawText.Text) *
            -Sin(aDrawText.Angle * Pi / 180));
          LY := aDrawText.DrawRect.Top;
        end;
      end;
      if ((aDrawText.TextAlignment = taRightJustified)) then
      begin
        if (aDrawText.Angle = 0) then
        begin
          LX := aDrawText.DrawRect.Right - FEngine.TextWidth(aDrawText.Text);
          LY := aDrawText.DrawRect.Top;
        end;
        if (aDrawText.Angle = 90) then
        begin
          LX := aDrawText.DrawRect.Left;
          LY := aDrawText.DrawRect.Top + FEngine.TextWidth(aDrawText.Text);
        end;
        if (aDrawText.Angle = 180) then
        begin
          LX := aDrawText.DrawRect.Left + FEngine.TextWidth(aDrawText.Text);
          LY := aDrawText.DrawRect.Bottom;
        end;
        if (aDrawText.Angle = 270) then
        begin
          LX := aDrawText.DrawRect.Right;
          LY := aDrawText.DrawRect.Bottom - FEngine.TextWidth(aDrawText.Text);
        end;
      end;
      if ((aDrawText.TextAlignment = taCentered)) then
      begin
        if (aDrawText.Angle = 0) then
        begin
          LX := ((aDrawText.DrawRect.Left + aDrawText.DrawRect.Right) / 2) -
            (FEngine.TextWidth(aDrawText.Text) / 2);
          LY := aDrawText.DrawRect.Top;
        end;
        if (aDrawText.Angle = 90) then
        begin
          LX := aDrawText.DrawRect.Left;
          LY := ((aDrawText.DrawRect.Bottom + aDrawText.DrawRect.Top) / 2) -
            (FEngine.TextWidth(aDrawText.Text) / 2);
        end;
        if (aDrawText.Angle = 180) then
        begin
          LX := ((aDrawText.DrawRect.Left + aDrawText.DrawRect.Right) / 2) -
            (FEngine.TextWidth(aDrawText.Text) / 2);;
          LY := aDrawText.DrawRect.Bottom;
        end;
        if (aDrawText.Angle = 270) then
        begin
          LX := aDrawText.DrawRect.Right;
          LY := ((aDrawText.DrawRect.Bottom + aDrawText.DrawRect.Top) / 2) -
            (FEngine.TextWidth(aDrawText.Text) / 2);
        end;
      end;
{$ENDIF}
      if (IsSymbolCharset(aDrawText.Font.Name)) then
      begin
        LY := LY - 4;
      end;
      Engine.Brush.Color := aDrawText.Color;
      if (not aDrawText.Transparent) then
      begin
        Engine.Pen.Style := psClear;
        Engine.Brush.Style := bsSolid;
        Engine.Brush.Color := aDrawText.Color;
        with aDrawText.DrawRect do
          if (aDrawText.AutoSize) then
            Engine.Rectangle(LX, LY, LX + FEngine.TextWidth(aDrawText.Text),
              LY + FEngine.TextHeight(aDrawText.Text), True)
          else
            Engine.Rectangle(Left, Top, Right, Bottom, True);
      end;
      Engine.Brush.Style := bsClear;
      LDontTextOut := False;
      LText := aDrawText.Text;
      if (Assigned(GlobalOnDrawText)) then
        GlobalOnDrawText(aDrawText, FEngine, LText, LX, LY, LDontTextOut);
      if not LDontTextOut then
        with aDrawText.DrawRect do
          // If not AutoSize, text needs to be clipped
          if (not aDrawText.AutoSize) then
            Engine.TextRect(gtRect(Left, Top, Right, Bottom), LX, LY, LText)
          else
            Engine.TextOut(LX, LY, LText);
    end;
  end;

  procedure TgtRBXport.EndJob;
  begin
    inherited;
    if FParent is TgtRBExportInterface then
      TgtRBExportInterface(FParent).EndDocument
    else
      Engine.EndDoc;
  end;

  procedure TgtRBXport.EndPage(aPage: TppPage);
  begin

  end;

  function TgtRBXport.GetEngine: IgtDocumentEngine;
  begin
    Result := IgtDocumentEngine(FEngine);
  end;

  procedure TgtRBXport.ReceivePage(aPage: TppPage);
  var
    I: Integer;
  begin
    inherited ReceivePage(aPage);
    if (IsRequestedPage) then
    begin
      DisplayMessage(aPage);
      if IsMessagePage then
        Exit;

      BeginPage(aPage);
      try
        FCurrentPage := aPage;
        for I := 0 to aPage.DrawCommandCount - 1 do
          Draw(aPage.DrawCommands[I]);
      finally
        EndPage(aPage);
        FCurrentPage := nil;
      end;
    end;
  end;

  procedure TgtRBXport.StartJob;
  begin
    Engine.FileName := FileName;
    FEngine.ReferencePoint := rpPage;
    FEngine.InputXRes := Screen.PixelsPerInch;
    FEngine.InputYRes := Screen.PixelsPerInch;
  end;

  { TgtRBExportInterface }

  constructor TgtRBExportInterface.Create(AOwner: TComponent);
  begin
    inherited;
  end;

  destructor TgtRBExportInterface.Destroy;
  begin
    inherited;
  end;

  function TgtRBExportInterface.GetEncodeGraphic: TgtEncodeGraphicEvent;
  begin
    Result := FEncodeGraphic;
    EncodeGraphic := FEncodeGraphic;
  end;

  function TgtRBExportInterface.GetOnDrawText: TgtDrawTextEvent;
  begin
    Result := GlobalOnDrawText;
  end;

  function TgtRBExportInterface.GetOnEncodeGraphicDone
    : TgtEncodeGraphicDoneEvent;
  begin
    Result := FEncodeGraphicDone;
    EncodeGraphicDone := FEncodeGraphicDone;
  end;

  procedure TgtRBExportInterface.RenderDocument(Report: TppReport);
  var
    LExport: TgtRBXport;
  begin
    if Engine = nil then
      Exit;
    LExport := FFilterClass.Create(Self, Engine);
    LExport.Publisher := Report.Publisher;
    LExport.FileName := IgtDocumentEngine(Engine).FileName;
    Report.PrintToDevices;
    LExport.Free;
  end;

  procedure TgtRBExportInterface.SetEngine(const Value
    : TgtCustomDocumentEngine);

{$IFNDEF NOGlobalSettingsVar}
    procedure SetGlobalEngine(AFilterClass: TgtRBXportClass;
      AValue: TgtCustomDocumentEngine);
    begin
      if AFilterClass = TgtRBPDFXport then
        PDFEngine := TgtPDFEngine(AValue)
      else if AFilterClass = TgtRBRTFXport then
        RTFEngine := TgtRTFEngine(AValue)
      else if AFilterClass = TgtRBHTMLXport then
        HTMLEngine := TgtHTMLEngine(AValue)
      else if AFilterClass = TgtRBXHTMLXport then
        XHTMLEngine := TgtXHTMLEngine(AValue)
      else
{$IFDEF gtPro}
        if AFilterClass = TgtRBSVGXport then
        SVGEngine := TgtSVGEngine(AValue)
      else if AFilterClass = TgtRBTIFFXport then
        TIFFEngine := TgtTIFFEngine(AValue)
      else if AFilterClass = TgtRBPNGXport then
        PNGEngine := TgtPNGEngine(AValue)
      else
{$ENDIF}
        if AFilterClass = TgtRBJPEGXport then
        JPEGEngine := TgtJPEGEngine(AValue)
      else if AFilterClass = TgtRBGIFXport then
        GIFEngine := TgtGIFEngine(AValue)
      else if AFilterClass = TgtRBEMFXport then
        EMFEngine := TgtEMFEngine(AValue)
      else if AFilterClass = TgtRBWMFXport then
        WMFEngine := TgtWMFEngine(AValue)
      else if AFilterClass = TgtRBBMPXport then
        BMPEngine := TgtBMPEngine(AValue)
      else if AFilterClass = TgtRBExcelXport then
        ExcelEngine := TgtExcelEngine(AValue)
      else if AFilterClass = TgtRBXLSXport then
        XLSEngine := TgtXLSEngine(AValue)
      else if AFilterClass = TgtRBQuattroProXport then
        QuattroProEngine := TgtQuattroProEngine(AValue)
      else if AFilterClass = TgtRBLotusXport then
        LotusEngine := TgtLotusEngine(AValue)
      else if AFilterClass = TgtRBDIFXport then
        DIFEngine := TgtDIFEngine(AValue)
      else if AFilterClass = TgtRBSYLKXport then
        SYLKEngine := TgtSYLKEngine(AValue)
      else if AFilterClass = TgtRBTextXport then
        TextEngine := TgtTextEngine(AValue)
    end;
{$ENDIF}
    procedure SetFilterSettings;
    begin
      if Value is TgtPDFEngine then
        FFilterClass := TgtRBPDFXport
      else if Value is TgtRTFEngine then
        FFilterClass := TgtRBRTFXport
      else if Value is TgtXHTMLEngine then
        FFilterClass := TgtRBXHTMLXport
      else if Value is TgtHTMLEngine then
        FFilterClass := TgtRBHTMLXport
      else
{$IFDEF gtPro}
        if Value is TgtSVGEngine then
        FFilterClass := TgtRBSVGXport
      else if Value is TgtTIFFEngine then
        FFilterClass := TgtRBTIFFXport
      else if Value is TgtPNGEngine then
        FFilterClass := TgtRBPNGXport
      else
{$ENDIF}
        if Value is TgtJPEGEngine then
        FFilterClass := TgtRBJPEGXport
      else if Value is TgtGIFEngine then
        FFilterClass := TgtRBGIFXport
      else if Value is TgtEMFEngine then
        FFilterClass := TgtRBEMFXport
      else if Value is TgtWMFEngine then
        FFilterClass := TgtRBWMFXport
      else if Value is TgtBMPEngine then
        FFilterClass := TgtRBBMPXport
      else if Value is TgtExcelEngine then
        FFilterClass := TgtRBExcelXport
      else if Value is TgtXLSEngine then
        FFilterClass := TgtRBXLSXport
      else if Value is TgtQuattroProEngine then
        FFilterClass := TgtRBQuattroProXport
      else if Value is TgtLotusEngine then
        FFilterClass := TgtRBLotusXport
      else if Value is TgtDIFEngine then
        FFilterClass := TgtRBDIFXport
      else if Value is TgtSYLKEngine then
        FFilterClass := TgtRBSYLKXport
      else if Value is TgtTextEngine then
        FFilterClass := TgtRBTextXport;
    end;

  begin
    if Visible and (FFilterClass <> nil) then
      ppUnRegisterDevice(FFilterClass);
{$IFNDEF NOGlobalSettingsVar}
    SetGlobalEngine(FFilterClass, nil);
{$ENDIF}
    SetFilterSettings;
{$IFNDEF NOGlobalSettingsVar}
    SetGlobalEngine(FFilterClass, Value);
{$ENDIF}
    if Visible then
      ppRegisterDevice(FFilterClass);

    inherited Engine := Value;
  end;

  procedure TgtRBExportInterface.SetMetafileAsRasterImage(const Value: Boolean);
  begin
    FMetafileAsRasterImage := Value;
    MetafileAsRaster := Value;
  end;

  procedure TgtRBExportInterface.SetOnDrawText(const Value: TgtDrawTextEvent);
  begin
    GlobalOnDrawText := Value;
  end;

  procedure TgtRBExportInterface.SetOnEncodeGraphic
    (const Value: TgtEncodeGraphicEvent);
  begin
    FEncodeGraphic := Value;
    EncodeGraphic := Value;
  end;

  procedure TgtRBExportInterface.SetOnEncodeGraphicDone
    (const Value: TgtEncodeGraphicDoneEvent);
  begin
    FEncodeGraphicDone := Value;
    EncodeGraphicDone := Value;
  end;

  procedure TgtRBExportInterface.SetVisible(const Value: Boolean);
  begin
    if Value <> Visible then
    begin
      inherited Visible := Value;
      if Visible then
        ppRegisterDevice(FFilterClass)
      else
        ppUnRegisterDevice(FFilterClass);
    end;
  end;

  { TgtRBPDFXport }

  constructor TgtRBPDFXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if PDFEngine <> nil then
      FEngine := PDFEngine
    else
{$ENDIF}
      FEngine := TgtPDFEngine.Create(AOwner);
  end;

  class function TgtRBPDFXport.DefaultExt: string;
  begin
    Result := 'pdf';
  end;

  class function TgtRBPDFXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      PDFEngine.FileDescription
{$ELSE}
      SPDFDescription
{$ENDIF}
      + '(*.pdf)|*.pdf|All files|*.*';
  end;

  class function TgtRBPDFXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := PDFEngine.FileDescription;
{$ELSE}
    Result := SPDFDescription;
{$ENDIF}
  end;

  { TgtRBRTFXport }

  constructor TgtRBRTFXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if RTFEngine <> nil then
      FEngine := RTFEngine
    else
{$ENDIF}
      FEngine := TgtRTFEngine.Create(AOwner);
  end;

  class function TgtRBRTFXport.DefaultExt: string;
  begin
    Result := 'rtf';
  end;

  class function TgtRBRTFXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      RTFEngine.FileDescription
{$ELSE}
      SRTFDescription
{$ENDIF}
      + '(*.rtf)|*.rtf|All files|*.*';
  end;

  class function TgtRBRTFXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := RTFEngine.FileDescription;
{$ELSE}
    Result := SRTFDescription;
{$ENDIF}
  end;

  { TgtRBTextXport }

  constructor TgtRBTextXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if TextEngine <> nil then
      FEngine := TextEngine
    else
{$ENDIF}
      FEngine := TgtTextEngine.Create(AOwner);
  end;

  class function TgtRBTextXport.DefaultExt: string;
  begin
    Result := 'txt';
  end;

  class function TgtRBTextXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      TextEngine.FileDescription
{$ELSE}
      STextDescription
{$ENDIF}
      + '(*.txt)|*.txt|All files|*.*';
  end;

  class function TgtRBTextXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := TextEngine.FileDescription;
{$ELSE}
    Result := STextDescription;
{$ENDIF}
  end;

  { TgtRBWMFXport }

  constructor TgtRBWMFXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if WMFEngine <> nil then
      FEngine := WMFEngine
    else
{$ENDIF}
      FEngine := TgtWMFEngine.Create(AOwner);
  end;

  class function TgtRBWMFXport.DefaultExt: string;
  begin
    Result := 'wmf';
  end;

  class function TgtRBWMFXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      WMFEngine.FileDescription
{$ELSE}
      SWMFDescription
{$ENDIF}
      + '(*.wmf)|*.wmf|All files|*.*';
  end;

  class function TgtRBWMFXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := WMFEngine.FileDescription;
{$ELSE}
    Result := SWMFDescription;
{$ENDIF}
  end;

  { TgtRBEMFXport }

  constructor TgtRBEMFXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if EMFEngine <> nil then
      FEngine := EMFEngine
    else
{$ENDIF}
      FEngine := TgtEMFEngine.Create(AOwner);
  end;

  class function TgtRBEMFXport.DefaultExt: string;
  begin
    Result := 'emf';
  end;

  class function TgtRBEMFXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      EMFEngine.FileDescription
{$ELSE}
      SEMFDescription
{$ENDIF}
      + '(*.emf)|*.emf|All files|*.*';
  end;

  class function TgtRBEMFXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := EMFEngine.FileDescription;
{$ELSE}
    Result := SEMFDescription;
{$ENDIF}
  end;

  { TgtRBBMPXport }

  constructor TgtRBBMPXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if BMPEngine <> nil then
      FEngine := BMPEngine
    else
{$ENDIF}
      FEngine := TgtBMPEngine.Create(AOwner);
  end;

  class function TgtRBBMPXport.DefaultExt: string;
  begin
    Result := 'bmp';
  end;

  class function TgtRBBMPXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      BMPEngine.FileDescription
{$ELSE}
      SBMPDescription
{$ENDIF}
      + '(*.bmp)|*.bmp|All files|*.*';
  end;

  class function TgtRBBMPXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := BMPEngine.FileDescription;
{$ELSE}
    Result := SBMPDescription;
{$ENDIF}
  end;

  { TgtRBGIFXport }

  constructor TgtRBGIFXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if GIFEngine <> nil then
      FEngine := GIFEngine
    else
{$ENDIF}
      FEngine := TgtGIFEngine.Create(AOwner);
  end;

  class function TgtRBGIFXport.DefaultExt: string;
  begin
    Result := 'gif';
  end;

  class function TgtRBGIFXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      GIFEngine.FileDescription
{$ELSE}
      SGIFDescription
{$ENDIF}
      + '(*.gif)|*.gif|All files|*.*';
  end;

  class function TgtRBGIFXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := GIFEngine.FileDescription;
{$ELSE}
    Result := SGIFDescription;
{$ENDIF}
  end;

  { TgtRBJPEGXport }

  constructor TgtRBJPEGXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if JPEGEngine <> nil then
      FEngine := JPEGEngine
    else
{$ENDIF}
      FEngine := TgtJPEGEngine.Create(AOwner);
  end;

  class function TgtRBJPEGXport.DefaultExt: string;
  begin
    Result := 'jpg';
  end;

  class function TgtRBJPEGXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      JPEGEngine.FileDescription
{$ELSE}
      SJPEGDescription
{$ENDIF}
      + '(*.jpg)|*.jpg|All files|*.*';
  end;

  class function TgtRBJPEGXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := JPEGEngine.FileDescription;
{$ELSE}
    Result := SJPEGDescription;
{$ENDIF}
  end;

  { TgtRBPNGXport }
{$IFDEF gtPro}

  constructor TgtRBPNGXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if PNGEngine <> nil then
      FEngine := PNGEngine
    else
{$ENDIF}
      FEngine := TgtPNGEngine.Create(AOwner);
  end;

  class function TgtRBPNGXport.DefaultExt: string;
  begin
    Result := 'png';
  end;

  class function TgtRBPNGXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      PNGEngine.FileDescription
{$ELSE}
      SPNGDescription
{$ENDIF}
      + '(*.png)|*.png|All files|*.*';
  end;

  class function TgtRBPNGXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := PNGEngine.FileDescription;
{$ELSE}
    Result := SPNGDescription;
{$ENDIF}
  end;

  { TgtRBTIFFXport }

  constructor TgtRBTIFFXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if TIFFEngine <> nil then
      FEngine := TIFFEngine
    else
{$ENDIF}
      FEngine := TgtTIFFEngine.Create(AOwner);
  end;

  class function TgtRBTIFFXport.DefaultExt: string;
  begin
    Result := 'tiff';
  end;

  class function TgtRBTIFFXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      TIFFEngine.FileDescription
{$ELSE}
      STIFFDescription
{$ENDIF}
      + '(*.tiff)|*.tiff|All files|*.*';
  end;

  class function TgtRBTIFFXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := TIFFEngine.FileDescription;
{$ELSE}
    Result := STIFFDescription;
{$ENDIF}
  end;
{$ENDIF}
  { TgtRBSYLKXport }

  constructor TgtRBSYLKXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if SYLKEngine <> nil then
      FEngine := SYLKEngine
    else
{$ENDIF}
      FEngine := TgtSYLKEngine.Create(AOwner);
  end;

  class function TgtRBSYLKXport.DefaultExt: string;
  begin
    Result := 'sylk';
  end;

  class function TgtRBSYLKXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      SYLKEngine.FileDescription
{$ELSE}
      SSYLKDescription
{$ENDIF}
      + '(*.sylk)|*.sylk|All files|*.*';
  end;

  class function TgtRBSYLKXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := SYLKEngine.FileDescription;
{$ELSE}
    Result := SSYLKDescription;
{$ENDIF}
  end;

  { TgtRBDIFXport }

  constructor TgtRBDIFXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if DIFEngine <> nil then
      FEngine := DIFEngine
    else
{$ENDIF}
      FEngine := TgtDIFEngine.Create(AOwner);
  end;

  class function TgtRBDIFXport.DefaultExt: string;
  begin
    Result := 'dif';
  end;

  class function TgtRBDIFXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      DIFEngine.FileDescription
{$ELSE}
      SDIFDescription
{$ENDIF}
      + '(*.dif)|*.dif|All files|*.*';
  end;

  class function TgtRBDIFXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := DIFEngine.FileDescription;
{$ELSE}
    Result := SDIFDescription;
{$ENDIF}
  end;

  { TgtRBLotusXport }

  constructor TgtRBLotusXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if LotusEngine <> nil then
      FEngine := LotusEngine
    else
{$ENDIF}
      FEngine := TgtLotusEngine.Create(AOwner);
  end;

  class function TgtRBLotusXport.DefaultExt: string;
  begin
    Result := 'wk1';
  end;

  class function TgtRBLotusXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      LotusEngine.FileDescription
{$ELSE}
      SLotusDescription
{$ENDIF}
      + '(*.wk1)|*.wk1|All files|*.*';
  end;

  class function TgtRBLotusXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := LotusEngine.FileDescription;
{$ELSE}
    Result := SLotusDescription;
{$ENDIF}
  end;

  { TgtRBQuattroProXport }

  constructor TgtRBQuattroProXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if QuattroProEngine <> nil then
      FEngine := QuattroProEngine
    else
{$ENDIF}
      FEngine := TgtQuattroProEngine.Create(AOwner);
  end;

  class function TgtRBQuattroProXport.DefaultExt: string;
  begin
    Result := 'wb1';
  end;

  class function TgtRBQuattroProXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      QuattroProEngine.FileDescription
{$ELSE}
      SQuattroProDescription
{$ENDIF}
      + '(*.wb1)|*.wb1|All files|*.*';
  end;

  class function TgtRBQuattroProXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := QuattroProEngine.FileDescription;
{$ELSE}
    Result := SQuattroProDescription;
{$ENDIF}
  end;

  { TgtRBExcelXport }

  constructor TgtRBExcelXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if ExcelEngine <> nil then
      FEngine := ExcelEngine
    else
{$ENDIF}
      FEngine := TgtExcelEngine.Create(AOwner);
  end;

  class function TgtRBExcelXport.DefaultExt: string;
  begin
    Result := 'xlsx';
  end;

  class function TgtRBExcelXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      ExcelEngine.FileDescription
{$ELSE}
      SExcelDescription
{$ENDIF}
      + '(*.xlsx)|*.xlsx|All files|*.*';
  end;

  class function TgtRBExcelXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := ExcelEngine.FileDescription;
{$ELSE}
    Result := SExcelDescription;
{$ENDIF}
  end;

  { TgtRBXLSXport }
  constructor TgtRBXLSXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if XLSEngine <> nil then
      FEngine := XLSEngine
    else
{$ENDIF}
      FEngine := TgtXLSEngine.Create(AOwner);
  end;

  class function TgtRBXLSXport.DefaultExt: string;
  begin
    Result := 'xls';
  end;

  class function TgtRBXLSXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      XLSEngine.FileDescription
{$ELSE}
      SExcelDescription
{$ENDIF}
      + '(*.xls)|*.xls|All files|*.*';
  end;

  class function TgtRBXLSXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := XLSEngine.FileDescription;
{$ELSE}
    Result := SExcelDescription;
{$ENDIF}
  end;

  { TgtRBSVGXport }
{$IFDEF gtPro}

  constructor TgtRBSVGXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if SVGEngine <> nil then
      FEngine := SVGEngine
    else
{$ENDIF}
      FEngine := TgtSVGEngine.Create(AOwner);
  end;

  class function TgtRBSVGXport.DefaultExt: string;
  begin
    Result := 'svg';
  end;

  class function TgtRBSVGXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      SVGEngine.FileDescription
{$ELSE}
      SSVGDescription
{$ENDIF}
      + '(*.svg)|*.svg|All files|*.*';
  end;

  class function TgtRBSVGXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := SVGEngine.FileDescription;
{$ELSE}
    Result := SSVGDescription;
{$ENDIF}
  end;
{$ENDIF}
  { TgtRBXHTMLXport }

  constructor TgtRBXHTMLXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if XHTMLEngine <> nil then
      FEngine := XHTMLEngine
    else
{$ENDIF}
      FEngine := TgtXHTMLEngine.Create(AOwner);
  end;

  class function TgtRBXHTMLXport.DefaultExt: string;
  begin
    Result := 'htm';
  end;

  class function TgtRBXHTMLXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      XHTMLEngine.FileDescription
{$ELSE}
      SXHTMLDescription
{$ENDIF}
      + '(*.htm)|*.htm|All files|*.*';
  end;

  class function TgtRBXHTMLXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := XHTMLEngine.FileDescription;
{$ELSE}
    Result := SXHTMLDescription;
{$ENDIF}
  end;

  { TgtRBHTMLXport }

  constructor TgtRBHTMLXport.Create(AOwner: TComponent);
  begin
    inherited;
{$IFNDEF NOGlobalSettingsVar}
    if HTMLEngine <> nil then
      FEngine := HTMLEngine
    else
{$ENDIF}
      FEngine := TgtHTMLEngine.Create(AOwner);
  end;

  class function TgtRBHTMLXport.DefaultExt: string;
  begin
    Result := 'htm';
  end;

  class function TgtRBHTMLXport.DefaultExtFilter: string;
  begin
    Result :=
{$IFNDEF NOGlobalSettingsVar}
      HTMLEngine.FileDescription
{$ELSE}
      SHTMLDescription
{$ENDIF}
      + '(*.htm)|*.htm|All files|*.*';
  end;

  class function TgtRBHTMLXport.DeviceDescription(aLanguageIndex
    : Integer): string;
  begin
{$IFNDEF NOGlobalSettingsVar}
    Result := HTMLEngine.FileDescription;
{$ELSE}
    Result := SHTMLDescription;
{$ENDIF}
  end;

  procedure TgtRBXport.DrawRichText(aDrawRichText: TppDrawRichText);
  var
    lCharRange: TCharRange;
    lSaveFont: TFont;
{$IFDEF RB70UP}
    lRichEdit: TCustomRichEdit;
{$ELSE}
    lRichEdit: TppRichEdit;
{$ENDIF}
    LMetaCanvas: TMetafileCanvas;
    LMetafile: TMetafile;
    LMetaCanvas1: TMetafileCanvas;
    LMetafile1: TMetafile;
    LRect: TRect;
    LPrinter: TppPrinter;
    LHDC: HRGN;
    liSize: Integer;
    liWidth, liHeight: Integer;
  begin
    if FEngine.EngineStatus = esCancelled then
      Exit;
    lSaveFont := TFont.Create;
{$IFDEF RB70UP}
    lRichEdit := ppCreateRichEdit(nil);
{$ELSE}
    lRichEdit := TppRichEdit.Create(nil);
    lRichEdit.Visible := False;
    lRichEdit.Parent := Application.MainForm;
{$ENDIF}
    LMetafile := TMetafile.Create;

    if (aDrawRichText.RichTextStream.Size > 0) then
    begin
      liSize := aDrawRichText.RichTextStream.Size;
      ppSetOrdPropValue(lRichEdit, 'MaxLength', liSize);
    end;

    try
      aDrawRichText.RichTextStream.Position := 0;
{$IFDEF RB70UP}
      ppGetRichEditLines(lRichEdit).LoadFromStream
        (aDrawRichText.RichTextStream);
{$ELSE}
      lRichEdit.Lines.LoadFromStream(aDrawRichText.RichTextStream);
{$ENDIF}
      lCharRange.cpMin := aDrawRichText.StartCharPos;
      lCharRange.cpMax := aDrawRichText.EndCharPos;

      LPrinter := ppPrinter;
      if ((FCurrentPage <> nil) and (LPrinter <> nil)) then
        LPrinter.PrinterSetup.Assign(FCurrentPage.PrinterSetup);

      if (LPrinter <> nil) and (LPrinter.DC <> 0) then
      Begin
        LHDC := LPrinter.DC;
        liWidth := Round(aDrawRichText.Width / 1000.0 *
          (CMMToInches * LPrinter.PixelsPerInch.X));
        liHeight := Round(aDrawRichText.Height / 1000.0 *
          (CMMToInches * LPrinter.PixelsPerInch.Y));
      end
      else
      Begin
        LHDC := GetDC(0);
        liWidth := Round(aDrawRichText.Width / 1000.0 *
          (CMMToInches * Screen.PixelsPerInch));
        liHeight := Round(aDrawRichText.Height / 1000.0 *
          (CMMToInches * Screen.PixelsPerInch));
      end;

      LMetafile.Width := liWidth;
      LMetafile.Height := liHeight;
      LMetaCanvas := TMetafileCanvas.Create(LMetafile, LHDC);
      lSaveFont.Assign(LMetaCanvas.Font);
      if not aDrawRichText.Transparent then
      begin
        LMetaCanvas.CopyMode := cmSrcCopy;
        LMetaCanvas.Brush.Style := bsSolid;
        LMetaCanvas.Brush.Color := aDrawRichText.Color;
        LMetaCanvas.FillRect(Rect(0, 0, liWidth, liHeight));
      end;

      LMetaCanvas.Brush.Style := bsClear;
      LRect := Rect(0, 0, liWidth, liHeight);

{$IFDEF RB70UP}
      TppRTFEngine.DrawRichText(lRichEdit, LMetaCanvas.Handle, LHDC, LRect,
        lCharRange);
{$ELSE}
      ppGetRTFEngine(lRichEdit).DrawRichText(LMetaCanvas.Handle, LHDC, LRect,
        lCharRange);
{$ENDIF}
      LMetaCanvas.Font.Assign(lSaveFont);
      LMetaCanvas.Free;
      if ((LPrinter = nil) or (LPrinter.DC = 0)) then
        ReleaseDC(0, LHDC);

      with aDrawRichText.DrawRect do
      begin
        LMetafile1 := TMetafile.Create;
        try
          LMetafile1.Width := Abs(Left - Right);
          LMetafile1.Height := Abs(Top - Bottom);
          LMetaCanvas1 := TMetafileCanvas.Create(LMetafile1, 0);
          LMetaCanvas1.StretchDraw(Rect(0, 0, Abs(Left - Right) + 1,
            Abs(Top - Bottom) + 1), LMetafile);
          LMetaCanvas1.Free;
          IgtDocumentEngine(FEngine).PlayMetafile(Left, Top, LMetafile1);
        finally
          LMetafile1.Free;
        end;
      end;
    finally
      LMetafile.Free;
      lSaveFont.Free;
      lRichEdit.Free;
    end;
  end;

{$IFDEF BUILDER_CONTROLS}

  function TgtRBXport.CalcRect(ACanvas: TCanvas; MaxWidth: Integer;
    const AText: string): TRect;
  begin
    Result := Rect(0, 0, MaxWidth, 0);
    Windows.DrawText(ACanvas.Handle, PChar(AText), -1, Result, DT_EXPANDTABS or
      DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX);
  end;

  function TgtRBXport.CalcClientRect(Canvas: TCanvas; Angle: Integer;
    ARect: TRect; var APoint: TPoint): TRect;
  type
    TVector = record
      X: Real;
      Y: Real;
    end;

  var
    cur: TVector;

    procedure GetBounds(const V: TVector);
    begin
      if V.X > Result.Right then
        Result.Right := Trunc(V.X) + 1
      else if V.X < Result.Left then
        Result.Left := Trunc(V.X);

      if V.Y > Result.Bottom then
        Result.Bottom := Trunc(V.Y) + 1
      else if V.Y < Result.Top then
        Result.Top := Trunc(V.Y);
    end;

    function ExtendedNeg(const V: TVector): TVector;
    begin
      Result.X := -V.X;
      Result.Y := -V.Y;
    end;

    function CalcVector(V: TVector): TPoint;
    begin
      cur.X := cur.X + V.X;
      cur.Y := cur.Y + V.Y;

      GetBounds(cur);

      Result.X := Trunc(cur.X);
      Result.Y := Trunc(cur.Y);
    end;

  var
    ver, hor: TVector;
    RadAngle: Real;
    Displacement: TPoint;
    VectList: array [0 .. 3] of TPoint;
  begin
    cur.X := ARect.Left;
    cur.Y := ARect.Top;

    Result := Rect(ARect.Left, ARect.Top, ARect.Left, ARect.Top);
    RadAngle := (Angle * Pi / 180.0);

    ver.X := Sin(RadAngle) * (ARect.Bottom - ARect.Top);
    ver.Y := Cos(RadAngle) * (ARect.Bottom - ARect.Top);

    hor.X := Cos(RadAngle) * (ARect.Right - ARect.Left);
    hor.Y := -Sin(RadAngle) * (ARect.Right - ARect.Left);

    VectList[0] := CalcVector(ver);
    VectList[1] := CalcVector(hor);
    VectList[2] := CalcVector(ExtendedNeg(ver));
    VectList[3] := CalcVector(ExtendedNeg(hor));

    Displacement.X := ARect.Left - Result.Left;
    Displacement.Y := ARect.Top - Result.Top;

    APoint := Point(ARect.Left + Displacement.X, ARect.Top + Displacement.Y);

    Inc(Result.Left, Displacement.X);
    Inc(Result.Right, Displacement.X);
    Inc(Result.Top, Displacement.Y);
    Inc(Result.Bottom, Displacement.Y);
  end;

  procedure TgtRBXport.DrawRotatedText(aDrawRotatedText: TDrawRotatedText);
  var
    lTextMetric: TTextMetric;
    lTopIncrement, lLeftIncrement: Integer;
    lClientRect: TRect;
    lClientOrigin: TPoint;
  begin
    if FEngine.EngineStatus = esCancelled then
      Exit;

    if (FCanvas.Font.CharSet <> aDrawRotatedText.Font.CharSet) or
      (FCanvas.Font.Color <> aDrawRotatedText.Font.Color) or
      (FCanvas.Font.Pitch <> aDrawRotatedText.Font.Pitch) or
      (FCanvas.Font.Size <> aDrawRotatedText.Font.Size) or
      (FCanvas.Font.Style <> aDrawRotatedText.Font.Style) or
      (FCanvas.Font.Name <> aDrawRotatedText.Font.Name) then
      FCanvas.Font := aDrawRotatedText.Font;

    { calc line height }
    GetTextMetrics(FCanvas.Handle, lTextMetric);

    lTopIncrement := Round(aDrawRotatedText.Origin.Y);
    lLeftIncrement := Round(aDrawRotatedText.Origin.X);

    aDrawRotatedText.DrawTop := aDrawRotatedText.DrawTop + lTopIncrement;
    aDrawRotatedText.DrawLeft := aDrawRotatedText.DrawLeft + lLeftIncrement;

    if not aDrawRotatedText.Transparent then
    begin
      lClientRect := CalcRect(FCanvas, Screen.Width, aDrawRotatedText.Text);
      lClientRect := CalcClientRect(FCanvas, aDrawRotatedText.Angle,
        lClientRect, lClientOrigin);

      OffsetRect(lClientRect, aDrawRotatedText.DrawLeft - lClientOrigin.X,
        aDrawRotatedText.DrawTop - lClientOrigin.Y);

      FCanvas.Brush.Style := bsSolid;
      FCanvas.Brush.Color := aDrawRotatedText.Color;
      FCanvas.FillRect(lClientRect);
    end;

    SetBkMode(FCanvas.Handle, Windows.Transparent);
    ppTextOutRotate(FCanvas, FCanvas.Font, aDrawRotatedText.DrawLeft,
      aDrawRotatedText.DrawTop, aDrawRotatedText.Angle, aDrawRotatedText.Text);
  end;

  procedure TgtRBXport.DrawSimpleGrid(aDrawSimpleGrid: TDrawSimpleGrid);
  var
    I: Integer;
    VOffset, HOffset: Integer;
    DrawWidth, DrawHeight: Integer;
  begin
    with aDrawSimpleGrid do
    begin
      DrawWidth := DrawRight - DrawLeft;
      while Frac(DrawWidth / ColCount) <> 0 do
      begin
        DrawRight := DrawRight - 1;
        DrawWidth := DrawRight - DrawLeft;
      end;

      DrawHeight := DrawBottom - DrawTop;
      while Frac(DrawHeight / RowCount) <> 0 do
      begin
        DrawBottom := DrawBottom - 1;
        DrawHeight := DrawBottom - DrawTop;
      end;

      VOffset := DrawWidth div ColCount;
      HOffset := DrawHeight div RowCount;

      FCanvas.Brush.Assign(Brush);
      FCanvas.Pen.Assign(Pen);

      if not Transparent then
        FCanvas.FillRect(Rect(DrawLeft, DrawTop, DrawRight, DrawBottom));

      I := DrawLeft;
      while I <= DrawRight do
      begin
        FCanvas.MoveTo(I, DrawTop);
        FCanvas.LineTo(I, DrawBottom);
        Inc(I, VOffset);
      end;

      I := DrawTop;
      while I <= DrawBottom do
      begin
        FCanvas.MoveTo(DrawLeft, I);
        FCanvas.LineTo(DrawRight, I);
        Inc(I, HOffset);
      end;
    end;
  end;
{$ENDIF}
{$IFDEF WPRICHTEXT}

  procedure TgtRBXport.DrawWpRichText(aDrawWPRichText: TppDrawWPTRichText);
  var
    lRichText: TWPCustomRichText;
    LMetafile: TMetafile;
    LMetaCanvas: TMetafileCanvas;
    lForm: TForm;
    LUnit: TgtUnitType;
{$IFDEF WPRICHTEXT5}
    LXRes, LYRes: Integer;
{$ENDIF}
  begin
    LMetafile := TMetafile.Create;
    LMetaCanvas := TMetafileCanvas.Create(LMetafile, 0);

    // Setup RichText from Stream
    lForm := TForm.Create(nil);
    lRichText := TWPCustomRichText.Create(lForm);
    try
      lRichText.Parent := lForm;
      lRichText.Visible := False;
{$IFNDEF WPRICHTEXT5}
      lRichText.WYSIWYG := True;
      lRichText.ScreenResMode := rm1440;
{$ENDIF}
      aDrawWPRichText.RichTextStream.Position := 0;
      lRichText.LoadFromStream(aDrawWPRichText.RichTextStream);
      with lRichText.Header do
      begin
        LeftMargin := 0;
        RightMargin := 0;
        TopMargin := 0;
        BottomMargin := 0;
        PageWidth := Round(aDrawWPRichText.Width * CMMToPoints /
          (CTwipsToPoints * 1000)); // PageWidth in Twips
        PageHeight := 20 * Round(CInchesToPoints / CTwipsToPoints);
        // PageHeight=20 Inch in Twips
      end;
      // If not Transparent then draw backgroundcolor
      if not aDrawWPRichText.Transparent then
      begin
        LMetaCanvas.Brush.Style := bsSolid;
        LMetaCanvas.Brush.Color := aDrawWPRichText.Color;
        LMetaCanvas.FillRect(Rect(0, 0, aDrawWPRichText.Width,
          aDrawWPRichText.Height));
      end;

      // Draw the RichText to the metafile
{$IFDEF WPRICHTEXT5}
      lRichText.HeaderFooter.UpdateReformatMode(True);
      LXRes := GetDeviceCaps(LMetaCanvas.Handle, LOGPIXELSX);
      LYRes := GetDeviceCaps(LMetaCanvas.Handle, LOGPIXELSY);
      lRichText.Draw(LMetaCanvas, 0, 0,
        Round(aDrawWPRichText.Height * CMMToPoints / (CTwipsToPoints * 1000)),
        LXRes, LYRes, aDrawWPRichText.StartLine);
{$ELSE}
      lRichText.SetCompatibleViewport(LMetaCanvas.Handle);
      lRichText.Draw(LMetaCanvas, 0, 0,
        Round(aDrawWPRichText.Height * CMMToPoints / (CTwipsToPoints * 1000)),
        aDrawWPRichText.StartLine, 0);
{$ENDIF}
      LMetaCanvas.Free;
      LUnit := FEngine.MeasurementUnit;
      FEngine.MeasurementUnit := muMM;

      IgtDocumentEngine(FEngine).PlayMetafile(aDrawWPRichText.Left / 1000,
        aDrawWPRichText.Top / 1000, LMetafile);
      FEngine.MeasurementUnit := LUnit;
    finally
      LMetafile.Free;
      lRichText.Free;
      lForm.Free;
    end;
  end;
{$ENDIF}
{$IFDEF RICHVIEW}

  procedure TgtRBXport.DrawRichView(aDrawRichView: TppDrawRichView);
  var
    LMetafile: TMetafile;
    LMetaCanvas: TMetafileCanvas;
  begin
    LMetafile := TMetafile.Create;
    LMetafile.Width := aDrawRichView.DrawRect.Right -
      aDrawRichView.DrawRect.Left;
    LMetafile.Height := aDrawRichView.DrawRect.Bottom -
      aDrawRichView.DrawRect.Top;
    LMetaCanvas := TMetafileCanvas.Create(LMetafile, 0);
    try
      aDrawRichView.DrawTo(LMetaCanvas,
        Rect(0, 0, aDrawRichView.DrawRect.Right - aDrawRichView.DrawRect.Left,
        aDrawRichView.DrawRect.Bottom - aDrawRichView.DrawRect.Top));
      LMetaCanvas.Free;
      IgtDocumentEngine(FEngine).PlayMetafile(aDrawRichView.DrawRect.Left,
        aDrawRichView.DrawRect.Top, LMetafile);
    finally
      LMetafile.Free;
    end;
  end;
{$ENDIF}
{$IFDEF GRIDPACK}

  procedure TgtRBXport.DrawGridPackTableGrid(ADrawTableGrid: TrbDrawTableGrid);
  var
    LMetafile: TMetafile;
    LMetaCanvas: TMetafileCanvas;
  begin
    LMetafile := TMetafile.Create;
    LMetaCanvas := TMetafileCanvas.Create(LMetafile, 0);

    if not ADrawTableGrid.Transparent then
    begin
      LMetaCanvas.Brush.Color := ADrawTableGrid.Color;
      LMetaCanvas.Brush.Style := bsSolid;
      LMetaCanvas.FillRect(ADrawTableGrid.DrawRect);
    end;
    try
      ADrawTableGrid.DrawTableGrid(LMetaCanvas,
        Rect(0, 0, (ADrawTableGrid.DrawRect.Right -
        ADrawTableGrid.DrawRect.Left), (ADrawTableGrid.DrawRect.Bottom -
        ADrawTableGrid.DrawRect.Top)), 1, 1);
      LMetaCanvas.Free;
      IgtDocumentEngine(FEngine).PlayMetafile(ADrawTableGrid.DrawRect.Left,
        ADrawTableGrid.DrawRect.Top, LMetafile);
    finally
      LMetafile.Free;
    end;
  end;

  procedure TgtRBXport.DrawCheckBox(aDrawCheckBox: TrbDrawCheckBox);
  var
    LMetafile: TMetafile;
    LMetaCanvas: TMetafileCanvas;
  begin
    LMetafile := TMetafile.Create;
    LMetaCanvas := TMetafileCanvas.Create(LMetafile, 0);

    if not aDrawCheckBox.Transparent then
    begin
      LMetaCanvas.Brush.Color := aDrawCheckBox.Color;
      LMetaCanvas.Brush.Style := bsSolid;
      LMetaCanvas.FillRect(aDrawCheckBox.DrawRect);
    end;
    try

      aDrawCheckBox.DrawCheckBox(LMetaCanvas,
        Rect(0, 0, aDrawCheckBox.DrawRect.Right - aDrawCheckBox.DrawRect.Left,
        aDrawCheckBox.DrawRect.Bottom - aDrawCheckBox.DrawRect.Top), 1, 1);
      LMetaCanvas.Free;
      IgtDocumentEngine(FEngine).PlayMetafile(aDrawCheckBox.DrawRect.Left,
        aDrawCheckBox.DrawRect.Top, LMetafile);
    finally
      LMetafile.Free;
    end;
  end;

{$ENDIF}

end.
