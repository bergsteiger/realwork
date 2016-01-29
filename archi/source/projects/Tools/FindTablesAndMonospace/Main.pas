unit Main;

{ $Id: Main.pas,v 1.2 2012/02/29 10:15:48 lulin Exp $ }

// $Log: Main.pas,v $
// Revision 1.2  2012/02/29 10:15:48  lulin
// CheckFiler
//
// Revision 1.1  2010/05/24 07:51:46  fireton
// - initial commit
//
// Revision 1.2  2010/04/16 12:42:03  fireton
// - выкидываем ненужную трубу
//
// Revision 1.1  2010/04/16 09:15:42  fireton
// - initial commit
//
// Revision 1.3  2010/04/15 14:45:15  fireton
// - доработка
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3InterfacedComponent, m3DBInterfaces, Mask, ToolEdit, 
  afwControlPrim, afwBaseControl, afwControl, vtCombo, vtDateEdit;

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
    edBaseDir: TDirectoryEdit;
    pnStatus: TPanel;
    btStat: TSpeedButton;
    lbPercent: TLabel;
    btHideFileMeter: TSpeedButton;
    Label1: TLabel;
    edTopicListFN: TFilenameEdit;
    lblTopicListFN: TLabel;
    cbAllDocs: TCheckBox;
    procedure btCopyClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btStatClick(Sender: TObject);
    procedure btHideFileMeterClick(Sender: TObject);
    procedure FilesMeterSetStr(const aStr: String);
    procedure cbAllDocsClick(Sender: TObject);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_DB        : Im3DB;
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
    procedure Yield(aSender: TObject);
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
  l3InternalInterfaces,
  l3Base,
  l3Filer,
  l3FileUtils,
  l3Parser,
  l3Stream,
  l3Memory,

  k2Types,
  k2Tags,
  k2TagGen,
  k2StackGenerator,

  m3DB,
  m3DBActions,
  m3StorageInterfaces,
  m3StorageElementIDList,

  evdReader,
  evdWriter,
  evEvdRd,

  FTAM_Filter,

  D_MEMUSG
  ;

// start class TMainForm

const
 cBaseDir = 'w:\bigstg';
 //cBaseDir = '\\ARCHI2\Archi\fullbase.archi\garant\';

function LoadDocNumbers(const aFileName: string): Im3StorageElementIDList;
var
 lStream : Tl3FileStream;
 lTmpStream : Tl3MemoryStream;
 l_Parser    : Tl3Parser;
 l_CurNum    : Integer;

begin
 Result := nil;
 if FileExists(aFileName) then
 begin
  lStream := Tl3FileStream.Create(aFileName, l3_fmRead);
  try
   l_Parser := Tl3Parser.Create(nil);
   try
    l_Parser.CheckFloat := False;
    l_Parser.CheckFiler.Stream := lStream;
    l_Parser.NextTokenSp;
    while l_Parser.TokenType <> l3_ttEOF do
    begin
     if l_Parser.TokenType = l3_ttInteger then
     begin
      if Result = nil then
       Result := Tm3StorageElementIDList.MakeI;
      try
       l_CurNum := l_Parser.TokenInt;
       Result.Add(l_CurNum);
      except
      end;
     end;
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
    end;
   finally
    l3Free(l_Parser);
   end;
  finally
   l3Free(lStream);
  end;
 end;
end;

procedure TMainForm.btCopyClick(Sender: TObject);
var
 l_Total : TDateTime;

 procedure DoIndex;
 var
  l_Name   : string;
  l_Filter : TFTAMFilter;
  l_Range  : Im3DBRange;
  l_List   : Im3StorageElementIDList;
 begin//DoIndex
  if not cbAllDocs.Checked then
  begin
   l_List := LoadDocNumbers(edTopicListFN.FileName);
   if l_List = nil then
   begin
    MessageDlg('Не удалось получить список топиков из файла!', mtError, [mbOK], 0);
    Exit;
   end;
  end;
  l_Name := ConcatDirName(BaseDir, 'bserv001');
  f_DB := Tm3DB.Make(l_Name,
                     Yield,
                     FileMeter.ProgressProc_ev,
                     FilesMeter.ProgressProc_ev,
                     FilesProcessed,
                     FilesProcessedEx);
  try
   l_Filter := TFTAMFilter.Create;
   try
    if cbAllDocs.Checked then
     l_Range := f_DB.AllFiles
    else
     l_Range := f_DB.FilesInList(l_List);
    l_Range.Iterate(l_Filter, False, [m3_dsMain]);
    //l_Total := l_Total + f_DB.LastElapsed;
   finally
    FreeAndNil(l_Filter);
   end;
  finally
   f_DB := nil;
  end;//try..finally
 end;//DoIndex

begin
 //g_AllowRaiseAbort := true;
 f_Stopped := false;
 f_InProcess := true;
 btCopy.Enabled := false;
 btStop.Enabled := true;
 try
  l_Total := 0;
  try
   DoIndex;
   if f_Stopped then
    pnStatus.Caption := 'Обработка прервана пользователем ' + TimeToStr(l_Total)
   else
    pnStatus.Caption := 'Обработка завершена ' + TimeToStr(l_Total);
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
 f_Stopped := true;
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
  if (MessageDlg('Вы хотите прервать обработку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
   f_NeedClose := true;
   f_Stopped := true;
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

procedure TMainForm.DoBeforeIndexLoad(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Идёт расстановка разделов';
end;

procedure TMainForm.DoBeforeSort(aSender: TObject);
  {-}
begin
 pnStatus.Caption := 'Расстановка разделов завершена';
end;
  
procedure TMainForm.Yield(aSender: TObject);
  {-}
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbNum.Caption := aStr;
end;

procedure TMainForm.cbAllDocsClick(Sender: TObject);
begin
 edTopicListFN.Enabled := not cbAllDocs.Checked;
 lblTopicListFN.Enabled := edTopicListFN.Enabled;
end;

end.
