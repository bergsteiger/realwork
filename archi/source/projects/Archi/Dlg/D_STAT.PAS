unit D_stat;

{ $Id: D_STAT.PAS,v 1.9 2015/11/26 08:45:28 lukyanets Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
     StdCtrls, ExtCtrls, Mask, ToolEdit, OvcBase, OvcNbk, vtCombo,
  vtDateEdit, ComCtrls;

type
  TStatisticDlg = class(TForm)
    pnlButtons: TPanel;
    pnlButtonsRight: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel1: TPanel;
    FilenameEdit1: TFilenameEdit;
    Label11: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label5: TLabel;
    cbDocGroupD: TComboBox;
    chbShowUserD: TCheckBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtLowDateD: TvtDateEdit;
    edtHighDateD: TvtDateEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 Procedure GetStatistic;

implementation

{$R *.DFM}

uses
     SysUtils,
     daTypes,
     daSchemeConsts,
     DT_Const, Dt_Types, dt_AttrSchema,
     DT_Doc, DT_Dict, DT_User, DT_Stage,
     l3Date,
     Main;


Procedure TStatisticDlg.FormCreate(Sender: TObject);
 {Var
  I : TStageType;}
 begin
  {UserManager.UserTbl.GetDictList(cbUser.Items, False);
  cbUser.Items.Insert(0, '[ВСЕ]');
  cbStage.Items.Insert(0, '[ВСЕ]');
  For I := Succ(Succ(Low(TStageType))) to High(TStageType) do
   cbStage.Items.AddObject(StageStringConst[I],TObject(I));
  }

  DictServer(CurrentFamily).DictTbl[da_dlBases].GetDictList(cbDocGroupD.Items, False);
  cbDocGroupD.Items.Insert(0, '[ВСЕ]');
  cbDocGroupD.ItemIndex := 0;
  {cbUser     .ItemIndex := 0;
  cbStage    .ItemIndex := 0;
  cbStageType.ItemIndex := 0;
  cbDocGroupD.ItemIndex := 0;   }
 end;

procedure GetStatistic;
begin
 raise Exception.Create('Функция выключена поскольку разработчики решили, что она никем не используется.' +
                         'Если вы все же используете ее в работе сообщите разработчикам и мы вернем ее.');
  (*
   With TStatisticDlg.Create(MainForm) do
    Try
     If ShowModal = mrOK then
      Begin
       DocumentServer.Family := CurrentFamily;
       DocumentServer.StageTbl.ReportFile := FilenameEdit1.Text;
       DocumentServer.BaseStatistic1(Word(cbDocGroupD.Items.Objects[cbDocGroupD.ItemIndex]),
                            DateTimeToStDate(edtLowDateD.Date),
                            DateTimeToStDate(edtHighDateD.Date),
                            chbShowUserD.Checked,True);
      end;
    finally
     Free;
    end;
   *)
  end;

end.
