unit EasyUpdateMailForm;

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
 TEasyUpdateMailForm = class(TForm)
  f_MainPanel: TPanel;
   f_InformationMemo: TMemo;
    f_MailFromLabel: TLabel;
    f_MailFromEdit: TEdit;
    f_MailToLabel: TLabel;
    f_MailToEdit: TEdit;
    f_MailServerLabel: TLabel;
    f_MailServerEdit: TEdit;
    f_MailServerUserLabel: TLabel;
    f_MailServerUserEdit: TEdit;
    f_MailServerPasswordLabel: TLabel;
    f_MailServerPasswordEdit: TEdit;
  f_BottomPanel: TPanel;
   f_CommonSaveBitBtn: TBitBtn;
   f_CommonCancelBitBtn: TBitBtn;
  //
  procedure FormCreate(a_Sender: TObject);
 end;

var
 g_EasyUpdateMailForm: TEasyUpdateMailForm;

implementation {$R *.dfm}

procedure TEasyUpdateMailForm.FormCreate(a_Sender: TObject);
begin
 Caption := GetCurrentLocaleMessage(c_EasyUpdateMailFormCaption);
 //
 f_InformationMemo.Lines.Text := GetCurrentLocaleMessage(c_EasyUpdateMailFormInformationMemoLinesText);
 //
 f_MailFromLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateMailFormMailFromLabelCaption);
 f_MailToLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateMailFormMailToLabelCaption);
 //
 f_MailServerLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateMailFormMailServerLabelCaption);
 f_MailServerUserLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateMailFormMailServerUserLabelCaption);
 f_MailServerPasswordLabel.Caption := GetCurrentLocaleMessage(c_EasyUpdateMailFormMailServerPasswordLabelCaption);
 //
 f_CommonSaveBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateMailFormCommonSaveBitBtnCaption);
 f_CommonCancelBitBtn.Caption := GetCurrentLocaleMessage(c_EasyUpdateMailFormCommonCancelBitBtnCaption);
end;


end.
