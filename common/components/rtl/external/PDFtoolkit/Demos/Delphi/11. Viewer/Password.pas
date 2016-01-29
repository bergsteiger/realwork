unit Password;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmPassword = class(TForm)
    Label1: TLabel;
    edtpassword: TEdit;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

procedure TfrmPassword.Button1Click(Sender: TObject);
begin
  FPwd := edtpassword.Text;
  IsCancel:= False;
  IsOk:= True;
  edtpassword.SetFocus;
  Close;
end;

procedure TfrmPassword.Button2Click(Sender: TObject);
begin
  IsCancel:= True;
  IsOk:= False;
  Close;
end;

end.
