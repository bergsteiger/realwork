unit d_SrchIncludeDoc;

{ $Id: D_SRCHINCLUDEDOC.PAS,v 1.2 2005/05/30 10:28:39 lulin Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, ToolEdit, vtHeader, vtCombo, vtDateEdit;

type
  TSrchIncludeDocDlg = class(TForm)
    pnlButtons: TPanel;
    pnlButtonsRight: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel1: TPanel;
    cbUser: TComboBox;
    Label6: TLabel;
    cbxAttach: TCheckBox;
    cbxChanged: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    edtLowDate: TvtDateEdit;
    edtHighDate: TvtDateEdit;
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

procedure TSrchIncludeDocDlg.FormCreate(Sender: TObject);
begin
 UserManager.GetFiltredUserList(cbUser.Items);
 //UserManager.UserTbl.GetDictList(cbUser.Items, False);
 cbUser.Items.Insert(0, '[бяе]');
 cbUser.ItemIndex := 0;
end;

end.
