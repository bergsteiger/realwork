unit D_DocListSort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls;

type
  TDocListSortDlg = class(TBottomBtnDlg)
    rgSortField: TRadioGroup;
    rgSortOrder: TRadioGroup;
    cbSetAsDefault: TCheckBox;
    procedure rgSortFieldClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure UpdateState;
    { Public declarations }
  end;

var
  BottomBtnDlg1: TDocListSortDlg;

implementation

{$R *.dfm}

procedure TDocListSortDlg.rgSortFieldClick(Sender: TObject);
begin
 UpdateState;
end;

procedure TDocListSortDlg.UpdateState;
begin
  rgSortOrder.Enabled := rgSortField.ItemIndex > 0;
end;

end.
