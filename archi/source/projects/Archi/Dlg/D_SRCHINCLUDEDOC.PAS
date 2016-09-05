unit d_SrchIncludeDoc;

{ $Id: D_SRCHINCLUDEDOC.PAS,v 1.4 2016/08/10 12:48:40 lukyanets Exp $ }

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
  daDataProvider;

procedure TSrchIncludeDocDlg.FormCreate(Sender: TObject);
begin
 GlobalDataProvider.UserManager.GetFiltredUserList(cbUser.Items);
 cbUser.Items.Insert(0, '[бяе]');
 cbUser.ItemIndex := 0;
end;

end.
