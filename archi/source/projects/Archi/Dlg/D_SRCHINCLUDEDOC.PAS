unit d_SrchIncludeDoc;

{ $Id: D_SRCHINCLUDEDOC.PAS,v 1.3 2016/04/18 08:39:30 lukyanets Exp $ }

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
 cbUser.Items.Insert(0, '[бяе]');
 cbUser.ItemIndex := 0;
end;

end.
