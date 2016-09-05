unit D_Autolink;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BtnDlg, StdCtrls, Buttons, ExtCtrls;

type
  TAutolinkDlg = class(TBtnDlg)
    rbAllDocs: TRadioButton;
    Label1: TLabel;
    rbOneDoc: TRadioButton;
    edTopic: TEdit;
    cbDeleteLinks: TCheckBox;
    cbSelectionOnly: TCheckBox;
    procedure edTopicChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure rbClick(Sender: TObject);
  private
    f_TopicNo: LongInt;
    procedure UpdateUI;
    { Private declarations }
  public
    property TopicNo: LongInt read f_TopicNo;
    { Public declarations }
  end;

var
  AutolinkDlg: TAutolinkDlg;

implementation
uses
 daInterfaces,
 daSchemeConsts,
 dt_LinkServ,
 dt_Doc;

{$R *.dfm}

procedure TAutolinkDlg.edTopicChange(Sender: TObject);
begin
 rbOneDoc.Checked := True;
end;

procedure TAutolinkDlg.FormShow(Sender: TObject);
begin
 UpdateUI;
end;

procedure TAutolinkDlg.OKClick(Sender: TObject);
var
 l_IntNo: Longint;
begin
 if rbOneDoc.Checked then
 begin
  f_TopicNo := StrToIntDef(edTopic.Text, cUndefDocID);
  if f_TopicNo = cUndefDocID then
  begin
   MessageDlg('Неправильно указан номер топика!', mtError, [mbOK], 0);
   Exit;
  end;
  l_IntNo := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(f_TopicNo);
  if (l_IntNo = cUndefDocID) or (not DocumentServer(CurrentFamily).CheckDocEx(l_IntNo)) then
  begin
   MessageDlg('Такого документа нет в базе!', mtError, [mbOK], 0);
   Exit;
  end;
 end;
 ModalResult := mrOK;
end;

procedure TAutolinkDlg.rbClick(Sender: TObject);
begin
 UpdateUI;
end;

procedure TAutolinkDlg.UpdateUI;
begin
 //edTopic.Enabled := rbOneDoc.Checked;
end;

end.
