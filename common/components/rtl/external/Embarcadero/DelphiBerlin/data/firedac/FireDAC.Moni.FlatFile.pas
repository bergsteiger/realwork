{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{       FireDAC monitor flat file implementation        }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Moni.FlatFile;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Consts, FireDAC.Stan.Util,
  FireDAC.Moni.Base, FireDAC.Moni.Custom;

{$IFDEF FireDAC_MONITOR}
type
  {-----------------------------------------------------------------------------}
  { TFDMoniFlatFileClientLink                                                   }
  {-----------------------------------------------------------------------------}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDMoniFlatFileClientLink = class(TFDMoniClientLinkBase)
  private
    FFFClient: IFDMoniFlatFileClient;
    FFileNameChanged: Boolean;
    function GetFileName: String;
    procedure SetFileName(const AValue: String);
    function GetFileAppend: Boolean;
    procedure SetFileAppend(const AValue: Boolean);
    function GetFileColumns: TFDTraceFileColumns;
    procedure SetFileColumns(const Value: TFDTraceFileColumns);
    function IsFNS: Boolean;
    function GetFileEncoding: TFDEncoding;
    procedure SetFileEncoding(AValue: TFDEncoding);
    function GetShowTraces: Boolean;
    procedure SetShowTraces(AValue: Boolean);
  protected
    function GetMoniClient: IFDMoniClient; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property FFClient: IFDMoniFlatFileClient read FFFClient;
  published
    property FileName: String read GetFileName write SetFileName stored IsFNS;
    property FileAppend: Boolean read GetFileAppend write SetFileAppend default False;
    property FileColumns: TFDTraceFileColumns read GetFileColumns write SetFileColumns
      default C_FD_MonitorColumns;
    property FileEncoding: TFDEncoding read GetFileEncoding write SetFileEncoding
      default ecDefault;
    property ShowTraces: Boolean read GetShowTraces write SetShowTraces default True;
    property Tracing;
  end;
{$ENDIF}

implementation

{$IFDEF FireDAC_MONITOR}
uses
  System.SysUtils, System.Variants,
  FireDAC.Stan.Factory, FireDAC.Stan.Tracer;

{-----------------------------------------------------------------------------}
{ TFDMoniFlatFileClient                                                       }
{-----------------------------------------------------------------------------}
type
  TFDMoniFlatFileClient = class(TFDMoniCustomClient, IFDMoniFlatFileClient)
  private
    FStarted: Boolean;
    FTracer: TFDTracer;
  protected
    // IFDMoniFlatFileClient
    function GetFileName: String;
    procedure SetFileName(const AValue: String);
    function GetFileAppend: Boolean;
    procedure SetFileAppend(const AValue: Boolean);
    function GetFileColumns: TFDTraceFileColumns;
    procedure SetFileColumns(const AValue: TFDTraceFileColumns);
    function GetFileEncoding: TFDEncoding;
    procedure SetFileEncoding(const AValue: TFDEncoding);
    // other
    procedure DoTraceMsg(const AClassName, AObjName, AMessage: String); override;
    function DoTracingChanged: Boolean; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    property Tracer: TFDTracer read FTracer;
  end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClient.Initialize;
begin
  inherited Initialize;
  FTracer := TFDTracer.Create;
  FTracer.TraceFileName := C_FD_MonitorFileName;
  FTracer.TraceFileAppend := C_FD_MonitorAppend;
  FTracer.TraceFileColumns := C_FD_MonitorColumns;
  FTracer.TraceFileEncoding := TFDEncoding(C_FD_MonitorEncoding);
  FStarted := False;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniFlatFileClient.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FTracer);
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
function TFDMoniFlatFileClient.DoTracingChanged: Boolean;
begin
  if GetTracing and not FStarted then begin
    FTracer.Resume;
    FStarted := True;
  end;
  FTracer.Active := GetTracing;
  Result := True;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClient.DoTraceMsg(const AClassName, AObjName,
  AMessage: String);
begin
  FTracer.TraceMsg(AClassName, AObjName, AMessage);
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClient.GetFileName: String;
begin
  Result := FTracer.TraceFileName;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClient.SetFileName(const AValue: String);
begin
  FTracer.TraceFileName := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClient.GetFileAppend: Boolean;
begin
  Result := FTracer.TraceFileAppend;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClient.SetFileAppend(const AValue: Boolean);
begin
  FTracer.TraceFileAppend := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClient.GetFileColumns: TFDTraceFileColumns;
begin
  Result := FTracer.TraceFileColumns;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClient.SetFileColumns(const AValue: TFDTraceFileColumns);
begin
  FTracer.TraceFileColumns := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClient.GetFileEncoding: TFDEncoding;
begin
  Result := FTracer.TraceFileEncoding;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClient.SetFileEncoding(const AValue: TFDEncoding);
begin
  FTracer.TraceFileEncoding := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDMoniFlatFileClientLink                                                     }
{-------------------------------------------------------------------------------}
constructor TFDMoniFlatFileClientLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFFClient := MoniClient as IFDMoniFlatFileClient;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniFlatFileClientLink.Destroy;
begin
  FFFClient := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClientLink.GetMoniClient: IFDMoniClient;
var
  oFFClient: IFDMoniFlatFileClient;
begin
  FDCreateInterface(IFDMoniFlatFileClient, oFFClient);
  Result := oFFClient as IFDMoniClient;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClientLink.GetFileName: String;
begin
  Result := FFClient.FileName;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClientLink.SetFileName(const AValue: String);
begin
  if (FFClient.FileName <> AValue) or (csReading in ComponentState) then begin
    FFClient.FileName := AValue;
    FFileNameChanged := (AValue <> '');
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClientLink.IsFNS: Boolean;
begin
  Result := FFileNameChanged;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClientLink.GetFileAppend: Boolean;
begin
  Result := FFClient.FileAppend;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClientLink.SetFileAppend(const AValue: Boolean);
begin
  FFClient.FileAppend := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClientLink.GetFileColumns: TFDTraceFileColumns;
begin
  Result := FFClient.FileColumns;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClientLink.SetFileColumns(const Value: TFDTraceFileColumns);
begin
  FFClient.FileColumns := Value;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClientLink.GetFileEncoding: TFDEncoding;
begin
  Result := FFClient.FileEncoding;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClientLink.SetFileEncoding(AValue: TFDEncoding);
begin
  FFClient.FileEncoding := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniFlatFileClientLink.GetShowTraces: Boolean;
begin
  Result := FADShowTraces;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniFlatFileClientLink.SetShowTraces(AValue: Boolean);
begin
  FADShowTraces := AValue;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDSingletonFactory.Create(TFDMoniFlatFileClient, IFDMoniFlatFileClient);

finalization
  FDReleaseFactory(oFact);
{$ENDIF}

end.
