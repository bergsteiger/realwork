unit alcuEmailNotifyDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, OvcBase, vtLister, vtStringLister, afwControl,
  afwInputControl, afwControlPrim, afwBaseControl;

type
  TEmailNotifyDialog = class(TForm)
    Bevel1: TBevel;
    CancelBtn: TButton;
    cbOnlyErrors: TCheckBox;
    editAddress: TLabeledEdit;
    editComment: TLabeledEdit;
    EventsList: TvtStringLister;
    OKBtn: TButton;
    procedure FormCreate(Sender: TObject);
  end;
  
var
  EmailNotifyDialog: TEmailNotifyDialog;

implementation

Uses
 alcuMailServer;

{$R *.dfm}

procedure TEmailNotifyDialog.FormCreate(Sender: TObject);
var
 i: Integer;
begin
 for i:= minEvent to maxEvent do
  EventsList.Items.Add(EventName[i]);
end;

end.

