unit Password;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmPassword = class(TForm)
    Image1: TImage;
    edtPassword: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    FPwd: string;
    IsCancel:Boolean;
    IsOk:Boolean;
    { Public declarations }
  end;

var
  frmPassword: TfrmPassword;

implementation

{$R *.dfm}

procedure TfrmPassword.btnCancelClick(Sender: TObject);
begin
  IsCancel:= True;
  IsOk:= False;
  frmPassword.Close;
end;

procedure TfrmPassword.btnOKClick(Sender: TObject);
begin
  FPwd := edtpassword.Text;
  IsCancel:= False;
  IsOk:= True;
  edtpassword.SetFocus;
  Close;
end;

end.
