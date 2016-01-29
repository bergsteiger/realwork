unit F_DictItemEdit;

{$Include l3Define.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OvcBase, afwControl, evEditorWindow,
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations, evMemo,

  l3Types, l3Interfaces, Buttons, evCustomMemo, evCustomMemoTextSource,
  afwControlPrim, afwBaseControl, nevControl, evCustomEditorWindowPrim,
  evCustomEditorWindowModelPart, evCustomEditorModelPart, daTypes,
  Dt_Types, dt_AttrSchema, evCustomEditorWindow;

type
  TDictItemEditFrame = class(TFrame)
    pnlName: TPanel;
    lblNameRus: TLabel;
    sbSpellChecker: TSpeedButton;
    lblNameEng: TLabel;
    mNameRus: TevMemo;
    mNameEng: TevMemo;
    AddedDataPanel: TPanel;
    pnlExtCode: TPanel;
    Label2: TLabel;
    edtCode: TEdit;
    pnlExtPrivate: TPanel;
    cbxPrivate: TCheckBox;
    cbxIsNonPeriodic: TCheckBox;
    procedure pnlNameResize(Sender: TObject);
    procedure mNameTextSourceBruttoCharCountChange(Sender: TObject);
  private
    fExtParams : TDictExtParams;
    fExtNeedFillParams : TDictExtParams;
    fROnly     : Boolean;
    fBiLingual : Boolean;
    function GetIsPrivate : Byte;
    function GetIsNonPeriodic : Byte;
    function GetCode : String;

    procedure SetEditTextR(const Value : Tl3PCharLen);
    function  GetEditTextR : Tl3PCharLen;
    procedure SetEditTextE(const Value : Tl3PCharLen);
    function  GetEditTextE : Tl3PCharLen;

    procedure mEditorCharCountChangeRus(Sender: TObject);
    procedure mEditorCharCountChangeEng(Sender: TObject);

    procedure sbSpellCheckerClick(Sender: TObject);

  public
    procedure SetBiLingual(aValue : Boolean); virtual;
    procedure SetROnly(aValue : boolean);

    function Validate : boolean;
    property IsPrivate : Byte read GetIsPrivate;
    property IsNonPeriodic : Byte read GetIsNonPeriodic;
    property Code : String read GetCode;

    procedure Init(aDictID : TdaDictionaryType);
    property EditTextR : Tl3PCharLen read GetEditTextR write SetEditTextR;
    property EditTextE : Tl3PCharLen read GetEditTextE write SetEditTextE;
    property BiLingual : Boolean read fBiLingual write SetBiLingual;
  end;

implementation

{$R *.dfm}
uses
  StrShop,
  vtDialogs,

  DT_Const,
  DictsSup,
  D_Spell,

  evFacadTextSource,
  evTypes,
  l3Base,
  l3String,
  Main;

{$IFDEF Archi}
{$INCLUDE ArchiDefine.inc}
{$ENDIF Archi} 

resourcestring
 sidName    = 'Название';
 sidNameRus = 'Название на русском';
 sidNameEng = 'Название на английском';

procedure TDictItemEditFrame.SetROnly(aValue : boolean);
begin
 //OK.Enabled := not aValue;
 mNameRus.ReadOnly := aValue;
 mNameEng.ReadOnly := aValue;
 edtCode.Enabled := Not aValue;
 cbxPrivate.Enabled := Not aValue;
 cbxIsNonPeriodic.Enabled := Not aValue;
end;

function TDictItemEditFrame.GetIsPrivate : Byte;
begin
 if depPrivate in fExtParams then
 begin
  if cbxPrivate.Checked then
   Result := 1
  else
   Result := 0;
 end
 else
  Result := cEmptyByte;
end;

function TDictItemEditFrame.GetIsNonPeriodic : Byte;
begin
 if depPrivate in fExtParams then
 begin
  if cbxIsNonPeriodic.Checked then
   Result := 1
  else
   Result := 0;
 end
 else
  Result := cEmptyByte;
end;

function TDictItemEditFrame.GetCode : String;
begin
 if depCode in fExtParams then
  Result := edtCode.Text
 else
  Result := PChar(nil);
end;

function TDictItemEditFrame.Validate : boolean;
begin
 Result := True;

 if (Trim(mNameRus.Text) = '') then
 begin
  ShowMessage(Format(sidCanNotBeEmpty, [sidNameRus]));
  GetParentForm(Self).ActiveControl := mNameRus;
  Result := False;
  Exit;
 end;

 if (depCode in fExtNeedFillParams) and (Trim(edtCode.Text) = '') then
 begin
  ShowMessage(Format(sidFieldEmptyErr, ['Код']));
   GetParentForm(Self).ActiveControl := edtCode;
  Result := False;
  Exit;
 end;
end;

procedure TDictItemEditFrame.Init(aDictID : TdaDictionaryType);
var
 lHeight : Integer;
 lMaxTextLen : Integer;

begin
 sbSpellChecker.Enabled := False;
 lMaxTextLen := GetDictNameLength(aDictID);

 pnlName.OnResize := pnlNameResize;

 if lMaxTextLen <> 0 then
 begin
  evSetBruttoCharLimit(mNameRus.TextSource, lMaxTextLen + 2);
  evSetNettoCharCountEvent(mNameRus.TextSource, mEditorCharCountChangeRus);
  mEditorCharCountChangeRus(Self);
  evSetBruttoCharLimit(mNameEng.TextSource, lMaxTextLen + 2);
  evSetNettoCharCountEvent(mNameEng.TextSource, mEditorCharCountChangeEng);
 end;

 SetBiLingual(fBiLingual);

 fExtParams := GetDictExtParams(aDictID);
 lHeight := 0;

 if fExtParams <> [] then
 begin
  if depCode in fExtParams then
   Inc(lHeight, pnlExtCode.Height);
  pnlExtCode.Visible := depCode in fExtParams;

  pnlExtPrivate.Visible := (depPrivate in fExtParams) and (depNonPeriodic in fExtParams);

  if pnlExtPrivate.Visible then
   Inc(lHeight, pnlExtPrivate.Height);

  cbxIsNonPeriodic.Enabled := not fROnly and (depNonPeriodic in fExtParams);
 end;

 if lHeight > 0 then
  AddedDataPanel.Height := lHeight;
 AddedDataPanel.Visible := lHeight > 0;
end;

procedure TDictItemEditFrame.SetEditTextR(const Value : Tl3PCharLen);
begin
 mNameRus.Buffer := Value;
 {NameEditor.IsOpen := True;}
end;

function  TDictItemEditFrame.GetEditTextR : Tl3PCharLen;
begin
 Tl3WString(Result) := mNameRus.Buffer;
end;

procedure TDictItemEditFrame.mEditorCharCountChangeRus(Sender: TObject);
begin
with mNameRus.TextSource.Processor do
  if BiLingual then
   lblNameRus.Caption := Format(sidNameRus + ' ' + scFmtCounter, [evGetNettoCharCount(mNameRus.TextSource), evGetBruttoCharLimit(mNameRus.TextSource) - 2])
  else
   lblNameRus.Caption := Format(sidName + ' ' + scFmtCounter, [evGetNettoCharCount(mNameRus.TextSource), evGetBruttoCharLimit(mNameRus.TextSource) - 2]);
end;

procedure TDictItemEditFrame.mEditorCharCountChangeEng(Sender: TObject);
begin
with mNameEng.TextSource.Processor do
 lblNameEng.Caption := Format(sidNameEng + ' ' + scFmtCounter, [evGetNettoCharCount(mNameEng.TextSource), evGetBruttoCharLimit(mNameEng.TextSource) - 2]);
end;

procedure TDictItemEditFrame.sbSpellCheckerClick(Sender: TObject);
var
 lCurEditor    : TevMemo;
begin
 if  GetParentForm(Self).ActiveControl = mNameEng then
  lCurEditor := mNameEng
 else
  lCurEditor := mNameRus;
 TSpellCheckDlg.Execute(lCurEditor, MainForm.SpellDictionary);
 TSpellCheckDlg.CloseSpellCheck;
end;

procedure TDictItemEditFrame.SetBiLingual(aValue : Boolean);
begin
 fBiLingual := aValue;
 If fBiLingual then
 begin
  mNameRus.Height := (pnlName.ClientHeight - TControl(mNameRus).Left) div 2 - TControl(mNameRus).Top;

  lblNameEng.Top := (pnlName.ClientHeight - TControl(mNameRus).Left) div 2 + lblNameRus.Top;
  lblNameEng.Visible := True;

  TControl(mNameEng).Top := (pnlName.ClientHeight - TControl(mNameRus).Left) div 2 + TControl(mNameRus).Top;
  mNameEng.Height := pnlName.ClientHeight - TControl(mNameEng).Top - TControl(mNameRus).Left;
  //mNameRus.Height;

  lblNameRus.Caption := sidNameRus;
  mNameEng.Visible := True;
 end
 else
 begin
  mNameRus.Height := pnlName.ClientHeight - TControl(mNameRus).Top - TControl(mNameRus).Left;

  lblNameEng.Visible := False;
  lblNameRus.Caption := sidName;
  mNameEng.Visible := False;
 end;
end;

procedure TDictItemEditFrame.pnlNameResize(Sender: TObject);
begin
  inherited;
  SetBiLingual(fBiLingual);
end;

function TDictItemEditFrame.GetEditTextE: Tl3PCharLen;
begin
 if fBiLingual then
  Tl3WString(Result) := mNameEng.Buffer
 else
  Result := l3PCharLen;
end;

procedure TDictItemEditFrame.SetEditTextE(const Value: Tl3PCharLen);
begin
 mNameEng.Buffer := Value;
end;

procedure TDictItemEditFrame.mNameTextSourceBruttoCharCountChange(Sender: TObject);
begin
 sbSpellChecker.Enabled := True;
end;

end.