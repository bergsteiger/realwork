unit uSecurity;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, PDFtoolkitUsage, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, StdCtrls, CheckLst, ExtCtrls;

type
  TForm1 = class(TForm)
    gbEncryption: TGroupBox;
    lblConfirmOwnerPswd: TLabel;
    lblUserPswd: TLabel;
    lblConfirmUserPswd: TLabel;
    lblOwnerPswd: TLabel;
    rgEncryptionLevel: TRadioGroup;
    gbUserPermissions: TGroupBox;
    chklstUserPermissions: TCheckListBox;
    edtOwnerPassword: TEdit;
    edtConfirmOwnerPassword: TEdit;
    edtUserPassword: TEdit;
    edtConfirmUserPassword: TEdit;
    btnSetEncryption: TButton;
    chkEnableEncryption: TCheckBox;
    Label13: TLabel;
    Label14: TLabel;
    Label75: TLabel;
    edPDFfilename: TEdit;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    btnLoadPDF: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    btnSave: TButton;
    btnReset: TButton;
    cbOpenAfterCreate: TCheckBox;
    SaveDialog1: TSaveDialog;
    procedure chkEnableEncryptionClick(Sender: TObject);
    procedure btnSetEncryptionClick(Sender: TObject);
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);
    

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSetEncryptionClick(Sender: TObject);
begin
  SetSecurity(gtPDFDocument1, edtOwnerPassword.Text,edtUserPassword.Text, edtConfirmOwnerPassword.Text,
     edtConfirmUserPassword.Text, rgEncryptionLevel.ItemIndex, chkEnableEncryption.Checked,
     chklstUserPermissions.Checked[0], chklstUserPermissions.Checked[1], chklstUserPermissions.Checked[2],
     chklstUserPermissions.Checked[3],chklstUserPermissions.Checked[4],chklstUserPermissions.Checked[5],
     chklstUserPermissions.Checked[6],chklstUserPermissions.Checked[7]);
end;

procedure TForm1.chkEnableEncryptionClick(Sender: TObject);
var
  Li: Integer;
begin
  if chkEnableEncryption.Checked then
  begin
     for Li := 0 to gbEncryption.ControlCount - 1 do
     begin
        gbEncryption.Controls[Li].Enabled := True;
     end;
     chklstUserPermissions.Enabled :=  True;
     rgEncryptionLevel.ItemIndex := 0;
  end
  else
  begin
     for Li := 0 to gbEncryption.ControlCount - 1 do
     begin
        gbEncryption.Controls[Li].Enabled := False;
     end;
     chklstUserPermissions.Enabled :=  False;
  end;
end;

procedure TForm1.btnLoadPDFClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
  begin
    gtPDFDocument1.LoadFromFile(OpenDialog1.FileName);
    edPDFfilename.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.btnSaveFileNameClick(Sender: TObject);
begin
   if SaveDialog1.Execute then
  begin
    edSavePDFTo.Text := SaveDialog1.FileName;
  end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  if (cbOpenAfterCreate.Checked) then
    gtPDFDocument1.OpenAfterSave := True
  else
    gtPDFDocument1.OpenAfterSave := False;
  gtPDFDocument1.SaveToFile(edSavePDFTo.Text);
  btnResetClick(Self);
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  ResetControls(Form1);
end;

procedure TForm1.ResetControls(Sender: TObject);
var
  cntrlCnt: Integer;
begin
  if (Sender is TWinControl) then
  begin
    for cntrlCnt := 0 to TWinControl(Sender).ControlCount - 1 do
    begin
      if TWinControl(Sender).ContainsControl(TWinControl(Sender).Controls[cntrlCnt]) then
      begin
        ResetControls(TWinControl(Sender).Controls[cntrlCnt]);
      end;
      if (TWinControl(Sender).Controls[cntrlCnt] is TEdit) then
        (TWinControl(Sender).Controls[cntrlCnt] As TEdit).Text := ''
      else if (TWinControl(Sender).Controls[cntrlCnt] is TCheckBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TCheckBox).Checked := False
      else if (TWinControl(Sender).Controls[cntrlCnt] is TComboBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TComboBox).ItemIndex := 0;
    end;
  end;
  edSavePDFTo.Text := 'C:\Output.pdf';
  edPDFfilename.Text := '';
end;


end.
