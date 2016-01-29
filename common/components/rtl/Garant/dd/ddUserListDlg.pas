unit ddUserListDlg;

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TddUserListDialog = class(TForm)
    ListBox1: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ddUserListDialog: TddUserListDialog;

implementation

{$R *.dfm}

end.
