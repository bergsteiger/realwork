{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC script processing form             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.VCLUI.Script;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
    Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ImgList,
  FireDAC.Stan.Intf,
  FireDAC.UI.Intf, FireDAC.VCLUI.OptsBase, FireDAC.VCLUI.Controls;

type
  TfrmFDGUIxFormsfScript = class(TfrmFDGUIxFormsOptsBase)
    pnlPrcLocation: TPanel;
    tvPrcLocation: TTreeView;
    pbPrcMain: TProgressBar;
    Label1: TLabel;
    lblTotalSize: TLabel;
    Label3: TLabel;
    lblTotalDone: TLabel;
    Label5: TLabel;
    lblTotalPctDone: TLabel;
    Label2: TLabel;
    lblTotalErrors: TLabel;
    Timer1: TTimer;
    pnlPrcOutput: TPanel;
    lbPrcOutput: TListBox;
    procedure btnCancelClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FModalData: Pointer;
    FIsRunning: Boolean;
    FRequestStop: Boolean;
    procedure InternalHide(AImmediately: Boolean);
  protected
    FOnProgress: TFDGUIxScriptProgressEvent;
    FOnOutput: TFDGUIxScriptOutputEvent;
    FOnInput: TFDGUIxScriptInputEvent;
    FOnPause: TFDGUIxScriptPauseEvent;
    FOptions: TFDGUIxScriptOptions;
    // IFDGUIxScriptDialog
    procedure Show;
    procedure Progress(const AInfoProvider: IFDGUIxScriptDialogInfoProvider);
    procedure Output(const AStr: String);
    procedure Input(const APrompt: String; var AResult: String);
    procedure Pause(const APrompt: String);
    procedure Hide;
  end;

var
  frmFDGUIxFormsfScript: TfrmFDGUIxFormsfScript;

implementation

{$R *.dfm}

uses
  System.UITypes,
  FireDAC.Stan.Consts, FireDAC.Stan.Factory, FireDAC.Stan.ResStrs, FireDAC.Stan.Util,
  FireDAC.UI;

{-------------------------------------------------------------------------------}
{ TfrmFDGUIxFormsfScript                                                        }
{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.Show;
var
  iDeltaH, iPrcLocH, iPrcOutH: Integer;
begin
  btnCancel.Caption := '&Cancel';
  Timer1.Enabled := False;
  tvPrcLocation.Items.Clear;
  lbPrcOutput.Items.Clear;
  pbPrcMain.Position := 0;
  FIsRunning := False;
  FRequestStop := False;
  iDeltaH := 0;
  iPrcLocH := pnlPrcLocation.Height;
  iPrcOutH := pnlPrcOutput.Height;
  if ssCallstack in FOptions then begin
    if not pnlPrcLocation.Visible then begin
      pnlPrcLocation.Visible := True;
      iDeltaH := iPrcLocH;
    end;
  end
  else begin
    if pnlPrcLocation.Visible then begin
      iDeltaH := - iPrcLocH;
      pnlPrcLocation.Visible := False;
    end;
  end;
  if ssConsole in FOptions then begin
    if not pnlPrcOutput.Visible then begin
      pnlPrcOutput.Visible := True;
      iDeltaH := iDeltaH + iPrcOutH;
    end;
  end
  else begin
    if pnlPrcOutput.Visible then begin
      iDeltaH := iDeltaH - iPrcOutH;
      pnlPrcOutput.Visible := False;
    end;
  end;
  Height := Height + iDeltaH;
  if not Visible then begin
    FDGUIxCancel;
    FModalData := FDGUIxBeginModal(Self);
    inherited Show;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.Output(const AStr: String);
var
  i: Integer;
  lOnLastItem: Boolean;
  s: String;
begin
  if not Visible or not pnlPrcOutput.Visible then
    Exit;
  lOnLastItem := lbPrcOutput.ItemIndex = lbPrcOutput.Items.Count - 1;
  s := AStr;
  for i := 1 to Length(s) do
    if FDInSet(s[i], [#13, #10, #9]) then
      s[i] := ' ';
  lbPrcOutput.Items.Add(s);
  if lOnLastItem then begin
    lbPrcOutput.ItemIndex := lbPrcOutput.Items.Count - 1;
    i := lbPrcOutput.Items.Count - lbPrcOutput.Height div lbPrcOutput.ItemHeight - 1;
    if i < 0 then
      i := 0;
    lbPrcOutput.TopIndex := i;
  end;
  Application.ProcessMessages;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.Input(const APrompt: String; var AResult: String);
begin
  if APrompt <> '' then
    Output(APrompt);
  AResult := InputBox('SQL Script', APrompt, AResult);
  Output(AResult);
  Output('');
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.Pause(const APrompt: String);
var
  s: String;
begin
  s := APrompt;
  if s <> '' then
    Output(s)
  else
    s := 'Press OK to continue';
  MessageBox(0, PChar(s), PChar('SQL Script'), MB_OK);
  Output('');
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.Progress(const AInfoProvider: IFDGUIxScriptDialogInfoProvider);
var
  oItem: TTreeNode;
  i: Integer;
begin
  if not Visible then
    Exit;
  FIsRunning := AInfoProvider.IsRunning;
  pbPrcMain.Position := AInfoProvider.TotalPct10Done;
  if pnlPrcLocation.Visible then begin
    tvPrcLocation.Items.BeginUpdate;
    try
      tvPrcLocation.Items.Clear;
      oItem := nil;
      for i := 0 to AInfoProvider.CallStack.Count - 1 do
        oItem := tvPrcLocation.Items.AddChild(oItem, AInfoProvider.CallStack[i]);
      if oItem <> nil then begin
        oItem.Selected := True;
        oItem.Focused := True;
        oItem.MakeVisible;
      end;
    finally
      tvPrcLocation.Items.EndUpdate;
    end;
  end;
  if AInfoProvider.TotalJobSize <= 0 then
    lblTotalSize.Caption := '<unknown>'
  else if AInfoProvider.TotalJobSize < 1000 then
    lblTotalSize.Caption := Format('%d bytes', [AInfoProvider.TotalJobSize])
  else if AInfoProvider.TotalJobSize < 1000000 then
    lblTotalSize.Caption := FormatFloat('0.000 Kb', AInfoProvider.TotalJobSize / 1000)
  else
    lblTotalSize.Caption := FormatFloat('0.000 Mb', AInfoProvider.TotalJobSize / 1000000);
  if AInfoProvider.TotalJobDone < 1000 then
    lblTotalDone.Caption := Format('%d bytes', [AInfoProvider.TotalJobDone])
  else if AInfoProvider.TotalJobDone < 1000000 then
    lblTotalDone.Caption := FormatFloat('0.000 Kb', AInfoProvider.TotalJobDone / 1000)
  else
    lblTotalDone.Caption := FormatFloat('0.000 Mb', AInfoProvider.TotalJobDone / 1000000);
  if AInfoProvider.TotalJobSize <= 0 then
    lblTotalPctDone.Caption := '<unknown>'
  else
    lblTotalPctDone.Caption := FormatFloat('0.0 %', AInfoProvider.TotalPct10Done / 10);
  lblTotalErrors.Caption := Format('%d', [AInfoProvider.TotalErrors]);
  if FRequestStop then
    AInfoProvider.RequestStop;
  if Assigned(FOnProgress) then
    FOnProgress(Self, AInfoProvider as TObject);
  Application.ProcessMessages;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.InternalHide(AImmediately: Boolean);
begin
  if not Visible then
    Exit;
  if not AImmediately then
    Timer1.Enabled := True
  else begin
    tvPrcLocation.Items.Clear;
    lbPrcOutput.Items.Clear;
    pbPrcMain.Position := 0;
    inherited Hide;
    FDGUIxEndModal(FModalData);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.Hide;
begin
  if ssAutoHide in FOptions then
    InternalHide(False)
  else
    btnCancel.Caption := '&Hide';
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.btnCancelClick(Sender: TObject);
begin
  if FIsRunning and not FRequestStop then begin
    if MessageDlg('Do you really want to cancel script execution ?',
                  mtConfirmation, [mbYes, mbNo], -1) = mrYes then
      FRequestStop := True;
  end
  else if not FIsRunning then
    InternalHide(True);
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsfScript.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  InternalHide(True);
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxFormsScriptImpl                                                        }
{-------------------------------------------------------------------------------}
type
  TFDGUIxFormsScriptImpl = class(TFDGUIxVisualScriptImplBase)
  private
    FForm: TfrmFDGUIxFormsfScript;
  protected
    // IFDGUIxScriptDialog
    procedure Show; override;
    procedure Progress(const AInfoProvider: IFDGUIxScriptDialogInfoProvider); override;
    procedure Output(const AStr: String; AKind: TFDScriptOutputKind); override;
    procedure Input(const APrompt: String; var AResult: String); override;
    procedure Pause(const APrompt: String); override;
    procedure Hide; override;
  public
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxFormsScriptImpl.Destroy;
begin
  FDFreeAndNil(FForm);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsScriptImpl.Show;
begin
  if FDGUIxSilent() then
    Exit;
  if FForm = nil then
    FForm := TfrmFDGUIxFormsfScript.Create(nil);
  FForm.OnShow := FOnShow;
  FForm.OnHide := FOnHide;
  FForm.FOnProgress := FOnProgress;
  FForm.FOnOutput := FOnOutput;
  FForm.FOnInput := FOnInput;
  FForm.FOnPause := FOnPause;
  FForm.FOptions := FOptions;
  FForm.Caption := FCaption;
  FForm.Show;
  Application.ProcessMessages;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsScriptImpl.Progress(
  const AInfoProvider: IFDGUIxScriptDialogInfoProvider);
begin
  if FDGUIxSilent() or (FForm = nil) then
    Exit;
  FForm.Progress(AInfoProvider);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsScriptImpl.Output(const AStr: String; AKind: TFDScriptOutputKind);
begin
  if FDGUIxSilent() or (FForm = nil) then
    Exit;
  FForm.Output(AStr);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsScriptImpl.Input(const APrompt: String;
  var AResult: String);
begin
  AResult := '';
  if FDGUIxSilent() or (FForm = nil) then
    Exit;
  FForm.Input(APrompt, AResult);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsScriptImpl.Pause(const APrompt: String);
begin
  if FDGUIxSilent() or (FForm = nil) then
    Exit;
  FForm.Pause(APrompt);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFormsScriptImpl.Hide;
begin
  if (FForm <> nil) and FForm.Visible then
    FForm.Hide;
  Application.ProcessMessages;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDGUIxFormsScriptImpl,
    IFDGUIxScriptDialog, C_FD_GUIxFormsProvider);

finalization
  FDReleaseFactory(oFact);

end.
