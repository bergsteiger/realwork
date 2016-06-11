{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC FireMonkey Error dialog            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.FMXUI.Error;

interface

{$SCOPEDENUMS ON}

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes,
  FMX.Forms, FMX.Controls, FMX.ListBox, FMX.Layouts, FMX.Memo, FMX.Edit,
    FMX.TabControl, FMX.Objects, FMX.Types, FMX.ExtCtrls, FMX.Grid, FMX.StdCtrls, 
	FMX.Header,
  FireDAC.Stan.Intf, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.FMXUI.OptsBase;

type
  TfrmFDGUIxFMXError = class(TfrmFDGUIxFMXOptsBase)
    pcAdvanced: TTabControl;
    tsAdvanced: TTabItem;
    tsQuery: TTabItem;
    NativeLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtErrorCode: TEdit;
    edtServerObject: TEdit;
    edtMessage: TMemo;
    edtErrorKind: TEdit;
    edtCommandTextOffset: TEdit;
    Label9: TLabel;
    Label5: TLabel;
    lvCommandParams: TListBox;
    tsOther: TTabItem;
    Label6: TLabel;
    Label7: TLabel;
    edtClassName: TEdit;
    edtADCode: TEdit;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    pnlMsg: TPanel;
    memMsg: TMemo;
    pnlAdvanced: TPanel;
    btnCopy: TButton;
    pnlCopy: TPanel;
    Panel1: TPanel;
    mmCommandText: TMemo;
    Panel3: TPanel;
    Header1: THeader;
    HeaderItem1: THeaderItem;
    HeaderItem2: THeaderItem;
    Label12: TLabel;
    edtADObjName: TEdit;
    btnPrior: TButton;
    btnNext: TButton;
    procedure FormActivate(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure NextClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DetailsBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnCopyClick(Sender: TObject);
  private
    FError: EFDDBEngineException;
    FDetailsHeight, CurItem: Integer;
    FDetails: string;
    FPrevWidth: Integer;
    FOnHide: TFDGUIxErrorDialogEvent;
    FOnShow: TFDGUIxErrorDialogEvent;
    procedure UpdateLayout(ASwitching: Boolean);
    procedure ShowError;
    procedure ShowCommand;
  protected
    procedure Execute(AExc: EFDDBEngineException);
  end;

var
  frmFDGUIxFMXError: TfrmFDGUIxFMXError;

implementation

uses
  System.UITypes,
  FMX.Platform,
  FireDAC.Stan.Consts, FireDAC.Stan.Factory, FireDAC.Stan.Util, FireDAC.Stan.ResStrs,
  FireDAC.UI;

{$R *.fmx}

{ --------------------------------------------------------------------------- }
{ TfrmFDGUIxFMXError                                                          }
{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.FormCreate(Sender: TObject);
begin
  Caption := S_FD_ErrorDialogDefCaption;
  FDetailsHeight := ClientHeight;
  FDetails := btnCancel.Text;
  pnlAdvanced.Visible := True;
  DetailsBtnClick(nil);
  ActiveControl := btnOk;
  Visible := False;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.FormDestroy(Sender: TObject);
begin
  if frmFDGUIxFMXError = Self then
    frmFDGUIxFMXError := nil;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then begin
    ModalResult := mrCancel;
    Key := 0;
  end
  else if (ssCtrl in Shift) and ((KeyChar = 'C') or (Key = vkInsert)) then begin
    btnCopyClick(nil);
    Key := 0;
  end;
  inherited;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.btnCopyClick(Sender: TObject);
const
  C_Delim: String = '-------------------------------------------';
var
  oStrs: TFDStringList;
  i: Integer;
  oLI: TListBoxItem;
  oName, oValue: TText;
  oClpSrv: IFMXClipboardService;
begin
  oStrs := TFDStringList.Create;
  try
    oStrs.Add(Caption);
    oStrs.Add(lblPrompt.Text);
    oStrs.Add(C_Delim);
    oStrs.Add(Label4.Text + ' ' + edtMessage.Text);
    oStrs.Add(NativeLabel.Text + ' ' + edtErrorCode.Text);
    oStrs.Add(Label2.Text + ' ' + edtErrorKind.Text);
    oStrs.Add(Label1.Text + ' ' + edtServerObject.Text);
    oStrs.Add(Label3.Text + ' ' + edtCommandTextOffset.Text);
    oStrs.Add(C_Delim);
    oStrs.Add(Label9.Text + ' ' + mmCommandText.Text);
    oStrs.Add(Label5.Text);
    // Start from 1/skip the header
    for i := 1 to lvCommandParams.Items.Count - 1 do begin
      oLI := lvCommandParams.ListItems[i];
      oName := TText(oLI.FindStyleResource('Name'));
      oValue := TText(oLI.FindStyleResource('Value'));
      if (oName <> nil) and (oValue <> nil) then
        oStrs.Add('  ' + oName.Text + '=' + oValue.Text);
    end;
    oStrs.Add(C_Delim);
    oStrs.Add(Label6.Text + ' ' + edtClassName.Text);
    oStrs.Add(Label7.Text + ' ' + edtADCode.Text);
    oStrs.Add(Label12.Text + ' ' + edtADObjName.Text);
    if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(oClpSrv)) then
      oClpSrv.SetClipboard(oStrs.Text);
  finally
    FDFree(oStrs);
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.UpdateLayout(ASwitching: Boolean);
const
  DetailsOn: array [Boolean] of string = ('%s >>', '<< %s');
begin
  if pnlAdvanced.Visible then
    ClientHeight := FDetailsHeight
  else begin
    FDetailsHeight := ClientHeight;
    ClientHeight := ClientHeight - Trunc(pnlAdvanced.Height);
  end;
  btnCancel.Text := Format(DetailsOn[pnlAdvanced.Visible], [FDetails]);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.ShowError;
const
  ErrorKinds: array [TFDCommandExceptionKind] of String =
    ('Other', 'NoDataFound', 'TooManyRows', 'RecordLocked', 'UKViolated',
     'FKViolated', 'ObjNotExists', 'UserPwdInvalid', 'UserPwdExpired',
     'UserPwdWillExpire', 'CmdAborted', 'ServerGone', 'ServerOutput',
     'ArrExecMalfunc', 'InvalidParams');
var
  oError: TFDDBError;
  s: String;
  i: Integer;
begin
  btnPrior.Enabled := CurItem > 0;
  btnNext.Enabled := CurItem < FError.ErrorCount - 1;
  if CurItem > FError.ErrorCount - 1 then
    CurItem := FError.ErrorCount - 1
  else if CurItem < 0 then
    CurItem := 0;
  if FError.ErrorCount > 0 then begin
    oError := FError.Errors[CurItem];
    s := IntToStr(oError.ErrorCode);
    if oError.ErrorCode > 0 then
      for i := 1 to 5 - Length(s) do
        s := '0' + s;
    edtErrorCode.Text := s;
    edtErrorKind.Text := ErrorKinds[oError.Kind];
    edtMessage.Text := AdjustLineBreaks(oError.Message, tlbsCRLF);
    edtServerObject.Text := oError.ObjName;
    if oError.CommandTextOffset = -1 then
      edtCommandTextOffset.Text := ''
    else
      edtCommandTextOffset.Text := IntToStr(oError.CommandTextOffset);
  end
  else begin
    edtErrorCode.Text := '';
    edtErrorKind.Text := '';
    edtMessage.Text := '';
    edtServerObject.Text := '';
    edtCommandTextOffset.Text := '';
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.ShowCommand;
var
  i: Integer;
  oParams: TStrings;
  oLI: TListBoxItem;
  oText: TText;
begin
  mmCommandText.Text := FError.SQL;
  lvCommandParams.Clear;
  oParams := FError.Params;
  for i := 0 to oParams.Count - 1 do begin
    oLI := TListBoxItem.Create(Self);
    oLI.Parent := lvCommandParams;
    oLI.StyleLookup := 'LBReportStyle';
    oText := TText(oLI.FindStyleResource('Name'));
    if oText <> nil then
      oText.Text := oParams.KeyNames[i];
    oText := TText(oLI.FindStyleResource('Value'));
    if oText <> nil then
      oText.Text := oParams.ValueFromIndex[i];
  end;
  tsQuery.Visible := (Trim(mmCommandText.Text) <> '') or
    (lvCommandParams.Items.Count > 0);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.FormActivate(Sender: TObject);
begin
  memMsg.Text := AdjustLineBreaks(FError.Message, tlbsCRLF);
  edtClassName.Text := FError.ClassName;
  edtADCode.Text := IntToStr(FError.FDCode);
  edtADObjName.Text := FError.FDObjName;
  CurItem := 0;
  ShowError;
  ShowCommand;
  FPrevWidth := ClientWidth;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.BackClick(Sender: TObject);
begin
  Dec(CurItem);
  ShowError;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.NextClick(Sender: TObject);
begin
  Inc(CurItem);
  ShowError;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.DetailsBtnClick(Sender: TObject);
begin
  pnlAdvanced.Visible := not pnlAdvanced.Visible;
  UpdateLayout(True);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.Execute(AExc: EFDDBEngineException);
var
  oPrevForm: TCommonCustomForm;
  i: Integer;
begin
  if Assigned(FOnShow) then
    FOnShow(Self, AExc);
  FError := AExc;
  oPrevForm := nil;
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i].Active then begin
      oPrevForm := Screen.Forms[i];
      Break;
    end;
  if Application.MainForm <> nil then
    Application.MainForm.BringToFront;
  ShowModal;
  if oPrevForm <> nil then
    oPrevForm.BringToFront;
  FError := nil;
  if Assigned(FOnHide) then
    FOnHide(Self, AExc);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFMXError.FormResize(Sender: TObject);
begin
  FPrevWidth := ClientWidth;
end;

{ --------------------------------------------------------------------------- }
{ TFDGUIxErrorDialogImpl                                                      }
{ --------------------------------------------------------------------------- }
type
  TFDGUIxErrorDialogImpl = class(TFDGUIxObject, IFDGUIxErrorDialog)
  private
    FPrevOnException: TExceptionEvent;
    FHandlingException: Boolean;
    function GetForm: TfrmFDGUIxFMXError;
    procedure HandleException(Sender: TObject; E: Exception);
  protected
    // IFDGUIxErrorDialog
    function GetOnShow: TFDGUIxErrorDialogEvent;
    procedure SetOnShow(const AValue: TFDGUIxErrorDialogEvent);
    function GetOnHide: TFDGUIxErrorDialogEvent;
    procedure SetOnHide(const AValue: TFDGUIxErrorDialogEvent);
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function GetEnabled: Boolean;
    procedure SetEnabled(const AValue: Boolean);
    function GetStayOnTop: Boolean;
    procedure SetStayOnTop(const AValue: Boolean);
    procedure Execute(AExc: EFDDBEngineException);
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxErrorDialogImpl.Initialize;
begin
  inherited Initialize;
  frmFDGUIxFMXError := nil;
  SetEnabled(True);
end;

{ --------------------------------------------------------------------------- }
destructor TFDGUIxErrorDialogImpl.Destroy;
begin
  SetEnabled(False);
  FDFreeAndNil(frmFDGUIxFMXError);
  inherited Destroy;
end;

{ --------------------------------------------------------------------------- }
function TFDGUIxErrorDialogImpl.GetForm: TfrmFDGUIxFMXError;
begin
  if frmFDGUIxFMXError = nil then
    frmFDGUIxFMXError := TfrmFDGUIxFMXError.Create(Application);
  Result := frmFDGUIxFMXError;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxErrorDialogImpl.HandleException(Sender: TObject; E: Exception);
begin
  if (E is EFDDBEngineException) and not Application.Terminated and
     not FHandlingException then begin
    FHandlingException := True;
    try
      Execute(EFDDBEngineException(E))
    finally
      FHandlingException := False;
    end;
  end
  else if Assigned(FPrevOnException) then
    FPrevOnException(Sender, E)
  else
    Application.ShowException(E);
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxErrorDialogImpl.Execute(AExc: EFDDBEngineException);
begin
  if not FDGUIxSilent() then
    GetForm.Execute(AExc);
end;

{ --------------------------------------------------------------------------- }
function TFDGUIxErrorDialogImpl.GetOnHide: TFDGUIxErrorDialogEvent;
begin
  Result := GetForm.FOnHide;
end;

{ --------------------------------------------------------------------------- }
function TFDGUIxErrorDialogImpl.GetOnShow: TFDGUIxErrorDialogEvent;
begin
  Result := GetForm.FOnShow;
end;

{ --------------------------------------------------------------------------- }
function TFDGUIxErrorDialogImpl.GetCaption: String;
begin
  Result := GetForm.Caption;
end;

{ --------------------------------------------------------------------------- }
function TFDGUIxErrorDialogImpl.GetEnabled: Boolean;
var
  oHndlExc: TExceptionEvent;
begin
  oHndlExc := HandleException;
  Result := (Application <> nil) and
            (TMethod(Application.OnException).Code = TMethod(oHndlExc).Code) and
            (TMethod(Application.OnException).Data = TMethod(oHndlExc).Data);
end;

{ --------------------------------------------------------------------------- }
function TFDGUIxErrorDialogImpl.GetStayOnTop: Boolean;
begin
  Result := GetForm.FormStyle = TFormStyle.StayOnTop;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxErrorDialogImpl.SetOnHide(const AValue: TFDGUIxErrorDialogEvent);
begin
  if Assigned(AValue) or Assigned(frmFDGUIxFMXError) then
    GetForm.FOnHide := AValue;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxErrorDialogImpl.SetOnShow(const AValue: TFDGUIxErrorDialogEvent);
begin
  if Assigned(AValue) or Assigned(frmFDGUIxFMXError) then
    GetForm.FOnShow := AValue;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxErrorDialogImpl.SetCaption(const AValue: String);
begin
  if (AValue <> '') or Assigned(frmFDGUIxFMXError) then
    GetForm.Caption := AValue;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxErrorDialogImpl.SetEnabled(const AValue: Boolean);
begin
  if GetEnabled <> AValue then
    if AValue then begin
      FPrevOnException := Application.OnException;
      Application.OnException := HandleException;
    end
    else begin
      if Application <> nil then
        Application.OnException := FPrevOnException;
      FPrevOnException := nil;
    end;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxErrorDialogImpl.SetStayOnTop(const AValue: Boolean);
begin
  if AValue then
    GetForm.FormStyle := TFormStyle.StayOnTop
  else
    GetForm.FormStyle := TFormStyle.Normal;
end;

{ --------------------------------------------------------------------------- }
var
  oFact: TFDFactory;

initialization
  oFact := TFDSingletonFactory.Create(TFDGUIxErrorDialogImpl,
    IFDGUIxErrorDialog, C_FD_GUIxFMXProvider);

finalization
  FDReleaseFactory(oFact);

end.
