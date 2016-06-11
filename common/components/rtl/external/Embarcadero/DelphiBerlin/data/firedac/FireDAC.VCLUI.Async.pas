{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC async notify form               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.VCLUI.Async;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  FireDAC.Stan.Intf,
  FireDAC.UI.Intf, FireDAC.VCLUI.OptsBase;

type
  TfrmFDGUIxFormsAsyncExecute = class(TfrmFDGUIxFormsOptsBase)
    tmrDelay: TTimer;
    btnCancel2: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
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
    function IsFormActive: Boolean;
    function IsFormMouseMessage(const AMsg: TMsg): Boolean;
{$ENDIF}
  end;

var
  frmFDGUIxFormsAsyncExecute: TfrmFDGUIxFormsAsyncExecute;

implementation

{$R *.dfm}

uses
  Vcl.Consts,
  FireDAC.Stan.Consts, FireDAC.Stan.Factory, FireDAC.Stan.ResStrs, FireDAC.Stan.Util,
  FireDAC.UI, FireDAC.VCLUI.Controls;

{-------------------------------------------------------------------------------}
{ TfrmFDGUIxFormsAsyncExecute                                                   }
{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsAsyncExecute.FormCreate(Sender: TObject);
begin
  Caption := S_FD_AsyncDialogDefCaption;
  lblPrompt.Caption := S_FD_AsyncDialogDefPrompt;
  FShowDelay := C_FD_DelayBeforeFWait;
  FHideDelay := C_FD_DelayBeforeFWait;
  btnCancel2.Caption := '&' + SCancelButton;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsAsyncExecute.FormDestroy(Sender: TObject);
begin
  if frmFDGUIxFormsAsyncExecute = Self then
    frmFDGUIxFormsAsyncExecute := nil;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsAsyncExecute.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then begin
    btnCancelClick(nil);
    Key := 0;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsAsyncExecute.btnCancelClick(Sender: TObject);
begin
  if (FExecutor <> nil) and FExecutor.Operation.AbortSupported then
    FExecutor.AbortJob;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsAsyncExecute.tmrDelayTimer(Sender: TObject);
begin
  if (FRequestShow <> Visible) and not (csDestroying in ComponentState) then begin
    FDGUIxCancel;
    if FRequestShow then begin
      FModalData := FDGUIxBeginModal(Self, False);
      inherited Show;
    end
    else begin
      if FModalData <> nil then
        FDGUIxEndModal(FModalData);
      inherited Hide;
    end;
    tmrDelay.Enabled := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsAsyncExecute.Show(const AExecutor: IFDStanAsyncExecutor);
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
procedure TfrmFDGUIxFormsAsyncExecute.Hide;
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
function TfrmFDGUIxFormsAsyncExecute.IsFormActive: Boolean;
begin
  Result := Screen.ActiveForm = Self;
end;

{-------------------------------------------------------------------------------}
function TfrmFDGUIxFormsAsyncExecute.IsFormMouseMessage(const AMsg: TMsg): Boolean;
var
  oCtrl: TControl;
begin
  oCtrl := FindControl(AMsg.hwnd);
  if oCtrl <> nil then
    Result := (GetParentForm(oCtrl) = Self)
  else
    Result := False;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TFDGUIxFormsAsyncExecuteImpl                                                  }
{-------------------------------------------------------------------------------}
type
  TFDGUIxFormsAsyncExecuteImpl = class(TFDGUIxObject, IFDGUIxAsyncExecuteDialog)
  private
    function GetForm: TfrmFDGUIxFormsAsyncExecute;
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
procedure TFDGUIxFormsAsyncExecuteImpl.Initialize;
begin
  inherited Initialize;
  frmFDGUIxFormsAsyncExecute := nil;
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxFormsAsyncExecuteImpl.Destroy;
begin
  FDFreeAndNil(frmFDGUIxFormsAsyncExecute);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsAsyncExecuteImpl.GetForm: TfrmFDGUIxFormsAsyncExecute;
begin
  if frmFDGUIxFormsAsyncExecute = nil then
    frmFDGUIxFormsAsyncExecute := TfrmFDGUIxFormsAsyncExecute.Create(Application);
  Result := frmFDGUIxFormsAsyncExecute;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsAsyncExecuteImpl.Show(const AExecutor: IFDStanAsyncExecutor);
begin
  if not FDGUIxSilent() then
    GetForm.Show(AExecutor);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsAsyncExecuteImpl.Hide;
begin
  if not FDGUIxSilent() then
    GetForm.Hide;
end;

{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
function TFDGUIxFormsAsyncExecuteImpl.IsFormActive: Boolean;
begin
  Result := not FDGUIxSilent() and GetForm.IsFormActive;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsAsyncExecuteImpl.IsFormMouseMessage(
  const AMsg: TMsg): Boolean;
begin
  Result := not FDGUIxSilent() and GetForm.IsFormMouseMessage(AMsg);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDGUIxFormsAsyncExecuteImpl.GetOnHide: TNotifyEvent;
begin
  Result := GetForm.OnHide;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsAsyncExecuteImpl.GetOnShow: TNotifyEvent;
begin
  Result := GetForm.OnShow;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsAsyncExecuteImpl.SetOnHide(const AValue: TNotifyEvent);
begin
  if Assigned(AValue) or Assigned(frmFDGUIxFormsAsyncExecute) then
    GetForm.OnHide := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsAsyncExecuteImpl.SetOnShow(const AValue: TNotifyEvent);
begin
  if Assigned(AValue) or Assigned(frmFDGUIxFormsAsyncExecute) then
    GetForm.OnShow := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsAsyncExecuteImpl.GetCaption: String;
begin
  Result := GetForm.Caption;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsAsyncExecuteImpl.SetCaption(const AValue: String);
begin
  if (AValue <> '') or Assigned(frmFDGUIxFormsAsyncExecute) then
    GetForm.Caption := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsAsyncExecuteImpl.GetPrompt: String;
begin
  Result := GetForm.lblPrompt.Caption;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsAsyncExecuteImpl.SetPrompt(const AValue: String);
begin
  if (AValue <> '') or Assigned(frmFDGUIxFormsAsyncExecute) then
    GetForm.lblPrompt.Caption := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsAsyncExecuteImpl.GetShowDelay: Integer;
begin
  Result := GetForm.FShowDelay;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsAsyncExecuteImpl.SetShowDelay(AValue: Integer);
begin
  if (AValue <> 0) or Assigned(frmFDGUIxFormsAsyncExecute) then
    GetForm.FShowDelay := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsAsyncExecuteImpl.GetHideDelay: Integer;
begin
  Result := GetForm.FHideDelay;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsAsyncExecuteImpl.SetHideDelay(AValue: Integer);
begin
  if (AValue <> 0) or Assigned(frmFDGUIxFormsAsyncExecute) then
    GetForm.FHideDelay := AValue;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDSingletonFactory.Create(TFDGUIxFormsAsyncExecuteImpl,
    IFDGUIxAsyncExecuteDialog, C_FD_GUIxFormsProvider);

finalization
  FDReleaseFactory(oFact);

end.
