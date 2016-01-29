unit a2ChangePasswordDlg;

{ $Id: a2ChangePasswordDlg.pas,v 1.2 2007/05/14 12:26:04 fireton Exp $}

// $Log: a2ChangePasswordDlg.pas,v $
// Revision 1.2  2007/05/14 12:26:04  fireton
// - �������� ������������� ������ ������������ ������ � �� �� �����
//
// Revision 1.1  2005/08/20 11:05:32  fireton
// - ������������� ������ (���������� ���������� ����� � �������� ��� ������)
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TChangePasswordDlg = class(TForm)
    edPassword: TLabeledEdit;
    edPasswordConfirm: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private
    function pm_GetPassword: string;
    { Private declarations }
  public
    property Password: string read pm_GetPassword;
  end;

var
  ChangePasswordDlg: TChangePasswordDlg;

implementation

{$R *.dfm}

procedure TChangePasswordDlg.Button1Click(Sender: TObject);
begin
 if edPassword.Text <> edPasswordConfirm.Text then
 begin
  MessageDlg('������ � ������������� �� ���������!', mtError, [mbOK], 0);
  ActiveControl := edPassword;
 end
 else
  ModalResult := mrOK;
end;

function TChangePasswordDlg.pm_GetPassword: string;
begin
 Result := edPassword.Text;
end;

end.
