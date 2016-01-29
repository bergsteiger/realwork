unit d_UrgencyEditDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls,

  DT_Types
  ;

type
  TUrgencyEditDlg = class(TBottomBtnDlg)
    Label1: TLabel;
    cbxUrgency: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    function pm_GetUrgency: TDocUrgency;
    procedure pm_SetUrgency(const Value: TDocUrgency);
    { Private declarations }
  public
    property Urgency: TDocUrgency read pm_GetUrgency write pm_SetUrgency;
    { Public declarations }
  end;

var
  UrgencyEditDlg: TUrgencyEditDlg;

implementation
uses
 DT_Const;

{$R *.dfm}

procedure TUrgencyEditDlg.FormCreate(Sender: TObject);
var
 I: TDocUrgency;
begin
 inherited;
 for I := cMinUrgency to cMaxUrgency do
  cbxUrgency.Items.Add(cUrgencyString[I]);
end;

function TUrgencyEditDlg.pm_GetUrgency: TDocUrgency;
begin
 Result := cbxUrgency.ItemIndex;
end;

procedure TUrgencyEditDlg.pm_SetUrgency(const Value: TDocUrgency);
begin
 cbxUrgency.ItemIndex := Value;
end;

end.
