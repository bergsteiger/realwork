unit ddConfirmSplitDlg;

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TddConfirmSplitDialog = class(TForm)
    radioAction: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ddConfirmSplitDialog: TddConfirmSplitDialog;

implementation

{$R *.dfm}

end.
