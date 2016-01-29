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
// TO ENABLE: Remove the dot(.) before $DEFINE to look as {$DEFINE ...}
// TO DISABLE: Add a dot(.) before $DEFINE to look as {.$DEFINE ...}

// --- FastReport3 Trial Version Support ---
// ENABLE this switch for supporting Trial version of FastReport 3.
{ .$DEFINE FRTrial }

unit gtFRXportIntf;

interface

uses
  Windows, Classes, Graphics, Controls, StdCtrls, frxClass,
  gtXportIntf, gtCstDocEng, frxRes, Dialogs, gtUtils3, gtConsts3, Math;

type
  TgtFRExportPreferences = class(TPersistent)
  private
    FScaleDownLargeImages: Boolean;
    FScaleDownToDPI: Integer;
    procedure SetScaleDownLargeImages(const Value: Boolean);
    procedure SetScaleDownToDPI(const Value: Integer);
  public
    constructor Create; overload; virtual;
    destructor Destroy; override;
  published
    property ScaleDownLargeImages: Boolean read FScaleDownLargeImages
      write SetScaleDownLargeImages default False;
    property ScaleDownToDPI: Integer read FScaleDownToDPI
      write SetScaleDownToDPI default 96;
  end;

  TgtFRXport_Base = class(TfrxCustomExportFilter)
  private
    FParent: TObject;
    FEngine: TgtCustomDocumentEngine;
    FShowSaveDialog: Boolean;
    FSaveDialog: TSaveDialog;
    FMeta: TMetafile;
    FMetaCanvas: TMetafileCanvas;
    FPreferences: TgtFRExportPreferences;
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetShowSaveDialog(const Value: Boolean);
    procedure SetPreferences(const Value: TgtFRExportPreferences);
    function GetPreferences: TgtFRExportPreferences;
  protected
    property Engine: TgtCustomDocumentEngine read FEngine write SetEngine;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Start: Boolean; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    property ShowSaveDialog: Boolean read FShowSaveDialog
      write SetShowSaveDialog default True;
    property Preferences: TgtFRExportPreferences read GetPreferences
      write SetPreferences;
  end;

  TgtFRClipboardXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRPDFXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRRTFXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRHTMLXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRXHTMLXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRTextXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRExcelXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRXLSXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRDIFXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRQuattroProXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRLotusXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRSYLKXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRBMPXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRGIFXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRJPEGXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRWMFXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFREMFXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

{$IFDEF gtPro}

  TgtFRTIFFXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRPNGXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;

  TgtFRSVGXport = class(TgtFRXport_Base)
  public
    class function GetDescription: String; override;
  end;
{$ENDIF}

  TgtFRExportInterface = class(TgtExportInterface)
  private
    FFRXport: TgtFRXport_Base;
    FShowSaveDialog: Boolean;
    FPreferences: TgtFRExportPreferences;
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);
    procedure FRRegister;
    procedure FRUnregister;
    procedure SetShowSaveDialog(const Value: Boolean);
    procedure SetPreferences(const Value: TgtFRExportPreferences);
    function GetPreferences: TgtFRExportPreferences;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(AReport: TfrxReport;
      APrepared, AShowPreparedReport: Boolean);
  published
    property ShowSaveDialog: Boolean read FShowSaveDialog
      write SetShowSaveDialog default True;
    property Engine write SetEngine;
    property Visible write SetVisible;
    property Preferences: TgtFRExportPreferences read GetPreferences
      write SetPreferences;
  end;

implementation

uses
  SysUtils,
  gtPDFEng, gtRTFEng, gtHTMLEng, gtXHTMLEng, gtTXTEng,
  gtXLSEng, gtQProEng, gtSLKEng, gtDIFEng, gtLotusEng,
  gtBMPEng, gtJPEGEng, gtGIFEng, gtEMFEng, gtWMFEng, gtXLS95Eng
{$IFDEF gtPro}
    , gtTIFFEng, gtPNGEng, gtSVGEng
{$ENDIF}
{$IFNDEF gtRE}
    , gtClipboard
{$ENDIF}
    ;

constructor TgtFRXport_Base.Create(AOwner: TComponent);
begin
  inherited;
  FParent := AOwner;
  FShowSaveDialog := True;
  // FPreferences := TgtFRExportPreferences.Create;
end;

destructor TgtFRXport_Base.Destroy;
begin
  inherited;
  // if Assigned(FPreferences) then
  // FreeAndNil(FPreferences);
end;

constructor TgtFRExportInterface.Create(AOwner: TComponent);
begin
  inherited;
  ShowSaveDialog := True;
  FPreferences := TgtFRExportPreferences.Create;
end;

destructor TgtFRExportInterface.Destroy;
begin

  if Assigned(FPreferences) then
    FreeAndNil(FPreferences);
  inherited;
end;

procedure TgtFRExportInterface.RenderDocument(AReport: TfrxReport;
  APrepared, AShowPreparedReport: Boolean);
begin
  Visible := True;
  FFRXport.Engine := Engine;
  FFRXport.Report := AReport;
  FFRXport.Preferences := FPreferences;
  if (not APrepared) then
    AReport.PrepareReport;
  if (AShowPreparedReport) then
  begin
    AReport.ShowPreparedReport;
    if (AReport.Preview <> nil) then
      AReport.Export(FFRXport);
  end
  else
    AReport.Export(FFRXport);

end;

procedure TgtFRExportInterface.FRRegister;
begin
  if Engine is TgtPDFEngine then
    FFRXport := TgtFRPDFXport.Create(Self)
  else if Engine is TgtRTFEngine then
    FFRXport := TgtFRRTFXport.Create(Self)
  else if Engine is TgtXHTMLEngine then
    FFRXport := TgtFRXHTMLXport.Create(Self)
  else if Engine is TgtHTMLEngine then
    FFRXport := TgtFRHTMLXport.Create(Self)
  else if Engine is TgtJPEGEngine then
    FFRXport := TgtFRJPEGXport.Create(Self)
  else if Engine is TgtGIFEngine then
    FFRXport := TgtFRGIFXport.Create(Self)
  else if Engine is TgtEMFEngine then
    FFRXport := TgtFREMFXport.Create(Self)
  else if Engine is TgtWMFEngine then
    FFRXport := TgtFRWMFXport.Create(Self)
  else if Engine is TgtBMPEngine then
    FFRXport := TgtFRBMPXport.Create(Self)
  else if Engine is TgtExcelEngine then
    FFRXport := TgtFRExcelXport.Create(Self)
  else if Engine is TgtXLSEngine then
    FFRXport := TgtFRXLSXport.Create(Self)
  else if Engine is TgtQuattroProEngine then
    FFRXport := TgtFRQuattroProXport.Create(Self)
  else if Engine is TgtLotusEngine then
    FFRXport := TgtFRLotusXport.Create(Self)
  else if Engine is TgtDIFEngine then
    FFRXport := TgtFRDIFXport.Create(Self)
  else if Engine is TgtSYLKEngine then
    FFRXport := TgtFRSYLKXport.Create(Self)
  else if Engine is TgtTextEngine then
    FFRXport := TgtFRTextXport.Create(Self)
{$IFNDEF gtRE}
  else if Engine is TgtClipboard then
    FFRXport := TgtFRClipboardXport.Create(Self)
{$ENDIF}
{$IFDEF gtPro}
  else if Engine is TgtSVGEngine then
    FFRXport := TgtFRSVGXport.Create(Self)
  else if Engine is TgtTIFFEngine then
    FFRXport := TgtFRTIFFXport.Create(Self)
  else if Engine is TgtPNGEngine then
    FFRXport := TgtFRPNGXport.Create(Self)
{$ENDIF}
      ;
  FFRXport.Engine := Engine;
  FFRXport.ShowSaveDialog := ShowSaveDialog;
  FFRXport.Preferences := Preferences;
end;

procedure TgtFRExportInterface.FRUnregister;
begin
  FFRXport.Free;
end;

function TgtFRExportInterface.GetPreferences: TgtFRExportPreferences;
begin
  Result := FPreferences;
end;

procedure TgtFRExportInterface.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  if Engine <> nil then
    FRUnregister;
  inherited Engine := Value;
  if ((Engine <> nil) and Visible) then
    FRRegister;
end;

procedure TgtFRExportInterface.SetPreferences(const Value
  : TgtFRExportPreferences);
begin
  FPreferences := Value;
  if (FFRXport <> nil) then
    FFRXport.Preferences := Value;
end;

procedure TgtFRXport_Base.SetPreferences(const Value: TgtFRExportPreferences);
begin
  FPreferences := Value;
end;

procedure TgtFRExportInterface.SetVisible(const Value: Boolean);
begin
  if (Visible <> Value) then
  begin
    inherited Visible := Value;
    if (Engine <> nil) then
    begin
      if Visible then
        FRRegister
      else
        FRUnregister;
    end;
  end;
end;

function TgtFRXport_Base.Start: Boolean;
begin
  Result := inherited Start;
  FEngine.MeasurementUnit := muPixels;
  FEngine.ReferencePoint := rpPage;
  IgtDocumentEngine(FEngine).Page.PaperSize := Custom;
  if ShowSaveDialog then
  begin
    FSaveDialog := TSaveDialog.Create(Self);
    try
      with FSaveDialog do
      begin
        Title := 'Save Document...';
        DefaultExt := IgtDocumentEngine(FEngine).FileExtension;
        FileName := IgtDocumentEngine(FEngine).FileName;
        Filter := IgtDocumentEngine(FEngine).FileDescription + '|*.' +
          IgtDocumentEngine(FEngine).FileExtension;
        if Execute then
          IgtDocumentEngine(FEngine).FileName := FileName
        else
          Result := False;
      end;
    finally
      FSaveDialog.Free;
    end;
  end;
end;

procedure TgtFRXport_Base.StartPage(Page: TfrxReportPage; Index: Integer);
var
  LLeft, LTop, LRight, LBottom: Double;
begin
  // Set Page size...
  IgtDocumentEngine(FEngine).Page.Height := Page.Height;
  IgtDocumentEngine(FEngine).Page.Width := Page.Width;

  if (Index = 0) then
  begin
    if FParent is TgtFRExportInterface then
      TgtFRExportInterface(FParent).StartDocument
    else
      IgtDocumentEngine(FEngine).BeginDoc;
  end
  else
    IgtDocumentEngine(FEngine).NewPage;
  if (Page.BackPicture <> nil) and (Page.BackPicture.Graphic <> nil) and
    (not Page.BackPicture.Graphic.Empty) then
  begin
    LLeft := Page.LeftMargin * 4;
    LTop := Page.TopMargin * 4;
    LRight := IgtDocumentEngine(FEngine).Page.Width - (Page.RightMargin * 4);
    LBottom := IgtDocumentEngine(FEngine).Page.Height - (Page.BottomMargin * 4);

    IgtDocumentEngine(FEngine).ImageSettings.Stretch := True;
    // IgtDocumentEngine(FEngine).DrawImage(gtRect(0, 0,
    // IgtDocumentEngine(FEngine).Page.Width, IgtDocumentEngine(FEngine).Page.Height),
    // Page.BackPicture.Graphic);

    IgtDocumentEngine(FEngine).DrawImage(gtRect(LLeft, LTop, LRight, LBottom),
      Page.BackPicture.Graphic);

  end;
  FMeta := TMetafile.Create;
  FMeta.Height := Round(Page.Height);
  FMeta.Width := Round(Page.Width);
  FMetaCanvas := TMetafileCanvas.Create(FMeta, 0);
end;

procedure TgtFRXport_Base.ExportObject(Obj: TfrxComponent);
var
  LTempBmp: TBitmap;
  LScale, LTempScaleY, LTempScaleX: Double;
begin
  if (Engine.EngineStatus <> esStarted) then
    Exit;

  if FPreferences.FScaleDownLargeImages and (Obj is TfrxPictureView) then
  begin
    if (Obj.Name <> '_pagebackground') then
    // for PictureView
    begin
      // If Scaledownimage  then scale down
      // If ScaledowntoDPI  also scale down
      // If No need to Scaledownimage, keep scale as 1
      if (TfrxPictureView(Obj).Picture.Width = 0) Or
        (TfrxPictureView(Obj).Picture.Height = 0) then
        LScale := 1
      else
      begin
        // Scales down image using given DPI
        LTempScaleX := (Obj.Width / TfrxPictureView(Obj).Picture.Width) *
          (FPreferences.FScaleDownToDPI / 96);
        LTempScaleY := (Obj.Height / TfrxPictureView(Obj).Picture.Height) *
          (FPreferences.FScaleDownToDPI / 96);
        LScale := Max(LTempScaleX, LTempScaleY);
      end;

      // If scaling Factor is more than 1 do not scale the image
      if LScale > 1 then
        LScale := 1;

      // Create a temp bitmap for scaling
      LTempBmp := TBitmap.Create;

      // Set scaled down size
      LTempBmp.Height := Round(TfrxPictureView(Obj).Picture.Height * LScale);
      LTempBmp.Width := Round(TfrxPictureView(Obj).Picture.Width * LScale);

      // Draw the FRX graphics into Temp bitmap
      LTempBmp.Canvas.StretchDraw(Rect(0, 0, LTempBmp.Width, LTempBmp.Height),
        TfrxPictureView(Obj).Picture.Graphic);

      // Assign Scaled bitmap as FRX graphics
      TfrxPictureView(Obj).Picture.Graphic := LTempBmp;

      TfrxView(Obj).Draw(FMetaCanvas, 1, 1, 0, 0);
      LTempBmp.Free;
    end;
  end
  else if Obj is TfrxView then
    if Obj.Name <> '_pagebackground' then
      TfrxView(Obj).Draw(FMetaCanvas, 1, 1, 0, 0);

  if Obj.Name = '_pagebackground' then // For Drawing Page Borders
    TfrxView(Obj).Draw(FMetaCanvas, 1, 1, 0, 0);
end;

procedure TgtFRXport_Base.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  inherited;
  FMetaCanvas.Free;
  IgtDocumentEngine(FEngine).PlayMetafile(FMeta);
  FMeta.Free;
  if (Index = Report.PreviewPages.Count - 1)
{$IFDEF FRTrial} or (Index = 4) {$ENDIF} then
  begin
    if FParent is TgtFRExportInterface then
      TgtFRExportInterface(FParent).EndDocument
    else
      IgtDocumentEngine(FEngine).EndDoc;
  end;
end;

function TgtFRXport_Base.GetPreferences: TgtFRExportPreferences;
begin
  Result := FPreferences;
end;

procedure TgtFRXport_Base.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  FEngine := Value;
  with IgtDocumentEngine(Engine) do
  begin
    frxResources.Add(Engine.ClassName, FileDescription + ' (*.' +
      FileExtension + ')');
  end
end;

{ TgtFRClipboardXport }

class function TgtFRClipboardXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtClipboard');
end;

{ TgtFRPDFXport }

class function TgtFRPDFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtPDFEngine');
end;

{ TgtFRRTFXport }

class function TgtFRRTFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtRTFEngine');
end;

{ TgtFRHTMLXport }

class function TgtFRHTMLXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtHTMLEngine');
end;

{ TgtFRXHTMLXport }

class function TgtFRXHTMLXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtXHTMLEngine');
end;

{ TgtFRTextXport }

class function TgtFRTextXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtTextEngine');
end;

{ TgtFRExcelXport }

class function TgtFRExcelXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtExcelEngine');
end;

{ TgtFRDIFXport }

class function TgtFRDIFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtDIFEngine');
end;

{ TgtFRQuattroProXport }

class function TgtFRQuattroProXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtQuattroProEngine');
end;

{ TgtFRLotusXport }

class function TgtFRLotusXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtLotusEngine');
end;

{ TgtFRSYLKXport }

class function TgtFRSYLKXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtSYLKEngine');
end;

{ TgtFRBMPXport }

class function TgtFRBMPXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtBMPEngine');
end;

{ TgtFRGIFXport }

class function TgtFRGIFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtGIFEngine');
end;

{ TgtFRJPEGXport }

class function TgtFRJPEGXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtJPEGEngine');
end;

{ TgtFRWMFXport }

class function TgtFRWMFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtWMFEngine');
end;

{ TgtFREMFXport }

class function TgtFREMFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtEMFEngine');
end;

{$IFDEF gtPro}
{ TgtFRTIFFXport }

class function TgtFRTIFFXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtTIFFEngine');
end;

{ TgtFRPNGXport }

class function TgtFRPNGXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtPNGEngine');
end;

{ TgtFRSVGXport }

class function TgtFRSVGXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtSVGEngine');
end;
{$ENDIF}

procedure TgtFRExportInterface.SetShowSaveDialog(const Value: Boolean);
begin
  FShowSaveDialog := Value;
  if (FFRXport <> nil) then
    FFRXport.ShowSaveDialog := Value;
end;

procedure TgtFRXport_Base.SetShowSaveDialog(const Value: Boolean);
begin
  FShowSaveDialog := Value;
end;

{ TgtFRXLSXport }

class function TgtFRXLSXport.GetDescription: String;
begin
  Result := frxResources.Get('TgtXLSEngine');
end;

{ TgtFRExportPreferences }

constructor TgtFRExportPreferences.Create;
begin
  FScaleDownLargeImages := False;
  FScaleDownToDPI := 96;
end;

destructor TgtFRExportPreferences.Destroy;
begin
  inherited;
end;

procedure TgtFRExportPreferences.SetScaleDownLargeImages(const Value: Boolean);
begin
  FScaleDownLargeImages := Value;
end;

procedure TgtFRExportPreferences.SetScaleDownToDPI(const Value: Integer);
begin
  FScaleDownToDPI := Value;
end;

end.
