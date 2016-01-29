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

unit gtFRXportIntf;

interface

uses
  Windows, Classes, Graphics, Controls, StdCtrls, FR_Class,
	gtXportIntf, gtCstDocEng
  ;

type
  TgtFRXport_Base = class(TfrExportFilter)
  private
    FParent: TObject;
  	FEngine: TgtCustomDocumentEngine;
    FMetafileList: TList;
    FMetafile : TMetafile;
    FCanvas: TMetafileCanvas;
    procedure OnAfterExportEvent(const FileName: String);
		procedure OnBeforeExportEvent(var FileName: String; var bContinue: Boolean);
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
  protected
  	property Engine: TgtCustomDocumentEngine read FEngine write SetEngine;

  public
  	constructor Create(AOwner: TComponent); override;
		destructor Destroy; override;
    procedure OnBeginDoc; override;
    procedure OnBeginPage; override;
    procedure OnData(x, y: Integer; View: TfrView); override;
    procedure OnEndPage; override;
  end;

{$IFNDEF gtRE}
  TgtFRClipboardXport = class(TgtFRXport_Base)
  end;
{$ENDIF}

  TgtFRPDFXport = class(TgtFRXport_Base)
  end;

  TgtFRRTFXport = class(TgtFRXport_Base)
  end;

  TgtFRHTMLXport = class(TgtFRXport_Base)
  end;

  TgtFRXHTMLXport = class(TgtFRXport_Base)
  end;

  TgtFRTextXport = class(TgtFRXport_Base)
  end;

  TgtFRExcelXport = class(TgtFRXport_Base)
  end;

  TgtFRDIFXport = class(TgtFRXport_Base)
  end;

  TgtFRQuattroProXport = class(TgtFRXport_Base)
  end;

  TgtFRLotusXport = class(TgtFRXport_Base)
  end;

  TgtFRSYLKXport = class(TgtFRXport_Base)
  end;

  TgtFRBMPXport = class(TgtFRXport_Base)
  end;

  TgtFRGIFXport = class(TgtFRXport_Base)
  end;

  TgtFRJPEGXport = class(TgtFRXport_Base)
  end;

  TgtFRWMFXport = class(TgtFRXport_Base)
  end;

  TgtFREMFXport = class(TgtFRXport_Base)
  end;

  {$IFDEF gtPro}
  TgtFRTIFFXport = class(TgtFRXport_Base)
  end;

  TgtFRPNGXport = class(TgtFRXport_Base)
  end;

  TgtFRSVGXport = class(TgtFRXport_Base)
  end;
  {$ENDIF}

	TgtFRExportInterface = class(TgtExportInterface)
  private
    FFRXport: TgtFRXport_Base;
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);
    procedure FRRegister;
    procedure FRUnregister;
  protected
  public
  	constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(AReport: TfrReport;
    	APrepared, AShowPreparedReport: Boolean);
  published
  	property Engine write SetEngine;
    property Visible write SetVisible;
  end;

implementation

uses
	SysUtils,
  gtPDFEng, gtRTFEng, gtHTMLEng, gtXHTMLEng, gtTXTEng,
  gtXLSEng, gtQProEng, gtSLKEng, gtDIFEng, gtLotusEng,
  gtBMPEng, gtJPEGEng, gtGIFEng, gtEMFEng, gtWMFEng
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
  OnBeforeExport := OnBeforeExportEvent;
  OnAfterExport := OnAfterExportEvent;
end;

destructor TgtFRXport_Base.Destroy;
begin
  inherited;
end;

constructor TgtFRExportInterface.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TgtFRExportInterface.Destroy;
begin
  inherited;
end;

procedure TgtFRExportInterface.RenderDocument(AReport: TfrReport;
	APrepared, AShowPreparedReport: Boolean);
var
  LFileName: string;
begin
	Visible := True;
	FFRXport.Engine := Engine;
  if (not APrepared) then AReport.PrepareReport;
  if (AShowPreparedReport) then AReport.ShowPreparedReport;
  LFileName := IgtDocumentEngine(Engine).FileName;
  if (LFileName = '') then
    LFileName := 'Temp';
	AReport.ExportTo(FFRXport, LFileName);
end;

procedure TgtFRExportInterface.FRRegister;
begin
  if Engine is TgtPDFEngine then
    FFRXport := TgtFRPDFXport.Create(Self)
  else if Engine is TgtRTFEngine then
    FFRXport := TgtFRRTFXport.Create(Self)
  else if Engine is TgtHTMLEngine then
    FFRXport := TgtFRHTMLXport.Create(Self)
  else if Engine is TgtXHTMLEngine then
    FFRXport := TgtFRXHTMLXport.Create(Self)
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
  frRegisterExportFilter(FFRXport, IgtDocumentEngine(Engine).FileDescription,
  	'*.' + IgtDocumentEngine(Engine).FileExtension);
end;

procedure TgtFRExportInterface.FRUnregister;
begin
	frUnRegisterExportFilter(FFRXport);
	FFRXport.Free;
end;

procedure TgtFRExportInterface.SetEngine(
  const Value: TgtCustomDocumentEngine);
begin
	if Engine <> nil then FRUnregister;
  inherited Engine := Value;
  if ((Engine <> nil) and Visible) then FRRegister;
end;

procedure TgtFRExportInterface.SetVisible(const Value: Boolean);
begin
	if (Visible <> Value) then
  begin
    inherited Visible := Value;
    if (Engine <> nil) then
    begin
	    if Visible then FRRegister
    	else FRUnregister;
    end;
  end;
end;

procedure TgtFRXport_Base.OnAfterExportEvent(const FileName: String);
var
	I: Integer;
begin
	if FileExists(FileName) then SysUtils.DeleteFile(FileName);

  IgtDocumentEngine(Engine).FileName := FileName;

	for I := 0 to FMetafileList.Count - 1 do
  begin
    IgtDocumentEngine(Engine).Page.LeftMargin :=
    	CurReport.EMFPages[I].pgMargins.Left;
    IgtDocumentEngine(Engine).Page.RightMargin :=
    	CurReport.EMFPages[I].pgMargins.Right;
		IgtDocumentEngine(Engine).Page.TopMargin :=
    	CurReport.EMFPages[I].pgMargins.Top;
		IgtDocumentEngine(Engine).Page.BottomMargin :=
    	CurReport.EMFPages[I].pgMargins.Bottom;
    IgtDocumentEngine(Engine).Page.Width :=
      CurReport.EMFPages[I].PrnInfo.Pgw;
    IgtDocumentEngine(Engine).Page.Height :=
      CurReport.EMFPages[I].PrnInfo.Pgh;
  	if I = 0 then
    begin
      if FParent is TgtFRExportInterface then
        TgtFRExportInterface(FParent).StartDocument
      else
       IgtDocumentEngine(Engine).BeginDoc
    end
    else
     IgtDocumentEngine(Engine).NewPage;
    IgtDocumentEngine(Engine).PlayMetafile(TMetafile(FMetafileList[I]));

    if I = FMetafileList.Count - 1 then
      if FParent is TgtFRExportInterface then
        TgtFRExportInterface(FParent).EndDocument
      else
  	    IgtDocumentEngine(Engine).EndDoc;

    TMetafile(FMetafileList[I]).Free;
  end;
  FMetafileList.Free;
end;

procedure TgtFRXport_Base.OnBeforeExportEvent(var FileName: String;
  var bContinue: Boolean);
begin
  FMetafileList := TList.Create;
end;

procedure TgtFRXport_Base.OnBeginDoc;
begin
  inherited;
  FEngine.MeasurementUnit := muPixels;
  FEngine.ReferencePoint := rpPage;
  IgtDocumentEngine(FEngine).Page.PaperSize := Custom;
end;

procedure TgtFRXport_Base.OnBeginPage;
begin
	FMetafile := TMetafile.Create;
	FCanvas := TMetafileCanvas.Create(FMetafile, 0);
end;

procedure TgtFRXport_Base.OnData(x, y: Integer; View: TfrView);
begin
	View.Draw(FCanvas);
end;

procedure TgtFRXport_Base.OnEndPage;
begin
  inherited;
	FCanvas.Free;
  FMetafileList.Add(FMetafile);
end;

procedure TgtFRXport_Base.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  FEngine := Value;
end;

end.

