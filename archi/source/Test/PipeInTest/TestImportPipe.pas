unit TestImportPipe;
{ Верхний слой трубы для импорта - знает про входные форматы и цикл }
{ $Id: TestImportPipe.pas,v 1.9 2016/08/11 10:42:03 lukyanets Exp $ }

// copy from ddImportPipe.pas,v 1.49 2009/02/05

interface

{$DEFINE Filter}
{$DEFINE TwoStepImport}
{.$DEFINE MultiKW}
uses
  WinTypes, WinProcs, Messages, Classes, Graphics, Controls, SysUtils,
  Forms, Dialogs,
  ddNSRC_r, ddKW_r, ddProgressObj, ddImportPipeKernel, ddFileIterator,
  ddExtAnnoPipe,
  l3Filer, l3Base, l3Types,
  l3Date,
  k2Reader, k2TagGen,
  evHndFlt,
  daInterfaces,
  daTypes,
  DT_Const, DT_Types, DT_Fam, dt_IFltr, ddPipeTypes;

type
  TddPipeStatus = (dd_psOk, dd_psError, dd_psDelDuplicate, dd_psNSRCImport,
                   dd_psKWImport);

  TddPipeInputFileType = (dd_itAutoDetect,      // определяется путем анализа имени файла
                          dd_itGarant,          // ddNSRC_r
                          dd_itEverest,         // evEvdRd
                          dd_itEverestInternal, // evEvdRd
                          dd_itRTFAnnotation,   // ddDocReader
                          dd_itTXTAnnotation,   // evPlainText
                          dd_itUnknown);        // тип не известен
  TddPipeInputFileTypeSet = set of TddPipeInputFileType;

  TddSkipTopicEvent = procedure (theTopicNo: Longint; const theMessage: String) of object;
  TPipeDream = class(TComponent)
  private
   { Private declarations }
   f_Kernel: TddImportPipeFilter;
   f_FileIterator: TddFileIterator;
   f_Progressor : TddProgressObject;
   f_FileReader: Tk2CustomFileReader;
   f_Generator: Tk2TagGenerator;
   f_InFiler: TevDOSFiler;
    function GetCheckRegion: Boolean;
    procedure SetCheckRegion(const Value: Boolean);
  private { Настройки трубы }
   FAutoDetectTypes: TddPipeInputFileTypeSet;
   f_Family: TdaFamilyID;
   f_PictDir: String;
   f_MoveFiles: Boolean;
   f_DoneDir: ShortString;
   f_UserDepend: Boolean;
   //f_CloseStages: Boolean;
   f_LoadDict: Boolean;
   f_FinalUpdate: Boolean;
   f_SameDocuments: TSameDocReact;
   f_DelConditions : TDeleteConditionSet;
   f_CheckDocuments: Boolean;
   f_NeedLockBase : Boolean;
   f_CheckNullDocs: Boolean;
   f_SafeCleanDir: String;
   f_CleanFiles: Boolean;
   f_UserID    : Long;
   f_InputFileType: TddPipeInputFileType;
   f_ClearLog   : Boolean;
   f_Abort: Boolean;
   f_AnnoFilter: TddExtAnnotationFilter;
   f_ErrorLog : TStrings;
   f_Status    : TddPipeStatus;
   f_TopicStart: TddTopicEvent;
   f_TopicSkip: TddTopicEvent;
   f_CommentWrite: TddCommentWriteEvent;
   f_NotUpdatableDicts: TDLTypeSet;
   f_TopicNo: Longint;
   f_TopicCount : Longint;
  private
   procedure CreateFileReader(aFileType : TddPipeInputFileType);
   procedure DestroyFileReader;
   procedure FilerAbortLoad(Sender: TObject; var Aborted: Bool);
   procedure SetIsEnglish(Value: Boolean);
   function  GetIsEnglish: Boolean;
   procedure SetProgressor(Value: TddProgressObject);
   procedure SetInputFileType(Value: TddPipeInputFileType);
   procedure SetWorkDir(Value: ShortString);
   function  GetWorkDir: ShortString;
   function  GetFileMask: String;
   function pm_GetAddNewToLog: Boolean;
   function pm_GetNeedFork: Boolean;
    procedure pm_SetAddNewToLog(const aValue: Boolean);
   procedure pm_SetNeedFork(const aValue: Boolean);
   procedure StartProgressor;
   procedure StopProgressor;
   procedure SetFileMask(aValue: String);
   procedure SetKernelParams;
   function _UpdateDicts(aDictType: TdaDictionaryType; aDocID, aSubID: TSubID;
                          aName: Tl3CustomString): Boolean;
   procedure _StartTopic(aTopicNo: Longint; aMessage: String);
   procedure _Abort(Sender: TObject);
   procedure _SkipDocument(aDocID : TDocID; WhyFlag : TSkipDocReason; UserID : Longint);
   function  _ProcessOneFile(const aFileName: String): Boolean;
  protected
    { Protected declarations }

   function  ImportDocuments: Boolean;
   procedure AddError(Msg: String);
   procedure DoCleanFiles;
   procedure AbortImport;
   procedure AddSize(Size: Longint);
   procedure MyFileProc(aState: Byte; aValue: Longint; const aMsg: string);
   procedure ClearDoneDir;
  public
   { Public declarations }
   constructor Create(aOwner: TComponent; aFamily: Integer); overload; virtual;
   destructor Destroy; override;
   function Execute: Boolean;
   procedure AbortProcess;
   class function GetInputFileType(aFilename: String; aValidTypes:
       TddPipeInputFileTypeSet): TddPipeInputFileType;
  public
   property Status : TddPipeStatus
    read f_Status;

   property Aborted: Boolean
    read f_Abort;
   property AddNewToLog: Boolean read pm_GetAddNewToLog write pm_SetAddNewToLog;
   property AutoDetectTypes: TddPipeInputFileTypeSet read FAutoDetectTypes write
       FAutoDetectTypes;

   property UserID: Long
    read f_UserID write f_UserID;

   property ErrorLog: TStrings
    read f_ErrorLog;

   property ClearLog: Boolean
    read f_ClearLog write f_ClearLog;
   property NeedFork: Boolean read pm_GetNeedFork write pm_SetNeedFork;

  published
    { Published declarations }
   property Reader: Tk2CustomFileReader read f_FileReader write f_FileReader;

   property Family : TdaFamilyID
    read f_Family
    write f_Family
    default 1;

   property InputFileType: TddPipeInputFileType
    read f_InputFileType
    write SetInputFileType;

   property FileMask: String
    read GetFileMask
    write SetFileMask;

   property IsEnglish: Boolean
    read GetIsEnglish
    write SetIsEnglish;

   property WorkDir: ShortString
    read GetWorkDir
    write SetWorkDir;

   property PictureDir: String
    read f_PictDir
    write f_PictDir;

   property MoveFiles: Boolean
    read f_MoveFiles
    write f_MoveFiles;

   property DoneDir: ShortString
    read f_DoneDir
    write f_DoneDir;

   property UserDepend: Boolean
   {* Создание папки для импортированных файлов в домашней папке пользователя}
    read f_UserDepend
    write f_UserDepend;

   property CheckDocuments: Boolean
    read f_CheckDocuments
    write f_CheckDocuments;

   property NeedLockBase: Boolean
    read f_NeedLockBase
    write f_NeedLockBase;

   property CheckNullDocs: Boolean
    read f_CheckNullDocs
    write f_CheckNullDocs;

   property SameDocuments: TSameDocReact
    read f_SameDocuments
    write f_SameDocuments;

   property DeleteConditions : TDeleteConditionSet
    read f_DelConditions
    write f_DelConditions;

   property LoadDict: Boolean
    read f_LoadDict
    write f_LoadDict;

   property FinalUpdate: Boolean      { Обновление базы по окончании }
    read f_FinalUpdate
    write f_FinalUpdate;

   property NotUpdatableDicts : TDLTypeSet
    read f_NotUpdatableDicts
    write f_NotUpdatableDicts;

    property CleanFiles: Boolean
      read f_CleanFiles write f_CleanFiles;

    property SafeCleanDir: String
      read f_SafeCleandir write f_SafeCleanDir;

    //property CloseStages: Boolean {* Закрывать этапы в Гардоке}
    // read f_CloseStages
    // write f_CloseStages;
    property CheckRegion: Boolean
     read GetCheckRegion
     write SetCheckRegion;
   published
    property OnTopicStart: TddTopicEvent
     read f_TopicStart
     write f_TopicStart;

    property OnTopicSkip: TddTopicEvent
    { вызывается в момент пропуска топика }
      read f_TopicSkip
      write f_TopicSkip;

    property OnCommentWrite: TddCommentWriteEvent
      read f_CommentWrite write f_CommentWrite;

    property Progressor : TddProgressObject
     read f_Progressor
     write SetProgressor;
  end;


function CheckFileType(const FileList: TStrings; IsAnnotation: Boolean): TddPipeInputFileType; overload;

const
 ddAllDicts = [da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlBases,
               da_dlDateNums, da_dlWarnings, da_dlCorrects, da_dlCorSources, da_dlPublisheds,
               da_dlPrefixes, da_dlTerritories, da_dlNorms, da_dlAccGroups,
               da_dlAnnoClasses];

 ImportFileMask : array[TddPipeInputFileType] of String =
                  ('*.*',          // dd_itAutoDetect
                   '*.nsr',        // dd_itGarant
                   '*.evd;*.evr',  // dd_itEverest
                   '*.evd;*.evr',  // dd_itEverestInternal
                   '*.rtf;*.doc',  // dd_itRTFAnnotation
                   '*.txt',        // dd_itTXTAnnotation
                   ''             // dd_itUnknown
                   );

procedure Register;

function CheckFileType(const Directory: String; IsAnnotation: Boolean): TddPipeInputFileType; overload;

implementation

uses
 StrUtils,
 l3IniFile, l3String, l3FileUtils,

 afwFacade,

 daDataProvider,

 DT_DOC, ComCtrls, evEvdRd, ddUtils,
 ddNSRCUtils, k2Tags, k2Base, l3Except, evTxtRd,
  ddDocReader, l3languages, BAse_CFG;

procedure Register;
begin
  RegisterComponents('Readers', [TPipeDream]);
end;

constructor TPipeDream.Create(aOwner: TComponent; aFamily: Integer);
begin
 inherited Create(aOwner);
 f_Kernel:= TddImportPipeFilter.Create(aFamily);
 f_FileIterator:= TddFileIterator.Create(nil);
 f_InFiler:= TevDOSFiler.Create(nil);
 f_InFiler.OnCheckAbortedLoad := FilerAbortLoad;
 f_ErrorLog:= TStringList.Create;
 if f_InFiler.Indicator <> nil then
 begin
  f_InFiler.Indicator.NeedProgressProc:= True;
  f_InFiler.Indicator.OnProgressProc:= MyFileProc;
 end; // f_InFiler.Indicator <> nil
 f_MoveFiles:= False;
 f_DoneDir:= '';
 f_CleanFiles:= False;
 f_SafeCleanDir:= '';
 f_UserID:= 0;
 f_InputFileType:= dd_itUnknown;
 f_CheckNullDocs:= True;
 f_ClearLog:= True;
 f_UserDepend:= False;
 //f_CloseStages:= False;
 f_Family:= aFamily;
 f_NotUpdatableDicts:= ddAllDicts;
 FAutoDetectTypes := [dd_itGarant, dd_itEverest, dd_itEverestInternal];
end;


destructor TPipeDream.Destroy;
begin
 f_ErrorLog.Free;
 l3Free(f_Kernel);
 l3Free(f_FileIterator);
 l3Free(f_InFiler);
 inherited Destroy;
end;

function TPipeDream._ProcessOneFile(const aFileName: String): Boolean;
var
 l_FileType : TddPipeInputFileType;
begin
 Result:= False;
 if f_Abort then
   exit;
 if InputFileType = dd_itAutoDetect then
  l_FileType := getInputFileType(aFileName, AutoDetectTypes)
 else
  l_FileType := InputFileType;
 if l_FileType <> dd_itUnknown then
 begin
  CreateFileReader(l_FileType);
  f_InFiler.FileName:= aFileName;
  f_Status:= dd_psNSRCImport;
  try
   if InputFileType = dd_itAutoDetect then
    f_FileReader.Start;
   l3System.Msg2Log('Обработка %s начата', [aFileName]);
   f_FileReader.Execute;
   l3System.Msg2Log('Обработка %s закончена', [aFileName]);
   if InputFileType = dd_itAutoDetect then
    f_FileReader.Finish;
   if MoveFiles then
    CopyFile(aFileName, ConcatDirName(DoneDir, ExtractFileName(aFileName)),
             cmDeleteSource);
   f_Status:= dd_psOk;
   Result:= True;
  except
   on E: Exception do
   begin
    if not (E Is El3AbortLoad) then
    begin
     f_Status:= dd_psError;
     l3System.Msg2Log(Format('CRITICAL ERROR : Ошибка импорта файла %s', [aFileName]));
     raise;
    end
    else
     l3System.Msg2Log('Загрузка документа прервана');
   end; //on E: Exception
  end; // try..finally
  if InputFileType = dd_itAutoDetect then
   DestroyFileReader;
 end // l_FileType <> dd_itUnknown
 else
  Result := True;
end;



procedure TPipeDream.MyFileProc(aState: Byte; aValue: Longint; const aMsg: string);
begin
 if Assigned(f_Progressor) then
  f_Progressor.UpdateEx(aState, aValue, aMsg, f_InFiler.Indicator.ValueFactor);
end;

function TPipeDream.Execute: Boolean;
var
  aUserName,aLoginName : ShortString;
  aActFlag    : Byte;
begin
 Result := False;
 if f_ClearLog then
  f_ErrorLog.Clear;
 if StationConfig = nil then
  StationConfig:=TCfgList.Create('');
 if UserID > 0 then
 begin
  GlobalDataProvider.UserManager.GetUserInfo(UserID, aUserName, aLoginName, aActFlag);
  l3System.Msg2Log(Format('Начало выполнения импорта от имени %s (ID %d)', [aUserName, UserID]));
 end // UserID > 0
 else
  l3System.Msg2Log('Начало импорта');
 if ImportDocuments then
 begin
  DoCleanFiles;
  if UserID > 0 then
   l3System.Msg2Log(Format('Импорт от имени %s (ID %d) завершен.', [aUserName, UserID]))
  else
   l3System.Msg2Log('Импорт завершен.');
  Result := True;
 end
 else
  l3System.Msg2Log('Импорт завершился с ошибками');
end;


function TPipeDream.ImportDocuments: Boolean;
var
 l_StartTime: TDateTime;
 i: Integer;
begin
 Result := False;
 if Aborted then
  exit;
 l_StartTime:= Now;
 f_FileIterator.LoadFiles;
 f_TopicCount := 0;

 if f_FileIterator.TotalSize > 0 then
 begin
 { Создание объектов }
  CreateFileReader(InputFileType);
  try
   /// ???
   { Соединение }
   SetKernelParams;
   if MoveFiles then
    ClearDoneDir;
   if InputFileType <> dd_itAutoDetect then
    if f_FileReader.Generator <> nil then
    f_FileReader.Generator.Start;
   try
    StartProgressor;
    try
     //f_FileIterator.IterateFiles(_ProcessOneFile);

     Randomize;
     for i:= 0 to 999 do
     begin
      _ProcessOneFile(f_FileIterator.FileList.Strings[Random(f_FileIterator.FileList.Count)]);
     end;

    finally
     StopProgressor;
    end;
   finally
    if not f_Abort and (InputFileType <> dd_itAutoDetect) then
     if f_FileReader.Generator <> nil then
      f_FileReader.Generator.Finish;
   end; { try..finally }
  finally
   DestroyFileReader;
  end;
 end; // f_FileIterator.TotalSize > 0

 // Импорт закончен
 if f_Progressor <> nil then
  l3System.Msg2Log('Импортировано %s (%d документов) за %s',
                     [Bytes2Str(f_Progressor.TotalCur),
                      f_TopicCount,
                      CalcElapsedTime(l_StartTime, Now)])
 else
  l3System.Msg2Log('Импортировано %d документов за %s',
                     [f_TopicCount,
                      CalcElapsedTime(l_StartTime, Now)]);
 Result := True;
end;

procedure TPipeDream.DoCleanFiles;
var
 i: Integer;
begin
 if CleanFiles then
 begin
  if Assigned(f_Progressor) then
  begin
    f_Progressor.Caption:= 'Копирование и удаление файлов';
    f_Progressor.Start;
    f_Progressor.Update(0, f_FileIterator.FileList.Count, 'Удаление ненужных файлов');
  end;
  try
   for i:= 0 to Pred(f_FileIterator.FileList.Count) do
   begin
     if SafeCleanDir <> '' then
     begin
       if UserDepend then
         CopyNSRCFile(f_FileIterator.FileList.Strings[i],
                      ConcatDirName(ConcatDirName(SafeCleanDir,
                                    Format('User_#%d', [UserID])),
                                    ExtractFileName(f_FileIterator.FileList.Strings[i])))
       else
         CopyNSRCFile(f_FileIterator.FileList.Strings[i], ConcatDirName(SafeCleanDir, ExtractFileName(f_FileIterator.FileList.Strings[i])));
      DeleteFile(f_FileIterator.FileList.Strings[i]);
     end
     else
       DeleteFile(f_FileIterator.FileList.Strings[i]);
      if Assigned(f_Progressor) then
      begin
        f_Progressor.Update(1, i, '');
      end;
   end; // for i
   DelDir(WorkDir);

   if Assigned(f_Progressor) then
   begin
     f_Progressor.Update(2, Pred(f_FileIterator.FileList.Count), '');
     f_Progressor.Stop;
   end; // Assigned(f_Progressor);

  except
    l3System.Msg2Log('Ошибка удаления обработанных файлов');
  end;
 end; { CleanFiles }
end;

procedure TPipeDream._SkipDocument(aDocID : TDocID; WhyFlag : TSkipDocReason;
    UserID: Longint);
var
 aUserName,aLoginName : ShortString;
 aActFlag             : Byte;
 l_Msg: String;
begin
 if UserID > -1 then
  GlobalDataProvider.UserManager.GetUserInfo(UserID, aUserName, aLoginName, aActFlag);
  { Накапливаем сообщения о пропущенных документах }
 case WhyFlag of
  srUnknown       : l_Msg:= 'Причина неизвестна';
  srAlreadyExists : l_Msg:= Format('   #%d - существует в базе', [aDocID]);
  srBusy          : l_Msg:= Format('   #%d - занят пользователем %s', [aDocID, aUserName]);
  srCantBeDeleted : l_Msg:= Format('   #%d - не прошел проверку условий удаления', [aDocID]);
  srAccessDenied  : l_Msg:= 'Не удалось удалить исходный документ';
  srNoHandle      : l_Msg:= 'Не задан номер документа';
 end; // case WhyFlag
 if f_Progressor <> nil then
  f_Progressor.AddToDialog(l_Msg);
 if Assigned(f_TopicSkip) then
  f_TopicSkip(aDocID, l_Msg);
end;


procedure TPipeDream.ClearDoneDir;
 procedure _DelFiles(const aMask: String);
 var
   SR: TSearchRec;
   H, D: Integer;
   D2: TDateTime;
   Year, Month, Day: Word;
   S: String;
 begin
   if FindFirst(ConcatDirName(DoneDir, aMask), faAnyFile, SR) = 0 then
   repeat
     S:= ConcatDirName(DoneDir, SR.Name);
     H:= FileOpen(S, fmOpenWrite or fmShareDenyNone);
     Year:= 0; Month:= 0; Day:= 0;
     try
       D:= FileGetDate(H);
       D2:= FileDateToDateTime(D);
       D2:= Date-D2;
       DecodeDate(D2, Year, Month, Day);
     finally
       FileClose(H);
     end;
     if (Year*365+Month*30+Day) > 7 then
       DeleteFile(S);
   until FindNext(SR) <> 0;
   FindClose(SR);
 end;
begin
 _DelFiles('*.nsr');
 _DelFiles('*.evd');
end;

procedure TPipeDream.AbortImport;
begin
  f_Abort:= True;
(*
  case InputFileType of
    dd_itGarant: TCustomNSRCReader(f_FileReader).StopLoading:= True;
    dd_itEverest: ;
  end; {}
*)
end;

procedure TPipeDream.AddSize(Size: Longint);
begin
 try
  if Assigned(f_Progressor) then
   f_Progressor.IncSize(Size);
 except

 end;
end;

procedure TPipeDream.AddError(Msg: String);
begin
 try
  f_ErrorLog.Add(Msg);
 except
  l3System.Msg2Log('Ошибка лога импорта');
 end;
end;

procedure TPipeDream._StartTopic(aTopicNo: Longint; aMessage: String);
var
 l_Msg : String;
begin
 if Assigned(f_TopicStart) then
  f_TopicStart(aTopicNo, '');
 f_TopicNo:= aTopicNo;
 l_Msg := Format('Начался документ № %d', [f_TopicNo]);
 if f_Progressor <> nil then
  f_Progressor.AddToDialog(l_Msg);
 l3System.Msg2Log(l_Msg);
 Inc(f_TopicCount);
end;

procedure TPipeDream._Abort(Sender: TObject);
begin
 AbortImport;
end;

procedure TPipeDream.SetWorkDir(Value: ShortString);
begin
 if f_FileIterator = nil then
  f_FileIterator:= TddFileIterator.Create(nil);
 f_FileIterator.Directory:= Value;
end;

function TPipeDream.GetWorkDir: ShortString;
begin
 if f_FileIterator = nil then
  f_FileIterator:= TddFileIterator.Create(nil);
 Result:= f_FileIterator.Directory;
end;

procedure TPipeDream.SetFileMask(aValue: String);
begin
 if f_FileIterator = nil then
  f_FileIterator:= TddFileIterator.Create(nil);
 f_FileIterator.FileMask:= aValue;
end;

function TPipeDream.GetFileMask: String;
begin
 if f_FileIterator = nil then
  f_FileIterator:= TddFileIterator.Create(nil);
 Result:= f_FileIterator.FileMask;
end;

function TPipeDream._UpdateDicts(aDictType: TdaDictionaryType; aDocID, aSubID: TSubID;
                                 aName: Tl3CustomString): Boolean;
var
 l_S: String;
begin
 if aDictType in f_NotUpdatableDicts then
 begin
  Result:= False;
  if aDictType <> da_dlNone then
   l_S:= cDLPassports[aDictType].rName
  else
   l_S:= 'Название неизвестно';
  if aSubID > 0 then
   l_S:= Format('#%d (метка #%d) - добавление элемента "%s" в словарь %s',
                  [aDocID, aSubID, aName.AsString, l_S])
  else
   l_S:= Format('#%d - добавление элемента "%s" в словарь %s',
                  [aDocID, aName.AsString, l_S]);
  AddError(l_S);
 end
 else
  Result:= True;
end;



procedure TPipeDream.AbortProcess;
begin
 AbortImport
end;

function CheckFileType(const FileList: TStrings; IsAnnotation: Boolean): TddPipeInputFileType;

 function _Check(const AExt: ShortString): Boolean;
 var
  i: Integer;
 begin
  Result := False;
  for i:= 0 to Pred(FileList.Count) do
   if AnsiEndsText(aExt, FileList.Strings[i]) then
   begin
    Result := True;
    break
   end;
 end;

begin
 if _Check('.nsr') then
  Result:= dd_itGarant
 else
 if _Check('.evd') then
  Result:= dd_itEverest
 else
 if IsAnnotation and (_Check('.rtf') or _Check('.doc')) then
  Result:= dd_itRTFAnnotation
 else
 if IsAnnotation and (_Check('.txt')) then
  Result:= dd_itTXTAnnotation
 else
  Result:= dd_itUnknown;
end;

function CheckFileType(const Directory: String; IsAnnotation: Boolean): TddPipeInputFileType;

 function _Check(const AExt: ShortString): Boolean;
 var
  SR: TSearchRec;
 begin
  Result:= FindFirst(ConcatDirName(Directory, AExt), faAnyFile, SR) = 0;
  FindClose(SR);
 end;

begin
 if _Check('*.nsr') then
  Result:= dd_itGarant
 else
 if _Check('*.evd') then
  Result:= dd_itEverest
 else
 if IsAnnotation and (_Check('*.rtf') or _Check('*.doc')) then
  Result:= dd_itRTFAnnotation
 else
 if IsAnnotation and (_Check('*.txt')) then
  Result:= dd_itTXTAnnotation
 else
  Result:= dd_itUnknown;
end;


procedure TPipeDream.CreateFileReader(aFileType : TddPipeInputFileType);
begin
 if f_FileReader = nil then
 begin
  case aFileType of
   dd_itGarant:
    begin
     f_FileReader:= TCustomNSRCReader.Create(nil);
     TCustomNSRCReader(f_FileReader).OnAddSize:= AddSize;
     TCustomNSRCReader(f_FileReader).OnError:= AddError;
     if Assigned(f_CommentWrite) then
      TCustomNSRCReader(f_FileReader).OnCommentWrite:= f_CommentWrite;
     TCustomNSRCReader(f_FileReader).WorkDir:= WorkDir;
     TCustomNSRCReader(f_FileReader).PictureDir:= PictureDir;
     TCustomNSRCReader(f_FileReader).CodePage:= GlobalDataProvider.BaseLanguage[CurrentFamily].OEMCodePage;
     TCustomNSRCReader(f_FileReader).AnsiCodePage:= GlobalDataProvider.BaseLanguage[CurrentFamily].AnsiCodePage;
    end;
   dd_itEverest,
   dd_itEverestInternal:
     f_FileReader:= TevEvdReader.Create(nil);
   dd_itRTFAnnotation,
   dd_itTXTAnnotation:
    begin
     if f_InputFileType = dd_itRTFAnnotation then
      f_FileReader := TddDocReader.Create(nil)
     else
      f_FileReader := TevTxtReader.Create(nil);
     f_AnnoFilter:= TddExtAnnotationFilter.Create(nil);
     f_FileReader.Generator := f_AnnoFilter;
    end;
   else
    exit;
  end; // case f_InputFileType;
  f_InFiler.CodePage := cp_ANSI; //сбросим CodePage, которая могла быть изменена предыдущим использованием
  f_FileReader.Filer:= f_InFiler;
  f_Generator:= f_FileReader;
  if f_InputFileType in [dd_itRTFAnnotation, dd_itTXTAnnotation] then
   f_AnnoFilter.Generator := f_Kernel
  else
   f_FileReader.Generator:= f_Kernel;
 end; // f_FileReader = nil
end;

procedure TPipeDream.DestroyFileReader;
begin
  if f_InputFileType <> dd_itUnknown then
   l3Free(f_FileReader);
  if f_InputFileType in [dd_itRTFAnnotation, dd_itTXTAnnotation] then
   l3Free(f_AnnoFilter);
end;

procedure TPipeDream.FilerAbortLoad(Sender: TObject; var Aborted: Bool);
begin
 Aborted := f_Abort;
end;

procedure TPipeDream.SetInputFileType(Value: TddPipeInputFileType);
begin
 if f_InputFileType <> Value then
 begin
  f_InputFileType:= Value;
  FileMask := ImportFileMask[f_InputFileType];
 end; // f_InputFileType <> Value
end;

procedure TPipeDream.SetProgressor(Value: TddProgressObject);
begin
 if f_Progressor <> Value then
  f_Progressor:= Value;
end;

function TPipeDream.GetIsEnglish: Boolean;
begin
 Result:= f_Kernel.IsEnglish;
end;

procedure TPipeDream.SetIsEnglish(Value: Boolean);
begin
 f_Kernel.IsEnglish:= Value;
end;

function TPipeDream.GetCheckRegion: Boolean;
begin
 Result:= f_Kernel.CheckRegion;
end;

class function TPipeDream.GetInputFileType(aFilename: String; aValidTypes:
    TddPipeInputFileTypeSet): TddPipeInputFileType;
var
 l_Ext: String;
 i: TddPipeInputFileType;
begin
 Result := dd_itUnknown;
 l_Ext := ExtractFileExt(aFileName);
 for i:= dd_itGarant to dd_itTXTAnnotation do
  if AnsiContainsText(ImportFileMask[i], l_Ext) and (i in aValidTypes) then
  begin
   Result := i;
   break
  end;
end;

function TPipeDream.pm_GetAddNewToLog: Boolean;
begin
 Result := f_Kernel.AddNewToLog;
end;

function TPipeDream.pm_GetNeedFork: Boolean;
begin
 Result := f_Kernel.NeedFork;
end;

procedure TPipeDream.pm_SetAddNewToLog(const aValue: Boolean);
begin
 f_Kernel.AddNewToLog := aValue;
end;

procedure TPipeDream.pm_SetNeedFork(const aValue: Boolean);
begin
 f_Kernel.NeedFork:= aValue;
end;

procedure TPipeDream.StartProgressor;
begin
 afw.ProcessMessages;
 if Assigned(f_Progressor) then
 begin
  f_Progressor.Caption:= 'Импорт данных';
  f_Progressor.Start(f_FileIterator.TotalSize);
  f_Progressor.OnAbort:= _Abort;
 end; // Assigned(f_Progressor);
end;

procedure TPipeDream.StopProgressor;
begin
  if Assigned(f_Progressor) then
   f_Progressor.Stop;
end;

procedure TPipeDream.SetCheckRegion(const Value: Boolean);
begin
 f_Kernel.CheckRegion:= Value;
end;

procedure TPipeDream.SetKernelParams;
begin
  f_Kernel.Family:= Family;
  f_Kernel.UpdateTables:= FinalUpdate;
  f_Kernel.CheckDocuments:= CheckDocuments;
  f_Kernel.NeedLockBase:= NeedLockBase;
  f_Kernel.DocumentReaction:= SameDocuments;
  f_Kernel.DeleteConditions := DeleteConditions;
  f_Kernel.InternalFormat:= f_InputFileType = dd_itEverestInternal;
  f_Kernel.UserID:= UserID;
  //f_Kernel.CloseStages:= CloseStages;
  f_Kernel.OnTopicStart:= _StartTopic;
  f_Kernel.OnSkipDocument:= _SkipDocument;
  f_Kernel.OnDictionaryUpdate:= _UpdateDicts;
end;

end.

