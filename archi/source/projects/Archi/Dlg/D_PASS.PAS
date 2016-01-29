unit D_pass;

{ $Id: D_PASS.PAS,v 1.5 2004/12/23 11:47:04 lulin Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, vtCtrls;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    EnhImage1: TImage;
    UserName: TEdit;
    NameLabel: TLabel;
  private
    { Private declarations }
  public
    Function Execute : Boolean;
  end;

var
  UserPassName  : String[15];
  UserPassword  : String[10];

  Function GetPassword : Boolean;

implementation
 Uses l3IniFile;

{$R *.DFM}

 Function TPasswordDlg.Execute : Boolean;
  Begin
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

