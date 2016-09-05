unit D_HndDoc;

{ $Id: d_HndDoc.pas,v 1.9 2016/08/10 12:48:40 lukyanets Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, vtCombo, vtDateEdit;

type
  THandlingDocDlg = class(TForm)
    pnlButtons: TPanel;
    pnlButtonsRight: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel1: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    cbUser: TComboBox;
    cbStage: TComboBox;
    cbStageType: TComboBox;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
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
 daDataProvider,

 DT_Types,
 DT_Doc,
 DT_Dict,
 DT_Stage,

 l3Date;


procedure THandlingDocDlg.FormCreate(Sender: TObject);
 Var
  I : integer;

 begin
  GlobalDataProvider.UserManager.GetFiltredUserList(cbUser.Items);
  cbUser.Items.Insert(0, '[бяе]');
  cbStage.Items.Insert(0, '[бяе]');
  for I := Low(cStagesStringUserOrder) to High(cStagesStringUserOrder) do
   cbStage.Items.AddObject(cStagesStringUserOrder[I].rName, TObject(cStagesStringUserOrder[I].rStageID));
  cbUser     .ItemIndex := 0;
  cbStage    .ItemIndex := 0;
  cbStageType.ItemIndex := 0;
 end;

end.
