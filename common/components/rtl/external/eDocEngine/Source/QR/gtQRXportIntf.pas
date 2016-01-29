{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I ..\gtDefines.inc}
{$I ..\gtDocDefines.inc}
{$I ..\gtExpIntf.inc}
// TO ENABLE: Remove the dot(.) before $DEFINE to look as {$DEFINE ...}
// TO DISABLE: Add a dot(.) before $DEFINE to look as {.$DEFINE ...}

// --- QuickReport Version Support ---
// If Enabled: Supports QuickReport versions v3.6.2 & above
// If Disabled: Supports QuickReport versions below v3.6.2
//{$DEFINE QR362up}

unit gtQRXportIntf;

interface
uses
  Windows, Classes, Graphics, SysUtils, QrPrntr, QuickRpt, Dialogs, QRPrgres,
  Forms, gtCstDocEng, gtXportIntf, Printers ;

type
  TgtQRXport_Base = class;

  TgtQRExportFilterClass = class of TgtQRXport_Base;

  TgtQRXport_Base = class(TQRExportFilter)
  private
    FLocalEngine: TgtCustomDocumentEngine;

  protected
    FEngine: TgtCustomDocumentEngine;
    FMetafile: TMetafile;
    function GetExtension: string; override;
    function GetFilterName: string; override;

  public
    procedure Finish; override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
  end;

  TgtQRPDFXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRRTFXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRHTMLXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRXHTMLXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  {$IFDEF gtPro}
  TgtQRSVGXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;
  {$ENDIF}

  TgtQRTextXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRExcelXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;
    TgtQRXLSXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;
  end;

  TgtQRQuattroProXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRSYLKXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRDIFXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRLotusXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRBMPXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRJPEGXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRGIFXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQREMFXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRWMFXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  {$IFDEF gtPro}
  TgtQRTIFFXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;

  TgtQRPNGXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;
  {$ENDIF}
  {$IFNDEF gtRE}
  TgtQRClipboardXport = class(TgtQRXport_Base)
  public
    procedure AfterConstruction; override;

  end;
  {$ENDIF}
  TgtQRExportInterface = class(TgtExportInterface)
  private
    FShowProgress: Boolean;
    FProgress: TQRProgressForm;
    function IsFilterNotInList: Boolean;
    procedure RemoveFilterClass;
    procedure AddFilterClass;
    {$IFNDEF NOGlobalSettingsVar}
    procedure SetFilterObject;
    procedure RemoveFilterObject;
    {$ENDIF}
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);
    procedure ExportQR(QRPrinter: TQRPrinter);
		procedure InitProgress(AQRPrinter: TQRPrinter);
    procedure EndProgress(AQRPrinter: TQRPrinter);
    procedure SetShowProgress(const Value: Boolean);
  protected
    FFilterClass: TgtQRExportFilterClass;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(AReport: TQuickRep;
      AlreadyPrepared: Boolean); overload;
    procedure RenderDocument(ACompositeReport: TQRCompositeReport;
      AlreadyPrepared: Boolean); overload;
    procedure RenderDocument(AQuickRepList: TList;
      AlreadyPrepared: Boolean); overload;
    procedure RenderDocument(AQRPFile: string); overload;

  published
    property Engine write SetEngine;
    property Visible write SetVisible;
    property ShowProgress: Boolean read FShowProgress write SetShowProgress
    	default True;
  end;

procedure Register;

implementation
uses
  gtConsts3,

  gtPDFEng, gtRTFEng, gtHTMLEng, gtXHTMLEng,
  gtTXTEng,
  gtXLSEng, gtQProEng, gtSLKEng, gtDIFEng, gtLotusEng,
  gtBMPEng, gtJPEGEng, gtGIFEng, gtEMFEng, gtWMFEng, gtXLS95Eng
  {$IFNDEF gtRE}
  , gtClipboard
  {$ENDIF}
  {$IFDEF gtPro}
     , gtSVGEng, gtTIFFEng, gtPNGEng
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
  {$IFNDEF gtRE}
  Clipboard: TgtClipboard;
  {$ENDIF}
{$ENDIF}

type
	TgtHackCstDocEngine = class(TgtCustomDocumentEngine)
	end;

{ TgtQRXport_Base }

procedure TgtQRXport_Base.AfterConstruction;
begin
  inherited;
end;

destructor TgtQRXport_Base.Destroy;
begin
  FreeAndNil(FLocalEngine);
  inherited;
end;

procedure TgtQRXport_Base.Finish;
var
  I: Integer;
  LMetafile: TMetafile;
begin
  if not (Owner is TCustomQuickRep) then
    Exit;
  with TCustomQuickRep(Owner) do
    if OriginalQRPrinter <> nil then
      with OriginalQRPrinter do
      begin
        try
          FEngine.MeasurementUnit := muPixels;
          IgtDocumentEngine(FEngine).FileName := Filename;
          IgtDocumentEngine(FEngine).Page.PaperSize := Custom;
          (* Convert To Pixels. *)
          IgtDocumentEngine(FEngine).Page.Orientation := Orientation;
          IgtDocumentEngine(FEngine).Page.Width :=  XPos(PaperWidthValue);
          IgtDocumentEngine(FEngine).Page.Height := YPos(PaperLengthValue);
          IgtDocumentEngine(FEngine).BeginDoc;
          for I := 1 to PageCount do
          begin
            LMetaFile := GetPage(I);
            if Assigned(LMetaFile) then
            begin
              if I > 1 then
                IgtDocumentEngine(FEngine).NewPage;
              try
                IgtDocumentEngine(FEngine).PlayMetafile(0, 0, LMetafile);
              finally
                LMetaFile.Free;
              end;
            end;
          end;
          IgtDocumentEngine(FEngine).EndDoc;
        finally

        end;
      end;
end;

function TgtQRXport_Base.GetExtension: string;
begin
  Result := IgtDocumentEngine(FEngine).FileExtension;
end;

function TgtQRXport_Base.GetFilterName: string;
begin
  Result := TgtCustomDocumentEngine(FEngine).FileDescription;
end;

{ TgtQRPDFXport }

procedure TgtQRPDFXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if PDFEngine <> nil then
    FEngine := PDFEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtPDFEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRExportInterface }

constructor TgtQRExportInterface.Create(AOwner: TComponent);
begin
  inherited;
  FShowProgress := True;
end;

destructor TgtQRExportInterface.Destroy;
begin
  if FFilterClass <> nil then
  begin
    {$IFNDEF NOGlobalSettingsVar}
    RemoveFilterObject;
    {$ENDIF}
    QRExportFilterLibrary.RemoveFilter(FFilterClass);
  end;
  inherited;
end;

procedure TgtQRExportInterface.RenderDocument(AReport: TQuickRep;
  AlreadyPrepared: Boolean);
var
  LRefPoint: TgtReferencePoint;
begin
	try
    if not AlreadyPrepared then
      AReport.Prepare;
    with IgtDocumentEngine(Engine) do
    begin
      case AReport.Units of
        MM: Engine.MeasurementUnit := muMM;
        Inches: Engine.MeasurementUnit := muInches;
        Pixels: Engine.MeasurementUnit := muPixels;
      else
        Engine.MeasurementUnit := muMM;
      end;
      with Page do
      begin
        PaperSize := Custom;
        // Check orientation......
        Orientation := AReport.QRPrinter.Orientation;
        Width := AReport.Page.Width;
        Height := AReport.Page.Length;
        LeftMargin := AReport.Page.LeftMargin;
        TopMargin := AReport.Page.TopMargin;
        RightMargin := AReport.Page.RightMargin;
        BottomMargin := AReport.Page.BottomMargin;
      end;
      StartDocument;
      LRefPoint := Engine.ReferencePoint;
      Engine.ReferencePoint := rpPage;
      ExportQR(AReport.QRPrinter);
      Engine.ReferencePoint := LRefPoint;
      EndDocument;
    end;
	finally
    if not AlreadyPrepared then
    begin
      AReport.QRPrinter.Free;
      AReport.QRPrinter := nil;
    end;
  end
end;

procedure TgtQRExportInterface.RenderDocument(
  ACompositeReport: TQRCompositeReport; AlreadyPrepared: Boolean);
begin
  try
    if not AlreadyPrepared then
      ACompositeReport.Prepare;
    with IgtDocumentEngine(Engine) do
    begin
      Engine.MeasurementUnit := muMM;
      with Page do
      begin
        PaperSize := Custom;
        //Check orientation....
        Orientation := TQuickRep(ACompositeReport.Reports[0]).QRPrinter.Orientation;
        Width := TQuickRep(ACompositeReport.Reports[0]).Page.Width / 10;
        Height := TQuickRep(ACompositeReport.Reports[0]).Page.Length / 10;
      end;
      StartDocument;
      ExportQR(TQuickRep(ACompositeReport.Reports[0]).QRPrinter);
      EndDocument;
    end;
  except
    raise Exception.Create('Composite Report Export Failed.');
  end;
end;

procedure TgtQRExportInterface.RenderDocument(AQuickRepList: TList;
  AlreadyPrepared: Boolean);
var
  I, J: Integer;
  LMetaFile: TMetafile;
begin
  try
    for I := 0 to AQuickRepList.Count - 1 do
    begin
      if not (TObject(AQuickRepList[I]) is TQuickRep) then
        Continue;

      if not AlreadyPrepared then
        TQuickRep(AQuickRepList[I]).Prepare;

      with IgtDocumentEngine(Engine).Page do
      begin
        case TQuickRep(AQuickRepList[I]).Units of
          MM: Engine.MeasurementUnit := muMM;
          Inches: Engine.MeasurementUnit := muInches;
          Pixels: Engine.MeasurementUnit := muPixels;
        else
          Engine.MeasurementUnit := muMM;
        end;
        PaperSize := Custom;
        // check orientation.....
        Orientation := TQuickRep(AQuickRepList[I]).QRPrinter.Orientation;
        Width := TQuickRep(AQuickRepList[I]).Page.Width;
        Height := TQuickRep(AQuickRepList[I]).Page.Length;
      end;

      with TQuickRep(AQuickRepList[I]) do
        for J := 1 to QRPrinter.PageCount do
        begin
          LMetaFile := QRPrinter.GetPage(J);
          if Assigned(LMetaFile) then
          begin
            if (I = 0) and (J = 1) then
              StartDocument
            else
              IgtDocumentEngine(Engine).NewPage;
            try
              IgtDocumentEngine(Engine).PlayMetafile(0, 0, LMetafile);
            finally
              LMetaFile.Free;
            end;
          end;
        end;

      if not AlreadyPrepared then
      begin
        TQuickRep(AQuickRepList[I]).QRPrinter.Free;
        TQuickRep(AQuickRepList[I]).QRPrinter := nil;
      end;
    end;
    if AQuickRepList.Count <> 0 then
      EndDocument;
  except
    Exception.Create('Combined Report Export Failed.');
  end;
end;

procedure TgtQRExportInterface.ExportQR(QRPrinter: TQRPrinter);
var
  I: Integer;
  LMetafile: TMetafile;
begin
	if ShowProgress then
  	InitProgress(QRPrinter);
	try
    for I := 1 to QRPrinter.PageCount do
    begin
      LMetaFile := QRPrinter.GetPage(I);
      if Assigned(LMetaFile) then
      begin
        if I > 1 then
          IgtDocumentEngine(Engine).NewPage;
        try
          IgtDocumentEngine(Engine).PlayMetafile(0, 0, LMetafile);
        finally
          LMetaFile.Free;
        end;
      end;
      if ShowProgress then
      begin
				if QRPrinter.Cancelled then
        begin
        	EndProgress(QRPrinter);
          Break;
        end;
        QRPrinter.Progress := (I * 100) div QRPrinter.PageCount;
        FProgress.Refresh;
        Application.ProcessMessages;
      end;
    end;
  finally
  	if (ShowProgress and (not QRPrinter.Cancelled)) then
    	EndProgress(QRPrinter);
  end;
end;

procedure TgtQRExportInterface.RenderDocument(AQRPFile: string);
var
  QRPrinter: TQRPrinter;
  LMetafile: TMetafile;
begin
	{$IFDEF QR362up}
  QRPrinter := TQRPrinter.Create(nil);
  {$ELSE}
  QRPrinter := TQRPrinter.Create;
  {$ENDIF}
	try
    QRPrinter.PaperSize := QrPrntr.Custom;
    QRPrinter.Load(AQRPFile);
    if QRPrinter.ReportLoaded then
      with IgtDocumentEngine(Engine) do
      begin
        Engine.MeasurementUnit := muPixels;
        with Page do
        begin
          PaperSize := Custom;
          if QRPrinter.PaperSize = QrPrntr.Custom then
          begin
            LMetafile := QRPrinter.GetPage(1);
            try
              Width := LMetafile.Width;
              Height := LMetafile.Height;
            finally
              LMetafile.Free;
            end;
          end
          else
          begin
            // check orientation....
            Orientation := QRPrinter.Orientation;
            Width := QRPrinter.XPos(QRPrinter.PaperWidthValue);
            Height := QRPrinter.YPos(QRPrinter.PaperLengthValue);
          end;
        end;
        StartDocument;
        ExportQR(QRPrinter);
        EndDocument;
      end;
	finally
    FreeAndNil(QRPrinter);
  end
end;

function TgtQRExportInterface.IsFilterNotInList: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to QRExportFilterLibrary.Filters.Count - 1 do
    if TQRExportFilterLibraryEntry(QRExportFilterLibrary.Filters[I])
        .ExportFilterClass = FFilterClass then
    begin
      Result := False;
      Break;
    end;
end;

{$IFNDEF NOGlobalSettingsVar}
procedure TgtQRExportInterface.RemoveFilterObject;
begin
  if FFilterClass = TgtQRPDFXport then
    PDFEngine := nil
  else if FFilterClass = TgtQRRTFXport then
    RTFEngine := nil
  else if FFilterClass = TgtQRHTMLXport then
    HTMLEngine := nil
  else if FFilterClass = TgtQRXHTMLXport then
    XHTMLEngine := nil
  {$IFDEF gtPro}
  else if FFilterClass = TgtQRSVGXport then
    SVGEngine := nil
  {$ENDIF}
  else if FFilterClass = TgtQRTextXport then
    TextEngine := nil
  else if FFilterClass = TgtQRExcelXport then
    ExcelEngine := nil
      else if FFilterClass = TgtQRXLSXport then
    XLSEngine := nil
  else if FFilterClass = TgtQRQuattroProXport then
    QuattroProEngine := nil
  else if FFilterClass = TgtQRSYLKXport then
    SYLKEngine := nil
  else if FFilterClass = TgtQRDIFXport then
    DIFEngine := nil
  else if FFilterClass = TgtQRLotusXport then
    LotusEngine := nil
  else if FFilterClass = TgtQRBMPXport then
    BMPEngine := nil
  else if FFilterClass = TgtQRJPEGXport then
    JPEGEngine := nil
  else if FFilterClass = TgtQRGIFXport then
    GIFEngine := nil
  else if FFilterClass = TgtQREMFXport then
    EMFEngine := nil
  else if FFilterClass = TgtQRWMFXport then
    WMFEngine := nil
  {$IFDEF gtPro}    
  else if FFilterClass = TgtQRTIFFXport then
    TIFFEngine := nil
  else if FFilterClass = TgtQRPNGXport then
    PNGEngine := nil
  {$ENDIF}
  {$IFNDEF gtRE}
  else if FFilterClass = TgtQRClipboardXport then
    Clipboard := nil
  {$ENDIF}
  ;
end;
{$ENDIF}

procedure TgtQRExportInterface.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  inherited Engine := Value;
  if Value <> nil then
  begin
    if (Visible) then
      AddFilterClass
    else
      RemoveFilterClass;
  end
  else
    RemoveFilterClass;
end;

{$IFNDEF NOGlobalSettingsVar}
procedure TgtQRExportInterface.SetFilterObject;
begin
  if Engine is TgtPDFEngine then
    PDFEngine := TgtPDFEngine(Engine)
  else if Engine is TgtRTFEngine then
    RTFEngine := TgtRTFEngine(Engine)
  else if Engine is TgtHTMLEngine then
    HTMLEngine := TgtHTMLEngine(Engine)
  else if Engine is TgtXHTMLEngine then
    XHTMLEngine := TgtXHTMLEngine(Engine)
{$IFDEF gtPro}
  else if Engine is TgtSVGEngine then
    SVGEngine := TgtSVGEngine(Engine)
{$ENDIF}
  else if Engine is TgtTextEngine then
    TextEngine := TgtTextEngine(Engine)
  else if Engine is TgtExcelEngine then
    ExcelEngine := TgtExcelEngine(Engine)
     else if Engine is TgtXLSEngine then
    XLSEngine := TgtXLSEngine(Engine)
  else if Engine is TgtQuattroProEngine then
    QuattroProEngine := TgtQuattroProEngine(Engine)
  else if Engine is TgtSYLKEngine then
    SYLKEngine := TgtSYLKEngine(Engine)
  else if Engine is TgtDIFEngine then
    DIFEngine := TgtDIFEngine(Engine)
  else if Engine is TgtLotusEngine then
    LotusEngine := TgtLotusEngine(Engine)
  else if Engine is TgtBMPEngine then
    BMPEngine := TgtBMPEngine(Engine)
  else if Engine is TgtJPEGEngine then
    JPEGEngine := TgtJPEGEngine(Engine)
  else if Engine is TgtGIFEngine then
    GIFEngine := TgtGIFEngine(Engine)
  else if Engine is TgtEMFEngine then
    EMFEngine := TgtEMFEngine(Engine)
  else if Engine is TgtWMFEngine then
    WMFEngine := TgtWMFEngine(Engine)
{$IFDEF gtPro}
  else if Engine is TgtTIFFEngine then
    TIFFEngine := TgtTIFFEngine(Engine)
  else if Engine is TgtPNGEngine then
    PNGEngine := TgtPNGEngine(Engine)
{$ENDIF}
{$IFNDEF gtRE}
  else if Engine is TgtClipboard then
    Clipboard := TgtClipboard(Engine)
{$ENDIF}
  ;
end;
{$ENDIF}

procedure TgtQRExportInterface.SetVisible(const Value: Boolean);
begin
  if (Value) then
  begin
    if (Engine <> nil) then
      AddFilterClass;
  end
  else
  begin
    if (Engine <> nil) then
      RemoveFilterClass;
  end;
  inherited Visible := Value;
end;

procedure TgtQRExportInterface.EndProgress(AQRPrinter: TQRPrinter);
begin
	if AQRPrinter.Cancelled then
  begin
  	TgtHackCstDocEngine(Engine).CancelCreate;
  end;
	FProgress.Free;
	AQRPrinter.Client := nil;
end;

procedure TgtQRExportInterface.InitProgress(AQRPrinter: TQRPrinter);
begin
	FProgress := TQRProgressForm.Create(Application);
	FProgress.QRPrinter := AQRPrinter;
  FProgress.Show;
	AQRPrinter.Client := FProgress;
end;

procedure TgtQRExportInterface.SetShowProgress(const Value: Boolean);
begin
  FShowProgress := Value;
end;

procedure TgtQRExportInterface.AddFilterClass;
var
  LCnt: Integer;

  procedure SetFilterClass;
  begin
    if Engine is TgtPDFEngine then
      FFilterClass := TgtQRPDFXport
    else if Engine is TgtRTFEngine then
      FFilterClass := TgtQRRTFXport
    else if Engine is TgtHTMLEngine then
      FFilterClass := TgtQRHTMLXport
    else if Engine is TgtXHTMLEngine then
      FFilterClass := TgtQRXHTMLXport
    {$IFDEF gtPro}
    else if Engine is TgtSVGEngine then
      FFilterClass := TgtQRSVGXport
    {$ENDIF}
    else if Engine is TgtTextEngine then
      FFilterClass := TgtQRTextXport
    else if Engine is TgtExcelEngine then
      FFilterClass := TgtQRExcelXport
        else if Engine is TgtXLSEngine then
      FFilterClass := TgtQRXLSXport
    else if Engine is TgtQuattroProEngine then
      FFilterClass := TgtQRQuattroProXport
    else if Engine is TgtSYLKEngine then
      FFilterClass := TgtQRSYLKXport
    else if Engine is TgtDIFEngine then
      FFilterClass := TgtQRDIFXport
    else if Engine is TgtLotusEngine then
      FFilterClass := TgtQRLotusXport
    else if Engine is TgtBMPEngine then
      FFilterClass := TgtQRBMPXport
    else if Engine is TgtJPEGEngine then
      FFilterClass := TgtQRJPEGXport
    else if Engine is TgtGIFEngine then
      FFilterClass := TgtQRGIFXport
    else if Engine is TgtEMFEngine then
      FFilterClass := TgtQREMFXport
    else if Engine is TgtWMFEngine then
      FFilterClass := TgtQRWMFXport
    {$IFDEF gtPro}
    else if Engine is TgtTIFFEngine then
      FFilterClass := TgtQRTIFFXport
    else if Engine is TgtPNGEngine then
      FFilterClass := TgtQRPNGXport
    {$ENDIF}
    {$IFNDEF gtRE}
    else if Engine is TgtClipboard then
      FFilterClass := TgtQRClipboardXport
    {$ENDIF}
    ;
  end;
begin
  (*
    If one filter was already registered, unregister it before setting the
    new one.
  *)
  if FFilterClass <> nil then
  begin
    {$IFNDEF NOGlobalSettingsVar}
    RemoveFilterObject;
    {$ENDIF}
    QRExportFilterLibrary.RemoveFilter(FFilterClass);
  end;

  SetFilterClass;

  if (FFilterClass <> nil) then
  begin
    if (IsFilterNotInList) then
    begin
      LCnt := QRExportFilterLibrary.Filters.Count;
      QRExportFilterLibrary.AddFilter(FFilterClass);
      if (QRExportFilterLibrary.Filters.Count = (LCnt + 1)) then
        with TQRExportFilterLibraryEntry(QRExportFilterLibrary.Filters.Items[QRExportFilterLibrary.Filters.Count - 1]) do
        begin
          FilterName := IgtDocumentEngine(Engine).FileDescription;
          Extension := IgtDocumentEngine(Engine).FileExtension;
        end;
    end;
    {$IFNDEF NOGlobalSettingsVar}
    SetFilterObject;
    {$ENDIF}
  end;
end;

procedure TgtQRExportInterface.RemoveFilterClass;
begin
  if (FFilterClass <> nil) then
  begin
    if not IsFilterNotInList then
    begin
      {$IFNDEF NOGlobalSettingsVar}
      RemoveFilterObject;
      {$ENDIF}
      QRExportFilterLibrary.RemoveFilter(FFilterClass);
      FFilterClass := nil;
    end;
  end; 
end;

{ TgtQRRTFXport }

procedure TgtQRRTFXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if RTFEngine <> nil then
    FEngine := RTFEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtRTFEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}    
  end;
{$ENDIF}
end;

{ TgtQRHTMLXport }

procedure TgtQRHTMLXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;  
{$IFNDEF NOGlobalSettingsVar}
  if HTMLEngine <> nil then
    FEngine := HTMLEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtHTMLEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}    
  end;
{$ENDIF}
end;

{ TgtQRXHTMLXport }

procedure TgtQRXHTMLXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if XHTMLEngine <> nil then
    FEngine := XHTMLEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtXHTMLEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRSVGXport }
{$IFDEF gtPro}
procedure TgtQRSVGXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if SVGEngine <> nil then
    FEngine := SVGEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtSVGEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}    
  end;
{$ENDIF}
end;
{$ENDIF}
{ TgtQRTextXport }

procedure TgtQRTextXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if TextEngine <> nil then
    FEngine := TextEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtTextEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}    
  end;
{$ENDIF}
end;

{ TgtQRExcelXport }

procedure TgtQRExcelXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if ExcelEngine <> nil then
    FEngine := ExcelEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtExcelEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRQuattroProXport }

procedure TgtQRQuattroProXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if QuattroProEngine <> nil then
    FEngine := QuattroProEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtQuattroProEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}    
  end;
{$ENDIF}
end;

{ TgtQRSYLKXport }

procedure TgtQRSYLKXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if SYLKEngine <> nil then
    FEngine := SYLKEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtSYLKEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRDIFXport }

procedure TgtQRDIFXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if DIFEngine <> nil then
    FEngine := DIFEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtDIFEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRLotusXport }

procedure TgtQRLotusXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if LotusEngine <> nil then
    FEngine := LotusEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtLotusEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRBMPXport }

procedure TgtQRBMPXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if BMPEngine <> nil then
    FEngine := BMPEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtBMPEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRJPEGXport }

procedure TgtQRJPEGXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if JPEGEngine <> nil then
    FEngine := JPEGEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtJPEGEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRGIFXport }

procedure TgtQRGIFXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if GIFEngine <> nil then
    FEngine := GIFEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtGIFEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQREMFXport }

procedure TgtQREMFXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if EMFEngine <> nil then
    FEngine := EMFEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtEMFEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRWMFXport }

procedure TgtQRWMFXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if WMFEngine <> nil then
    FEngine := WMFEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtWMFEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRTIFFXport }
{$IFDEF gtPro}
procedure TgtQRTIFFXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if TIFFEngine <> nil then
    FEngine := TIFFEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtTIFFEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

{ TgtQRPNGXport }

procedure TgtQRPNGXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if PNGEngine <> nil then
    FEngine := PNGEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtPNGEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;
{$ENDIF}
{ Registeration procedure }

procedure Register;
begin
	RegisterComponents('Gnostice Interface', [TgtQRExportInterface]);
end;

{ TgtQRClipboardXport }
{$IFNDEF gtRE}
procedure TgtQRClipboardXport.AfterConstruction;
begin
  inherited;
  FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if Clipboard <> nil then
    FEngine := Clipboard
  else
  begin
{$ENDIF}
    FLocalEngine := TgtClipboard.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;
{$ENDIF}
{ TgtQRXLSXport }

procedure TgtQRXLSXport.AfterConstruction;
begin
  inherited;
    FLocalEngine := nil;
{$IFNDEF NOGlobalSettingsVar}
  if XLSEngine <> nil then
    FEngine := XLSEngine
  else
  begin
{$ENDIF}
    FLocalEngine := TgtXLSEngine.Create(nil);
    FEngine := FLocalEngine;
{$IFNDEF NOGlobalSettingsVar}
  end;
{$ENDIF}
end;

end.
