unit d_edMSub;

{$Include l3Define.inc}

{ $Id: D_EDMSUB.PAS,v 1.9 2015/09/30 11:42:56 dinishev Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
    StdCtrls, ExtCtrls, vtSpin, OvcBase, evEditorWindow, evEditor, evMemo,
    evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations,
    afwControl, evCustomMemo, afwControlPrim, afwBaseControl, nevControl,
  l3WinControlCanvas, evCustomEditorWindowPrim,
  evCustomEditorWindowModelPart, evCustomEditorModelPart,
  evCustomEditorWindow, vtCtrls, vtForm;

type
  TNewSubDlg = class(TvtForm)
    Panel1: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    AllBtn: TBitBtn;
    NoBtn: TBitBtn;
    Panel2: TPanel;
    Label2: TLabel;
    edtSubNum: TvtSpinEdit;
    edtSubName: TevMemo;
    Label1: TLabel;
    stCounter: TStaticText;
    pnlType: TPanel;
    cbPosition: TComboBox;
    Label3: TLabel;
    pnlStyle: TPanel;
    Label6: TLabel;
    cbStyle: TvtComboBox;
    procedure OKBtnClick(Sender: TObject);
    procedure edtSubName_TextSourceEditorWindowProcessorNettoCharCountChange(
      Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbPositionChange(Sender: TObject);
  private
    fMaxTextLen  : Integer;
    fCurSubID    : Integer;
    fUniqNumber : Boolean;
    fInCorrection : Boolean;
    lItsBlock : Boolean;
    f_IgnoreRight: Boolean;
    f_HasLeftBlock: Boolean;
    f_HasRightBlock: Boolean;
    f_PrevPosition: Integer;
    f_Editor: TevCustomEditor;
  private
    procedure SetHasLeftBlock(const Value: Boolean);
    procedure SetHasRightBlock(const Value: Boolean);
    procedure SetCurSubID(Value : Longint);
    procedure SetIgnoreRight(const Value: Boolean);
    procedure CheckLeftOrRightBlocksCount;
  public
   {$IfDef InsiderTest}
    g_AllowModal : Integer;
     {-}
   function ShowModal: integer;
     override;
     {-}
   {$IfDef l3HackedVCL}
   function NeedCancelModal: Boolean;
     override;
     {-}
   {$EndIf l3HackedVCL}
  {$EndIf InsiderTest}
    property HasLeftBlock: Boolean write SetHasLeftBlock;
    property HasRightBlock: Boolean write SetHasRightBlock;
    procedure NeedStyles(const aList: TStrings);
    function Execute(aAutoMode : Boolean = False; aItsBlock : Boolean = False): Byte;
    procedure NeedTypes;
    property CurSubID : Longint write SetCurSubID;
    property IgnoreRight: Boolean write SetIgnoreRight;
    property NumberIsUniq : Boolean read fUniqNumber;
    property Editor: TevCustomEditor write f_Editor;
  end;

implementation

{$IFDEF Archi}
{$INCLUDE ArchiDefine.inc}
{$ENDIF Archi}

uses
 SysUtils,

 l3Types,
 l3String,
 l3Base,
 l3BatchService,

 Dialogs,

 vtDialogs,
 evCommonRes,
{$IFDEF InsiderTest}
 afwAnswer,
 seModalSupport,
{$ENDIF InsiderTest}

{$IFDEF Archi}
 EditWin,
 IniShop,
{$ENDIF Archi}
 evFacadTextSource,
 evFacadeSub,
 evFacadeUtils
 ;

{$R *.DFM}

procedure TNewSubDlg.NeedStyles(const aList: TStrings);
begin
 if pnlStyle.Visible then
  Exit;
 pnlStyle.Visible := True;
 Constraints.MinHeight := Constraints.MinHeight + pnlStyle.Height;
 cbStyle.Items.Assign(aList);
 cbStyle.Items.Insert(0, '[не определён]');
 cbStyle.ItemIndex := 0;
 f_PrevPosition := 0;
end;

function TNewSubDlg.Execute(aAutoMode : Boolean = False; aItsBlock : Boolean = False): Byte;
begin
 edtSubNum.EmptyText := 'Auto';
 fUniqNumber := True;
 lItsBlock := aItsBlock;
 if not aAutoMode then
 begin
  AllBtn.Visible := False;
  NoBtn .Visible := False;
  OkBtn .Left    := NoBtn.Left;
 end;

 fMaxTextLen := 700;
 evSetBruttoCharLimit(edtSubName.TextSource, fMaxTextLen + 2);
 edtSubName_TextSourceEditorWindowProcessorNettoCharCountChange(Self);

{$IFDEF Archi}
 edtSubName.Canvas.DrawSpecial := IniRec.ShowSpecSymbol;
{$ENDIF Archi}
 Result := ShowModal;
end;

procedure TNewSubDlg.SetCurSubID(Value : Longint);
begin
 FCurSubID := Value;
 edtSubNum.AsInteger := FCurSubID;
end;

procedure TNewSubDlg.OKBtnClick(Sender: TObject);
 //var
 // lBlock : IevDocumentPart;
begin
 if (FCurSubID = edtSubNum.AsInteger) then
 begin
  edtSubNum.Modified := False;
  Exit;
 end;

 if edtSubNum.AsInteger <= 0 then
  vtMessageDlg(str_sidNonValidSubNumber.AsCStr, mtError)
 else
  if edtSubNum.Modified then
  begin
   with f_Editor do
   begin
    if not evGetSubList(TextSource).Sub[edtSubNum.AsInteger].Exists then Exit;
    if not lItsBlock and (evGetSubList(TextSource).Block[edtSubNum.AsInteger] = nil) then
    begin
     if (vtMessageDlg(str_sidNonUniqSubNumberQst.AsCStr, mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
     begin
      fUniqNumber := False;
      Exit;
     end
    end
    else
     vtMessageDlg(str_sidNonUniqSubNumber.AsCStr, mtError);
   end;
  end;
 ActiveControl := edtSubNum;
 ModalResult := mrNone;
end;

procedure TNewSubDlg.edtSubName_TextSourceEditorWindowProcessorNettoCharCountChange(Sender: TObject);
var
 lName : string;
begin
 if fInCorrection then Exit; // prevent reenter
 try
  fInCorrection := True;
  {lName := edtSubName.Buffer.S;
  if Length(lName) > 0 then
   edtSubName.Buffer := l3PCharLen(l3DeleteDoubleSpace(l3ReplaceNonReadable(lName)));
  }
  stCounter.Caption := Format('%d/%d', [evGetNettoCharCount(edtSubName.TextSource), fMaxTextLen])
 finally
  fInCorrection := False;
 end;
end;

procedure TNewSubDlg.FormCreate(Sender: TObject);
begin
 f_HasLeftBlock := False;
 f_HasRightBlock := False;
 pnlStyle.Visible := False;
 pnlType.Visible := False;
 edtSubName.KeepAllFormatting := False;
 EvSetPlainTextFlag(edtSubName, False);
 edtSubName.Canvas.DrawSpecial := True;
 f_IgnoreRight := False;
 {$IfDef InsiderTest}
 g_AllowModal := 0;
 {$EndIf InsiderTest}
end;

procedure TNewSubDlg.FormShow(Sender: TObject);
begin
 evSetNettoCharCountEvent(edtSubName.TextSource, edtSubName_TextSourceEditorWindowProcessorNettoCharCountChange);
 evSetTextParaLimit(edtSubName.TextSource, 1);
 f_PrevPosition := cbPosition.ItemIndex;
end;

procedure TNewSubDlg.NeedTypes;
begin
 if pnlType.Visible then
  Exit;
 pnlType.Visible := True;
 Constraints.MinHeight := Constraints.MinHeight + pnlType.Height;
 cbPosition.ItemIndex := 0;
 f_PrevPosition := 0;
end;

procedure TNewSubDlg.cbPositionChange(Sender: TObject);
begin
 CheckLeftOrRightBlocksCount;
 f_PrevPosition := cbPosition.ItemIndex;
end;

{$IfDef InsiderTest}
{$IfDef l3HackedVCL}
function TNewSubDlg.NeedCancelModal: Boolean;
begin
 Result := False;
 {$IfDef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  if Tl3BatchService.Instance.ExecuteCurrentModalWorker then
  begin
   if (ModalResult = 0) then
   begin
    Result := true;
    Exit;
   end;//ModalResult = 0
  end//seExecuteCurrentModalWorker
  else
  begin
   Result := true;
  end;//seExecuteCurrentModalWorker
 end;//g_BatchMode
 {$EndIf InsiderTest}
end;
{$EndIf l3HackedVCL}

function TNewSubDlg.ShowModal: integer;
begin
 {$IfDef InsiderTest}
 Assert(g_AllowModal >= 0);
 if Tl3BatchService.Instance.IsBatchMode then
  if (g_AllowModal <= 0) then
   if (Application.MainForm <> nil) then
    if not Tl3BatchService.Instance.HasModalWorker then
     raise EafwTryEnterModalState.Create('Здесь надо обрабатывать модальность формы');
 {$EndIf InsiderTest}
 Result := inherited ShowModal;
end;
{$ENDIF InsiderTest}

procedure TNewSubDlg.SetIgnoreRight(const Value: Boolean);
begin
 f_IgnoreRight := Value;
end;

procedure TNewSubDlg.SetHasRightBlock(const Value: Boolean);
begin
 f_HasRightBlock := Value;
end;

procedure TNewSubDlg.CheckLeftOrRightBlocksCount;
begin
 if (f_HasLeftBlock and (cbPosition.ItemIndex = 1)) or
    (f_HasRightBlock and (cbPosition.ItemIndex = 2) and not f_IgnoreRight) then
 begin
  vtMessageDlg(str_sidBlockAlreadyExists.AsCStr, mtError);
  cbPosition.ItemIndex := f_PrevPosition;
 end;
end;

procedure TNewSubDlg.SetHasLeftBlock(const Value: Boolean);
begin
 f_HasLeftBlock := Value;
end;

end.
