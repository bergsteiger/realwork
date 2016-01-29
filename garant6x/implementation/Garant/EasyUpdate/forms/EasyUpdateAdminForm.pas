unit EasyUpdateAdminForm;

interface

uses
 Windows
 , Buttons
 , Classes
 , Controls
 , ExtCtrls
 , Forms
 , StdCtrls
 //
 , LocaleMessages
 ;

type
 TEasyUpdateAdminForm = class(TForm)
  f_MainPanel: TPanel;
   f_InformationMemo: TMemo;
   f_AdminNameLabel: TLabel;
   f_AdminNameEdit: TEdit;
   f_AdminPasswordLabel: TLabel;
   f_AdminPasswordEdit: TEdit;
   f_AdminPasswordCheckLabel: TLabel;
   f_AdminPasswordCheckEdit: TEdit;
  f_BottomPanel: TPanel;
   f_CommonSaveBitBtn: TBitBtn;
   f_CommonCancelBitBtn: TBitBtn;
  //
  procedure FormCreate(a_Sender: TObject);
  //
  procedure CommonSaveBitBtnClick(a_Sender: TObject);
 private
  class procedure ShowInvalidPasswordError;
 end;

var
 g_EasyUpdateAdminForm: TEasyUpdateAdminForm;

implementation {$R *.dfm}

procedure TEasyUpdateAdminForm.FormCreate(a_Sender: TObject);
begin
 Caption := GetCurrentLocaleMessage(c_EasyUpdateAdminFormCaption);
 //
 f_InformationMemo.Lines.Text := GetCurrentLocaleMessage(c_EasyUpdateAdminFormInformationMemoLinesText);
 //
 f_AdminNameLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateAdminFormAdminNameLabelCaption);
 f_AdminPasswordLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateAdminFormAdminPasswordLabelCaption);
 f_AdminPasswordCheckLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateAdminFormAdminPasswordCheckLabelCaption);
 //
 f_CommonSaveBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateAdminFormCommonSaveBitBtnCaption);
 f_CommonCancelBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateAdminFormCommonCancelBitBtnCaption);
end;

procedure TEasyUpdateAdminForm.CommonSaveBitBtnClick(a_Sender: TObject);
begin
 if (f_AdminPasswordEdit.Text = f_AdminPasswordCheckEdit.Text) then
  ModalResult := mrOk
 else
  ShowInvalidPasswordError;
end;

class procedure TEasyUpdateAdminForm.ShowInvalidPasswordError;
begin
 Application.MessageBox(
  PChar(GetCurrentLocaleMessage(c_EasyUpdateAdminFormShowInvalidPasswordErrorText))
  , PChar(GetCurrentLocaleMessage(c_EasyUpdateAdminFormShowInvalidPasswordErrorCaption))
  , MB_ICONERROR or MB_OK
 );
end;


end.
