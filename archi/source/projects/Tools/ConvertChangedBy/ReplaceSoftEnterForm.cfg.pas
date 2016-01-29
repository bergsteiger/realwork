unit ReplaceSoftEnterForm.cfg;

{ $Id: ReplaceSoftEnterForm.cfg.pas,v 1.1 2012/02/07 06:49:01 narry Exp $ }

// $Log: ReplaceSoftEnterForm.cfg.pas,v $
// Revision 1.1  2012/02/07 06:49:01  narry
// Утилита по замене мягких переносов (335580209)
//
// Revision 1.2  2012/01/11 10:40:41  narry
// Возврат к обработке через хранилище
//
// Revision 1.1  2012/01/04 11:34:36  narry
// Утилита построения списка измененных (325261072)
//

interface

uses
  Windows, ActiveX, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcBase, l3Types,  W95Meter, ExtCtrls, Buttons,
  vtSpin, l3InterfacedComponent, m3DBInterfaces, Mask, ToolEdit,
  afwControlPrim, afwBaseControl, afwControl, XPMan, ComCtrls,
  l3LongintList, ReplaceSoftEnterFilter,
  m3StorageInterfaces, DT_Sab, DT_Types, l3Stream;

type
  TMainForm = class(TForm)
    btWork: TButton;
    btStop: TButton;
    pnStatus: TPanel;
    lbPercent: TLabel;
    Progress: TProgressBar;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edBaseDir: TDirectoryEdit;
    Label4: TLabel;
    Label5: TLabel;
    EditLogin: TEdit;
    EditPassword: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    comboWhat: TComboBox;
    lblTopicListFN: TLabel;
    edTopicListFN: TFilenameEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btWorkClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure comboWhatChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    f_ChangedNumbers: Tl3NamedTextStream;
    f_CurDoc: TDocID;
    { Private declarations }
    f_DB        : Im3DB;
    f_Stopped   : Bool;
    f_InProcess : Bool;
    f_NeedClose : Bool;
    f_Start: TDateTime;
    f_Topics: Tl3LongintList;
    function  pm_GetBaseDir: String;
    procedure pm_SetBaseDir(const aValue: String);
    procedure DoWork;
    procedure TotalProgress(aState     : Byte; aValue     : Long; const aMsg : String = '');
      {-}
    procedure HTIdle;
    procedure StopWork;
      {-}
  protected
    function AllDocsList: Im3DBRange;
    procedure DocumentStatus(DocID: Integer; DocStatus: TddDocStatus);
    function HTLongProcess(aState : TProcessState): Boolean;
    function ListDocsList(const aFileName: String): Im3DBRange;
    function Sab2Range(aSab: ISab): Im3DBRange;
    procedure Yield(Sender: TObject);
  public
    function GetAppFolderFileName(const aFileName: String; aUnique: Boolean =
        False): String;
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
  l3Memory,

  k2Types,
  k2Tags,
  k2TagGen,
  k2StackGenerator,

  m3DB,
  m3DBActions,

  evdReader,
  evdWriter,
  evEvdRd,

  evInfoFilter, ddUtils, L3Math, StrUtils,
  ddHTInit, DT_Const,
  DT_LinkServ, dt_ListUtils, DT_Serv,
  l3LongintListPrim, DT_Doc, m3StorageElementIDList;



function TMainForm.AllDocsList: Im3DBRange;
var
 l_Sab: ISab;
begin
 l_Sab:= MakeAllRecords(DocumentServer(CurrentFamily).FileTbl);
 l_Sab.ValuesOfKey(fID_fld);
 Result:= Sab2Range(l_Sab);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_Topics);
 SaveSettings(Self);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 LoadSettings(Self);
 f_Topics := Tl3LongintList.Create();
 comboWhatChange(Self);
end;

procedure TMainForm.btWorkClick(Sender: TObject);
var
 l_Total : TDateTime;

begin
 f_Stopped := false;
 f_InProcess := true;
 btWork.Enabled := false;
 btStop.Enabled := true;
 Progress.Visible:= True;
 try
  l_Total := 0;
  try
   if InitBaseEngine(BaseDir, editLogin.Text, editPassword.Text) then
   try
    GlobalHTServer.OnIdle:= HTIdle;
    GlobalHtServer.OnLongProcess:= HTLongProcess;
    l3System.Msg2Log('Начало обработки');
    DoWork;
    if f_Stopped then
     l3System.Msg2Log('Обработка прервана пользователем')
    else
     l3System.Msg2Log('Обработка завершена');
   finally
    DoneBaseEngine;
   end;
  finally
   f_InProcess := false;
  end;//try..finally
 finally
  btWork.Enabled := true;
  btStop.Enabled := false;
  Progress.Visible:= False;
 end;//try..finally
 pnStatus.Caption:= '';
 lbPercent.Caption:= '';
 if f_NeedClose then Close;
end;

procedure TMainForm.btStopClick(Sender: TObject);
begin
 f_Stopped := true;
 StopWork;
end;

procedure TMainForm.comboWhatChange(Sender: TObject);
begin
 edTopicListFN.Visible  := comboWhat.ItemIndex = 1;
 lblTopicListFN.Visible := edTopicListFN.Visible;
end;

function TMainForm.pm_GetBaseDir: String;
  {-}
begin
 Result := edBaseDir.Text;
end;

procedure TMainForm.pm_SetBaseDir(const aValue: String);
begin
 edBaseDir.Text := aValue;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if f_InProcess then begin
  if (MessageDlg('Вы хотите прервать обработку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
   f_NeedClose := true;
   f_Stopped := true;
   StopWork;
  end;
  CanClose := false;
 end;//f_InProcess
end;

procedure TMainForm.DocumentStatus(DocID: Integer; DocStatus: TddDocStatus);
var
 l_S: ShortString;
 l_ID: TDocID;
begin
 l_ID:= LinkServer(CurrentFamily).Renum.GetExtDocID(DocID);
 case DocStatus of
  dd_dsChanged:
   begin
    l_S:= 'Исправлен';
    f_ChangedNumbers.PutInteger(l_ID);
    f_ChangedNumbers.PutEndOfLine;
   end;
  dd_dsAbsent: l_S:= 'Информация об изменениях не найдена';
  dd_dsNotFinished: l_S:= 'Не обработан';
  dd_dsIDAbsent: l_S:= 'Нет ID документа';
 end;
 l3System.Msg2Log('%10d: %s', [l_ID, l_S]);
end;


(*
 procedure DoWork;
 var
  l_Filter : Tk2TagGenerator;
  l_Range  : Im3DBRange;
 begin//DoWork
  l_Filter := nil;
  f_DB := Tm3DB.Make(ConcatDirName(BaseDir, 'bserv001'),
                     Yield,
                     nil,
                     TotalProgress);
  try
   l_Filter:= TddChangedByFilter.SetTo(l_Filter);
   try
    TddChangedByFilter(l_Filter).OnDocumentStatus:= DocStatus;
    pnStatus.Caption := '?????????????? ?????????? ??????????...';
    if comboWhat.ItemIndex = 0 then
     l_Range := f_DB.AllFiles
    else
     l_Range := LoadDocNumbers(edTopicListFN.Text);
    f_Topics.Clear;
    f_Start:= Now;
    l_Range.Iterate(l_Filter, True, [m3_dsMain]);
    SaveTopicsList;
   finally
    FreeAndNil(l_Filter);
   end;
  finally
   f_DB := nil;
  end;//try..finally
  MessageDlg('?????????????? ?????????', mtInformation, [mbOK], 0);
 end;//DoWork

*)
procedure TMainForm.DoWork;
var
 l_Filter : Tk2TagGenerator;
 l_Range  : Im3DBRange;
 l_D      : TDiapasonRec;
 l_List   : Im3StorageElementIDList;
begin//DoWork
 f_ChangedNumbers:= Tl3NamedTextStream.Create(GetAppFolderFileName('Style52Topics.txt'), l3_fmWrite);
 try
  f_DB := Tm3DB.Make(ConcatDirName(g_BaseEngine.PathRec.DocsPath, 'garant\bserv001'),
                     Yield,
                     nil,
                     TotalProgress);
  try
   l_Filter:= nil;
   try
    TReplaceSoftEnterFilter.SetTo(l_Filter);
    TReplaceSoftEnterFilter(l_Filter).OnDocumentStatus:= DocumentStatus;
    pnStatus.Caption := 'Поиск исправленных документов...';
    if comboWhat.ItemIndex = 0 then
     l_Range := AllDocsList
    else
     l_Range := ListDocsList(edTopicListFN.Text);
    try
     l_Range.Iterate(l_Filter, True, [m3_dsMain]);
     MessageDlg('Поиск завершен', mtInformation, [mbOK], 0);
    except
     on E: Exception do
     begin
      l3System.Exception2Log(E);
      MessageDlg(Format('Во время поиска произошла ошибка "%s".'#10'Подробности в лог-файле', [E.Message]), mtError, [mbOK], 0);
     end;
    end;
   finally
    FreeAndNil(l_Filter);
   end;
  finally
   f_DB := nil;
  end;//try..finally
 finally
  FreeAndNil(f_ChangedNumbers);
 end;
end;//DoWork

function TMainForm.GetAppFolderFileName(const aFileName: String; aUnique:
    Boolean = False): String;
var
 l_Folder: String;
begin
 l_Folder:= ExtractFileDir(Application.ExeName);
 Result:= ConcatDirName(l_Folder, aFileName);
 if aUnique then
  Result:= MakeUniqueFileName(Result);
end;

procedure TMainForm.HTIdle;
  {-}
begin
 Application.ProcessMessages;
end;

function TMainForm.HTLongProcess(aState : TProcessState): Boolean;
begin
 Result := False;
 Application.ProcessMessages;
end;

function TMainForm.ListDocsList(const aFileName: String): Im3DBRange;
begin
 Result:= Sab2Range(LoadDocNumbers(aFileName));
end;

function TMainForm.Sab2Range(aSab: ISab): Im3DBRange;
var
 l_SabList: Tl3LongintList;
 l_RangeList: Im3StorageElementIDList;
 i: Integer;
begin
 Result := nil;
 l_RangeList := Tm3StorageElementIDList.MakeI;
 try
  l_SabList:= dtMakeSortedIDListBySab(aSab);
  try
   for i:= 0 to l_SabList.Hi do
    l_RangeList.Add(l_SabList[i]);
   Result:= f_DB.FilesInList(l_RangeList); 
  finally
   FreeAndNil(l_SabList);
  end;
 finally
  l_RangeList:= nil;
 end;
end;

procedure TMainForm.StopWork;
begin
 if f_DB <> nil then
  f_DB.Stop;
end;

procedure TMainForm.TotalProgress(aState: Byte; aValue: Long; const aMsg: String = '');
begin
 case aState of
  0: begin
      Progress.Position:= 0;
      Progress.Max:= aValue;
     end;
  1: begin
      Progress.Position:= aValue;
     end; // aState = 1
  2: Progress.Position:= Progress.Max;
 end;
 Application.ProcessMessages;
end;

procedure TMainForm.Yield(Sender: TObject);
begin
 Application.ProcessMessages;
end;

end.
