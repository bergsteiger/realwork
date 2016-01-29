unit alcuSMSDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  alcuMsgDlg, StdCtrls;

type
  TSMSDialog = class(TForm)
    Button1: TButton;
    editPhone: TEdit;
    editText: TEdit;
    Label1: TLabel;
    Label2: TLabel;
  end;
  
var
  SMSDialog: TSMSDialog;

implementation

{$R *.dfm}

end.
