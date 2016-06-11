{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{         FireDAC FireMonkey async notify form          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.FMXUI.Async;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes,
  FMX.Forms, FMX.Controls, FMX.Objects, FMX.Types, FMX.Effects, FMX.StdCtrls,
  FireDAC.Stan.Intf,
  FireDAC.UI.Intf, FireDAC.FMXUI.OptsBase;

type
  TfrmFDGUIxFMXAsyncExecute = class(TfrmFDGUIxFMXOptsBase)
    pnlBlur: TPanel;
    aniProgress: TAniIndicator;
    lblText: TLabel;
    btnCancel2: TButton;
    tmrDelay: TTimer;
    rectBorder: TRectangle;
    lblTitle: TLabel;
    pnlBottom: TPanel;
    StyleBook1: TStyleBook;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure tmrDelayTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FExecutor: IFDStanAsyncExecutor;
    FRequestShow: Boolean;
    FModalData: Pointer;
    FShowDelay, FHideDelay: Integer;
  protected
    // IFDGUIxAsyncExecuteDialog
    procedure Show(const AExecutor: IFDStanAsyncExecutor);
    procedure Hide;
{$IFDEF MSWINDOWS}
    function IsFormMouseMessage(const AMsg: TMsg): Boolean;
{$ENDIF}
  end;

implementation

{$R *.fmx}

uses
  System.Types,
  FMX.Platform,
  FireDAC.Stan.Consts, FireDAC.Stan.Factory, FireDAC.Stan.ResStrs, FireDAC.Stan.Util,
  FireDAC.UI;

var
  frmFDGUIxFMXAsyncExecute: TfrmFDGUIxFMXAsyncExecute;

{-------------------------------------------------------------------------------}
{ TfrmFDGUIxFMXAsyncExecute                                                     }
{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXAsyncExecute.FormCreate(Sender: TObject);
begin
  lblText.Text := S_FD_AsyncDialogDefPrompt;
  FShowDelay := C_FD_DelayBeforeFWait;
  FHideDelay := C_FD_DelayBeforeFWait;
  lblTitle.Text := S_FD_AsyncDialogDefCaption;
  pnlButtons.Visible := False;
  pnlTop.Visible := False;
  FCentered := True;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXAsyncExecute.FormDestroy(Sender: TObject);
begin
  if frmFDGUIxFMXAsyncExecute = Self then
    frmFDGUIxFMXAsyncExecute := nil;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXAsyncExecute.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
{$IFDEF MSWINDOWS}
  if Key = VK_ESCAPE then begin
    btnCancelClick(nil);
    Key := 0;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXAsyncExecute.btnCancelClick(Sender: TObject);
begin
  if (FExecutor <> nil) and FExecutor.Operation.AbortSupported then
    FExecutor.AbortJob;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXAsyncExecute.tmrDelayTimer(Sender: TObject);
begin
  if (FRequestShow <> Visible) and not (csDestroying in ComponentState) then begin
    FDGUIxFMXCancel;
    if FRequestShow then begin
      FModalData := FDGUIxFMXBeginModal(Self, False);
      inherited Show;
    end
    else begin
      if FModalData <> nil then
        FDGUIxFMXEndModal(FModalData);
      inherited Hide;
    end;
    tmrDelay.Enabled := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXAsyncExecute.Show(const AExecutor: IFDStanAsyncExecutor);
begin
  FExecutor := AExecutor;
  if not FRequestShow then begin
    FRequestShow := True;
    btnCancel2.Visible := AExecutor.Operation.AbortSupported;
    tmrDelay.Interval := FShowDelay;
    tmrDelay.Enabled := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXAsyncExecute.Hide;
begin
  if FRequestShow then begin
    FRequestShow := False;
    FExecutor := nil;
    tmrDelay.Interval := FHideDelay;
    tmrDelay.Enabled := True;
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
function TfrmFDGUIxFMXAsyncExecute.IsFormMouseMessage(const AMsg: TMsg): Boolean;
var
  rMousePos: TPointF;
  oCtrl: IControl;
  oMouseSrv: IFMXMouseService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXMouseService, IInterface(oMouseSrv)) then
    rMousePos := oMouseSrv.GetMousePos
  else begin
    Result := False;
    Exit;
  end;
  oCtrl := ObjectAtPoint(rMousePos);
  Result := (oCtrl <> nil);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TFDGUIxFMXAsyncExecuteImpl                                                    }
{-------------------------------------------------------------------------------}
type
  TFDGUIxFMXAsyncExecuteImpl = class(TFDGUIxObject, IFDGUIxAsyncExecuteDialog)
  private
    function GetForm: TfrmFDGUIxFMXAsyncExecute;
  protected
    // IFDGUIxAsyncExecuteDialog
    function GetOnShow: TNotifyEvent;
    procedure SetOnShow(const AValue: TNotifyEvent);
    function GetOnHide: TNotifyEvent;
    procedure SetOnHide(const AValue: TNotifyEvent);
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function GetPrompt: String;
    procedure SetPrompt(const AValue: String);
    function GetShowDelay: Integer;
    procedure SetShowDelay(AValue: Integer);
    function GetHideDelay: Integer;
    procedure SetHideDelay(AValue: Integer);
    procedure Show(const AExecutor: IFDStanAsyncExecutor);
    procedure Hide;
{$IFDEF MSWINDOWS}
    function IsFormActive: Boolean;
    function IsFormMouseMessage(const AMsg: TMsg): Boolean;
{$ENDIF}
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.Initialize;
begin
  inherited Initialize;
  frmFDGUIxFMXAsyncExecute := nil;
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxFMXAsyncExecuteImpl.Destroy;
begin
  FDFreeAndNil(frmFDGUIxFMXAsyncExecute);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXAsyncExecuteImpl.GetForm: TfrmFDGUIxFMXAsyncExecute;
begin
  if frmFDGUIxFMXAsyncExecute = nil then
    frmFDGUIxFMXAsyncExecute := TfrmFDGUIxFMXAsyncExecute.Create(Application);
  Result := frmFDGUIxFMXAsyncExecute;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.Show(const AExecutor: IFDStanAsyncExecutor);
var
  oWait: IFDGUIxWaitCursor;
begin
  if not FDGUIxSilent() then begin
    FDCreateInterface(IFDGUIxWaitCursor, oWait);
    oWait.PopWait;
    GetForm.Show(AExecutor);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.Hide;
var
  oWait: IFDGUIxWaitCursor;
begin
  if not FDGUIxSilent() then begin
    FDCreateInterface(IFDGUIxWaitCursor, oWait);
    oWait.PushWait;
    GetForm.Hide;
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
function TFDGUIxFMXAsyncExecuteImpl.IsFormActive: Boolean;
begin
  Result := not FDGUIxSilent() and GetForm.Active;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXAsyncExecuteImpl.IsFormMouseMessage(const AMsg: TMsg): Boolean;
begin
  Result := not FDGUIxSilent() and GetForm.IsFormMouseMessage(AMsg);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDGUIxFMXAsyncExecuteImpl.GetOnHide: TNotifyEvent;
begin
  Result := GetForm.OnHide;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXAsyncExecuteImpl.GetOnShow: TNotifyEvent;
begin
  Result := GetForm.OnShow;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.SetOnHide(const AValue: TNotifyEvent);
begin
  if Assigned(AValue) or Assigned(frmFDGUIxFMXAsyncExecute) then
    GetForm.OnHide := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.SetOnShow(const AValue: TNotifyEvent);
begin
  if Assigned(AValue) or Assigned(frmFDGUIxFMXAsyncExecute) then
    GetForm.OnShow := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXAsyncExecuteImpl.GetCaption: String;
begin
  Result := GetForm.lblTitle.Text;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.SetCaption(const AValue: String);
begin
  if (AValue <> '') or Assigned(frmFDGUIxFMXAsyncExecute) then
    GetForm.lblTitle.Text := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXAsyncExecuteImpl.GetPrompt: String;
begin
  Result := GetForm.lblText.Text;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.SetPrompt(const AValue: String);
begin
  if (AValue <> '') or Assigned(frmFDGUIxFMXAsyncExecute) then
    GetForm.lblText.Text := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXAsyncExecuteImpl.GetShowDelay: Integer;
begin
  Result := GetForm.FShowDelay;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.SetShowDelay(AValue: Integer);
begin
  if (AValue <> 0) or Assigned(frmFDGUIxFMXAsyncExecute) then
    GetForm.FShowDelay := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXAsyncExecuteImpl.GetHideDelay: Integer;
begin
  Result := GetForm.FHideDelay;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXAsyncExecuteImpl.SetHideDelay(AValue: Integer);
begin
  if (AValue <> 0) or Assigned(frmFDGUIxFMXAsyncExecute) then
    GetForm.FHideDelay := AValue;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDSingletonFactory.Create(TFDGUIxFMXAsyncExecuteImpl,
    IFDGUIxAsyncExecuteDialog, C_FD_GUIxFMXProvider);

finalization
  FDReleaseFactory(oFact);

end.
