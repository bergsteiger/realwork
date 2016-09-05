unit MainForm;

{$I nsrcspy.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ToolEdit, Mask,
  l3IniFile, Buttons, RXCtrls,
  l3Base, l3StringList, dt_Types,  vtDialogs, TestImportPipe,
  daTypes, daInterfaces,
  ddProgressObj, XPMan;

type
  TSpyForm = class(TForm, IdaLongProcessSubscriber, IdaProgressSubscriber)
    VersionLabel: TLabel;
    PageControl1: TPageControl;
    Additional: TTabSheet;
    NSRCTab: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    deWorkDir: TDirectoryEdit;
    kwFileEdit: TFilenameEdit;
    TabSheet2: TTabSheet;
    chbClearOldKW: TCheckBox;
    dirPicture: TDirectoryEdit;
    Label8: TLabel;
    Label9: TLabel;
    cbUpdateDicts: TCheckBox;
    cbFinalUpdateTable: TCheckBox;
    cbCheckPriority: TCheckBox;
    rgSameDocuments: TRadioGroup;
    cbCheckDocuments: TCheckBox;
    comboInputType: TComboBox;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    cbIndex: TCheckBox;
    btnGo: TButton;
    CancelButton: TButton;
    cbUseIndicators: TCheckBox;
    lblMainInfo: TLabel;
    ServerProgressBar: TProgressBar;
    Label15: TLabel;
    comboUserList: TComboBox;
    cbIfNotModify: TCheckBox;
    cbIfNotVIncluded: TCheckBox;
    chbDictionCollect: TCheckBox;
    CheckBox1: TCheckBox;
    rgBaseTools: TGroupBox;
    Button2: TButton;
    btnUpdateTables: TButton;
    cbEnglish: TCheckBox;
    lblAdditionalInfo: TLabel;
    btnPriority: TButton;
    cbIfNotHasAnno: TCheckBox;
    cbIsDeltaKW: TCheckBox;
    cbxExclusiveMode: TCheckBox;
    cbxAddToDictionary: TCheckBox;
    cbAddNewToLog: TCheckBox;
    HelpButton: TButton;
    XPManifest1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure chbDictionCollectClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure cbUpdateDocClick(Sender: TObject);
    procedure cbCheckDocumentsClick(Sender: TObject);
    procedure btnUpdateTablesClick(Sender: TObject);
    procedure cbUseIndicatorsClick(Sender: TObject);
    procedure deWorkDirChange(Sender: TObject);
    procedure rgSameDocumentsClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbIndexClick(Sender: TObject);
    procedure btnEQClassClick(Sender: TObject);
    procedure btnTablePriorityClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure comboInputTypeChange(Sender: TObject);
    procedure btnPriorityClick(Sender: TObject);
    procedure cbIsDeltaKWClick(Sender: TObject);
    procedure chbClearOldKWClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    { Private declarations }
    AlreadyDone: Boolean;
    SelfDestroy: Boolean;
    f_ImportErrors: TStrings;
    f_Progressor : TddProgressObject;
   f_Pipe: TPipeDream;
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
    f_PackList: Tl3StringList;
    CancelAutoImport: Boolean;
    UseIndicators: Boolean;
    {---------------------------------------}
    procedure MyIdle(Sender: TObject; var Done: Boolean);
    procedure ReadCFG;
    procedure WriteCFG;
    procedure DisableControls;
    procedure EnableControls;
    procedure SetParams;
    procedure SetDefaultPacked;
    procedure ProgressUpdate(Sender: TObject; aState: Byte);
    procedure TotalProgress(aState: Byte; aValue: Longint; const aMsg: string);
    procedure FillAbout;
    procedure CheckAutoImport(UserID : TdaUserID; Const Catalog : String);
    procedure UpdateTables(makeProgressor: Boolean = False);
  protected
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
  daInterfaces,
  daProgressProcHolder,
  daDataProvider,
  DT_Serv, dt_Const, dt_IFltr, dt_Prior, dt_Doc,
  mgJouSrv, l3FileUtils, m4DB, m4DBInterfaces, m3StorageInterfaces,
  D_Pass, D_ImpPrg, ddHTInit, ht_Const, l3Types,
  l3Filer,  k2TagGen, ddDocReader, ddExtAnnoPipe, l3Stream,
  stDate, l3ExceptionsLog, ddClosingWin, ErrorForm, ddImportPipeKernel;

resourcestring
  SHaveSomeErrors = 'Некоторые документы содержали ошибки. Вы хотите посмотреть список ошибок?';
  SErrorSetParams = 'Ошибка установки параметров';
  SUserPassword = 'UserPassword';
  SUserName = 'UserName';
  SUser = 'User';
  SFamilyPath = 'FamilyPath';

const
  ProgramCaption = '"Архивариус". Импорт документов';


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
    if (C is TLabel) and (C <> lblMainInfo) and (C <> lblAdditionalInfo) then
      TLabel(C).Enabled:= False
    else
    if C is TRadioGroup then
      TRadioGroup(C).Enabled:= False
    else  
    if C is TComboBox then
     TComboBox(C).Enabled:= False;

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
      TRadioGroup(C).Enabled:= True;
  end;

end;

procedure TSpyForm.SetParams;
begin
 try
  deWorkDir.Text:= BasePath;
  dirPicture.Text:= PictureDir;
  SelfDestroy:= CloseWhenDone;
  cbCheckPriority.Checked:= CheckPriority;
  chbDictionCollect.Checked:= LoadDict;
  kwFileEdit.Text:= KWFile;
  chbClearOldKW.Checked:= ClearOldKW;
  cbxExclusiveMode.Checked := ExclusiveMode;

  CheckBox1.Checked:= LoadNSRC;
  cbFinalUpdateTable.Checked:= FinalUpdate;
  cbUpdateDicts.Checked:= UpdateDicts;
//  cbUpdateDoc.Checked:= UpdateDocs;
  rgSameDocuments.ItemIndex:= SameDocuments;
  cbCheckDocuments.Checked:= CheckDocuments;
  comboInputType.ItemIndex:= InputFileType;
  cbIfNotModify.Checked:= IfNotModify;
  cbIfNotVINcluded.Checked:= IfNotVIncluded;

  cbIndex.Checked:= ReIndex;
  cbUseIndicators.Checked := UseIndicators;
 except
  l3System.Msg2Log(SErrorSetParams);
 end;
end;

procedure TSpyForm.FormCreate(Sender: TObject);
var
  aName : ShortString;
  aActiveFlag : Byte;
  aLoginName : ShortString;
begin
 {$IFNDEF OneInit}
 if InitBaseEngine then
 begin
  {$ENDIF}
   AlreadyDone:= False;
   PageControl1.ActivePage:= NSRCTab;
   VersionLabel.Caption:= GetProgramVersion;

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

   comboInputType.ItemIndex:= 0;
   ReIndex:= False;
   f_PackList:= Tl3StringList.Make;
   {$IFDEF OneInit}
   SendServer := TdtSendServer.Create(Self);
   GlobalHtServer.SendServ := SendServer;
   {$ELSE}
   StationConfig:= TCfgList.Create('');
   {$ENDIF}
   ReadCFG;

   SetParams;

 //SelfDestroy:= False;
   l3System.Str2Log(GetProgramVersion);

   if UpperCase(ParamStr(1)) = '/AUTO' then
   begin
     SelfDestroy:= True;
     DisableControls;
     Application.ProcessMessages;
     Application.OnIdle:= MyIdle;
     SetParams;
   end;
   {$IFDEF ReUseNumberOff}
   Caption:= Caption + ' (специальная версия)';
   VersionLabel.Color:= clInactiveCaption;
   VersionLabel.Font.Color:= clInactiveCaptionText;
   {$ENDIF}
   // Заполняем список пользователей и позиционируемся на Autoload
   comboUserList.Items.Assign(UserManager.Users);
   GlobalDataProvider.UserManager.GetUserInfo(usServerService, aName, aLoginName, aActiveFlag);
   comboUserList.ItemIndex:= comboUserList.Items.IndexOf(aName);

   f_ImportErrors:= TStringList.Create;
  {$IFDEF Bilingual}
  cbEnglish.Visible:= True;
  {$ELSE}
  cbEnglish.Visible:= False;
  {$ENDIF}
 end
 else
  Application.Terminate;
end;

procedure TSpyForm.FormDestroy(Sender: TObject);
begin
  l3Free(f_ImportErrors);
  //l3Free(ReceiveServer);
  WriteCFG;
  L3Free(f_PackList);
 {$IFDEF OneInit}
 l3Free(SendServer);
 {$ELSE}
 DoneClientBaseEngine;
 {$ENDIF}
end;


procedure TSpyForm.MyIdle(Sender: TObject; var Done: Boolean);
begin
 { Здесь производятся нажатия на клавиши }
 Application.OnIdle:= nil;
 Done:= True;

 Application.ProcessMessages;
 btnGoClick(Self);
end;

procedure TSpyForm.ReadCFG;
var
  S: String;
begin
(*
 LoadSettings(Self);
 with StationConfig do
 begin
   Section:= 'FamilyConst';
   ReadParamString(SFamilyPath, S);
   Caption:= 'Импорт в базу ' + S;
 end;
 *)
  try
    with StationConfig do
    begin
      { BaseDocPath }
      Section:= 'BaseDocPath';
      Section:= 'FamilyConst';
      ReadParamString(SFamilyPath, S);
      Caption:= 'Импорт в базу ' + S;

      Section := 'EXE';
      Gm0EXCLibDefSrv.LogFileName := ReadParamStrDef('LogFile','');

      Section:= 'Spy';
      { Main Page }
      ReadParamInt('DocBase', BaseIndex);
      ReadParamInt('Family', FamilyIndex);
      { KW page }
      ReadParamBool('LoadDict', LoadDict);
      ReadParamString('KWFileName', KWFile);
      ReadParamBool('ClearOldKW', ClearOldKW);
      { NSRC page }
      ReadParamBool('UpdateDocs', UpdateDocs);
      ReadParamBool('LoadNSRC', LoadNSRC);
      ReadParamBool('CheckPriority', CheckPriority);
      ReadParamString('SrcDir', BasePath);
      ReadParamString('PictureDir', PictureDir);
      ReadParamBool('FinalUpdate', FinalUpdate);
      ReadParamBool('UpdateDicts', UpdateDicts);
      ReadParamBool('ExclusiveMode', ExclusiveMode);
      ReadParamInt('SameDocuments', SameDocuments);
      ReadParamBool('CheckDocuments', CheckDocuments);
      ReadParamBool('IfNotModify', IfNotModify);
      ReadParamBool('IfNotVIncluded', IfNotVIncluded);

      ReadParamInt('InputFileType', InputFileType);
      { Index page }
      ReadParamBool('ReIndex', ReIndex);
      ReadParamBool('UseIndicators', UseIndicators);
    end;
  except
  end;
  btnGo.Enabled:= chbDictionCollect.Checked or CheckBox1.Checked or cbIndex.Checked;
end;

procedure TSpyForm.WriteCFG;
begin
// SaveSettings(Self);
  try
    with StationConfig do
    begin
      Section:= 'Spy';
      { NSRC page }
//      WriteParamBool('UpdateDocs', cbUpdateDoc.Checked);
      WriteParamBool('LoadNSRC', CheckBox1.Checked);
      WriteParamBool('CheckPriority', cbCheckPriority.Checked);
      WriteParamStr('SrcDir', deWorkDir.Text);
      WriteParamStr('PictureDir', dirPicture.Text);
      WriteParamBool('FinalUpdate', cbFinalUpdateTable.Checked);
      WriteParamBool('UpdateDicts', cbUpdateDicts.Checked);
      WriteParamBool('ExclusiveMode', cbxExclusiveMode.Checked);
      WriteParamInt('SameDocuments', rgSameDocuments.ItemIndex);
      WriteParamBool('CheckDocuments', cbCheckDocuments.Checked);
      WriteParamBool('IfNotModify', cbIfNotModify.Checked);
      WriteParamBool('IfNotVIncluded', cbIfNotVIncluded.Checked);
      WriteParamInt('InputFileType', comboInputType.ItemIndex);
      { KW page }
      WriteParamBool('LoadDict', chbDictionCollect.Checked);
      WriteParamStr('KWFileName', KWFileEdit.Text);
      WriteParamBool('ClearOldKW', chbClearOldKW.Checked);
      { Index page }
      WriteParamBool('ReIndex', cbIndex.Checked);
      WriteParamBool('UseIndicators', cbUseIndicators.Checked);
    end;
  finally
  end;
end;


procedure TSpyForm.CancelBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TSpyForm.btnGoClick(Sender: TObject);
var

  S: String;
  Dc: TDeleteConditionSet;
  l_CurPath: String;
  l_S       : PString;
  CurAttrib : LongInt;


  procedure DoImport;
  begin
   f_Pipe:= TPipeDream.Create(nil, 1);
   try
    f_Pipe.Progressor:= f_Progressor;
    case comboInputType.ItemIndex of
     0: f_Pipe.InputFileType := dd_itGarant;          // ddNSRC_r;
     1: f_Pipe.InputFileType := dd_itEverest;         // evEvdRd
     2: f_Pipe.InputFileType := dd_itRTFAnnotation;
     3: f_Pipe.InputFileType := dd_itTXTAnnotation;
    else
     f_Pipe.InputFileType:= dd_itUnknown;
    end;

    case rgSameDocuments.ItemIndex of
     0: f_Pipe.SameDocuments:= sdrIgnore;
     1: begin
         f_Pipe.SameDocuments:= sdrDelete;
         dc:= [];
         if cbIfNotModify.Checked then
          Include(DC, dcIfNotModify);
         if cbIfNotVIncluded.Checked then
          Include(DC, dcIfNotVIncluded);
         if cbIfNotHasAnno.Checked then
          Include(DC, dcIfNotHasAnno);
         f_Pipe.DeleteConditions:= dc;
        end;
     end; // case rgSameDocuments.ItemIndex
     f_Pipe.CheckDocuments:= cbCheckDocuments.Checked;
     f_Pipe.NeedLockBase := cbxExclusiveMode.Checked;
     f_Pipe.WorkDir:= deWorkDir.Text;
     f_Pipe.MoveFiles:= False;
     f_Pipe.DoneDir:= '';
     //f_Pipe.TwoPassImport:= cbUpdateDoc.Checked;
     if cbUpdateDicts.Checked then
      f_Pipe.NotUpdatableDicts:= []
     else
      f_Pipe.NotUpdatableDicts:= ddAllDicts;
     f_Pipe.FinalUpdate:= cbFinalUpdateTable.Checked;
     f_Pipe.PictureDir:= dirPicture.Text;
     f_Pipe.NeedFork:= not cbIndex.Checked;
     // Выяснение номера пользователя, от имени которого будем заливать
     if comboUserList.ItemIndex > -1 then
       f_Pipe.UserID:= UserManager.Users.DataInt[comboUserList.ItemIndex];
     f_Pipe.IsEnglish:= cbEnglish.Checked;
     EnglishIncrement:= 0; //  Потом можно будет убрать
     f_Pipe.AddNewToLog := cbAddNewToLog.Checked;
     f_Pipe.Execute;
     if f_Pipe.Aborted then
       AlreadyDone:= False;                                         
   finally
    if (f_Pipe.ErrorLog.Count > 0) then
    begin
     f_ImportErrors.Assign(f_Pipe.ErrorLog);
    end;  // f_Pipe.ErrorLog.Count > 0
    l3Free(f_Pipe);
   end; // try..finally
  end;

  procedure DoIndex;
  var
   l_UpdateBase: Boolean;
   f_DB: Im4DB;
   l_EraseSAV: Boolean;
  begin
   l3System.Msg2Log('Начало обновления переменной части и индексация');
   Caption:= ProgramCaption + ' - Обновление текстового индекса';
   lblMainInfo.Visible:= True;
   lblAdditionalInfo.Visible:= True;
   ServerProgressBar.Visible:= True;
   try
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
    l3System.Msg2Log('Ошибка обновления переменной части');
    exit;
   end;
   Caption:= ProgramCaption;
   lblMainInfo.Visible:= False;
   lblAdditionalInfo.Visible:= False;
   ServerProgressBar.Visible:= False;
  end;

 procedure DoCheckPriority;
 begin
  begin
   l3System.Msg2Log('Расчет важности документов.');
   DocumentServer.Family:= 1;
   try
    f_Progressor.Caption:= 'Расчет важности документов.';
    f_Progressor.Start;
    DocumentServer.CheckDocPriority(True, f_Progressor.Update);
   finally
    f_Progressor.Stop;
   end;
   l3System.Msg2Log('Расчет важности документов закончен.');
  end;
 end;

 procedure DoLoadKWFile;
 var
  l_KWPipe : TddKeywordsPipe;
 begin
  l_KWPipe := TddKeywordsPipe.Create(nil);
  try
   l_KWPipe.Family := 1;
   l_KWPipe.FileName := kwFileEdit.Text;
   l_KWPipe.Progressor := f_Progressor;
   l_KWPipe.Aborted := @CancelAutoImport;
   l_KWPipe.IsDelta := cbIsDeltaKW.Checked;
   l_KWPipe.ClearBeforeLoad := chbClearOldKW.Checked;
   l_KWPipe.NeedAddToDictionary := cbxAddToDictionary.Checked;
   l_KWPipe.Execute;
  finally
   l3Free(l_KWPipe);
  end;
 end;

begin
 f_Progressor:= TddProgressObject.Create(nil);
 try
  CancelButton.Caption:= 'Прервать';
  if AlreadyDone then
   if MessageDlg('Импорт один раз закончен. Начать еще раз?',
                 mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    exit;
   WriteCFG;
   if cbUseIndicators.Checked then
   begin
    f_Progressor.ShowProcess := True;
    f_Progressor.Start;
   end
   else
   begin
    f_Progressor.OnUpdate:= ProgressUpdate;
    PageControl1.ActivePage:= Additional;
    ServerProgressBar.Visible:= True;
    lblMainInfo.Visible:= True;
    lblAdditionalInfo.Visible:= True;
   end;
   DisableControls;
   try
    GlobalDataProvider.SubscribeLongProcess(Self);
    try
     GlobalHtServer.FamilyTbl.GetPathAndAttrib(1, l_S, CurAttrib);
     l_CurPath:= l_S^; System.Delete(l_CurPath, Length(l_CurPath), 1);
      (*
      if cbxExclusiveMode.Checked then
       UpdateTables;
      *)
      { Запуск процесса импортирования }
      if CheckBox1.Checked then
       DoImport;

      if cbCheckPriority.Checked then
       DoCheckPriority;

      if chbDictionCollect.Checked then
       DoLoadKWFile;

      if cbIndex.Checked then
       DoIndex;

      if CheckBox1.Checked and (f_ImportErrors.Count > 0) then
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
      if cbFinalUpdateTable.Checked then
       UpdateTables;
    finally
     GlobalDataProvider.UnSubscribeLongProcess(Self);
    end;
   finally
    EnableControls;
    ReadCFG;
    SetParams;
    AlreadyDone:= True;
   end;
   ShowMessage('Импорт завершен');
 finally
  if cbUseIndicators.Checked then
  begin
   f_Progressor.Stop;
  end
  else
  begin
   ServerProgressBar.Visible:= False;
   lblMainInfo.Visible:= False;
   lblAdditionalInfo.Visible:= False;
  end;
  CancelButton.Caption:= 'Выход';
  l3Free(f_Progressor);
 end;
end;

procedure TSpyForm.chbDictionCollectClick(Sender: TObject);
begin
 kwFileEdit.Enabled:= chbDictionCollect.Checked;
 chbClearOldKW.Enabled:= chbDictionCollect.Checked;
 GroupBox2.Enabled:= chbDictionCollect.Checked;
 cbxAddToDictionary.Enabled:= chbDictionCollect.Checked;
 btnGo.Enabled:= chbDictionCollect.Checked or CheckBox1.Checked or cbIndex.Checked;
end;

procedure TSpyForm.CheckBox1Click(Sender: TObject);
begin
 deWorkDir.Enabled:= CheckBox1.Checked;
 dirPicture.Enabled:= CheckBox1.Checked;
 //cbUpdateDoc.Enabled:= CheckBox1.Checked;
 cbCheckPriority.Enabled:= CheckBox1.Checked;
 cbUpdateDicts.Enabled:= CheckBox1.Checked;
 cbFinalUpdateTable.Enabled:= CheckBox1.Checked;
 comboInputType.Enabled:= CheckBox1.Checked;
 cbCheckDocuments.Enabled:= CheckBox1.Checked;
 rgSameDocuments.Enabled:= CheckBox1.Checked;
 Label8.Enabled:= CheckBox1.Checked;
 Label9.Enabled:= CheckBox1.Checked;
 cbIfNotModify.Enabled:= CheckBox1.Checked;
 cbIfNotVIncluded.Enabled:= CheckBox1.Checked;
 cbIfNotHasAnno.Enabled := CheckBox1.Checked;
 cbxExclusiveMode.Enabled:= CheckBox1.Checked;
 cbAddNewToLog.Enabled:= CheckBox1.Checked;
 btnGo.Enabled:= chbDictionCollect.Checked or CheckBox1.Checked or cbIndex.Checked;
end;

procedure TSpyForm.FillAbout;
begin
end;

procedure TSpyForm.StopAutoImport;
begin
 CancelAutoImport:= True;
end;

procedure TSpyForm.CheckAutoImport(UserID : TdaUserID; Const Catalog : String);
var
  S: Tl3String;
begin
  S:= Tl3String.Create(nil);
  try
    S.AsString := Catalog;
    S.StringID := UserID;
    f_PackList.Add(S);
  finally
    l3Free(S);
  end;
end;




procedure TSpyForm.cbUpdateDocClick(Sender: TObject);
begin
//  if cbUpdateDoc.Checked then
//   rgImportType.ItemIndex:= 0;
 cbCheckDocuments.Enabled:= True; //not cbUpdateDoc.Checked;
 rgSameDocuments.Enabled:= {not cbUpdateDoc.Checked and} cbCheckDocuments.Checked and cbCheckDocuments.Enabled;
 cbIfNotModify.Enabled:= rgSameDocuments.Enabled and cbCheckDocuments.Checked and (rgSameDocuments.ItemIndex = 1);
 cbIfNotVIncluded.Enabled:= rgSameDocuments.Enabled and cbCheckDocuments.Checked and (rgSameDocuments.ItemIndex = 1);

end;


procedure TSpyForm.SetDefaultPacked;
begin
 cbCheckDocuments.Checked:= True;
 rgSameDocuments.ItemIndex:= 1;
 cbUpdateDicts.Checked:= comboInputType.ItemIndex <> 0;
 cbFinalUpdateTable.Checked:= False;
 cbFinalUpdateTable.Enabled:= False;
// cbUpdateDoc.Checked:= False;
// cbUpdateDoc.Checked:= False;
// cbUpdateDoc.Enabled:= False;
end;

procedure TSpyForm.cbCheckDocumentsClick(Sender: TObject);
begin
 rgSameDocuments.Enabled:= {not cbUpdateDoc.Checked and} cbCheckDocuments.Checked;
 cbIfNotModify.Enabled:= rgSameDocuments.Enabled and (rgSameDocuments.ItemIndex = 1);
 cbIfNotVIncluded.Enabled:= rgSameDocuments.Enabled and (rgSameDocuments.ItemIndex = 1);
 cbIfNotHasAnno.Enabled := rgSameDocuments.Enabled and (rgSameDocuments.ItemIndex = 1);
end;

procedure TSpyForm.btnUpdateTablesClick(Sender: TObject);
begin
  lblMainInfo.Visible:= True;
  lblAdditionalInfo.Visible:= True;
  ServerProgressBar.Visible:= True;
  try
   DisableControls;
   UpdateTables(True);
  finally
    EnableControls;
    lblMainInfo.Visible:= False;
    lblAdditionalInfo.Visible:= False;
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

procedure TSpyForm.cbUseIndicatorsClick(Sender: TObject);
begin
  lblMainInfo.Visible:= not cbUseIndicators.Checked;
  lblAdditionalInfo.Visible:= not cbUseIndicators.Checked;
//  Перенести информацию с одного прогресса на другой
end;

procedure TSpyForm.deWorkDirChange(Sender: TObject);
begin
  AlreadyDone:= False;
end;

procedure TSpyForm.rgSameDocumentsClick(Sender: TObject);
begin
  if rgSameDocuments.ItemIndex = 1 then
  begin
    cbIfNotModify.Enabled:= True;
    cbIfNotVIncluded.Enabled:= True;
    cbIfNotHasAnno.Enabled := True;
  end
  else
  begin
    cbIfNotModify.Enabled:= False;
    cbIfNotVIncluded.Enabled:= False;
    cbIfNotHasAnno.Enabled := False;
  end;
end;


procedure TSpyForm.Button2Click(Sender: TObject);
var
 l_ErrorFoundMain: Boolean;
 l_MsgMain: String;
 l_ErrorFoundGarant: Boolean;
 l_MsgGarant: String;
begin
  lblMainInfo.Visible:= True;
  lblAdditionalInfo.Visible:= True;
  ServerProgressBar.Visible:= True;
  try
    DisableControls;
    GlobalDataProvider.SubscribeLongProcess(Self);
    GLobalHtServer.PhisicalVerifyAllTbl(0, l_ErrorFoundMain, l_MsgMain);
    GLobalHtServer.PhisicalVerifyAllTbl(1, l_ErrorFoundGarant, l_MsgGarant);
  finally
    GlobalHTServer.OpenClosedTbls;
    EnableControls;
    GlobalDataProvider.UnSubscribeLongProcess(Self);
    lblMainInfo.Visible:= False;
    lblAdditionalInfo.Visible:= false;
    ServerProgressBar.Visible:= False;
    if not l_ErrorFoundMain and not l_ErrorFoundGarant then
     ShowMessage('Проверка завершена успешно')
    else
     MessageDlg(l_MsgMain + ' ' + l_MsgGarant, mtError, [mbOk], 0);
  end;
end;


procedure TSpyForm.cbIndexClick(Sender: TObject);
begin
 btnGo.Enabled:= chbDictionCollect.Checked or CheckBox1.Checked or cbIndex.Checked;
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
 cbUpdateDicts.Checked:= comboInputType.ItemIndex <> 0;
 deWorkDir.DialogText := 'Выберите папку с исходными файлами'
end;

procedure TSpyForm.ProgressUpdate(Sender: TObject; aState: Byte);
var
 l_Percent: Integer;
begin
 case aState of
  0:
   begin
    with Sender as TddProgressObject do
    begin
     ServerProgressBar.Hint := '';
     lblAdditionalInfo.Caption:= TextMessage;
     if TotalCur = 0 then
     begin
      lblMainInfo.Caption:= Caption;
      ServerProgressBar.Max:= 100;
      ServerProgressBar.Position:= 0;
     end;
    end;
   end;
  1:
   begin
    l_Percent := (Sender as TddProgressObject).TotalPercent;
    ServerProgressBar.Position:= l_Percent;
    ServerProgressBar.Hint := SysUtils.Format('Обработано %d%%', [l_Percent]);
    lblMainInfo.Caption:= 'До окончания осталось ' + (Sender as TddProgressObject).TotalRemainingTimeAsString;
   end;
  2:
   begin
    with Sender as TddProgressObject do
    begin
     if TotalCur = TotalMax then
     begin
      ServerProgressBar.Hint := '';
      lblMainInfo.Caption:= 'Задание выполнено за ' + TotalElapsedTimeAsString;
      ServerProgressBar.Position:= 100;
     end
     else
      lblAdditionalInfo.Caption:= 'Задание выполнено за ' + TotalElapsedTimeAsString;
    end;
   end;
 end;
 Application.ProcessMessages;
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
 if cbIsDeltaKW.Checked then
  chbClearOldKW.Checked := False;
end;

procedure TSpyForm.chbClearOldKWClick(Sender: TObject);
begin
 if chbClearOldKW.Checked then
 begin
  cbIsDeltaKW.Checked := False;
  cbxAddToDictionary.Checked:= True;
 end;
 cbxAddToDictionary.Enabled:= not chbClearOldKW.Checked;

end;

procedure TSpyForm.UpdateTables(makeProgressor: Boolean = False);
var
 l_Progress: IdaProgressSubscriber;
begin
 l3System.Msg2Log('Обновление базы');
 l_Progress := TdaProgressProcHolder.Make(f_Progressor.Update);
 try
  if makeProgressor then
   f_Progressor:= TddProgressObject.Create(nil);
  try
    GlobalDataProvider.SubscribeProgress(l_Progress);
    f_Progressor.Start(2, False);
    GlobalHTServer.CloseAllTbls(0);
    GlobalHTServer.CloseAllTbls(1);
    GlobalHTServer.UpdateAllTbl(0);
    f_Progressor.UpdateTotal(1, 1, '');
    GlobalHTServer.UpdateAllTbl(1);
    f_Progressor.UpdateTotal(1, 2, '');
  finally
    GlobalHTServer.OpenClosedTbls;
    GlobalDataProvider.UnSubscribeProgress(l_Progress);
    f_Progressor.Stop;
    if makeProgressor then
     l3Free(f_Progressor);
    l3System.Msg2Log('Обновление базы завершено');
  end;
 finally
  l_Progress := nil;
 end;
end;

procedure TSpyForm.HelpButtonClick(Sender: TObject);
begin
 Application.HelpContext(Succ(PageControl1.ActivePageIndex));
end;

function TSpyForm.DoLongProcessNotify(aState: TdaProcessState): Boolean;
begin
  Result:= False;
  (*
  Case aState of
   da_psStart   : begin
                Result := False;
                If fHTLongProcessMsg <> nil then Exit;
                fHTLongProcessMsg := vtShowCurtainMessage('База временно недоступна. Подождите, пожалуйста...', mtInformation, [mbCancel]);
               end;

   da_psCurrent : begin
                Result := False; //True;
                Application.ProcessMessages;
                If fHTLongProcessMsg <> nil
                 then Result := vtGetCurtainMessageModalResult(fHTLongProcessMsg) <> mrNone;
               end;

   da_psEnd     : begin
                Result := False;
                vtCloseCurtainMessage(fHTLongProcessMsg);
                fHTLongProcessMsg := nil;
               end;
  end;
  *)
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
