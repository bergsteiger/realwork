unit Main;

{ $Id: Main.pas,v 1.9 2005/05/27 14:44:33 lulin Exp $ }

// $Log: Main.pas,v $
// Revision 1.9  2005/05/27 14:44:33  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.8  2003/04/01 14:16:07  law
// no message
//
// Revision 1.7  2002/08/02 08:18:24  law
// no message
//
// Revision 1.6  2002/04/17 08:29:01  law
// - new proc: m4UpdateIndex.
//
// Revision 1.5  2002/04/16 15:05:31  law
// - new behavior: сделано объединение дельты со старым индексом (новые слова пока не учитываютс€).
//
// Revision 1.4  2002/04/11 14:17:35  law
// - new behavior: сделано возможность построени€ дельты.
// - new behavior: сделано выкидывание ссылок на удаленные документы.
//
// Revision 1.3  2002/04/06 11:28:15  law
// - new behavior: сделано копирование потоков дл€ слов.
//
// Revision 1.2  2002/04/05 12:54:25  law
// - new behavior: сделано копирование структуры индекса (первое приближение).
//
// Revision 1.1  2002/04/03 12:14:30  law
// - new project: UpdateOldIndex.
//
// Revision 1.6  2002/03/13 15:36:15  law
// - new project: IndexOldCon.
//
// Revision 1.5  2002/03/05 16:37:26  law
// - new behavior: сделана возможность индексации в обратном пор€дке.
//
// Revision 1.4  2002/03/01 10:08:33  law
// - some cosmetics.
//
// Revision 1.3  2002/02/21 15:58:41  law
// - optimization.
//
// Revision 1.2  2002/02/20 14:13:38  law
// - bug fix: неправильна€ функци€ сравнени€ адресов.
//
// Revision 1.1  2002/02/20 12:45:02  law
// - new units: перва€ реализаци€ индексации документов.
//
// Revision 1.1  2002/01/16 15:42:06  law
// - new project: Old2New.
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  l3InterfacedComponent;

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
    lbPercent: TLabel;
    btHideFileMeter: TSpeedButton;
    procedure btCopyClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btStatClick(Sender: TObject);
    procedure btHideFileMeterClick(Sender: TObject);
    procedure FilesMeterSetStr(const aStr: String);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    function  pm_GetBaseDir: String;
    procedure pm_SetBaseDir(const aValue: String);
      {-}
      procedure FilesProcessed(aCurrentID: Long);
        {-}
      procedure FilesProcessedEx(aCurrentID : Long;
                                 aMaxID     : Long;
                                 aTime      : TDateTime);
        {-}
      procedure DoBeforeIndexLoad(aSender: TObject);
        {-}
      procedure DoBeforeSort(aSender: TObject);
        {-}
      procedure DoSortFinished(aSender: TObject);
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
  
  m4OldIndexTools,

  D_MemUsg
  ;

const
 cBaseDir = 'N:\Bases\';
 cBaseName = 'bserv001';

procedure TMainForm.btCopyClick(Sender: TObject);
var
 l_Elapsed : TDateTime;
begin
 btCopy.Enabled := false;
 btStop.Enabled := true;
 try
  f_Stopped := false;
  f_InProcess := true;
  m4UpdateIndex(BaseDir + cBaseName,
                FileMeter.ProgressProc_ev,
                FilesMeter.ProgressProc_ev,
                @f_Stopped,
                DoBeforeIndexLoad,
                DoBeforeSort,
                DoSortFinished,
                FilesProcessed,
                FilesProcessedEx,
                @l_Elapsed,
                false);
  if f_Stopped then
   pnStatus.Caption := 'ќбновление прервано пользователем ' + TimeToStr(l_Elapsed)
  else
   pnStatus.Caption := 'ќбновление завершено ' + TimeToStr(l_Elapsed);
  f_inProcess := false; 
 finally
  btCopy.Enabled := true;
  btStop.Enabled := false;
 end;//try..finally
 if f_NeedClose then Close;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 f_Stopped := true;
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
  if (MessageDlg('¬ы хотите прервать обновление индекса?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
   f_NeedClose := true;
   f_Stopped := true;
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
                       ' расчетное врем€ ' + TimeToStr((aTime) * 100 / FilesMeter.Percent);
end;

procedure TMainForm.DoBeforeIndexLoad(aSender: TObject);
  {-}
begin
 pnStatus.Caption := '«агрузка индекса';
end;

procedure TMainForm.DoBeforeSort(aSender: TObject);
  {-}
begin
 pnStatus.Caption := '—ортировка индекса';
end;
  
procedure TMainForm.DoSortFinished(aSender: TObject);
  {-}
begin
 pnStatus.Caption := '«апись индекса';
 Application.ProcessMessages;
end;
  
procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbNum.Caption := aStr;
end;

end.
