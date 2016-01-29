unit Main;

{ $Id: Main.pas,v 1.8 2012/02/29 10:15:47 lulin Exp $ }

// $Log: Main.pas,v $
// Revision 1.8  2012/02/29 10:15:47  lulin
// CheckFiler
//
// Revision 1.7  2011/06/09 14:21:02  fireton
// - не собиралось
//
// Revision 1.6  2010/08/02 15:29:00  fireton
// - удаление пустых строк в начале блока (K228692043)
//
// Revision 1.5  2010/07/01 15:20:04  narry
// - K222036156
//
// Revision 1.4  2010/06/10 15:11:48  fireton
// - пишем список реально обработанных документов в файл
//
// Revision 1.3  2010/06/02 10:09:12  fireton
// - объединяем поиск таблиц и моноширинных текстов и расстановку
//    разделов в них
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
  afwControlPrim, afwBaseControl, afwControl, XPMan, ComCtrls;

type
  TMainForm = class(TForm)
    btWork: TButton;
    btStop: TButton;
    edBaseDir: TDirectoryEdit;
    pnStatus: TPanel;
    lbPercent: TLabel;
    Label1: TLabel;
    edTopicListFN: TFilenameEdit;
    lblTopicListFN: TLabel;
    Label2: TLabel;
    comboWhat: TComboBox;
    XPManifest1: TXPManifest;
    Progress: TProgressBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btWorkClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure comboWhatChange(Sender: TObject);
  private
    { Private declarations }
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_DB        : Im3DB;
    f_Start: TDateTime;
    function  pm_GetBaseDir: String;
    procedure pm_SetBaseDir(const aValue: String);
      {-}
    procedure DoBeforeIndexLoad(aSender: TObject);
      {-}
    procedure DoBeforeSort(aSender: TObject);
    procedure TotalProgress(aState     : Byte; aValue     : Long; const aMsg : String = '');
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

  ddSectionRepair,

  evdReader,
  evdWriter,
  evEvdRd,
  FTAM_Filter,
  evUnblockEmptyParaFilter,

  evInfoFilter, ddUtils, L3Math, ddSectionWithSub2Para;


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
   l_Parser := Tl3Parser.Create;
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

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 SaveSettings(Self);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 LoadSettings(Self);
end;

procedure TMainForm.btWorkClick(Sender: TObject);
var
 l_Total : TDateTime;

 procedure DoWork;
 var
  l_Name   : string;
  l_Filter : Tk2TagGenerator;
  l_SectRep: Tk2TagGenerator;
  l_Range  : Im3DBRange;
  l_List   : Im3StorageElementIDList;
  l_ListFN : string;
 begin//DoWork
  l_Filter := nil;
  l_Name := ConcatDirName(BaseDir, 'bserv001');
  f_DB := Tm3DB.Make(l_Name,
                     Yield,
                     nil,
                     TotalProgress);
  try
   if comboWhat.ItemIndex = 0 then
   begin
    l_ListFN := ExtractFilePath(Application.ExeName) + 'TopicsToProcess.txt';
    if FileExists(l_ListFN) then
     DeleteFile(l_ListFN);
    l_Filter := TFTAMFilter.Create(l_ListFN);
    try
     pnStatus.Caption := 'Поиск документов для обработки';
     l_Range := f_DB.AllFiles;
     f_Start:= Now;
     l_Range.Iterate(l_Filter, False, [m3_dsMain]);
    finally
     FreeAndNil(l_Filter);
     l_Range := nil;
    end;
   end
   else
    l_ListFN := edTopicListFN.FileName;

   if f_Stopped then
    Exit;

   l_List := LoadDocNumbers(l_ListFN);
   if l_List = nil then
   begin
    MessageDlg('Не удалось получить список топиков из файла!', mtError, [mbOK], 0);
    Exit;
   end;

   l_SectRep:= TddSectionRepairFilter.SetTo(l_Filter);
   try
    TevUnblockEmptyParaFilter.SetTo(l_Filter);
    TddSectionWithSub2ParaFilter.setTo(l_Filter);
    pnStatus.Caption := 'Простановка разделов';
    l_Range := f_DB.FilesInList(l_List);
    f_Start:= Now;
    l_Range.Iterate(l_Filter, True, [m3_dsMain]);
    TddSectionRepairFilter(l_SectRep).SaveListTo(ExtractFilePath(Application.ExeName)+'TopicsProcessed.txt');
   finally
    FreeAndNil(l_Filter);
   end;
  finally
   f_DB := nil;
  end;//try..finally
  MessageDlg('Обработка завершена!', mtInformation, [mbOK], 0);
 end;//DoWork

begin
 f_Stopped := false;
 f_InProcess := true;
 btWork.Enabled := false;
 btStop.Enabled := true;
 try
  l_Total := 0;
  try
   l3System.Msg2Log('Начало обработки');
   DoWork;
   if f_Stopped then
    l3System.Msg2Log('Обработка прервана пользователем')
   else
    l3System.Msg2Log('Обработка завершена');
  finally
   f_InProcess := false;
  end;//try..finally
 finally
  btWork.Enabled := true;
  btStop.Enabled := false;
 end;//try..finally
 pnStatus.Caption:= '';
 lbPercent.Caption:= '';
 if f_NeedClose then Close;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 f_Stopped := true;
 if (f_DB <> nil) then
  f_DB.Stop;
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

procedure TMainForm.comboWhatChange(Sender: TObject);
begin
 edTopicListFN.Visible  := comboWhat.ItemIndex = 1;
 lblTopicListFN.Visible := edTopicListFN.Visible;
end;

procedure TMainForm.TotalProgress(aState: Byte; aValue: Long; const aMsg: String = '');
begin
 case aState of
  0:
   begin
    Progress.Max:= aValue;
    Progress.Position:= 0;
    lbPercent.Caption := Format('Приступаем к обработке %d документов', [aValue]);
   end;
  1:
   begin
    Progress.Position:= aValue;
    if l3MulDiv(Progress.Position, 100, Progress.Max) > 0 then
     lbPercent.Caption := Format('Обработано %d документов из %d, до окончания осталось %s',
       [Progress.Position, Progress.Max, CalcLeftTime(Progress.Max, Progress.Position, f_Start, Now)])
    else
     lbPercent.Caption:= Format('Обработано %d документов из %d',  [Progress.Position, Progress.Max]);
   end;
  2:
   begin
    Progress.Position:= Progress.Max;
    lbPercent.Caption:= 'Обработка завершена';
   end;
 end;
end;

end.
