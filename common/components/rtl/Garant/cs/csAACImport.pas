unit csAACImport;

// Модуль: "w:\common\components\rtl\Garant\cs\csAACImport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsAACImport" MUID: (5317040F0257)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csImport
 , evdTasksHelpers
 , l3Variant
 , k2Base
 , dt_Types
 , Classes
;

type
 TcsAACImport = class(TcsImportTaskItem)
  protected
   function pm_GetManualMode: Boolean;
   procedure pm_SetManualMode(aValue: Boolean);
   function pm_GetCreatedByServer: Boolean;
   procedure pm_SetCreatedByServer(aValue: Boolean);
   function pm_GetLogsFolder: AnsiString;
   procedure pm_SetLogsFolder(const aValue: AnsiString);
   function pm_GetDestinationFolder: AnsiString;
   procedure pm_SetDestinationFolder(const aValue: AnsiString);
   function pm_GetZippedLogsFolder: AnsiString;
   procedure pm_SetZippedLogsFolder(const aValue: AnsiString);
   function pm_GetMailToLog: AnsiString;
   procedure pm_SetMailToLog(const aValue: AnsiString);
   function pm_GetDuplicatesFolder: AnsiString;
   procedure pm_SetDuplicatesFolder(const aValue: AnsiString);
   function pm_GetLinkDataFile: AnsiString;
   procedure pm_SetLinkDataFile(const aValue: AnsiString);
   function pm_GetKeyThemesFile: AnsiString;
   procedure pm_SetKeyThemesFile(const aValue: AnsiString);
   function pm_GetSourceIDList: SourceIDListHelper;
   function pm_GetBaseArchiveName: AnsiString;
   procedure pm_SetBaseArchiveName(const aValue: AnsiString);
   function pm_GetDossierSourceIDList: DossierSourceIDListHelper;
   function pm_GetMisspellsFileName: AnsiString;
   procedure pm_SetMisspellsFileName(const aValue: AnsiString);
   function pm_GetFASCorrectFileName: AnsiString;
   procedure pm_SetFASCorrectFileName(const aValue: AnsiString);
   function pm_GetDocTypesIDList: DocTypesIDListHelper;
   function pm_GetFASSourceIDList: FASSourceIDListHelper;
   function pm_GetSourceConvertFileName: AnsiString;
   procedure pm_SetSourceConvertFileName(const aValue: AnsiString);
   function pm_GetTypeRecodeFileName: AnsiString;
   procedure pm_SetTypeRecodeFileName(const aValue: AnsiString);
   function pm_GetSourceFileName: AnsiString;
   procedure pm_SetSourceFileName(const aValue: AnsiString);
   function pm_GetPartialLoadPackSize: Integer;
   procedure pm_SetPartialLoadPackSize(aValue: Integer);
   function pm_GetCourtDecisionSabCheckerParams: Tl3Tag;
   procedure pm_SetCourtDecisionSabCheckerParams(aValue: Tl3Tag);
   function pm_GetTaskCountBeforeRun: Integer;
   procedure pm_SetTaskCountBeforeRun(aValue: Integer);
   procedure DoLoadFrom(aStream: TStream;
    aIsPipe: Boolean); override;
  public
   constructor Create(aUserID: TUserID); override;
   procedure DoSaveTo(aStream: TStream;
    aIsPipe: Boolean); override;
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ManualMode: Boolean
    read pm_GetManualMode
    write pm_SetManualMode;
   property CreatedByServer: Boolean
    read pm_GetCreatedByServer
    write pm_SetCreatedByServer;
   property LogsFolder: AnsiString
    read pm_GetLogsFolder
    write pm_SetLogsFolder;
   property DestinationFolder: AnsiString
    read pm_GetDestinationFolder
    write pm_SetDestinationFolder;
   property ZippedLogsFolder: AnsiString
    read pm_GetZippedLogsFolder
    write pm_SetZippedLogsFolder;
   property MailToLog: AnsiString
    read pm_GetMailToLog
    write pm_SetMailToLog;
   property DuplicatesFolder: AnsiString
    read pm_GetDuplicatesFolder
    write pm_SetDuplicatesFolder;
   property LinkDataFile: AnsiString
    read pm_GetLinkDataFile
    write pm_SetLinkDataFile;
    {* Данные для простановки ссылок }
   property KeyThemesFile: AnsiString
    read pm_GetKeyThemesFile
    write pm_SetKeyThemesFile;
    {* Список Ключевых тем }
   property SourceIDList: SourceIDListHelper
    read pm_GetSourceIDList;
   property BaseArchiveName: AnsiString
    read pm_GetBaseArchiveName
    write pm_SetBaseArchiveName;
   property DossierSourceIDList: DossierSourceIDListHelper
    read pm_GetDossierSourceIDList;
   property MisspellsFileName: AnsiString
    read pm_GetMisspellsFileName
    write pm_SetMisspellsFileName;
   property FASCorrectFileName: AnsiString
    read pm_GetFASCorrectFileName
    write pm_SetFASCorrectFileName;
   property DocTypesIDList: DocTypesIDListHelper
    read pm_GetDocTypesIDList;
   property FASSourceIDList: FASSourceIDListHelper
    read pm_GetFASSourceIDList;
   property SourceConvertFileName: AnsiString
    read pm_GetSourceConvertFileName
    write pm_SetSourceConvertFileName;
   property TypeRecodeFileName: AnsiString
    read pm_GetTypeRecodeFileName
    write pm_SetTypeRecodeFileName;
   property SourceFileName: AnsiString
    read pm_GetSourceFileName
    write pm_SetSourceFileName;
   property PartialLoadPackSize: Integer
    read pm_GetPartialLoadPackSize
    write pm_SetPartialLoadPackSize;
   property CourtDecisionSabCheckerParams: Tl3Tag
    read pm_GetCourtDecisionSabCheckerParams
    write pm_SetCourtDecisionSabCheckerParams;
   property TaskCountBeforeRun: Integer
    read pm_GetTaskCountBeforeRun
    write pm_SetTaskCountBeforeRun;
 end;//TcsAACImport
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ddServerTask
 , AACImport_Const
;

function TcsAACImport.pm_GetManualMode: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrManualMode]);
end;//TcsAACImport.pm_GetManualMode

procedure TcsAACImport.pm_SetManualMode(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrManualMode, nil] := (aValue);
end;//TcsAACImport.pm_SetManualMode

function TcsAACImport.pm_GetCreatedByServer: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrCreatedByServer]);
end;//TcsAACImport.pm_GetCreatedByServer

procedure TcsAACImport.pm_SetCreatedByServer(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrCreatedByServer, nil] := (aValue);
end;//TcsAACImport.pm_SetCreatedByServer

function TcsAACImport.pm_GetLogsFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLogsFolder]);
end;//TcsAACImport.pm_GetLogsFolder

procedure TcsAACImport.pm_SetLogsFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrLogsFolder, nil] := (aValue);
end;//TcsAACImport.pm_SetLogsFolder

function TcsAACImport.pm_GetDestinationFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDestinationFolder]);
end;//TcsAACImport.pm_GetDestinationFolder

procedure TcsAACImport.pm_SetDestinationFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDestinationFolder, nil] := (aValue);
end;//TcsAACImport.pm_SetDestinationFolder

function TcsAACImport.pm_GetZippedLogsFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrZippedLogsFolder]);
end;//TcsAACImport.pm_GetZippedLogsFolder

procedure TcsAACImport.pm_SetZippedLogsFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrZippedLogsFolder, nil] := (aValue);
end;//TcsAACImport.pm_SetZippedLogsFolder

function TcsAACImport.pm_GetMailToLog: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailToLog]);
end;//TcsAACImport.pm_GetMailToLog

procedure TcsAACImport.pm_SetMailToLog(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMailToLog, nil] := (aValue);
end;//TcsAACImport.pm_SetMailToLog

function TcsAACImport.pm_GetDuplicatesFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDuplicatesFolder]);
end;//TcsAACImport.pm_GetDuplicatesFolder

procedure TcsAACImport.pm_SetDuplicatesFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDuplicatesFolder, nil] := (aValue);
end;//TcsAACImport.pm_SetDuplicatesFolder

function TcsAACImport.pm_GetLinkDataFile: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLinkDataFile]);
end;//TcsAACImport.pm_GetLinkDataFile

procedure TcsAACImport.pm_SetLinkDataFile(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrLinkDataFile, nil] := (aValue);
end;//TcsAACImport.pm_SetLinkDataFile

function TcsAACImport.pm_GetKeyThemesFile: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrKeyThemesFile]);
end;//TcsAACImport.pm_GetKeyThemesFile

procedure TcsAACImport.pm_SetKeyThemesFile(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrKeyThemesFile, nil] := (aValue);
end;//TcsAACImport.pm_SetKeyThemesFile

function TcsAACImport.pm_GetSourceIDList: SourceIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TSourceIDListHelper.Make(TaggedData.cAtom(k2_attrSourceIDList));
end;//TcsAACImport.pm_GetSourceIDList

function TcsAACImport.pm_GetBaseArchiveName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrBaseArchiveName]);
end;//TcsAACImport.pm_GetBaseArchiveName

procedure TcsAACImport.pm_SetBaseArchiveName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrBaseArchiveName, nil] := (aValue);
end;//TcsAACImport.pm_SetBaseArchiveName

function TcsAACImport.pm_GetDossierSourceIDList: DossierSourceIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDossierSourceIDListHelper.Make(TaggedData.cAtom(k2_attrDossierSourceIDList));
end;//TcsAACImport.pm_GetDossierSourceIDList

function TcsAACImport.pm_GetMisspellsFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMisspellsFileName]);
end;//TcsAACImport.pm_GetMisspellsFileName

procedure TcsAACImport.pm_SetMisspellsFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMisspellsFileName, nil] := (aValue);
end;//TcsAACImport.pm_SetMisspellsFileName

function TcsAACImport.pm_GetFASCorrectFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrFASCorrectFileName]);
end;//TcsAACImport.pm_GetFASCorrectFileName

procedure TcsAACImport.pm_SetFASCorrectFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrFASCorrectFileName, nil] := (aValue);
end;//TcsAACImport.pm_SetFASCorrectFileName

function TcsAACImport.pm_GetDocTypesIDList: DocTypesIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocTypesIDListHelper.Make(TaggedData.cAtom(k2_attrDocTypesIDList));
end;//TcsAACImport.pm_GetDocTypesIDList

function TcsAACImport.pm_GetFASSourceIDList: FASSourceIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TFASSourceIDListHelper.Make(TaggedData.cAtom(k2_attrFASSourceIDList));
end;//TcsAACImport.pm_GetFASSourceIDList

function TcsAACImport.pm_GetSourceConvertFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSourceConvertFileName]);
end;//TcsAACImport.pm_GetSourceConvertFileName

procedure TcsAACImport.pm_SetSourceConvertFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSourceConvertFileName, nil] := (aValue);
end;//TcsAACImport.pm_SetSourceConvertFileName

function TcsAACImport.pm_GetTypeRecodeFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTypeRecodeFileName]);
end;//TcsAACImport.pm_GetTypeRecodeFileName

procedure TcsAACImport.pm_SetTypeRecodeFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTypeRecodeFileName, nil] := (aValue);
end;//TcsAACImport.pm_SetTypeRecodeFileName

function TcsAACImport.pm_GetSourceFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSourceFileName]);
end;//TcsAACImport.pm_GetSourceFileName

procedure TcsAACImport.pm_SetSourceFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSourceFileName, nil] := (aValue);
end;//TcsAACImport.pm_SetSourceFileName

function TcsAACImport.pm_GetPartialLoadPackSize: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrPartialLoadPackSize]);
end;//TcsAACImport.pm_GetPartialLoadPackSize

procedure TcsAACImport.pm_SetPartialLoadPackSize(aValue: Integer);
begin
 TaggedData.IntW[k2_attrPartialLoadPackSize, nil] := (aValue);
end;//TcsAACImport.pm_SetPartialLoadPackSize

function TcsAACImport.pm_GetCourtDecisionSabCheckerParams: Tl3Tag;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Attr[k2_attrCourtDecisionSabCheckerParams]);
end;//TcsAACImport.pm_GetCourtDecisionSabCheckerParams

procedure TcsAACImport.pm_SetCourtDecisionSabCheckerParams(aValue: Tl3Tag);
begin
 TaggedData.AttrW[k2_attrCourtDecisionSabCheckerParams, nil] := (aValue);
end;//TcsAACImport.pm_SetCourtDecisionSabCheckerParams

function TcsAACImport.pm_GetTaskCountBeforeRun: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrTaskCountBeforeRun]);
end;//TcsAACImport.pm_GetTaskCountBeforeRun

procedure TcsAACImport.pm_SetTaskCountBeforeRun(aValue: Integer);
begin
 TaggedData.IntW[k2_attrTaskCountBeforeRun, nil] := (aValue);
end;//TcsAACImport.pm_SetTaskCountBeforeRun

constructor TcsAACImport.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_5317040F0257_var*
//#UC END# *53B3D8A8011F_5317040F0257_var*
begin
//#UC START# *53B3D8A8011F_5317040F0257_impl*
 inherited;
 VersionW := 2;
//#UC END# *53B3D8A8011F_5317040F0257_impl*
end;//TcsAACImport.Create

procedure TcsAACImport.DoSaveTo(aStream: TStream;
 aIsPipe: Boolean);
//#UC START# *53E481990243_5317040F0257_var*
//#UC END# *53E481990243_5317040F0257_var*
begin
//#UC START# *53E481990243_5317040F0257_impl*
 inherited;
 if Version > 1 then
 begin
  WriteBoolean(aStream, ManualMode);
 end;
//#UC END# *53E481990243_5317040F0257_impl*
end;//TcsAACImport.DoSaveTo

procedure TcsAACImport.DoLoadFrom(aStream: TStream;
 aIsPipe: Boolean);
//#UC START# *53E481DF03D1_5317040F0257_var*
//#UC END# *53E481DF03D1_5317040F0257_var*
begin
//#UC START# *53E481DF03D1_5317040F0257_impl*
 inherited;
 if Version > 1 then
  ManualMode := ReadBoolean(aStream);
//#UC END# *53E481DF03D1_5317040F0257_impl*
end;//TcsAACImport.DoLoadFrom

class function TcsAACImport.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAACImport;
end;//TcsAACImport.GetTaggedDataType

initialization
//#UC START# *53B6C1B60033*
//#UC END# *53B6C1B60033*
{$IfEnd} // NOT Defined(Nemesis)

end.
