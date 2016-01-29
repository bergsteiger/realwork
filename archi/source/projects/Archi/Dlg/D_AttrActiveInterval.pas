unit D_AttrActiveInterval;

{$Include l3Define.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, vtCombo, vtDateEdit,
  Buttons, ExtCtrls,
  d_DateIntervalEdit,
  k2Interfaces, k2Tags,
  DT_Const, DT_Active, OvcBase, evEditorWindow,
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations, evMemo,
  afwControl, afwControlPrim, afwBaseControl, nevControl, evCustomMemo,
  evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorWindowModelPart, evCustomEditorModelPart,

  l3Variant
  ;
  //, OvcBase,  evEditorWindow, evEditor, evMemo;

type
  TAttrActiveIntervalDlg = class(TDateIntervalDlg)
    Label3: TLabel;
    GroupBox1: TGroupBox;
    rbActive: TRadioButton;
    rbPreactive: TRadioButton;
    rbNoActive: TRadioButton;
    rbNotSure: TRadioButton;
    sbDateCalc: TSpeedButton;
    edtComment: TevMemo;
    Button1: TButton;
    procedure rbActiveClick(Sender: TObject);
    procedure rbPreactiveClick(Sender: TObject);
    procedure rbNoActiveClick(Sender: TObject);
    procedure edtDateLowEnter(Sender: TObject);
    procedure edtDateHighEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rbNotSureClick(Sender: TObject);
    procedure edtCommentDropDown(Sender: TObject);
    procedure sbDateCalcClick(Sender: TObject);
    procedure edtCommentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetAttrActiveInterval(aRec : Tl3Tag; aRecEmpty : Boolean = False) : Boolean;

implementation

{$INCLUDE ProjectDefine.inc}

{$R *.dfm}

uses
  DateUtils,
  Types,
  StrShop,
  l3Date, l3String,
  InsDWin,
  D_DateCalc,
  evFacadTextSource
  ;

function GetAttrActiveInterval(aRec : Tl3Tag; aRecEmpty : Boolean = False) : Boolean;
var
 lStart : Integer;
 lFinish : Integer;
begin
 with TAttrActiveIntervalDlg.Create(nil) do
 try
  with aRec do
  If aRecEmpty then
   //aRec.RecID := 0
  else
  begin
   lStart := IntA[k2_tiStart];
   lFinish := IntA[k2_tiFinish];
   if (lStart  = maxActiveDate) and (lFinish = maxActiveDate) then
   begin
    rbPreActive.Checked := True;
    ActiveControl := rbPreActive;
   end
   else
   if (lStart = minActiveDate) and (lFinish = minActiveDate) then
   begin
    rbNoActive.Checked := True;
    ActiveControl := rbNoActive;
   end
   else
   begin
    if not ((lStart = minActiveDate) or (lStart = maxActiveDate)) then
     edtDateLow.StDate  := lStart;
    if not ((lFinish = minActiveDate) or (lFinish = maxActiveDate)) then
     edtDateHigh.StDate := lFinish;
    if IntA[k2_tiType] = 1 then
    begin
     rbNotSure.Checked := True;
     //ActiveControl := rbNotSure;
    end
    else
    begin
     rbActive.Checked := True;
     //ActiveControl := rbActive;
    end;
   end;
   edtComment.Text := StrA[k2_tiComment];
  end;

  Result := Execute;

  if Result then
  with aRec do
  begin
   AttrW[k2_tiName, nil] := nil;
   if rbActive.Checked or rbNotSure.Checked then
   begin
    If edtDateLow.IsEmpty then
     lStart  := minActiveDate
    else
     lStart  := edtDateLow.StDate;

    if edtDateHigh.IsEmpty then
     lFinish  := maxActiveDate
    else
     lFinish := edtDateHigh.StDate;
   end
   else
    if rbPreActive.Checked then
    begin
     lStart  := maxActiveDate;
     lFinish := maxActiveDate;
    end
    else
     if rbNoActive.Checked then
     begin
      lStart  := minActiveDate;
      lFinish := minActiveDate;
     end;

   IntA[k2_tiStart] := lStart;
   IntA[k2_tiFinish] := lFinish;

   if rbNotSure.Checked then
    IntA[k2_tiType] := 1
   else
    IntA[k2_tiType] := 0;

   StrA[k2_tiComment] := edtComment.Text;
  end;
 finally
  Free;
 end;
end;

procedure TAttrActiveIntervalDlg.rbActiveClick(Sender: TObject);
begin
 rbActive.Checked    := True;
end;

procedure TAttrActiveIntervalDlg.rbPreactiveClick(Sender: TObject);
begin
 rbPreActive.Checked := True;

 edtDateLow.Clear;
 edtDateHigh.Clear;
end;

procedure TAttrActiveIntervalDlg.rbNoActiveClick(Sender: TObject);
begin
 rbNoActive.Checked  := True;

 edtDateLow.Clear;
 edtDateHigh.Clear;
end;

procedure TAttrActiveIntervalDlg.rbNotSureClick(Sender: TObject);
begin
 rbNotSure.Checked  := True;
end;

procedure TAttrActiveIntervalDlg.edtDateLowEnter(Sender: TObject);
begin
 if rbPreActive.Checked or rbNoActive.Checked then
  rbActive.Checked := True;
end;

procedure TAttrActiveIntervalDlg.edtDateHighEnter(Sender: TObject);
begin
 if rbPreActive.Checked or rbNoActive.Checked then
  rbActive.Checked := True;
end;

procedure TAttrActiveIntervalDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 inherited;
 CanClose:= True;
 if (ModalResult = mrOK) and rbNotSure.Checked then
 begin
  if rbNotSure.Checked then
   if edtDateLow.IsEmpty then
   begin
    ShowMessage(sidXFieldEmptyErr);
    ActiveControl := edtDateLow;
    CanClose := False;
    Exit;
   end;
   {
   else
    if edtDateHigh.IsEmpty then
    begin
     ShowMessage(sidXFieldEmptyErr);
     ActiveControl := edtDateHigh;
     CanClose := False;
     Exit;
    end;
   }

  if (not edtDateLow.IsEmpty) and (not edtDateHigh.IsEmpty) then
  begin
   CanClose:= not (CompareDateTime(edtDateLow.Date, edtDateHigh.Date) = GreaterThanValue);
   if not CanClose then
   begin
    ActiveControl:= edtDateHigh;
    ShowMessage('ƒата начала действи€ документа не может быть позже даты окончани€ действи€');
   end;
  end;
 end
end;

procedure TAttrActiveIntervalDlg.edtCommentDropDown(Sender: TObject);
var
 lInsText : String;
begin
 if GetInsText(lInsText) then
  edtComment.Text := lInsText;
end;

procedure TAttrActiveIntervalDlg.sbDateCalcClick(Sender: TObject);
var
 aDate : TStDate;
begin
 aDate := edtDateLow.StDate;
 if GetCalculateDate(aDate) then
  edtDateLow.StDate := aDate;
end;
                            
procedure TAttrActiveIntervalDlg.edtCommentKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 inherited;
 if (Key = VK_DOWN) and (ssAlt in Shift) then
  edtCommentDropDown(Sender);
end;

procedure TAttrActiveIntervalDlg.FormShow(Sender: TObject);
begin
 inherited;
 evSetTextParaLimit(edtComment.TextSource, 1);
end;

end.
