unit D_AttrAlarm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls,
  k2Interfaces, k2Tags,
  DT_Alarm, Mask, vtCombo, vtDateEdit,

  l3Variant
  ;

type
  TAttrAlarmDlg = class(TBottomBtnDlg)
    edtDate: TvtDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtComment: TvtSimpleComboEdit;
    procedure edtCommentDropDown(Sender: TObject);
  protected
    function ValidateInputData : Boolean;  override;
  public
    { Public declarations }
  end;

 function GetAttrAlarm(aRec : Tl3Tag; aRecEmpty : Boolean = False) : boolean;

implementation

{$R *.dfm}

uses
  l3String,
  l3Date,
  InsDWin;

 const
  sidTooEarlyDate = 'Дата не может быть меньше текущей.';
  sidEmptyDate = 'Дата не может быть пустой.';

function TAttrAlarmDlg.ValidateInputData : Boolean;
begin
 if edtDate.IsEmpty then
 begin
  FocusAndNote(edtDate,sidEmptyDate);
  Result := False;
 end
 else
 if edtDate.StDate < CurrentDate then
 begin
  FocusAndNote(edtDate,sidTooEarlyDate);
  Result := False;
 end
 else
  Result := True;
end;

function GetAttrAlarm(aRec: Tl3Tag; aRecEmpty : Boolean = False) : boolean;
begin
 with TAttrAlarmDlg.Create(nil) do
 try
  with aRec do
  If not aRecEmpty then
  begin
   edtDate.StDate  := IntA[k2_tiStart];
   edtComment.Text := StrA[k2_tiComment];
  end;

  Result := Execute;

  with aRec do
  begin
   AttrW[k2_tiName, nil] := nil;
   IntA[k2_tiStart] := edtDate.StDate;
   StrA[k2_tiComment] := edtComment.Text;
  end;

 finally
  Free;
 end;
end;

procedure TAttrAlarmDlg.edtCommentDropDown(Sender: TObject);
var
 lInsText : String;
begin
 if GetInsText(lInsText) then
  edtComment.Text := lInsText;
end;

end.
