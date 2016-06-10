unit d_DateIn;

{ $Id: d_DateIn.pas,v 1.10 2016/04/18 08:39:30 lukyanets Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, ToolEdit, vtCombo, vtDateEdit, vtCtrls, vtGroupBoxEx,
  vtGroupBox;

type
  TFindByJournalDlg = class(TForm)
    pnlButtons: TPanel;
    pnlButtonsRight: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel1: TPanel;
    gbxStageStatus: TvtGroupBoxEx;
    cbxStageInc: TCheckBox;
    cbxStageUnInc: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    LowDateEdit: TvtDateEdit;
    Label4: TLabel;
    HighDateEdit: TvtDateEdit;
    gbxType: TvtGroupBoxEx;
    cbxChanged: TCheckBox;
    cbxNew: TCheckBox;
    cbUser: TComboBox;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

Uses
  DT_User;

procedure TFindByJournalDlg.FormCreate(Sender: TObject);
begin
 UserManager.GetFiltredUserList(cbUser.Items);
 cbUser.Items.Insert(0, '[бяе]');
 cbUser.ItemIndex := 0;
end;

end.
