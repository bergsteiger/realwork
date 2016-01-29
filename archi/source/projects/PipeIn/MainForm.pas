unit MainForm;

{$I ProjectDefine.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ToolEdit, Mask,
  l3IniFile, Buttons, RXCtrls, l3Stream,
  l3Base, l3StringList, daTypes, daInterfaces, dt_Types,  vtDialogs, ddImportPipe,
  ddProgressObj, AppEvnts, CheckLst, ActnList, Menus, ddCmdLineUtils,
  l3Interfaces, l3Filer, SPHTMLHelp, StdActns;

type
  TSpyCommandLine = class(TddBaseCmdLine)
  private
   f_AutolinkFile: string;
   f_CheckDuplicate: String;
   f_Format: string;
   f_ImportParams: String;
   f_KTFile: string;
   f_MisspellFile: string;
   f_SrcFolder: String;
   f_SrcObjFolder: string;
  protected
   procedure Init; override;
   procedure SetDefault; override;
  public
   property AutolinkFile: string read f_AutolinkFile write f_AutolinkFile;
   property CheckDuplicate: String read f_CheckDuplicate write f_CheckDuplicate;
   property Format: string read f_Format write f_Format;
   property ImportParams: String read f_ImportParams write f_ImportParams;
   property KTFile: string read f_KTFile write f_KTFile;
   property SrcFolder: String read f_SrcFolder write f_SrcFolder;
   property SrcObjFolder: string read f_SrcObjFolder write f_SrcObjFolder;
  end;

  TSpyForm = class(TForm, IdaLongProcessSubscriber, IdaProgressSubscriber)
    VersionLabel: TLabel;
    PageControl1: TPageControl;
    Additional: TTabSheet;
    NSRCTab: TTabSheet;
    GroupBox2: TGroupBox;
    kwFileEdit: TFilenameEdit;
    TabSheet2: TTabSheet;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    btnGo: TButton;
    CancelButton: TButton;
    lblMainInfo: TLabel;
    ServerProgressBar: TProgressBar;
    Label15: TLabel;
    comboUserList: TComboBox;
    chbDictionCollect: TCheckBox;
    HelpButton: TButton;
    ApplicationEvents1: TApplicationEvents;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    actExit: TAction;
    actUpdateBase: TAction;
    actRepairBase: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    deWorkDir: TDirectoryEdit;
    dirPicture: TDirectoryEdit;
    comboInputType: TComboBox;
    comboSameDocs: TComboBox;
    chkImportParams: TCheckListBox;
    chkKWParams: TCheckListBox;
    Action1: TAction;
    actHelpContents: THelpContents;
    mnuHelp: TMenuItem;
    N7: TMenuItem;
    actHelpContext: THelpContextAction;
    pnlError: TPanel;
    pnlMessage: TPanel;
    pnlMain: TPanel;
    procedure actExitExecute(Sender: TObject);
    procedure actHelpContentsExecute(Sender: TObject);
    procedure actHelpContextExecute(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure chbDictionCollectClick(Sender: TObject);
    procedure btnUpdateTablesClick(Sender: TObject);
    procedure deWorkDirChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnEQClassClick(Sender: TObject);
    procedure btnTablePriorityClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure comboInputTypeChange(Sender: TObject);
    procedure btnPriorityClick(Sender: TObject);
    procedure cbIsDeltaKWClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    AlreadyDone: Boolean;
    SelfDestroy: Boolean;
    f_ImportErrors: TStrings;
    f_Progressor : TddProgressObject;
   f_Pipe: TddImportPipe;
    ReIndex: Boolean;
    IndexFileName: String;

    BaseIndex: Integer;
    FamilyIndex: Integer;
    BasePath: String;
    LoadDict: Boolean;
    KWFile: String;
    ClearOldKW: Boolean;
    CloseWhenDone: Boolean;
    MoveDoneFiles: Boolean;
    MoveDir: String;
    LoadNSRC: Boolean;
    CheckPriority: Boolean;
    ExclusiveMode: Boolean;
    FinalUpdate: Boolean;
    UpdateDicts: Boolean;
    UpdateDocs: Boolean;
    ImportType: Integer;
    SameDocuments: Integer;
    CheckDocuments: Boolean;
    InputFileType: Integer;
    PictureDir: String;
    IfNotModify: Boolean;
    IfNotVIncluded: Boolean;
    {--------  Пакетная доливка ------------}
    CancelAutoImport: Boolean;
    f_AutoRun: Boolean;
    f_BaseFolder: AnsiString;
    f_CmdLine: TSpyCommandLine;
    f_KTFileName: string;
    f_Password: string;
    f_Port: Integer;
    f_Server: string;
    f_UserName: string;
    f_WrongWords: Tl3DOSFiler;
    UseIndicators: Boolean;
    procedure CloseMessagePanels;
    {---------------------------------------}
    procedure MyIdle(Sender: TObject; var Done: Boolean);
    procedure DisableControls;
    procedure EnableControls;
    procedure TotalProgress(aState: Byte; aValue: Longint; const aMsg: string);
    procedure FillAbout;
    procedure DoCheckPriority;
    function DoImport: Boolean;
    procedure DoIndex;
    procedure DoLoadKWFile;
    procedure FIllImportParams;
    procedure ParseParamString;
    procedure ParseServerPart;
    procedure ParseUserPart;
    procedure ParseWhatPart;
    procedure PromptAddParams;
    procedure SetDefaultValues;
    procedure SetDefaultWhatPart;
    procedure ShowError(const aMessage: AnsiString);
    procedure ShowHelp;
    procedure ShowMessage(const aMessage: AnsiString);
    procedure UpdateTables(makeProgressor: Boolean = False);
    procedure WrongWordFound(aTopicID: Integer; aWrongWord: Il3CString);
  protected
    procedure FillFileTypes;
    // IdaLongProcessSubscriber
   function DoLongProcessNotify(aState: TdaProcessState): Boolean;
   // IdaProgressSubscriber
   procedure DoProgressNotify(aState: Byte;
     aValue: Integer;
     const aMsg: AnsiString = '');
  public
    { Public declarations }
    procedure StopAutoImport;
    procedure YieldProc(Sender: TObject);
  end;

var
  SpyForm: TSpyForm;


implementation

{$R *.DFM}

Uses
  ddUtils, ddKW_r,
  vtVerInf,
  daDataProvider,
  daProgressProcHolder,
  dt_Const, dt_AttrSchema,
  DT_Serv, dt_IFltr, {dt_Conn,} dt_User, dt_Prior, dt_Doc,
  l3FileUtils, m4DB, m4DBInterfaces, m3StorageInterfaces,
  D_Pass, D_ImpPrg, ddHTInit, ht_Const, l3Types,
  k2TagGen, ddDocReader, ddExtAnnoPipe,
  stDate, l3ExceptionsLog, ddClosingWin, ErrorForm, ddImportPipeKernel,
  ddBaseEngine, ddAppConfigUtils, dt_UserConst, afwVCL, ddAppConfigTypes,
  ddIniStorage, csUserRequestManager, StrUtils, BaseSupport, Base_CFG,
  ddAutoLinkServer, ddCmdLineDlg, ddClientBaseEngine,

  daDataProviderParams,
  ncsServiceProviderParams,
  htDataProviderParams,


  m3StgMgr
  ;

resourcestring
  SHaveSomeErrors = 'Некоторые документы содержали ошибки. Вы хотите посмотреть список ошибок?';
  SErrorSetParams = 'Ошибка установки параметров';
  SUserPassword = 'UserPassword';
  SUserName = 'UserName';
  SUser = 'User';
  SFamilyPath = 'FamilyPath';

const
 ProgramCaption = 'Импорт документов. "Архивариус"';
 cExclusiveMode = 0;
 cAddNewItems   = 1;
 //cCalcPriority  = 2;
 cAddImport2Log = 2;
 cUpdateBase    = 3;
 cUpdateText    = 4;
 cAutoLink      = 5;
 cOpenAKStage   = 6;
 cAddKT         = 7;
 cInclude       = 8;
 cSpellCheck    = 9;
 cAddAccGroup   = 10;
 {Всегда последний элемент!}
const
 cEnglishBase   : Integer = 11;

 cClearOldKW    = 0;
 cUpdateKW      = 1;
 cIsDeltaKW     = 2;

procedure TSpyForm.actExitExecute(Sender: TObject);
begin
 Close;
end;

procedure TSpyForm.actHelpContentsExecute(Sender: TObject);
begin
 Application.HelpSystem.ShowTableOfContents;
end;

procedure TSpyForm.actHelpContextExecute(Sender: TObject);
begin
 Application.HelpCommand(HELP_CONTEXT, Screen.ActiveControl.HelpContext);
end;

procedure TSpyForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
 UserRequestManager.ProcessNotifyList;
end;

procedure TSpyForm.DisableControls;
var
  i: Integer;
  C: TComponent;
begin
//  PageControl1.Enabled:= False;

  for i:= 0 to Pred(ComponentCount) do
  begin
    C:= Components[i];
    if C is TButton then
    begin
     if TButton(C).Tag <> 100 then
      TButton(C).Enabled:= False
    end
    else
    if  C is TCheckBox then
      TCheckBox(C).Enabled:= False
    else
    if C is TComboBox then
      TComboBox(C).Enabled:= False
    else
    if C is TDirectoryEdit then
      TDirectoryEdit(C).Enabled:= False
    else
    if (C is TLabel) and (C <> lblMainInfo) and (C <> VersionLabel) then
      TLabel(C).Enabled:= False
    else
    if C is TRadioGroup then
      TRadioGroup(C).Enabled:= False
    else
    if C is TCheckListBox then
     TCheckListBox(C).Enabled:= False;

  end;

end;

procedure TSpyForm.EnableControls;
var
  i: Integer;
  C: TComponent;
begin
//  PageControl1.Enabled:= True;

  for i:= 0 to Pred(ComponentCount) do
  begin
    C:= Components[i];
    if C is TButton then
      TButton(C).Enabled:= True
    else
    if  C is TCheckBox then
      TCheckBox(C).Enabled:= True
    else
    if C is TComboBox then
      TComboBox(C).Enabled:= True
    else
    if C is TDirectoryEdit then
      TDirectoryEdit(C).Enabled:= True
    else
    if C is TLabel then
      TLabel(C).Enabled:= True
    else
    if C is TRadioGroup then
      TRadioGroup(C).Enabled:= True
    else
    if C is TCheckListBox then
     TCheckListBox(C).Enabled:= true;
  end;

end;

procedure TSpyForm.FormCreate(Sender: TObject);
var
 aName: ShortString;
 aLoginName: ShortString;
 aActiveFlag: Byte;
 l_StandAlone: Boolean;
 l_IsAdmin, l_ShowSplash: Boolean;
 l_Ok: Boolean;
 l_HelpFile: String;
 WParam, LParam : integer;
 l_DParams: TdaDataProviderParams;
 l_SParams: TncsServiceProviderParams;
begin
 afwHackControlFont(Self);
 VersionLabel.Caption:= GetProgramVersion;
 {$IFDEF Region}
 VersionLabel.Caption:= VersionLabel.Caption + '(регион)';
 {$ENDIF}
 VersionLabel.Caption:= VersionLabel.Caption + ConfigFeature;
 l3System.Str2Log(VersionLabel.Caption);
 FillFileTypes;
 FIllImportParams;
 f_CmdLine := TSpyCommandLine.Create();
 ParseParamString;

 if f_AutoRun then
 begin
  l3System.ShowObjectsWindow:= False;
  // зачитываем значения из инишника
  MakeParams(l_SParams, l_DParams);
  InitStationAndServerConfig;
  try
   if (f_UserName = '') and (l_SParams.Login = '') then // если нет данных ни в инишнике, ни в командной строке
    f_UserName := 'guest';

   if f_UserName <> '' then
   begin
    l_SParams.Login := f_UserName;
    l_SParams.Password := f_Password;
   end;

   if f_Server <> '' then
   begin
    l_SParams.StandAlone := False;
    l_SParams.ServerHostName := f_Server;
    l_SParams.ServerPort := f_Port;
   end
   else
   if f_BaseFolder <> '' then
   begin
    l_SParams.StandAlone := True;
    l_SParams.IsDeveloper := True;
    l_DParams.ChangeBasePath(f_BaseFolder);
   end;

   l_OK := InitBaseEngine(l_SParams, l_DParams, True {QuietMode}, nil, False, False, True, True {AbsolutelyQuiet});
  finally
   FreeAndNil(l_SParams);
   FreeAndNil(l_DParams);
  end;
 end
 else
  l_OK := InitBaseEngine();

 (*
 if (f_Server <> '') and (f_Port <> 0) then
  l_Ok:= InitBaseEngine(f_Server, f_Port, f_UserName, f_Password, f_Password<>''{QuietMode})
 else
  if f_BaseFolder <> '' then
   l_Ok := InitBaseEngine(f_BaseFolder, f_UserName, f_Password, f_Password<>''{QuietMode})
  else
   l_Ok:= InitBaseEngine();
 *)
 
 if not l_Ok then
 begin
  PostMessage(Handle, wm_close, WParam, LParam);
 end;

 actUpdateBase.Enabled:= l_ok;
 actRepairBase.Enabled:= l_ok;
 if l_Ok then
 begin
   AlreadyDone:= False;
   SetDefaultValues;
   if f_AutoRun then
   begin
     SelfDestroy:= True;
     DisableControls;
     Application.ProcessMessages;
     Application.OnIdle:= MyIdle;
   end
   else
    LoadSettings(Self);
   {$IFDEF ReUseNumberOff}
   Caption:= Caption + ' (специальная версия)';
   VersionLabel.Color:= clInactiveCaption;
   VersionLabel.Font.Color:= clInactiveCaptionText;
   {$ENDIF}
   if Tm3StorageManager.UseSplitted then
   begin
    Caption:= Caption + ' (Кусочное хранилище)';
    VersionLabel.Enabled:= True;
    VersionLabel.Color:= clInactiveCaption;
    VersionLabel.Font.Color:= clInactiveCaptionText;
   end;//Tm3StorageManager.UseSplitted
   // Заполняем список пользователей и позиционируемся на Autoload
   comboUserList.Items.Assign(UserManager.Users);
   UserManager.GetUserInfo(usServerService, aName, aLoginName, aActiveFlag);
   comboUserList.ItemIndex:= comboUserList.Items.IndexOf(aName);

   f_ImportErrors:= TStringList.Create;
  l_HelpFile:= ChangeFileExt(Application.ExeName, '.chm');
  if FileExists(l_HelpFile) then
  begin
   HelpButton.Visible:= True;
   Application.HelpFile:= l_HelpFile;
   mnuHelp.Visible := True;
  end;
 end
 else
 begin
  ShowError('Не удалось подключиться к базе данных');
  DisableControls;
 end;
end;

procedure TSpyForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_CmdLine);
 CleanupAutolinkServer;
 l3Free(f_ImportErrors);
 SaveSettings(Self);
 DoneClientBaseEngine;
end;


procedure TSpyForm.MyIdle(Sender: TObject; var Done: Boolean);
begin
 { Здесь производятся нажатия на клавиши }
 Application.OnIdle:= nil;
 Done:= True;

 Application.ProcessMessages;
 btnGoClick(Self);
end;


procedure TSpyForm.CancelBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TSpyForm.btnGoClick(Sender: TObject);
var
  S: String;
begin
 f_Progressor:= TddProgressObject.Create;
 try
  try
   f_Progressor.SetVisualParams(ServerProgressBar, lblMainInfo);
   CancelButton.Caption:= 'Прервать';
   if AlreadyDone then
    if MessageDlg('Импорт один раз закончен. Начать еще раз?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo then
     exit;
   //f_Progressor.OnUpdate:= ProgressUpdate;
    CloseMessagePanels;
    ExitCode := 0;
    PageControl1.ActivePage:= Additional;
    ServerProgressBar.Visible:= True;
    lblMainInfo.Visible:= True;
    DisableControls;
    try
     GlobalDataProvider.SubscribeLongProcess(Self);
     try
       (*
       if cbxExclusiveMode.Checked then
        UpdateTables;
       *)
       { Запуск процесса импортирования }
      if not DoImport then
       Exit;

      if chbDictionCollect.Checked then
       DoLoadKWFile;

      if chkImportParams.Checked[cUpdateText] then
       DoIndex;

      if (f_ImportErrors.Count > 0) then
      begin
       if not SelfDestroy then
       begin
        if MessageDlg(SHaveSomeErrors, mtWarning, [mbYes, mbNo], 0) = mrYes then
        begin { Показать окошко с ошибками }
         with TPipeErrorForm.Create(Application) do
          try
           ListBox1.Items:= f_ImportErrors;
           ShowModal;
          finally
           Free;
          end; // try..finally
        end;
       end
       else // SelfDestroy
        try
         { Самостоятельно сохраняем файл ошибок }
         f_ImportErrors.SaveToFile('Import Errors.log');
        except
         l3System.Msg2Log('Ошибка записи лога ошибок импорта');
        end;
      end; // (f_ImportErrors.Count > 0)
      if chkImportParams.Checked[cUpdateBase] then
       UpdateTables;
      AlreadyDone := True;
     finally
      GlobalDataProvider.UnSubscribeLongProcess(Self);
     end;
    finally
     EnableControls;
     //ReadCFG;
     //SetParams;
    end;
    if not SelfDestroy then
     ShowMessage('Импорт завершен');
  except
   on E: Exception do
   begin
    l3System.Stack2Log('Ошибка: ' + E.Message);
    ShowError('Во время импорта произошла ошибка! Подробности - в логе.');
    ExitCode := 1; // это нужно, если импорт запущен из cmd-файла
   end;
  end;
 finally
   ServerProgressBar.Visible:= False;
   lblMainInfo.Visible:= False;
   CancelButton.Caption:= 'Выход';
   l3Free(f_Progressor);
 end;
 if SelfDestroy then
  Close;
end;

procedure TSpyForm.chbDictionCollectClick(Sender: TObject);
begin
 kwFileEdit.Enabled:= chbDictionCollect.Checked;
 chkKWParams.Enabled:= chbDictionCollect.Checked;
 GroupBox2.Enabled:= chbDictionCollect.Checked;
 //btnGo.Enabled:= chbDictionCollect.Checked;
end;

procedure TSpyForm.FillAbout;
begin
end;

procedure TSpyForm.StopAutoImport;
begin
 CancelAutoImport:= True;
end;

procedure TSpyForm.btnUpdateTablesClick(Sender: TObject);
begin
  CloseMessagePanels;
  lblMainInfo.Visible:= True;
  ServerProgressBar.Visible:= True;
  try
   DisableControls;
   UpdateTables(True);
  finally
    EnableControls;
    lblMainInfo.Visible:= False;
    ServerProgressBar.Visible:= False;
    ShowMessage('Обновление завершено');
  end;
end;

procedure TSpyForm.TotalProgress(aState: Byte; aValue: Longint; const aMsg: string);
begin
  case aState of
    0:
     begin
      lblMainInfo.Caption:= SysUtils.Format('Подготовка к заливке %d байт', [aValue]);
      if aValue <= High(ServerProgressBar.Max) then
      begin
       ServerProgressBar.Max:= aValue;
       ServerProgressBar.Position:= 0;
      end
      else
       ServerProgressBar.Max:= 0;
     end;
    1:
     begin
      lblMainInfo.Caption:= SysUtils.Format('Обработано %d байт со скоростью %s',[aValue, aMsg]);
      if ServerProgressBar.Max > 0 then
       ServerProgressBar.Position:= aValue;
     end;
    2:
     begin
      lblMainInfo.Caption:= '';
      ServerProgressBar.Position:= 0;
     end;
  end;
end;

procedure TSpyForm.deWorkDirChange(Sender: TObject);
begin
  AlreadyDone:= False;
end;


procedure TSpyForm.Button2Click(Sender: TObject);
var
 l_ErrorFoundMain: Boolean;
 l_MsgMain: String;
 l_ErrorFoundGarant: Boolean;
 l_MsgGarant: String;
begin
  lblMainInfo.Visible:= True;
  CloseMessagePanels;
  ServerProgressBar.Visible:= True;
  try
    DisableControls;
    GlobalDataProvider.SubscribeProgress(Self);
    GLobalHtServer.PhisicalVerifyAllTbl(0, l_ErrorFoundMain, l_MsgMain);
    GLobalHtServer.PhisicalVerifyAllTbl(1, l_ErrorFoundGarant, l_MsgGarant);
  finally
    GlobalHTServer.OpenClosedTbls;
    EnableControls;
    GlobalDataProvider.UnSubscribeProgress(Self);
    lblMainInfo.Visible:= False;
    ServerProgressBar.Visible:= False;
    if not l_ErrorFoundMain and not l_ErrorFoundGarant then
     ShowMessage('Проверка завершена успешно')
    else
     MessageDlg(l_MsgMain + ' ' + l_MsgGarant, mtError, [mbOk], 0);
  end;
end;


procedure TSpyForm.btnEQClassClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    LoadEqualClasses(1, OpenDialog1.FileName, '\');
    ShowMessage('Эквивалентные классы импортированы');
  end;
end;



procedure TSpyForm.btnTablePriorityClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    with TPriorTbl.Create(1) do
    try
      ImportPriorityFromFile(OpenDialog1.FileName, True, False);
      ShowMessage('Таблица приоритетов заполнена');
    finally
      Free;
    end;
  end;
end;

procedure TSpyForm.CancelButtonClick(Sender: TObject);
begin
 if f_Progressor <> nil then
 begin
  CancelAutoImport:= True;
  if f_Pipe <> nil then
   f_Pipe.AbortProcess;
 end
 else
  Close;
end;

procedure TSpyForm.comboInputTypeChange(Sender: TObject);
begin
 chkImportParams.Checked[cAddNewItems]:= comboInputType.ItemIndex <> 0;
 deWorkDir.DialogText := 'Выберите папку с исходными файлами';
 comboSameDocs.Enabled:= comboInputType.ItemIndex <> 4;
 if comboInputType.ItemIndex = 4 then
  comboSameDocs.ItemIndex:= 0;
 case comboInputType.ItemIndex of
  0: //Add('Гарант');
    with chkImportParams do
    begin
     Checked[cAddNewItems]:= False;
     //Checked[c]
    end;
  1: ; //Add('Эверест');
 end;
end;

procedure TSpyForm.YieldProc(Sender: TObject);
begin
 Application.ProcessMessages;
end;

procedure TSpyForm.btnPriorityClick(Sender: TObject);
var
 l_TableFileName: String;
begin
 if PromptForFileName(l_TableFileName, 'Текстовые файлы (*.txt)|*.txt') then
 begin
  with TPriorTbl.Create(CurrentFamily) do
  try
   ImportPriorityFromFile(l_TableFileName, True, True);
  finally
   Free
  end;
 end;
end;

procedure TSpyForm.cbIsDeltaKWClick(Sender: TObject);
begin
 (* Либо дельта, либо очистка *)

 if chkKWParams.Selected[cIsDeltaKW] and chkKWParams.Checked[cIsDeltaKW] then
  chkKWParams.Checked[cClearOldKW]:= False;
 if chkKWParams.Selected[cClearOldKW] and chkKWParams.Checked[cClearOldKW] then
 begin
  chkKWParams.Checked[cIsDeltaKW] := False;
  chkKWParams.Checked[cUpdateKW]:= True;
 end;
 chkKWParams.ItemEnabled[cUpdateKW]:= not chkKWParams.Checked[cClearOldKW];
end;

procedure TSpyForm.CloseMessagePanels;
begin
 pnlError.Visible := False;
 pnlMessage.Visible := False;
end;

procedure TSpyForm.DoCheckPriority;
begin
  l3System.Msg2Log('Расчет важности документов.');
  DocumentServer.Family:= 1;
  DocumentServer.CheckDocPriority(True, f_Progressor.ProcessUpdate);
  l3System.Msg2Log('Расчет важности документов закончен.');
end;

function TSpyForm.DoImport: Boolean;
var
 Dc: TDeleteConditionSet;
 l_Node: TddAppConfigNode;
 l_TmpFileName: string;
 l_Ok: Boolean;
begin
 f_KTFileName:= '';
 Result := False;
 if not DirectoryExists(deWorkDir.Text) then
 begin
  ShowError('Указанная папка с исходными данными не существует');
  PageControl1.ActivePage:= NSRCTab;
  Exit;
 end;
 f_Pipe:= TddImportPipe.Create(CurrentFamily);
 try
  f_Pipe.Progressor:= f_Progressor;
  l_Ok:= True;
  case comboInputType.ItemIndex of
   0: f_Pipe.InputFileType := dd_itGarant;          // ddNSRC_r;
   1: f_Pipe.InputFileType := dd_itEverest;         // evEvdRd
   2: f_Pipe.InputFileType := dd_itRTFAnnotation;
   3: f_Pipe.InputFileType := dd_itTXTAnnotation;
   4: f_Pipe.InputFileType:= dd_itFASCaseCode;
   5: f_Pipe.InputFileType := dd_itKT;
  else
   f_Pipe.InputFileType:= dd_itUnknown;
  end;

  case comboSameDocs.ItemIndex of
   0: // Не проверять
     ;
   1: // Пропускать
     f_Pipe.SameDocuments:= sdrIgnore;
   2: // Перезаписывать
     f_Pipe.SameDocuments:= sdrDelete;
  end; // case rgSameDocuments.ItemIndex
  f_Pipe.CheckDocuments:= comboSameDocs.ItemIndex > 0;
  f_Pipe.NeedLockBase := chkImportParams.Checked[cExclusiveMode];
  f_Pipe.WorkDir:= deWorkDir.Text;
  f_Pipe.MoveFiles:= False;
  f_Pipe.DoneDir:= '';
  //f_Pipe.TwoPassImport:= cbUpdateDoc.Checked;
  if chkImportParams.Checked[cAddNewItems] then
   f_Pipe.NotUpdatableDicts:= []
  else
   f_Pipe.NotUpdatableDicts:= ddAllDicts;
  f_Pipe.FinalUpdate:= chkImportParams.Checked[cUpdateBase];
  f_Pipe.PictureDir:= dirPicture.Text;
  // Выяснение номера пользователя, от имени которого будем заливать
  if comboUserList.ItemIndex > -1 then
    f_Pipe.UserID:= UserManager.Users.DataInt[comboUserList.ItemIndex];
  {$IFDEF Bilingual}
  f_Pipe.IsEnglish:= chkImportParams.Checked[cEnglishBase];
  {$ELSE}
  f_Pipe.IsEnglish:= False;
  {$ENDIF}
  EnglishIncrement:= 0; //  Потом можно будет убрать
  f_Pipe.AddNewToLog := chkImportParams.Checked[cAddImport2Log];
  PromptAddParams;
  f_Pipe.OpenClassStage := chkImportParams.Checked[cOpenAKStage];
  // В автоматическом режиме нельзя запрашивать имена файлов
  (*
  if chkImportParams.Checked[cAutoLink] then
  begin
   l_TmpFileName:= 'autolink.dat';
   if PromptForFileName(l_TmpFileName, 'Файл автоссылок (AutoLink.dat)|*.dat',
                        '.dat', 'Укажите файл автоссылок', GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily)) then
   begin
    f_Pipe.AutoLink := chkImportParams.Checked[cAutoLink];
    f_Pipe.AutoLinkFileName:= l_TmpFileName;
   end
   else
    f_Pipe.AutoLink := False;
  end;
  f_Pipe.OpenClassStage := chkImportParams.Checked[cOpenAKStage];
  if chkImportParams.Checked[cAddKT] then
  begin
   // Запросить имя файла KT
   l_TmpFileName:= 'kthemes.zip';
   if PromptForFileName(l_TmpFileName, 'Файл с ключевыми темами (kthemes.zip)|*.zip', '.zip',
                        'Укажите файл описания ключевых тем', GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily)) then
   begin
    f_Pipe.AddKT:= True;
    f_Pipe.kTFileName:= l_TmpFileName;
   end
   else
    f_Pipe.AddKT:= False;
  end;
  if chkImportParams.Checked[cSpellCheck] then
  begin
   l_TmpFileName:= '';
   if PromptForFileName(l_TmpFileName, 'Файл с типовыми опечатками |*.*', '.*',
                        'Укажите файл с типовыми опечатками', GetAppFolderFileName('')) then
   begin
    f_Pipe.SpellCheck:= True;
    f_Pipe.MisspellFileName:= l_TmpFileName;
    f_Pipe.OnWrongWordFound:= WrongWordFound;
    f_WrongWords:= Tl3DOSFiler.Make(GetAppFolderFileName('SpellCheck.txt', True), l3_fmWrite);
   end
   else
    f_Pipe.AddKT:= False;
  end;
  *)
  //raise Exception.Create('Shit happens...');
  if l_Ok then
   f_Pipe.Execute;
  if f_Pipe.Aborted then
   AlreadyDone:= False;
  Result := True;
 finally
  if (f_Pipe.ErrorLog.Count > 0) then
   f_ImportErrors.Assign(f_Pipe.ErrorLog);
  FreeAndNil(f_Pipe);
  FreeAndNil(f_wrongwords);
 end; // try..finally
end;

procedure TSpyForm.DoIndex;
var
 l_UpdateBase: Boolean;
 f_DB: Im4DB;
 l_EraseSAV: Boolean;
 l_S       : PString;
 l_CurPath: String;
 CurAttrib : LongInt;
begin
 l3System.Msg2Log('Начало обновления переменной части и индексация');
 Caption:= ProgramCaption + ' - Обновление текстового индекса';
 lblMainInfo.Visible:= True;
 ServerProgressBar.Visible:= True;
 try
  GlobalHtServer.FamilyTbl.GetPathAndAttrib(1, l_S, CurAttrib);
  l_CurPath:= l_S^; System.Delete(l_CurPath, Length(l_CurPath), 1);
  f_DB:= Tm4DB.Make(ConcatDirName(l_CurPath, 'bserv001'), YieldProc, nil, DoProgressNotify);
  try
   f_DB.Start(m3_saReadWrite);
   try
     l3System.Msg2Log('Начало обновления текстового индекса');
     f_DB.UpdateIndex;
     l3System.Msg2Log('Обновление текстового индекса завершено');
     l3System.Msg2Log('Начало обновления текстовой части');
     l_EraseSAV:= f_DB.Update;
     if l_EraseSAV then
      l3System.Msg2Log(SysUtils.Format('Уничтожено %d удаленных документов', [f_DB.Purge]));
     l3System.Msg2Log('Обновление текстовой части завершено');
   finally
    f_DB.Finish;
   end;
  finally
   f_DB:= nil;
  end;
  l3System.Msg2Log('Обновление переменной части завершено');
 except
  ShowError('Ошибка обновления переменной части');
  l3System.Str2Log('Ошибка обновления переменной части');
  exit;
 end;
 Caption:= ProgramCaption;
 lblMainInfo.Visible:= False;
 ServerProgressBar.Visible:= False;
end;

procedure TSpyForm.DoLoadKWFile;
var
 l_KWPipe : TddDictLinkPipe;
begin
 l_KWPipe := TddDictLinkPipe.Create;
 try
  l_KWPipe.Progressor := f_Progressor;
  l_KWPipe.Aborted := @CancelAutoImport;
  l_KWPipe.IsDelta := chkKWParams.Checked[2];
  l_KWPipe.Execute(kwFileEdit.Text, CurrentFamily, da_dlKeywords, True, chkKWParams.Checked[0], chkKWParams.Checked[1]);
 finally
  l3Free(l_KWPipe);
 end;
end;

procedure TSpyForm.FillFileTypes;
begin
 with comboInputType.Items do
 begin
  Clear;
  Add('Гарант');
  Add('Эверест');
 end;
end;

procedure TSpyForm.FIllImportParams;
begin
 with chkImportParams.Items do
 begin
  Clear;
  Add('Монопольный доступ к базе');
  Add('Пополнять словари');
  //Add('Рассчитывать юрсилу');
  Add('Отмечать импорт в Журнале');
  Add('Обновлять базу');
  Add('Обновлять текстовую часть');
  {.$IFNDEF Region}
  Add('Расставить ссылки');
  Add('Открыть этап Классификация');
  Add('Расставить Ключевые темы');
  Add('Подключить документы');
  Add('Проверить орфографию');
  Add('Добавить Группу доступа');
  {.$ENDIF}
  {$IFDEF Bilingual}
  Add('Английская база');
  cEnglishBase:= Pred(chkImportParams.Items.Count);
  {$ENDIF}
 end;
end;

procedure TSpyForm.FormShow(Sender: TObject);
begin
 CloseMessagePanels;
end;

procedure TSpyForm.UpdateTables(makeProgressor: Boolean = False);
var
 l_Progress: IdaProgressSubscriber;
begin
 l3System.Msg2Log('Обновление базы');
 if makeProgressor then
 begin
  f_Progressor:= TddProgressObject.Create(nil);
  f_Progressor.SetVisualParams(ServerProgressBar, lblMainInfo);
 end;
 l_Progress := TdaProgressProcHolder.Make(f_Progressor.ProcessUpdate);
 try
  try
    GlobalDataProvider.SubscribeProgress(l_Progress);
    GlobalHTServer.CloseAllTbls(0);
    GlobalHTServer.CloseAllTbls(1);
    GlobalHTServer.UpdateAllTbl(0);
    GlobalHTServer.UpdateAllTbl(1);
  finally
    GlobalHTServer.OpenClosedTbls;
    GlobalDataProvider.UnSubscribeProgress(l_Progress);
    if makeProgressor then
     FreeAndNil(f_Progressor);
    l3System.Msg2Log('Обновление базы завершено');
  end;
 finally
  l_Progress := nil;
 end;
end;

procedure TSpyForm.HelpButtonClick(Sender: TObject);
begin
 Application.HelpContext(PageControl1.HelpContext);
end;

procedure TSpyForm.PageControl1Change(Sender: TObject);
begin
 PageControl1.HelpContext := PageControl1.ActivePage.HelpContext;
end;

procedure TSpyForm.ParseParamString;

var
 l_Param: string;
begin
 f_AutoRun:= (ParamCount > 0) and not f_CmdLine.NeedHelp;
 if f_AutoRun or f_CmdLine.NeedHelp then
 begin
  if f_CmdLine.NeedHelp then
   ShowHelp
  else
  begin
   ParseServerPart;
   ParseUserPart;
   ParseWhatPart;
  end;
 end;
end;

procedure TSpyForm.ParseServerPart;
begin
 f_Server := f_CmdLine.ServerHostName;
 f_Port := f_CmdLine.ServerPort;
 f_BaseFolder := f_CmdLine.BaseRoot;
end;

procedure TSpyForm.ParseUserPart;
begin
 f_UserName:= f_CmdLine.User;
 f_Password:= f_CmdLine.Password;
end;

procedure TSpyForm.ParseWhatPart;
var
 l_Param: string;
 l_Pos: Integer;
begin
 SetDefaultWhatPart;
 if f_CmdLine.SrcFolder <> '' then // Папка
  deWorkDir.Text:= f_CmdLine.SrcFolder;
 if f_CmdLine.Format <> '' then
 begin
  case Upcase(f_CmdLine.Format[1]) of
   'N': comboInputType.ItemIndex:= 0;
   'E': comboInputType.ItemIndex:= 1;
  end;
 end
 else
  comboInputType.ItemIndex:= 0;
 if f_CmdLine.SrcObjFolder <> '' then // Папка
  dirPicture.Text:= f_CmdLine.SrcObjFolder;
 if f_CmdLine.CheckDuplicate <> '' then
 begin
  case Upcase(f_CmdLine.CheckDuplicate[1]) of
   'S': comboSameDocs.ItemIndex:= 1;
   'R': comboSameDocs.ItemIndex:= 2;
  end;
 end; // f_CmdLine.CheckDuplicate <> ''
 if f_CmdLine.ImportParams <> '' then // Папка
 begin
  chkImportParams.Checked[cExclusiveMode]:= AnsiContainsText(f_CmdLine.ImportParams, 'E');
  chkImportParams.Checked[cAddNewItems]:= AnsiContainsText(f_CmdLine.ImportParams, 'D');
  //chkImportParams.Checked[cCalcPriority]:= AnsiContainsText(f_CmdLine.ImportParams, 'P');
  chkImportParams.Checked[cAddImport2Log]:= AnsiContainsText(f_CmdLine.ImportParams, 'M');
  chkImportParams.Checked[cUpdateBase]:= AnsiContainsText(f_CmdLine.ImportParams, 'B');
  chkImportParams.Checked[cUpdateText]:= AnsiContainsText(f_CmdLine.ImportParams, 'T');
  chkImportParams.Checked[cAutoLink]:= AnsiContainsText(f_CmdLine.ImportParams, 'L');
  chkImportParams.Checked[cOpenAKStage]:= AnsiContainsText(f_CmdLine.ImportParams, 'C');
  chkImportParams.Checked[cAddKT]:= AnsiContainsText(f_CmdLine.ImportParams, 'K');
  chkImportParams.Checked[cInclude]:= AnsiContainsText(f_CmdLine.ImportParams, 'I');
  chkImportParams.Checked[cSpellCheck]:= AnsiContainsText(f_CmdLine.ImportParams, 'S');
 end;
end;

procedure TSpyForm.PromptAddParams;
var
 l_Node: TddAppConfigNode;
begin
 f_Pipe.AutoLink:= False;
 f_Pipe.AddKT := False;
 f_Pipe.SpellCheck := False;
 if chkImportParams.Checked[cAutoLink] or chkImportParams.Checked[cAddKT] or
    chkImportParams.Checked[cSpellCheck] or chkImportParams.Checked[cAddAccGroup] then
 begin // Запросить доппараметры
  if f_AutoRun then
  begin
   if chkImportParams.Checked[cAutoLink] then
   begin
    f_Pipe.AutoLink := True;
    f_Pipe.AutoLinkFileName:= f_CmdLine.AutolinkFile;
   end;
   if chkImportParams.Checked[cAddKT] then
   begin
    f_Pipe.AddKT := True;
    f_Pipe.kTFileName:= f_CmdLine.KTFile;
   end;
   if chkImportParams.Checked[cSpellCheck] then
   begin
    f_Pipe.SpellCheck := True;
    f_Pipe.MisspellFileName:= f_CmdLine.f_MisspellFile;
   end;
  end
  else
  begin
   l_Node:= MakeNode('Params', 'Дополнительные параметры', True, nil);
   try
    if chkImportParams.Checked[cAutoLink] then
     AppendNode(l_Node, MakeFileName('AutoLink', 'Файл автоссылок',
                                     'Файл автоссылок (AutoLink.dat)|*.dat',
                                     ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily), 'autolink.dat'),
                                     nil));
    if chkImportParams.Checked[cAddKT] then
     AppendNode(l_Node, MakeFileName('KTFile', 'Файл ключевых тем',
                                     'Файл с ключевыми темами (kthemes.zip)|*.zip',
                                     ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily), 'kthemes.zip'),
                                     nil));
    if chkImportParams.Checked[cSpellCheck] then
     AppendNode(l_Node, MakeFileName('SpellFile', 'Файл типовых опечаток',
                                     'Файл с типовыми опечатками *.*',
                                     '',
                                     nil));
    if chkImportParams.Checked[cAddAccGroup] then
     AppendNode(l_Node, MakeString('AccGroup', 'Группа доступа', '',
                                     nil));
    if ExecuteNodeDialog(l_Node) then
    begin
     if chkImportParams.Checked[cAutoLink] then
     begin
      f_Pipe.AutoLink := True;
      f_Pipe.AutoLinkFileName:= l_Node.ItemByAlias['autolink'].StringValue;
     end;
     if chkImportParams.Checked[cAddKT] then
     begin
      f_Pipe.AddKT := True;
      f_Pipe.kTFileName:= l_Node.ItemByAlias['KTFile'].StringValue;
     end;
     if chkImportParams.Checked[cSpellCheck] then
     begin
      f_Pipe.SpellCheck := True;
      f_Pipe.MisspellFileName:= l_Node.ItemByAlias['SpellFile'].StringValue;
     end;
     if chkImportParams.Checked[cAddAccGroup] then
      f_Pipe.AccGroup:= l_Node.ItemByAlias['AccGroup'].StringValue;
    end;
   finally
    FreeAndNil(l_Node);
   end;
  end;
  if f_Pipe.SpellCheck then
  begin
   f_Pipe.OnWrongWordFound:= WrongWordFound;
   f_WrongWords:= Tl3DOSFiler.Make(GetAppFolderFileName('SpellCheck.txt', True), l3_fmWrite);
  end;
 end; // chkImportParams.Checked[cAutoLink] or chkImportParams.Checked[cAddKT] or chkImportParams.Checked[cSpellCheck];
end;

procedure TSpyForm.SetDefaultValues;
begin
 PageControl1.ActivePage:= NSRCTab;
 Caption:= 'Импорт в базу ' + g_BaseEngine.DataParams.DocStoragePath;
 FillAbout;
 BaseIndex:= 0;
 FamilyIndex:= 0;
 BasePath:= '';
 PictureDir:= '';
 LoadDict:= False;
 ClearOldKW:= True;
 CloseWhenDone:= False;
 MoveDoneFiles:= False;
 MoveDir:= 'Done';
 UpdateDicts:= True;
 FinalUpdate:= True;
 UpdateDocs:= False;
 ImportType:= 0;
 SameDocuments:= 0;
 InputFileType:= 0;
// comboInputType.ItemIndex:= 0;
 ReIndex:= False;
end;

procedure TSpyForm.SetDefaultWhatPart;
var
 i: Integer;
begin
 comboInputType.ItemIndex:= 0; // nsrc
 deWorkDir.Text:= '';
 dirPicture.Text:= '';
 with chkImportParams do
 begin
  for i:= 0 to Pred(Items.Count) do
   Checked[i]:= False;
  Checked[cAddImport2Log]:= True;
 end; // chkImportParams
 comboSameDocs.ItemIndex:= 2;
end;

procedure TSpyForm.ShowError(const aMessage: AnsiString);
begin
 pnlError.Visible := True;
 pnlError.Caption := ' ' + aMessage;
 l3System.Msg2Log(aMessage);
 ExitCode := 1;
end;

procedure TSpyForm.ShowHelp;
begin
 ShowCmdHelpMessage('Использование NSRCSpy', f_CmdLine.HelpText);
end;

procedure TSpyForm.ShowMessage(const aMessage: AnsiString);
begin
 pnlMessage.Visible := True;
 pnlMessage.Caption := ' ' + aMessage;
end;

procedure TSpyForm.WrongWordFound(aTopicID: Integer; aWrongWord: Il3CString);
begin
 // Скинуть строку в файл
 f_WrongWords.Writeln(SysUtils.Format('%d'#9'%s', [aTopicID, aWrongWord.AsWStr.S]));
end;

procedure TSpyCommandLine.Init;
begin
 inherited Init;
 AddString('format', 'Формат исходных данных: N - NSRC (по умолчанию), E - Everest', '[N|E]', f_Format);
 AddFolder('src', 'Папка с данными', '', f_SrcFolder);
 AddFolder('srcobj', 'Папка с objtopic', '', f_SrcObjFolder);
 AddString('check', 'Обработка повторов: S - пропустить, R - заменить, по умолчанию не проверять', '[S|R]', f_CheckDuplicate);
 AddString('params', {'Параметры импорта: E - монопольный доступ; D - пополнять словари; P - расчет юрсилы; M - отмечать импорт; B - обновлять базу; T - обновлять; L - расставить ссылки; C - открыть этап Классификации; K - добавить Ключевые темы; I - подключить документы; S - проверить орфографию'}'', '[EDPMBTLCKIS]', f_ImportParams);
 AddString('link', 'Файл с данными для простановки ссылок', '<filename>', f_AutolinkFile);
 AddString('ktdata', 'Файл для простановки Ключевых тем', '<filename>', f_KTFile);
 AddString('spell', 'Файл с типичными опкечатками', '<filename>', f_MisspellFile);
end;

procedure TSpyCommandLine.SetDefault;
begin
 // Установить значения по умолчанию
end;

function TSpyForm.DoLongProcessNotify(aState: TdaProcessState): Boolean;
begin
  Result:= False;
end;

procedure TSpyForm.DoProgressNotify(aState: Byte; aValue: Integer;
  const aMsg: AnsiString);
begin
 case aState of
  0: begin
      lblMainInfo.Caption:= aMsg;
      if aValue > 0 then
       ServerProgressBar.Max:= aValue
      else
       ServerProgressBar.Max:= 0;
     end;
  1: begin
      ServerProgressBar.Position:= aValue;
      if aMSg <> '' then
       lblMainInfo.Caption:= aMsg;
     end;
  2: begin
      if aMSg <> '' then
       lblMainInfo.Caption:= aMsg;
      ServerProgressBar.Position:= ServerProgressBar.Max;
     end;
 end;
  Application.ProcessMessages;
end;

end.

