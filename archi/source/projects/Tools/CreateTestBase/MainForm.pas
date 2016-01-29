{$A8,B-,C-,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O-,P+,Q+,R+,S-,T-,U-,V-,W+,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit MainForm;

{$I ProjectDefine.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ToolEdit, Mask, Buttons, Contnrs,

  l3IniFile,
  l3Base, l3StringList,
  dt_Types,
  dtIntf,
  dt_Sab,

  l3ObjectList;

type
  TTestForm = class(TForm)
    Panel1 : TPanel;
    btnGo : TButton;
    lblGlobalStatus: TLabel;
    DBPath: TLabel;
    ProgressBar: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure TopicEvent(aTopicNo: Longint; const aMessage: String);
    procedure TotalProc(aState: Byte; aValue: Longint; const aMsg: string);
  private
    f_Family    : TFamilyID;
    f_NumSab    : ISab;
    f_SabFiller : IValueSetFiller;
  private
    procedure UpdateHomeDir;
    procedure BuildIndex;
    procedure BuildAutolinkCaches;
    function DoDeploy: Boolean;
    function DoImport: Boolean;
    procedure UpdateProgress(aSender: TObject; aTotalPercent: Integer);
  end;

var
  TestForm: TTestForm;


implementation

{$R *.DFM}

uses
  Math,
  FileCtrl,

  arDBUtils,

  m4DB,
  m4DBInterfaces,

  daDataProvider,

  dt_Doc,
  Dt_Serv,
  Dt_Const,
  dt_LinkServ,
  dt_Renum,
  dt_AttrSchema,
  Dt_IndexSupport,
  Dt_IFltr,

  m3StorageInterfaces,

  ExportPipe,

  ddHTInit,
  ddMailTools,
  ddImportPipe,
  ddProgressObj,
  ddFileIterator,
  ddAutolinkCache,
  ddClientBaseEngine,

  l3Types,
  l3Const,
  l3Stream,
  l3FileUtils,
  l3ExceptionsLog,

  stDate,

  afwVCL,

  JclMiscel;

procedure TTestForm.FormCreate(Sender: TObject);
begin
 DBPath.Caption := 'Папка с тестовой базой: ' + csTestBaseDir;
end;

function TTestForm.DoDeploy: Boolean;
var
 l_Msg: String;
begin
 lblGlobalStatus.Caption := 'Распаковка архива...';
 Application.ProcessMessages;
 Result := ArUnackBaseFromArchive(csBaseFileName, csTestBaseDir, l_Msg);
 if not Result then
 begin
  ShowMessage(l_Msg);
  Exit;
 end; // if not Result then
 if not DirectoryExists(csTestDocsDir) then
 begin
  ShowMessage('Не найдена директория с документами для базы.');
  Result:= False;
  Exit;
 end; // if DirectoryExists(csTestBaseDir) then
end;

procedure TTestForm.FormDestroy(Sender: TObject);
begin
 if g_BaseEngine <> nil then
  DoneClientBaseEngine;
end;

procedure TTestForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TTestForm.btnGoClick(Sender: TObject);
begin
 if DoDeploy and InitBaseEngine(nil, True) then
 begin
  f_Family := 1;
  lblGlobalStatus.Caption := '';
 end // if DoDeploy and InitBaseEngine then
 else
 begin
  MessageDlg('Не удалось восстановить тестовое окружение', mtError, [mbOk], 0);
  Exit;
 end;
 btnGo.Enabled := False;
 lblGlobalStatus.Caption := 'Подготовка к импорту...';
 Application.ProcessMessages;
 DoImport;
 lblGlobalStatus.Caption := 'Построение кэша автопростановщика ссылок...';
 Application.ProcessMessages;
 BuildAutolinkCaches;
 Application.ProcessMessages;
 lblGlobalStatus.Caption := 'Построение индекса...';
 BuildIndex; 
 Application.ProcessMessages;
 lblGlobalStatus.Caption := 'Обновление пользоватля ArchiTester...';
 UpdateHomeDir;
 Application.ProcessMessages;
 lblGlobalStatus.Caption := 'Создание архива с тестовой базой...';
 if not CreateTestBaseArchive then
  MessageDlg('Архив с тестовой базой не был создан!', mtError, [mbOk], 0);
 lblGlobalStatus.Caption := 'Готово!';
end;

procedure TTestForm.BuildAutolinkCaches;
var
 l_Prg: TddProgressObject;
begin
 l_Prg := TddProgressObject.Create(nil);
 try
  l_Prg.OnUpdate := UpdateProgress;
  CreateAutolinkCache(l_Prg.OnProgressProc);
 finally
  FreeAndNil(l_Prg);
 end;
end;

procedure TTestForm.TopicEvent(aTopicNo: Longint; const aMessage: String);
begin
 if f_SabFiller = nil then
  f_SabFiller := f_NumSab.MakeValueSetFiller(rnImportID_fld);
 f_SabFiller.AddValue(aTopicNo);
end;

function TTestForm.DoImport: Boolean;
var
 l_Prg: TddProgressObject;
begin
 with TddImportPipe.Create(f_Family{, True}) do
 try
  l_Prg := TddProgressObject.Create(nil);
  l_Prg.OnUpdate := UpdateProgress;
  Progressor := l_Prg;
  try
   f_NumSab := MakeSab(LinkServer(f_Family).Attribute[atRenum]);
   try
    InputFileType := dd_itAutoDetect;
    OnTopicStart := TopicEvent;
    CheckDocuments := True;

    NeedLockBase := True;
    WorkDir := csTestDocsDir;
    PictureDir := WorkDir;
    NotUpdatableDicts := [];//ddAllDicts;
    NeedFork := True;
    UserID := 0;
    AddNewToLog := false;
    Result := Execute;
   finally
    f_SabFiller := nil;
    f_NumSab.Refresh;
    f_NumSab.ValuesOfKey(rnRealID_fld);
    f_NumSab := nil;
   end;
  finally
   Progressor := nil;
   l3Free(l_Prg);
  end;
 finally
  Free;
 end; // try..finally
end;

procedure TTestForm.UpdateProgress(aSender: TObject; aTotalPercent: Integer);
begin
 ProgressBar.Position := aTotalPercent;
 ProgressBar.Max := 100;
 lblGlobalStatus.Caption := 'До окончания импорта осталось: '+ TddProgressObject(aSender).TotalRemainingTimeAsString;
 Application.ProcessMessages;
end;

procedure TTestForm.BuildIndex;
const
 csBServe = 'bserv001';
var
 l_DB         : Im4DB;
 l_Path       : AnsiString;
 l_DelFileName: AnsiString;
begin
 l_Path := ConcatDirName(ExcludeTrailingBackslash(GlobalHtServer.FamilyTbl.FamilyPath(f_Family)), csBServe);
 l_DB := Tm4DB.Make(l_Path, nil, nil, TotalProc);
 try
  l_DB.BuildIndex;
  l_DB.Start(m3_saReadWrite);
  try
   l_DB.UpdateIndex;
   if l_DB.Update then
    l_DB.Purge;
  finally
   l_DB.Finish;
  end;
  l_DB.DeleteVersion;
 finally
  l_DB := nil;
 end;
end;

procedure TTestForm.TotalProc(aState: Byte; aValue: Integer;
  const aMsg: string);
begin
 with ProgressBar do
 begin
  case aState of
   0: begin
       if aValue > 0 then
        Max := aValue
       else
        Max := 0;
       Position := 0;
       lblGlobalStatus.Caption := aMsg;
      end;
   1: Position := aValue;
   2: begin
       Position := Max;
       lblGlobalStatus.Caption:= '';
      end;
  end;
 end;
 Application.ProcessMessages;
end;

procedure TTestForm.UpdateHomeDir;
var
 l_HomePath: AnsiString;
begin
 l_HomePath := GlobalDataProvider.GetHomePath(cnArchiTestUserID);
 CopyFilesByMaskEX(csUserConfigDir, l_HomePath, '*.*', cmNoBakCopy);
 ddUpdateMailInHomes(GlobalDataProvider.GlobalHomePath);
end;

end.
