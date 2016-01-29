unit D_NameEd;

{ $Id: D_NameEd.pas,v 1.37 2012/07/30 09:11:33 dinishev Exp $ }

{$Include l3Define.inc}

interface

uses 
  WinTypes, 
  WinProcs, 
  Classes, 
  Graphics, 

  Forms, 
  Controls, 
  Buttons,
  StdCtrls, 
  ExtCtrls, 
  OvcBase, 

  l3Types, 
  l3Interfaces, 

  evCustomMemoTextSource,
  evEditorWindow, 
  evEditor, 
  evMemo,

  BottomBtnDlg, 

  TB97Ctls, 

  evMultiSelectEditorWindow, 
  evCustomEditor,
  evEditorWithOperations, 
  evTextSource, 

  afwControl, evCustomMemo, afwControlPrim, afwBaseControl, nevControl,
  evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  evCustomEditorModelPart, evCustomEditorWindow;

type
  TNameEditDlg = class(TBottomBtnDlg)
    pnlName: TPanel;
    lblNameRus: TLabel;
    lblNameEng: TLabel;
    mNameRus: TevMemo;
    mNameEng: TevMemo;
    sbSpellChecker: TSpeedButton;

    procedure mEditorCharCountChangeRus(Sender: TObject);
    procedure mEditorCharCountChangeEng(Sender: TObject);

    procedure OKClick(Sender: TObject);
    procedure sbSpellCheckerClick(Sender: TObject);

    procedure pnlNameResize(Sender: TObject);
    procedure mNameTextSourceBruttoCharCountChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fROnly     : Boolean;
    fBiLingual : Boolean;
  protected
    procedure SetROnly(aValue : Boolean); virtual;
    procedure SetBiLingual(aValue : Boolean); virtual;

    procedure SetEditTextR(const Value : Tl3PCharLen);
    function  GetEditTextR : Tl3PCharLen;
    procedure SetEditTextE(const Value : Tl3PCharLen);
    function  GetEditTextE : Tl3PCharLen;
  public
    function Execute(aMaxTextLen : Integer = 0) : Boolean; 
    property EditTextR : Tl3PCharLen read GetEditTextR write SetEditTextR;
    property EditTextE : Tl3PCharLen read GetEditTextE write SetEditTextE;
    property ROnly : Boolean read fROnly write SetROnly;
    property BiLingual : Boolean read fBiLingual write SetBiLingual;
  end;

implementation

{$R *.DFM}

uses
  Dialogs,
  vtDialogs,
  SysUtils,
  StrShop,
  evTypes,
  D_Spell, Main,
  l3Base,
  l3String,

  evFacadTextSource,
  evFacadeUtils
  ;


{$INCLUDE ProjectDefine.inc}


function TNameEditDlg.Execute(aMaxTextLen : Integer = 0) : Boolean;
begin
 sbSpellChecker.Enabled := False;
   //fMaxTextLen := aMaxTextLen;
 if aMaxTextLen <> 0 then
 begin
  mNameRus.NeedReplaceQuotes := False;
  mNameEng.NeedReplaceQuotes := False;
  evSetBruttoCharLimit(mNameRus.TextSource, aMaxTextLen + 2);
  evSetNettoCharCountEvent(mNameRus.TextSource, mEditorCharCountChangeRus);
  mEditorCharCountChangeRus(Self);
  evSetBruttoCharLimit(mNameEng.TextSource, aMaxTextLen + 2);
  evSetNettoCharCountEvent(mNameEng.TextSource, mEditorCharCountChangeEng);
  evSetTextParaLimit(mNameRus.TextSource, 1);
  evSetTextParaLimit(mNameEng.TextSource, 1);
 end;

 SetBiLingual(fBiLingual);
 Result := ShowModal = mrOk;
end;

procedure TNameEditDlg.SetEditTextR(const Value : Tl3PCharLen);
begin
 mNameRus.Buffer := Value;
 {NameEditor.IsOpen := True;}
end;

function  TNameEditDlg.GetEditTextR : Tl3PCharLen;
begin
 Tl3WString(Result) := mNameRus.Buffer;
end;

resourcestring
 sidName    = 'Название';
 sidNameRus = 'Название на русском';
 sidNameEng = 'Название на английском';

procedure TNameEditDlg.mEditorCharCountChangeRus(Sender: TObject);
begin
  if BiLingual then
   lblNameRus.Caption := Format(sidNameRus+' '+scFmtCounter, [evGetNettoCharCount(mNameRus.TextSource), evGetBruttoCharLimit(mNameRus.TextSource) - 2])
  else
   lblNameRus.Caption := Format(sidName+' '+scFmtCounter, [evGetNettoCharCount(mNameRus.TextSource), evGetBruttoCharLimit(mNameRus.TextSource) - 2]);
end;

procedure TNameEditDlg.mEditorCharCountChangeEng(Sender: TObject);
begin
 lblNameEng.Caption := Format(sidNameEng+' '+scFmtCounter, [evGetNettoCharCount(mNameEng.TextSource), evGetBruttoCharLimit(mNameEng.TextSource) - 2]);
end;

procedure TNameEditDlg.OKClick(Sender: TObject);
begin
 if (Trim(mNameRus.Text) = '') then
 begin
  ShowMessage(Format(sidCanNotBeEmpty, [sidNameRus]));
  ActiveControl := mNameRus;
  ModalResult := mrNone;
 end;
end;

procedure TNameEditDlg.sbSpellCheckerClick(Sender: TObject);
var
 lCurEditor    : TevMemo;
begin
 if ActiveControl = mNameEng then
  lCurEditor := mNameEng
 else
  lCurEditor := mNameRus;
 TSpellCheckDlg.Execute(lCurEditor, MainForm.SpellDictionary);
end;

//procedure TNameEditDlg.mEditorTextSourceBruttoCharCountChange(Sender: TObject);
//begin
// sbSpellChecker.Enabled := True;
//end;

procedure TNameEditDlg.SetROnly(aValue : Boolean);
begin
 fROnly := aValue;
 OK.Enabled := not aValue;
 mNameRus.ReadOnly := aValue;
 mNameEng.ReadOnly := aValue;
end;

procedure TNameEditDlg.SetBiLingual(aValue : Boolean);
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

procedure TNameEditDlg.pnlNameResize(Sender: TObject);
begin
  inherited;
  SetBiLingual(fBiLingual);
end;

function TNameEditDlg.GetEditTextE: Tl3PCharLen;
begin
 if fBiLingual then
  Tl3WString(Result) := mNameEng.Buffer
 else
  Result := l3PCharLen;
end;

procedure TNameEditDlg.SetEditTextE(const Value: Tl3PCharLen);
begin
 mNameEng.Buffer := Value;
end;

procedure TNameEditDlg.mNameTextSourceBruttoCharCountChange(Sender: TObject);
begin
 sbSpellChecker.Enabled := True;
end;

procedure TNameEditDlg.FormCreate(Sender: TObject);
begin
  inherited;
  mNameRus.KeepAllFormatting := False;
  EvSetPlainTextFlag(mNameRus, False);

  mNameEng.KeepAllFormatting := False;
  EvSetPlainTextFlag(mNameEng, False);
end;

end.


