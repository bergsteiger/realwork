{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }

{$I gtDefines.inc}
{$I gtPTKDefines.inc}

unit gtPDFPrinter;

interface

uses
  Classes, Controls, windows, Graphics, gtCstPDFDoc, gtExPDFDoc, gtExProPDFDoc,
  gtPDFConsts, gtPDFUtils, printers, Dialogs, gtPDFResStrs, SysUtils, WinSpool, math, winsvc,
  PDIGDIPlus, ActiveX, gtStreamAdpt
{$IFDEF gtActiveX}
  , gtPDFClasses, Buttons
{$ENDIF}
  ;

const
  PrinterTitle = 'Gnostice PDFPrinter - ';

type

  TgtPDFPageScaling = (psNone, psFitPage);

  TgtDuplexPrintingMode = (dpmNone, dpmVertical, dpmHorizontal);

  TgtPrintOrientationType = (potPortrait, potLandScape);

  TgtColorMode = (cmColor, cmMonochrome);

  TgtTextOutputPrecision = (tpAlignment, tpDefault);

  TgtPrintQuality = (pqHigh, pqMedium, pqLow, pqDraft);

  TgtOnDuplexPrintingModeChange = procedure(Sender: TObject;
    var Continue: Boolean) of object;

  TgtOnBinSelectionByNameModeChange = procedure(Sender: TObject;
    var Continue: Boolean; BinName: string; var BinIndex: Integer) of object;

  TgtOnBinSelectionByIndexModeChange = procedure(Sender: TObject;
    var Continue: Boolean; var BinIndex: Integer) of object;

  TgtOnColorMonoChromePrintingModeChange = procedure(Sender: TObject;
    var Continue: Boolean) of object;

  TgtOnOrientationPrintingChange = procedure(Sender: TObject;
    var Continue: Boolean) of object;

  FHackExPro = class(TgtExProPDFDocument);

  TgtPrinterCapabilities = class
  private
    FColor: Boolean;
    FBinNames: TStringList;
    FDuplex: Boolean;
    FLandscape: Boolean;
    FPaperNames: TStringList;
    function GetPaperSize: integer;
    procedure SetPaperSize(const Value: integer);
    procedure SetPaperWidth(Value: Extended);
    procedure SetPaperHeight(Value: Extended);
    function GetInchesInTenthOfaMM(aValue: Extended): Extended;
  public
    constructor Create;
    destructor Destroy; override;
    property Duplex: Boolean read FDuplex;
    property BinNames: TStringList read FBinNames;
    property Color: Boolean read FColor;
    property Landscape: Boolean read FLandscape;
    property PaperNames: TStringList read FPaperNames;
    property PaperSize: integer read GetPaperSize write SetPaperSize;
    property PaperWidth: Extended write SetPaperWidth;
    property PaperHeight: Extended write SetPaperHeight;
  end;

  TgtAdvancedPrinterSettings = class
  private
    FDuplexPrintingMode: TgtDuplexPrintingMode;
    FOnDuplexmodePrintingChange: TgtOnDuplexPrintingModeChange;
    FBinName: string;
    FOnBinSelectionByNameChange: TgtOnBinSelectionByNameModeChange;
    FBinIndex: Integer;
    FOnBinSelectionByIndexChange: TgtOnBinSelectionByIndexModeChange;
    FColor: TgtColorMode;
    FOnColorMonoChromePrintingChange: TgtOnColorMonoChromePrintingModeChange;
    FOrientation: TgtPrintOrientationType;
    FOnOrientationPrintingChange: TgtOnOrientationPrintingChange;
    FPrintQuality: TgtPrintQuality;

    procedure SetDuplexPrintingMode(const Value: TgtDuplexPrintingMode);
    procedure SetOnDuplexmodePrintingChange(
      const Value: TgtOnDuplexPrintingModeChange);

    procedure SetBinName(const Value: string);
    procedure SetOnBinSelectionByNameChange(const Value: TgtOnBinSelectionByNameModeChange);

    procedure SetBinIndex(value: Integer);
    procedure SetOnBinSelectionByIndexChange(const Value: TgtOnBinSelectionByIndexModeChange);

    procedure SetColor(const Value: TgtColorMode);
    procedure SetOnColorMonoChromePrintingChange(const value: TgtOnColorMonoChromePrintingModeChange);

    procedure SetOrientation(const Value: TgtPrintOrientationType);
    procedure SetOnPrintingOrientationChange(const value: TgtOnOrientationPrintingChange);

    procedure SetPrintQuality(Value: TgtPrintQuality);

  public
    property DuplexPrintingMode: TgtDuplexPrintingMode
      read FDuplexPrintingMode write SetDuplexPrintingMode;
    property BinName: string read FBinName write SetBinName;
    property BinIndex: Integer read FBinIndex write SetBinIndex;
    property Color: TgtColorMode read FColor write SetColor;
    property Orientation: TgtPrintOrientationType read FOrientation write SetOrientation;
    property PrintQuality: TgtPrintQuality read FPrintQuality write SetPrintQuality;


    property OnDuplexmodePrintingChange: TgtOnDuplexPrintingModeChange
      read FOnDuplexmodePrintingChange write SetOnDuplexmodePrintingChange;

    property OnBinSelectionByNameChange: TgtOnBinSelectionByNameModeChange
      read FOnBinSelectionByNameChange write SetOnBinSelectionByNameChange;

    property OnBinSelectionByIndexChange: TgtOnBinSelectionByIndexModeChange
      read FOnBinSelectionByIndexChange write SetOnBinSelectionByIndexChange;

    property OnColorMonoChromePrintingChange: TgtOnColorMonoChromePrintingModeChange
      read FOnColorMonoChromePrintingChange write SetOnColorMonoChromePrintingChange;

    property OnOrientationPrintingChange: TgtOnOrientationPrintingChange
      read FOnOrientationPrintingChange write SetOnPrintingOrientationChange;

  end;

  TgtPDFPrinter = class; // forward declaration

 { TgtPDFPrinter }

{$IFDEF gtActiveX}
  TgtPDFPrinter = class(TCustomControl)
{$ELSE}
  TgtPDFPrinter = class(TPrintDialog)
{$ENDIF}
  private
    FTextOutputPrecision: TgtTextOutputPrecision;
    FScaling: TgtPDFPageScaling;
    FPDFDocument: TgtCustomPDFDocument;
    FPrinterCapabilities: TgtPrinterCapabilities;
{$IFDEF gtDelphi2009Up}
    Device: string;
    Port: string;
    Driver: string;
{$ENDIF}
{$IFDEF gtActiveX}
    FPrintDlg: TPrintDialog;
    //. Following are required to draw the icon at design time.
    FIconBmp: Graphics.TBitmap;

    property IconBmp: Graphics.TBitmap read FIconBmp write FIconBmp;
    procedure SetCollate(Value: Boolean);
    procedure SetCopies(Value: Integer);
    procedure SetFromPage(Value: Integer);
    procedure SetMinPage(Value: Integer);
    procedure SetMaxPage(Value: Integer);
    procedure SetOptions(Value: TPrintDialogOptions);
    procedure SetPrintToFile(Value: Boolean);
    procedure SetPrintRange(Value: TPrintRange);
    procedure SetToPage(Value: Integer);
    procedure SetOnClose(Value: TNotifyEvent);
    procedure SetOnShow(Value: TNotifyEvent);

    function GetCollate: Boolean;
    function GetCopies: Integer;
    function GetFromPage: Integer;
    function GetMinPage: Integer;
    function GetMaxPage: Integer;
    function GetOptions: TPrintDialogOptions;
    function GetPrintToFile: Boolean;
    function GetPrintRange: TPrintRange;
    function GetToPage: Integer;
    function GetOnClose: TNotifyEvent;
    function GetOnShow: TNotifyEvent;
    procedure SetPrintCopies(const value: Integer);
    function GetPrintCopies: Integer;
{$ENDIF}
    procedure SetAbout(const Value: string);
    procedure SetVersion(const Value: string);
    procedure SetShowSetupDialog(const Value: boolean);
    procedure SetScaling(const Value: TgtPDFPageScaling);

    procedure SetPDFDocument(const Value: TgtCustomPDFDocument);
    procedure PopulateCapability;

    procedure AfterConstruction; override;
    function ServiceGetStatus(sMachine, sService : string ) : DWord;
  private
    FAdvancedPrinterSettings: TgtAdvancedPrinterSettings;
    FAutoRotate: Boolean;
    FAbout: string;
    FVersion: string;
    FTitle: WideString;
    FShowSetupDialog: boolean;
    FRotationAngle: TgtRotationAngle;
    procedure SetAdvancedPrinterSettings(
      const Value: TgtAdvancedPrinterSettings);

    procedure OnDuplexModePrintingChange(Sender: TObject; var Continue: Boolean);
    procedure OnBinSelectionByNameChange(Sender: TObject; var Continue: Boolean; BinName: string; var BinIndex: Integer);
    procedure OnBinSelectionByIndexChange(Sender: TObject; var Continue: Boolean; var BinIndex: Integer);
    procedure OnColorMonoChromePrintingChange(Sender: TObject; var Continue: Boolean);
    procedure OnOrientationPrintingChange(Sender: TObject; var Continue: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PrintDoc();
    procedure Reset;
    function GetInstalledPrinters: TStrings;
    function SelectPrinterByIndex(APrinterIndex: Integer): Boolean;
    function SelectPrinterByName(APrinterName: string): Boolean;
    property PrinterCapabilities: TgtPrinterCapabilities read FPrinterCapabilities;
    property AdvancedPrinterSettings: TgtAdvancedPrinterSettings read FAdvancedPrinterSettings write SetAdvancedPrinterSettings;
    property RotationAngle: TgtRotationAngle read FRotationAngle write FRotationAngle;

{$IFDEF gtActiveX}
    procedure Paint; override;
{$ENDIF}
  published
    property About: string read FAbout write SetAbout;
    property Title: WideString read FTitle write FTitle;
    property PDFDocument: TgtCustomPDFDocument read FPDFDocument write SetPDFDocument;
    property Scaling: TgtPDFPageScaling read FScaling write SetScaling default psNone;
    property Version: string read FVersion write SetVersion;
    property ShowSetupDialog: boolean read FShowSetupDialog write SetShowSetupDialog default True;
    property TextOutputPrecision: TgtTextOutputPrecision
      read FTextOutputPrecision write FTextOutputPrecision default tpDefault;
    property AutoRotate: Boolean read FAutoRotate write FAutoRotate;
{$IFDEF gtActiveX}
    property Copies: Integer read GetPrintCopies write SetPrintCopies;
    property Collate: Boolean read GetCollate write SetCollate default False;
    property FromPage: Integer read GetFromPage write SetFromPage default 0;
    property MinPage: Integer read GetMinPage write SetMinPage default 0;
    property MaxPage: Integer read GetMaxPage write SetMaxPage default 0;
    property Options: TPrintDialogOptions read GetOptions write SetOptions default [];
    property PrintToFile: Boolean read GetPrintToFile write SetPrintToFile default False;
    property PrintRange: TPrintRange read GetPrintRange write SetPrintRange default prAllPages;
    property ToPage: Integer read GetToPage write SetToPage default 0;
    property OnClose: TNotifyEvent read GetOnClose write SetOnClose;
    property OnShow: TNotifyEvent read GetOnShow write SetOnShow;
{$ENDIF}
  end;

implementation

var
{$IFNDEF gtDelphi2009Up}
  Device: array[0..255] of char;
  Port: array[0..255] of char;
  Driver: array[0..255] of char;
{$ENDIF}
  Hmode: THandle;
  PDevMode: PDeviceMode;

{ TgtPDFPrinter }

constructor TgtPrinterCapabilities.Create;
begin
  FBinNames := TStringList.Create;
  FPaperNames := TStringList.Create;
end;

procedure TgtPDFPrinter.AfterConstruction;
var
  ByteCnt, StructCnt: DWORD;
begin
  inherited;
//  if (ServiceGetStatus('','Spooler') = SERVICE_RUNNING) then
//  begin
    PopulateCapability;
//  end;
end;

function TgtPDFPrinter.ServiceGetStatus(
  sMachine,
  sService : string ) : DWord;
var
  //
  // service control
  // manager handle
  schm,
  //
  // service handle
  schs   : SC_Handle;
  //
  // service status
  ss     : TServiceStatus;
  //
  // current service status
  dwStat : DWord;
begin
  dwStat := 1;

  // connect to the service
  // control manager 
  schm := OpenSCManager(
    PChar(sMachine),
    Nil,
    SC_MANAGER_CONNECT);

  // if successful...
  if(schm > 0)then
  begin
    // open a handle to
    // the specified service
    schs := OpenService(
      schm,
      PChar(sService),
      // we want to
      // query service status
      SERVICE_QUERY_STATUS);

    // if successful...
    if(schs > 0)then
    begin
      // retrieve the current status
      // of the specified service    
      if(QueryServiceStatus(
           schs,
           ss))then
      begin
        dwStat := ss.dwCurrentState;
      end;
      
      // close service handle
      CloseServiceHandle(schs);
    end;

    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;

  Result := dwStat;
end;

constructor TgtPDFPrinter.Create(AOwner: TComponent);
var
  ByteCnt, StructCnt: DWORD;
begin
  inherited;
  FAbout := SProductName;
  FVersion := CVersion;
  FTextOutputPrecision := tpDefault;
  FTitle := '';
  ByteCnt := 0;
  StructCnt := 0;
  {$IFDEF gtActiveX}
    FIconBmp := Graphics.TBitmap.Create;
    FIconBmp.Transparent := True;
    FIconBmp.TransparentMode := tmAuto;
    SetBounds(Left, Top, AX_SIZE, AX_SIZE);
    Constraints.MinHeight := AX_SIZE;
    Constraints.MinWidth := AX_SIZE;
    Constraints.MaxHeight := AX_SIZE;
    Constraints.MaxWidth := AX_SIZE;
  {$ENDIF}
  {$IFDEF gtActiveX}
    FPrintDlg := TPrintDialog.Create(nil);
    FPrintDlg.Options := [poPageNums];
    FPrintDlg.Copies := 1;
    FPrintDlg.Collate := False;
  {$ELSE}
//    if (ServiceGetStatus('','Spooler') = SERVICE_RUNNING) then
//    begin
      Options := [poPageNums];
      Copies := 1;
      Collate := False;
//    end;
  {$ENDIF}
    FShowSetupDialog := True;
    FPrinterCapabilities := TgtPrinterCapabilities.Create;
    FAdvancedPrinterSettings := TgtAdvancedPrinterSettings.Create;
    FAdvancedPrinterSettings.OnDuplexmodePrintingChange := OnDuplexModePrintingChange;
    FAdvancedPrinterSettings.OnBinSelectionByNameChange := OnBinSelectionByNameChange;
    FAdvancedPrinterSettings.OnBinSelectionByIndexChange := OnBinSelectionByIndexChange;
    FAdvancedPrinterSettings.OnColorMonoChromePrintingChange := OnColorMonoChromePrintingChange;
    FAdvancedPrinterSettings.OnOrientationPrintingChange := OnOrientationPrintingChange;
  {$IFDEF gtDelphi2009Up}
    SetLength(Device, 256);
    SetLength(Port, 256);
    SetLength(Driver, 256);
  {$ENDIF}
end;

destructor TgtPDFPrinter.Destroy;
begin
  if Assigned(FAdvancedPrinterSettings) then
    FreeAndNil(FAdvancedPrinterSettings);
  if Assigned(FPrinterCapabilities) then
    FreeAndNil(FPrinterCapabilities);
{$IFDEF gtActiveX}
  FPrintDlg.Free;
{$ENDIF}
{$IFDEF gtDelphi2009Up}
  Finalize(Device);
  Finalize(Port);
  Finalize(Driver);
{$ENDIF}

  inherited;
end;

procedure TgtPDFPrinter.PrintDoc;
var
  LK, LCopies, LI: Integer;
  LPDFDoc: TgtCustomPDFDocument;

  procedure PrintPage(APageNo, ACopies: Integer);
  var
    I: Integer;
    LXRes, LYRes, LScaleX, LScaleY: Double;
    LMetafileStream: TMemoryStream;
    LPWidth, LPHeight: Cardinal;
    LPageSize: TgtPageSize;
    LGraphics: IGPGraphics;
    LMatrix: IGPMatrix;
    LMetaFile: IGPMetafile;
    LStream: IStream;
  begin
    //Get the size of the PDF
    LPageSize := PDFDocument.GetPageSize(APageNo, muPoints);

    //Get the resolution of Printer
    LXRes := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    LYRes := GetDeviceCaps(Printer.Handle, LOGPIXELSY);

    //Create EMF Stream
    LMetafileStream := TMemoryStream.Create;
    LPDFDoc := PDFDocument;

    //Render metafile with the size of the page
    LPWidth := Round(LPageSize.Width);
    LPHeight := Round(LPageSize.Height);
    FHackExPro(LPDFDoc).FPDDoc.UseDualEMFPlus := False;
    //Render the PDF page to a EMF stream, this EMF is later
    //drawn on the printer canvas
    FHackExPro(PDFDocument).RenderToStream(LMetafileStream, APageNo,
      LPWidth, LPHeight, Round(LXRes), Round(LYRes), 0, True, False);

    //Print ACopies of the current PDF page.
    for I := 1 to ACopies do
    begin
       //Draw the metafile to the printer canvas with the calculated width
       //and height
      LMetafileStream.Position := 0;

      if Scaling = psNone then
      begin
        LMatrix := TGPMatrix.Create(1,0,0,1,0,0);
        LGraphics := TGPGraphics.Create(Printer.Canvas);
        LGraphics.SetTransform(LMatrix);
        LScaleX := LPageSize.Width / Printer.PageWidth;
        LScaleY := LPageSize.Height / Printer.PageHeight;
        LGraphics.ScaleTransform(LScaleX, LScaleY, MatrixOrderAppend);
        LMetafileStream.Position := 0;
        LStream := TgtStreamAdapter.Create(LMetafileStream);
        LMetaFile := TGPMetafile.Create(LStream);
        LGraphics.DrawImageF(LMetaFile, 0, 0);
      end
      else
      begin
        if AutoRotate then
        begin
          LPWidth := Printer.PageWidth;
          LPHeight := Printer.PageHeight;

          if (AdvancedPrinterSettings.Orientation = potPortrait) then
          begin
            if (LPageSize.Width > LPageSize.Height) then
            begin
              FHackExPro(PDFDocument).RenderImageToCanvas(Printer.Canvas.Handle,
                LMetafileStream, LPWidth, LPHeight, -90);
            end
            else
            begin
              FHackExPro(PDFDocument).RenderImageToCanvas(Printer.Canvas.Handle,
                LMetafileStream, LPWidth, LPHeight, 0);
            end;
          end
          else if (AdvancedPrinterSettings.Orientation = potLandScape) then
          begin
            if (LPageSize.Width < LPageSize.Height) then
            begin
              AdvancedPrinterSettings.Orientation := potPortrait;
              FHackExPro(PDFDocument).RenderImageToCanvas(Printer.Canvas.Handle,
                LMetafileStream, LPWidth, LPHeight, -90);
              AdvancedPrinterSettings.Orientation := potLandScape;
            end
            else
            begin
              FHackExPro(PDFDocument).RenderImageToCanvas(Printer.Canvas.Handle,
                LMetafileStream, LPWidth, LPHeight, 0);
            end;
          end;
        end
        else
        begin
         {Case 1: If Portrait is printed as landscape, then there will be
                  additional space at the right side of printed output.
          Case 2: If Landscape is printed as portrait, then the right side
                  of the PDF will be cropped. }
          if ((LPageSize.Width < LPageSize.Height) and
            (AdvancedPrinterSettings.Orientation = potLandScape)) or
            ((LPageSize.Width > LPageSize.Height) and
            (AdvancedPrinterSettings.Orientation = potPortrait))
             then
          begin
             LPWidth := Printer.PageHeight;
             LPHeight := Printer.PageWidth;
          end
          else
          begin
            LPWidth := Printer.PageWidth;
            LPHeight := Printer.PageHeight;
          end;
          FHackExPro(PDFDocument).RenderImageToCanvas(Printer.Canvas.Handle,
          LMetafileStream, LPWidth, LPHeight, 0);
        end;
      end;
      if I < ACopies then
        Printer.NewPage;
    end;
    FreeAndNil(LMetafileStream);
  end;

begin
  if (PDFDocument <> nil) and (PDFDocument.IsLoaded) then
  begin
{$IFDEF gtActiveX}
    if ShowSetupDialog and not FPrintDlg.Execute then
      Exit;
{$ELSE}
    if ShowSetupDialog and not Execute then
      Exit;
{$ENDIF}
    if PrintRange = prAllPages then
    begin
      FromPage := 1;
      ToPage := PDFDocument.PageCount;
    end;
    if FromPage > ToPage then
      FromPage := ToPage;
    if ToPage < FromPage then
      ToPage := FromPage;
    if FromPage < 0 then
      FromPage := 1;
    if FromPage > PDFDocument.PageCount then
      FromPage := PDFDocument.PageCount;
    if ToPage < 0 then
      ToPage := 1;
    if ToPage > PDFDocument.PageCount then
      ToPage := PDFDocument.PageCount;

    if FTitle = '' then
    begin
      Printer.Title := PDFDocument.Filename;
      if PDFDocument.DocInfo.Title <> '' then
        Printer.Title := PDFDocument.DocInfo.Title
      else
        Printer.Title := PrinterTitle + Printer.Title;
    end
    else
      Printer.Title := FTitle;

{$IFDEF gtActiveX}
    LCopies := FPrintDlg.Copies;
    FPrintDlg.Copies := 1;
{$ELSE}
    LCopies := Copies;
    Copies := 1;
{$ENDIF}
    Printer.BeginDoc;
    try
// --------Collate
      if (Collate) then
      begin
        for LI := 1 to LCopies do
        begin
          for Lk := FromPage to ToPage do
          begin
            PrintPage(Lk, 1);
            if (Lk < ToPage) or (LI < LCopies) then
              Printer.NewPage;
          end;
        end;
      end
      else
      begin
        for Lk := FromPage to ToPage do
        begin
          begin
            PrintPage(Lk, LCopies);
            if (Lk < ToPage) then
              Printer.NewPage;
          end;
        end;
      end;
//----------------COLLATE End
    finally
      Printer.EndDoc;
    end;
  end;
end;

function TgtPDFPrinter.GetInstalledPrinters: TStrings;
begin
  Result := Printer.Printers;
end;

function TgtPDFPrinter.SelectPrinterByIndex(APrinterIndex: Integer): Boolean;
begin
  if (APrinterIndex < -1) or (APrinterIndex > (Printer.Printers.Count - 1)) then
    Result := False
  else
  begin
    Printer.PrinterIndex := APrinterIndex;
    PopulateCapability;
    Result := True;
  end;
end;

function TgtPDFPrinter.SelectPrinterByname(APrinterName: string): Boolean;
var
  LPrinterList: TStrings;
  LI: Integer;
  LPrinterFound: Boolean;
begin
  LPrinterFound := False;
  LPrinterList := Printer.Printers;
  for LI := 0 to LPrinterList.Count - 1 do
  begin
    if LPrinterList.Strings[LI] = APrinterName then
    begin
      LPrinterFound := True;
      Break;
    end;
  end;
  if LPrinterFound then
  begin
    Printer.PrinterIndex := LI;
    PopulateCapability;
    Result := True;
  end
  else
    Result := False;
end;

procedure TgtPDFPrinter.Reset;
begin
  if (Assigned(PDFDocument)) and (PDFDocument.IsLoaded) then
    PDFDocument.Reset;
end;

procedure TgtPDFPrinter.SetAbout(const Value: string);
begin
//  FAbout := Value;
end;

procedure TgtPDFPrinter.SetVersion(const Value: string);
begin
//  FVersion := Value;
end;

procedure TgtPDFPrinter.SetShowSetupDialog(const Value: boolean);
begin
  FShowSetupDialog := Value;
end;

procedure TgtPDFPrinter.SetScaling(const Value: TgtPDFPageScaling);
begin
  FScaling := Value;
end;

procedure TgtPDFPrinter.SetPDFDocument(const Value: TgtCustomPDFDocument);
begin
  FPDFDocument := Value;
  if FPDFDocument.IsLoaded then
  begin
    MinPage := 1;
    MaxPage := FPDFDocument.PageCount;
  end;
end;

procedure TgtPDFPrinter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FPDFDocument) and (Operation = opRemove) then
    FPDFDocument := nil;
end;

{$IFDEF gtActiveX}

procedure TgtPDFPrinter.SetPrintCopies(const value: Integer);
begin
//  if (ServiceGetStatus('','Spooler') = SERVICE_RUNNING) then
//  begin
    FPrintDlg.Copies := value;
//  end;
end;

function TgtPDFPrinter.GetPrintCopies: Integer;
begin
  Result := FPrintDlg.Copies;
end;

function TgtPDFPrinter.GetCollate: Boolean;
begin
  Result := FPrintDlg.Collate;
end;

function TgtPDFPrinter.GetCopies: Integer;
begin
  Result := FPrintDlg.Copies;
end;

function TgtPDFPrinter.GetFromPage: Integer;
begin
  Result := FPrintDlg.FromPage;
end;

function TgtPDFPrinter.GetMaxPage: Integer;
begin
  Result := FPrintDlg.MaxPage;
end;

function TgtPDFPrinter.GetMinPage: Integer;
begin
  Result := FPrintDlg.MinPage;
end;

function TgtPDFPrinter.GetOptions: TPrintDialogOptions;
begin
  Result := FPrintDlg.Options;
end;

function TgtPDFPrinter.GetPrintRange: TPrintRange;
begin
  Result := FPrintDlg.PrintRange;
end;

function TgtPDFPrinter.GetPrintToFile: Boolean;
begin
  Result := FPrintDlg.PrintToFile;
end;

function TgtPDFPrinter.GetToPage: Integer;
begin
  Result := FPrintDlg.ToPage;
end;

procedure TgtPDFPrinter.SetCollate(Value: Boolean);
begin
  FPrintDlg.Collate := Value;
end;

procedure TgtPDFPrinter.SetCopies(Value: Integer);
begin
  FPrintDlg.Copies := Value;
end;

procedure TgtPDFPrinter.SetFromPage(Value: Integer);
begin
  FPrintDlg.FromPage := Value;
end;

procedure TgtPDFPrinter.SetMaxPage(Value: Integer);
begin
  FPrintDlg.MaxPage := Value;
end;

procedure TgtPDFPrinter.SetMinPage(Value: Integer);
begin
  FPrintDlg.MinPage := Value;
end;

procedure TgtPDFPrinter.SetOptions(Value: TPrintDialogOptions);
begin
  FPrintDlg.Options := Value;
end;

procedure TgtPDFPrinter.SetPrintRange(Value: TPrintRange);
begin
  FPrintDlg.PrintRange := Value;
end;

procedure TgtPDFPrinter.SetPrintToFile(Value: Boolean);
begin
  FPrintDlg.PrintToFile := Value;
end;

procedure TgtPDFPrinter.SetToPage(Value: Integer);
begin
  FPrintDlg.ToPage := Value;
end;

function TgtPDFPrinter.GetOnClose: TNotifyEvent;
begin
  Result := FPrintDlg.OnClose;
end;

function TgtPDFPrinter.GetOnShow: TNotifyEvent;
begin
  Result := FPrintDlg.OnShow;
end;

procedure TgtPDFPrinter.SetOnClose(Value: TNotifyEvent);
begin
  FPrintDlg.OnClose := Value;
end;

procedure TgtPDFPrinter.SetOnShow(Value: TNotifyEvent);
begin
  FPrintDlg.OnShow := Value;
end;

procedure TgtPDFPrinter.Paint;
begin
  inherited;
  DrawButtonFace(Canvas, Rect(0, 0, AX_SIZE, AX_SIZE), 1, bsNew, False, False, True);
  if assigned(IconBmp) then
    IconBmp.LoadFromResourceID(HInstance, 3);
  Canvas.Draw(2, 2, IconBmp);
end;
{$ENDIF}


procedure TgtPDFPrinter.SetAdvancedPrinterSettings(
  const Value: TgtAdvancedPrinterSettings);
begin
  FAdvancedPrinterSettings := Value;
end;

procedure TgtPDFPrinter.OnDuplexModePrintingChange(Sender: TObject;
  var Continue: Boolean);
begin
  Continue := PrinterCapabilities.Duplex;
end;

procedure TgtPDFPrinter.OnOrientationPrintingChange(Sender: TObject;
  var Continue: Boolean);
begin
  Continue := PrinterCapabilities.Landscape;
end;

procedure TgtPDFPrinter.OnColorMonoChromePrintingChange(Sender: TObject;
  var Continue: Boolean);
begin
  Continue := PrinterCapabilities.Color;
end;

procedure TgtPDFPrinter.OnBinSelectionByNameChange(Sender: TOBject;
  var Continue: Boolean; BinName: string; var BinIndex: Integer);
var
  Status: Integer;
begin
  Status := PrinterCapabilities.BinNames.IndexOf(BinName);
  if Status <> -1 then
  begin
    Continue := True;
    BinIndex := Integer(PrinterCapabilities.BinNames.Objects[Status]);
  end
  else
    Continue := False;
end;

procedure TgtPDFPrinter.OnBinSelectionByIndexChange(Sender: TObject;
  var Continue: Boolean; var BinIndex: Integer);
var
  count1: Integer;
  CheckIndex: Boolean;
begin
  CheckIndex := False;
  for count1 := 0 to PrinterCapabilities.BinNames.Count - 1 do
  begin
    if BinIndex = Integer(PrinterCapabilities.BinNames.Objects[count1]) then
    begin
      CheckIndex := True;
      break;
    end;
  end;
  if CheckIndex then
    Continue := True
  else
    Continue := False;
end;

procedure TgtPDFPrinter.PopulateCapability;
type
  BinName = array[0..23] of char;
  BinNameArray = array[1..high(Integer) div sizeof(BinName)] of BinName;
  PBinName = ^BinNameArray;
  NumBinName = array[1..high(Integer) div sizeof(Word)] of Word;
  PNumBinName = ^NumBinName;
  PaperName = array[0..63] of char;
  PaperNameArray = array[1..high(Integer) div Sizeof(PaperName)] of PaperName;
  PPaperName = ^PaperNameArray;
var
  Status: Integer;
  BufferSize: Integer;
  DeviceOut: PDeviceMode;
  DeviceIn: PDeviceMode;
  PBinNameT: PBinName;
  PNumBin: PNumBinName;
  BNum, Iterator: Integer;
  NoOfPaper: Integer;
  PPaperName1: PPaperName;
begin
  PBinNameT := nil;
  PNumBin := nil;
  PPaperName1 := nil;
  DeviceOut := nil;
  DeviceIn := nil;
{$IFDEF gtDelphi2009Up}
  Printer.GetPrinter(PChar(Device), PChar(Driver), PChar(Port), Hmode);
{$ELSE}
  Printer.GetPrinter(Device, Driver, Port, Hmode);
{$ENDIF}
  {----------- Checking Paper Names that Printer Supports----------------- }
{$IFDEF gtDelphi2009Up}
  NoOfPaper := DeviceCapabilitiesA(PAnsiChar(Device), PAnsiChar(Port), DC_PAPERNAMES, nil, nil);
{$ELSE}
  NoOfPaper := DeviceCapabilitiesA(Device, Port, DC_PAPERNAMES, nil, nil);
{$ENDIF}
  if NoOfPaper > 0 then
    GetMem(PPaperName1, NoOfPaper * 64);
  try
{$IFDEF gtDelphi2009Up}
    DeviceCapabilitiesA(PAnsiChar(Device), PAnsiChar(Port), DC_PAPERNAMES, PAnsiChar(PPaperName1), nil);
{$ELSE}
    DeviceCapabilitiesA(Device, Port, DC_PAPERNAMES, PChar(PPaperName1), nil);
{$ENDIF}
    for Iterator := 1 to NoOfPaper do
    begin
      PrinterCapabilities.FPaperNames.add(PPaperName1^[Iterator]);
    end;
  finally
    FreeMem(PPaperName1);
  end;
  {--------------End of PaperName Checking for a Printer----------------- }

  {--------------Checking wether Printer Supports Landscape Printing---------}
{$IFDEF gtDelphi2009Up}
  Status := DeviceCapabilitiesA(PAnsiChar(Device), PAnsiChar(Port), DC_ORIENTATION, nil, nil);
{$ELSE}
  Status := DeviceCapabilitiesA(Device, Port, DC_ORIENTATION, nil, nil);
{$ENDIF}
  if Status = 0 then
    PrinterCapabilities.FLandscape := False
  else
    PrinterCapabilities.FLandscape := True;
  {--------------End of Landscape Printing Checking-------------------------}

  {---------------Checking wether Printer Supports Duplex Printing----------}
{$IFDEF gtDelphi2009Up}
  Status := DeviceCapabilitiesA(PAnsiChar(Device), PAnsiChar(Port), DC_DUPLEX, nil, nil);
{$ELSE}
  Status := DeviceCapabilitiesA(Device, Port, DC_DUPLEX, nil, nil);
{$ENDIF}
  if Status = 1 then
    PrinterCapabilities.FDuplex := True
  else
    PrinterCapabilities.FDuplex := False;

  {---------------End of Duplex Printing Checking--------------------------}

  {---------------Checking wether Printer Supports Color Printing----------}
{$IFDEF gtDelphi2009Up}
  BufferSize := DocumentProperties(0, 0, PChar(Device), DeviceOut^, DeviceIn^, 0);
{$ELSE}
  BufferSize := DocumentProperties(0, 0, Device, DeviceOut^, DeviceIn^, 0);
{$ENDIF}
  GetMem(DeviceOut, BufferSize);
{$IFDEF gtDelphi2009Up}
  DocumentProperties(0, 0, PChar(Device), DeviceOut^, DeviceIn^, DM_OUT_BUFFER);
{$ELSE}
  DocumentProperties(0, 0, Device, DeviceOut^, DeviceIn^, DM_OUT_BUFFER);
{$ENDIF}
  if DeviceOut^.dmColor > 1 then
  begin
    FreeMem(DeviceOut);
    PrinterCapabilities.FColor := True
  end
  else
  begin
    FreeMem(DeviceOut);
    PrinterCapabilities.FColor := False;
  end;
  {---------------End of Color Printing Checking--------------------------}


  {---------------Checking How many Bins Printer Supports -----------------}
{$IFDEF gtDelphi2009Up}
  BNum := DeviceCapabilitiesA(PAnsiChar(DEVICE), PAnsiChar(Port), DC_BINNAMES, nil, nil);
{$ELSE}
  BNum := DeviceCapabilitiesA(DEVICE, Port, DC_BINNAMES, nil, nil);
{$ENDIF}
  if BNum > 0 then
  begin
    GetMem(PBinNameT, BNum * 24);
    GetMem(PNumBin, BNum * sizeof(word));
  end;
  try
{$IFDEF gtDelphi2009Up}
    DeviceCapabilitiesA(PAnsiChar(Device), PAnsiChar(Port), DC_BINNAMES, PAnsiChar(PBinNameT), nil);
    DeviceCapabilitiesA(PAnsiChar(Device), PAnsiChar(port), DC_BINS, pAnsiChar(PNumBin), nil);
{$ELSE}
    DeviceCapabilitiesA(Device, Port, DC_BINNAMES, PAnsiChar(PBinNameT), nil);
    DeviceCapabilitiesA(Device, port, DC_BINS, pAnsiChar(PNumBin), nil);
{$ENDIF}
    PrinterCapabilities.BinNames.Clear;

    for Iterator := 0 to BNum - 1 do
    begin
      PrinterCapabilities.BinNames.AddObject(PBinNameT^[Iterator], TObject
        (PNumBin^[Iterator]));
    end;
  finally
    FreeMem(PBinNameT);
    FreeMem(PNumBin);
  end;
  {---------------End of Bin Printing Checking-----------------------------}
end;

{ TgtPrinterAdvancedSetting }

{-----------------Setting Duplex Printing for a Printing-------------------}

procedure TgtAdvancedPrinterSettings.SetDuplexPrintingMode
  (const Value: TgtDuplexPrintingMode);
var
  LDuplexSupported: Boolean;
begin

  LDuplexSupported := False;
  if Assigned(OnDuplexmodePrintingChange) then
    OnDuplexmodePrintingChange(Self, LDuplexSupported)
  else
    FDuplexPrintingMode := Value;
  if LDuplexSupported then
  begin
    if Hmode <> 0 then
    begin
      PDevMode := GlobalLock(Hmode);
      if PDevMode <> nil then
      begin
        with PDevMode^ do
        try
          begin
            dmFields := dmFields or DM_DUPLEX;
            if value = dpmVertical then
              dmDuplex := DMDUP_VERTICAL
            else if value = dpmHorizontal then
              dmDuplex := DMDUP_HORIZONTAL
            else
              dmDuplex := DMDUP_SIMPLEX;
          end;
        finally
          GlobalUnlock(Hmode);
        end;
      end;
    end;
  end
  else
   // raise EUnsupportedDuplexError.create(SUnsupportedDuplex);
end;

{----------------------End Of Setting Duplex Printing for a Printer------------}

{-------------------Setting Bin by Name for a Printer--------------------------}

procedure TgtAdvancedPrinterSettings.SetBinName(const Value: string);
var
  LBinSelectionByName: Boolean;
  LBinIndex: Integer;
begin
  LBinSelectionByName := False;
  LBinIndex := 0;
  if Assigned(OnBinSelectionByNameChange) then
    OnBinSelectionByNameChange(Self, LBinSelectionByName, Value, LBinIndex);
  if LBinSelectionByName then
  begin
    FBinName := Value;
    if Hmode <> 0 then
    begin
      PDevMode := GlobalLock(HMode);
      with PDevMode^ do
      try
        begin
          dmFields := dmfields or DM_DEFAULTSOURCE;
          dmDefaultSource := LBinIndex;
        end;
      finally
        GlobalUnlock(Hmode);
      end;
    end;
  end
  else
    //raise EInvalidBinNameError.create(SInvalidBinName);
end;
{----------------------End of Setting Bin by Name for a Printer----------------}

{-----------------------Setting Bin by Index for a Printer---------------------}

function TgtPrinterCapabilities.GetInchesInTenthOfaMM(
  aValue: Extended): Extended;
begin
  Result := (aValue * 25.4) * 10;
end;

procedure TgtAdvancedPrinterSettings.SetBinIndex(Value: Integer);
var
  LBinSelectionByIndex: Boolean;
begin
  LBinSelectionByIndex := False;
  if Assigned(OnBinSelectionByIndexChange) then
    OnBinSelectionByIndexChange(Self, LBinSelectionByIndex, Value);
  if LBinSelectionByIndex then
  begin
    FBinIndex := value;
    if Hmode <> 0 then
    begin
      PDevMode := GlobalLock(HMode);
      with PDevMode^ do
      try
        begin
          dmFields := dmfields or DM_DEFAULTSOURCE;
          dmDefaultSource := value;
        end;
      finally
        GlobalUnlock(Hmode);
      end;
    end;
  end
  else
    //raise EInvalidBinNameError.create(SInvalidBinIndex);
end;

{------------------------End of Setting Bin By Index for a printer-------------}

{------------------------Setting Printer Orientation---------------------------}

procedure TgtAdvancedPrinterSettings.SetOrientation(const Value: TgtPrintOrientationType);
var
  LLandScapeCapability: Boolean;
  Orientation: Integer;
begin
  if value = potPortrait then
    Orientation := 1
  else
    Orientation := 2;
  LLandScapeCapability := False;
  if Assigned(OnOrientationPrintingChange) then
    OnOrientationPrintingChange(Self, LLandScapeCapability);
  if not (LLandScapeCapability) and (value = potLandScape) then
    //raise EUnsupportedLandScapeError.create(SUnsupportedOrientation)
  else
  begin
    FOrientation := Value;
    if Hmode <> 0 then
    begin
      PDevMode := GlobalLock(HMode);
      with PDevMode^ do
      try
        begin
          dmFields := dmfields or DM_ORIENTATION;
          dmOrientation := Orientation;
        end;
      finally
        GlobalUnlock(Hmode);
      end;
    end;
  end;
end;
{---------------------End of Setting Printer Orientation----------------------}

{---------------------Setting PrintQuality for a Printer----------------------}

procedure TgtPrinterCapabilities.SetPaperHeight(Value: Extended);
begin
  if Hmode <> 0 then
  begin
    PDevMode := GlobalLock(HMode);
    with PDevMode^ do
    try
      begin
        if dmPaperSize = DMPAPER_USER then
        begin
          dmFields := dmFields or DM_PAPERSIZE or DM_PAPERWIDTH or DM_PAPERLENGTH; 
          dmPaperLength := Round(GetInchesInTenthOfaMM(Value));
        end;
      end;
    finally
      GlobalUnlock(Hmode);
    end;
  end;
end;

procedure TgtPrinterCapabilities.SetPaperWidth(Value: Extended);
begin
  if Hmode <> 0 then
  begin
    PDevMode := GlobalLock(HMode);
    with PDevMode^ do
    try
      begin
        if dmPaperSize = DMPAPER_USER then
        begin
          dmFields := dmFields or DM_PAPERSIZE or DM_PAPERWIDTH or DM_PAPERLENGTH; 
          dmPaperWidth := Round(GetInchesInTenthOfaMM(Value));
        end;
      end;
    finally
      GlobalUnlock(Hmode);
    end;
  end;
end;

procedure TgtAdvancedPrinterSettings.SetPrintQuality(value: TgtPrintQuality);
begin
  if Hmode <> 0 then
  begin
    FPrintQuality := value;
    PDevMode := GlobalLock(HMode);
    with PDevMode^ do
    try
      begin
        dmFields := dmfields or DM_PRINTQUALITY;
        if value = pqHigh then
          dmPrintQuality := short(DMRES_HIGH)
        else if value = pqLow then
          dmPrintQuality := short(DMRES_LOW)
        else if value = pqMedium then
          dmPrintQuality := short(DMRES_MEDIUM)
        else
          dmPrintQuality := short(DMRES_DRAFT);
      end;
    finally
      GlobalUnlock(Hmode);
    end;
  end;
end;

{---------------------End of Setting Print Quality for a Printer---------------}

{---------------------Setting Color/Monochrome Printing for a Printer----------}

procedure TgtAdvancedPrinterSettings.SetColor(const Value: TgtColorMode);
var
  LColorCapability: Boolean;
  value1: Boolean;
begin
  LColorCapability := False;
  if value = cmColor then
    value1 := True
  else
    value1 := False;
  if Assigned(OnColorMonoChromePrintingChange) then
    OnColorMonoChromePrintingChange(Self, LColorCapability);
  if not LColorCapability and Value1 then
    //raise EUnsupportedColorError.create(SUnsupportedPrinting);
    if LColorCapability and value1 then
    begin
      FColor := Value;
      if Hmode <> 0 then
      begin
        PDevMode := GlobalLock(HMode);
        with PDevMode^ do
        try
          begin
            dmFields := dmfields or DM_COLOR;
            dmColor := DMCOLOR_COLOR;
          end;
        finally
          GlobalUnlock(Hmode);
        end;
      end;
    end
    else
    begin
      FColor := Value;
      if Hmode <> 0 then
      begin
        PDevMode := GlobalLock(HMode);
        with PDevMode^ do
        try
          begin
            dmFields := dmfields or DM_COLOR;
            dmColor := DMCOLOR_MONOCHROME;
          end;
        finally
          GlobalUnlock(Hmode);
        end;
      end;
    end;
end;

{-------------End of Setting Color/MonoChrome printing for a Printer-----------}

procedure TgtAdvancedPrinterSettings.SetOnDuplexmodePrintingChange(
  const Value: TgtOnDuplexPrintingModeChange);
begin
  FOnDuplexmodePrintingChange := Value;
end;

procedure TgtAdvancedPrinterSettings.SetOnBinSelectionByNameChange(
  const Value: TgtOnBinSelectionByNameModeChange);
begin
  FOnBinSelectionByNameChange := Value;
end;

procedure TgtAdvancedPrinterSettings.SetOnBinSelectionByIndexChange(
  const Value: TgtOnBinSelectionByIndexModeChange);
begin
  FOnBinSelectionByIndexChange := Value;
end;

procedure TgtAdvancedPrinterSettings.SetOnColorMonoChromePrintingChange(
  const Value: TgtOnColorMonoChromePrintingModeChange);
begin
  FOnColorMonoChromePrintingChange := value;
end;

procedure TgtAdvancedPrinterSettings.SetOnPrintingOrientationChange(
  const Value: TgtOnOrientationPrintingChange);
begin
  FOnOrientationPrintingChange := value;
end;

destructor TgtPrinterCapabilities.destroy;
begin
  if Assigned(FBinNames) then
    FreeAndNil(FBinNames);
  if Assigned(FPaperNames) then
    FreeAndNil(FPaperNames);
  inherited;
end;

function TgtPrinterCapabilities.GetPaperSize: integer;
begin
  if Hmode <> 0 then
  begin
    PDevMode := GlobalLock(Hmode);
    if PDevMode <> nil then
    begin
      with PDevMode^ do
      begin
        try
          Result := PDevMode^.dmPaperSize;
        finally
          GlobalUnlock(Hmode);
        end;
      end;
    end;
  end;
end;

procedure TgtPrinterCapabilities.SetPaperSize(const Value: integer);
begin
  if Hmode <> 0 then
  begin
    PDevMode := GlobalLock(Hmode);
    if PDevMode <> nil then
    begin
      with PDevMode^ do
      begin
        try
          dmPaperSize := Value;
          dmFields := PDevMode^.dmFields or DM_PAPERSIZE;
        finally
          GlobalUnlock(Hmode);
        end;
      end;
    end;
  end;
end;

end.
