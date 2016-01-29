unit D_LogRequest;

{$Include l3Define.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, vtCombo, vtDateEdit,
  Buttons, ExtCtrls,
  d_DateIntervalEdit,
  DT_Const, evEditorWindow,
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations, evMemo,
  afwControl, afwControlPrim, afwBaseControl, nevControl, evCustomMemo,
  l3Date,
  ToolEdit;
  //, OvcBase,  evEditorWindow, evEditor, evMemo;

type
  TLogRequestDlg = class(TDateIntervalDlg)
    GroupBox1: TGroupBox;
    edtFilename: TFilenameEdit;
    Label3: TLabel;
    {procedure rbActiveClick(Sender: TObject);
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
    procedure FormShow(Sender: TObject);     }
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetLogRequestData(var aStartDate, aEndDate : TstDate;  var aFileName : TFileName) : Boolean;

implementation

{$INCLUDE ProjectDefine.inc}

{$R *.dfm}

uses
  DateUtils,
  Types,
  StrShop,
  l3String,
  InsDWin,
  D_DateCalc,
  evFacadTextSource
  ;

function GetLogRequestData(var aStartDate, aEndDate : TstDate; var aFileName : TFileName) : Boolean;
begin
 with TLogRequestDlg.Create(nil) do
 try
  Result := Execute;

  if Result then
  begin
   aStartDate := edtDateLow.StDate;
   aEndDate   := edtDateHigh.StDate;
   aFileName  := edtFilename. Text;
  end;
 finally
  Free;
 end;
end;
(*
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
 *)
end.
