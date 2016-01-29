unit D_PASS;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons;

type
  TPasswordDlg = class(TForm)
    CancelBtn: TBitBtn;
    Label1: TLabel;
    NameLabel: TLabel;
    OKBtn: TBitBtn;
    Password: TEdit;
    UserName: TEdit;
  public
    function Execute: Boolean;
  end;
  
var
  UserPassName  : String[15];
  UserPassword  : String[10];

  Function GetPassword : Boolean;

implementation
 Uses
  l3IniFile;

{$R *.DFM}

{
********************************* TPasswordDlg *********************************
}
function TPasswordDlg.Execute: Boolean;
begin
  If UserPassName = ''
   then ActiveControl := UserName
   else ActiveControl := Password;
  Result:=(ShowModal=mrOK);
end;

 Function GetPassword : Boolean;
  Begin
   With TPasswordDlg.Create(nil) do
    Begin
     UserName.Text:=UserPassName;
     Password.Text:=UserPassword;
     Result:=Execute;
     If Result
      then
       Begin
        UserPassName:=UserName.Text;
        UserPassword:=Password.Text;
       end;
     Destroy;
    end;
  end;
end.

