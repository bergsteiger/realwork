unit Main;

{ $Id: Main.pas,v 1.10 2007/08/24 20:34:58 lulin Exp $ }

// $Log: Main.pas,v $
// Revision 1.10  2007/08/24 20:34:58  lulin
// - cleanup.
//
// Revision 1.9  2007/08/24 20:27:13  lulin
// - bug fix: не собирался проект.
//
// Revision 1.8  2005/05/27 14:44:38  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.7  2005/02/03 12:54:25  lulin
// - bug fix: не компилировался индексатор.
//
// Revision 1.6  2004/08/24 14:45:55  law
// - new build.
//
// Revision 1.5  2004/08/20 12:43:59  law
// - new build.
//
// Revision 1.4  2004/08/20 07:50:22  law
// - new build.
//
// Revision 1.3  2004/08/19 15:39:45  law
// - в нулевом приближении сделана индексация нового хранилища.
//
// Revision 1.2  2004/08/17 15:25:39  law
// - new build.
//
// Revision 1.1  2004/05/07 13:08:36  law
// - change: утилита IndexOld переехала в каталог Tools.
//
// Revision 1.13  2003/06/16 13:56:46  law
// - new behavior: во время индексации отключаем кнопку проверки базы.
//
// Revision 1.12  2003/06/16 12:18:03  law
// - new behavior: сделана возможность индексировать в пустоту.
//
// Revision 1.11  2003/04/01 14:16:06  law
// no message
//
// Revision 1.10  2002/10/08 13:12:41  law
// - new actions.
//
// Revision 1.9  2002/09/18 12:51:58  law
// no message
//
// Revision 1.8  2002/04/11 14:15:05  law
// - new behavior: сделано возможность построения дельты.
//
// Revision 1.7  2002/04/03 12:16:20  law
// - new features: новые параметры индексации.
//
// Revision 1.6  2002/03/13 15:36:15  law
// - new project: IndexOldCon.
//
// Revision 1.5  2002/03/05 16:37:26  law
// - new behavior: сделана возможность индексации в обратном порядке.
//
// Revision 1.4  2002/03/01 10:08:33  law
// - some cosmetics.
//
// Revision 1.3  2002/02/21 15:58:41  law
// - optimization.
//
// Revision 1.2  2002/02/20 14:13:38  law
// - bug fix: неправильная функция сравнения адресов.
//
// Revision 1.1  2002/02/20 12:45:02  law
// - new units: первая реализация индексации документов.
//
// Revision 1.1  2002/01/16 15:42:06  law
// - new project: Old2New.
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3InterfacedComponent, m4DBInterfaces, afwControl;

type
  TMainForm = class(TForm)
    btCopy: TButton;
    FileMeter: TvtW95Meter;
    FilesMeter: TvtW95Meter;
    lbFile: TLabel;
    lbFiles: TLabel;
    OvcController: TOvcController;
    lbNum: TLabel;
    btStop: TButton;
    edBaseDir: TEdit;
    pnStatus: TPanel;
    btStat: TSpeedButton;
    seIndexID: TvtSpinEdit;
    lbPercent: TLabel;
    btHideFileMeter: TSpeedButton;
    cbPacked: TCheckBox;
    cbDelta: TCheckBox;
    cbFake: TCheckBox;
    procedure btCopyClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btStatClick(Sender: TObject);
    procedure btHideFileMeterClick(Sender: TObject);
    procedure FilesMeterSetStr(const aStr: String);
  private
    { Private declarations }
      f_DB        : Im4DB;
      f_Stopped   : Bool;
      f_InProcess : Bool;
      f_NeedClose : Bool;
      function  pm_GetBaseDir: String;
      procedure pm_SetBaseDir(const aValue: String);
        {-}
      procedure Yield(aSender: TObject);
        {-}
      procedure FilesProcessed(aCurrentID: Long);
        {-}
      procedure FilesProcessedEx(aCurrentID : Long;
                                 aMaxID     : Long;
                                 aTime      : TDateTime);
        {-}
  public
    { Public declarations }
      property BaseDir: String
        read pm_GetBaseDir
        write pm_SetBaseDir;
        {-}
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  l3Base,

  m4DB,

  D_MemUsg
  ;

const
 cBaseDir = 'N:\Bases\';

procedure TMainForm.btCopyClick(Sender: TObject);
var
 l_Total   : TDateTime;

 procedure DoIndex;
 var
  l_Elapsed : TDateTime;
 begin//DoIndex
  f_DB := Tm4DB.Make(BaseDir + 'bserv001',
                     Yield,
                     FileMeter.ProgressProc_ev,
                     FilesMeter.ProgressProc_ev,
                     FilesProcessed,
                     FilesProcessedEx);
  try
   f_DB.PackedIndex := cbPacked.Checked;
   f_DB.FakeIndex := cbFake.Checked;
   f_DB.BuildIndex(cbDelta.Checked, false, seIndexID.AsInteger);
   l_Elapsed := f_DB.LastElapsed;
   f_Stopped := f_DB.Stopped;  
  finally
   f_DB := nil;
  end;//try..finally
  l_Total := l_Total + l_Elapsed;
 end;//DoIndex

begin
 f_Stopped := false;
 f_InProcess := true;
 btCopy.Enabled := false;
 btStop.Enabled := true;
 try
  l_Total := 0;
  try
   DoIndex;
   if f_Stopped then
    pnStatus.Caption := 'Индексация прервана пользователем ' + TimeToStr(l_Total)
   else
    pnStatus.Caption := 'Индексация завершена ' + TimeToStr(l_Total);
  finally
   f_InProcess := false;
  end;//try..finally
 finally
  btCopy.Enabled := true;
  btStop.Enabled := false;
 end;//try..finally
 if f_NeedClose then Close;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 if (f_DB <> nil) then
  f_DB.Stop;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 BaseDir := cBaseDir;
end;

function TMainForm.pm_GetBaseDir: String;
  {-}
begin
 Result := edBaseDir.Text;
end;

procedure TMainForm.pm_SetBaseDir(const aValue: String);
  {-}
begin
 edBaseDir.Text := aValue;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if f_InProcess then begin
  if (MessageDlg('Вы хотите прервать заливку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
   f_NeedClose := true;
   if (f_DB <> nil) then
    f_DB.Stop;
  end;
  CanClose := false;
 end;//f_InProcess
end;

procedure TMainForm.btStatClick(Sender: TObject);
begin
 MemoryUsageDlg.ShowModal;
end;

procedure TMainForm.btHideFileMeterClick(Sender: TObject);
begin
 FileMeter.Visible := not btHideFileMeter.Down;
end;

procedure TMainForm.Yield(aSender: TObject);
  {-}
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FilesProcessed(aCurrentID: Long);
  {-}
begin
 with l3System do
  pnStatus.Caption := Format('local: %d global: %d objects: %d/%d',
                             [LocalMemUsed, GlobalMemUsed, ObjectCount, ObjectMemUsed]);
end;

procedure TMainForm.FilesProcessedEx(aCurrentID : Long;
                                     aMaxID     : Long;
                                     aTime      : TDateTime);
  {-}
begin
 lbPercent.Caption := IntToStr(FilesMeter.Percent) +
                               '% ' +
                               TimeToStr(aTime);
 if (FilesMeter.Percent > 0) then
  lbPercent.Caption := lbPercent.Caption +
                       ' расчетное время ' + TimeToStr((aTime) * 100 / FilesMeter.Percent);
end;

procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbNum.Caption := aStr;
end;

end.
