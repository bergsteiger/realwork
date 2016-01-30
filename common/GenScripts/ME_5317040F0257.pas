unit csAACImport;

// Модуль: "w:\common\components\rtl\Garant\cs\csAACImport.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csImport
 , AACImport_Const
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
   class function GetTaggedDataType: Tk2Type; override;
   constructor Create(aUserID: TUserID); override;
   procedure DoSaveTo(aStream: TStream;
    aIsPipe: Boolean); override;
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
;

function TcsAACImport.pm_GetManualMode: Boolean;
//#UC START# *8556ACDBA388_5317040F0257get_var*
//#UC END# *8556ACDBA388_5317040F0257get_var*
begin
//#UC START# *8556ACDBA388_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8556ACDBA388_5317040F0257get_impl*
end;//TcsAACImport.pm_GetManualMode

procedure TcsAACImport.pm_SetManualMode(aValue: Boolean);
//#UC START# *8556ACDBA388_5317040F0257set_var*
//#UC END# *8556ACDBA388_5317040F0257set_var*
begin
//#UC START# *8556ACDBA388_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *8556ACDBA388_5317040F0257set_impl*
end;//TcsAACImport.pm_SetManualMode

function TcsAACImport.pm_GetCreatedByServer: Boolean;
//#UC START# *64FD4DF3DD15_5317040F0257get_var*
//#UC END# *64FD4DF3DD15_5317040F0257get_var*
begin
//#UC START# *64FD4DF3DD15_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *64FD4DF3DD15_5317040F0257get_impl*
end;//TcsAACImport.pm_GetCreatedByServer

procedure TcsAACImport.pm_SetCreatedByServer(aValue: Boolean);
//#UC START# *64FD4DF3DD15_5317040F0257set_var*
//#UC END# *64FD4DF3DD15_5317040F0257set_var*
begin
//#UC START# *64FD4DF3DD15_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *64FD4DF3DD15_5317040F0257set_impl*
end;//TcsAACImport.pm_SetCreatedByServer

function TcsAACImport.pm_GetLogsFolder: AnsiString;
//#UC START# *C9E86B6EAF40_5317040F0257get_var*
//#UC END# *C9E86B6EAF40_5317040F0257get_var*
begin
//#UC START# *C9E86B6EAF40_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C9E86B6EAF40_5317040F0257get_impl*
end;//TcsAACImport.pm_GetLogsFolder

procedure TcsAACImport.pm_SetLogsFolder(const aValue: AnsiString);
//#UC START# *C9E86B6EAF40_5317040F0257set_var*
//#UC END# *C9E86B6EAF40_5317040F0257set_var*
begin
//#UC START# *C9E86B6EAF40_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *C9E86B6EAF40_5317040F0257set_impl*
end;//TcsAACImport.pm_SetLogsFolder

function TcsAACImport.pm_GetDestinationFolder: AnsiString;
//#UC START# *935741D4C254_5317040F0257get_var*
//#UC END# *935741D4C254_5317040F0257get_var*
begin
//#UC START# *935741D4C254_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *935741D4C254_5317040F0257get_impl*
end;//TcsAACImport.pm_GetDestinationFolder

procedure TcsAACImport.pm_SetDestinationFolder(const aValue: AnsiString);
//#UC START# *935741D4C254_5317040F0257set_var*
//#UC END# *935741D4C254_5317040F0257set_var*
begin
//#UC START# *935741D4C254_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *935741D4C254_5317040F0257set_impl*
end;//TcsAACImport.pm_SetDestinationFolder

function TcsAACImport.pm_GetZippedLogsFolder: AnsiString;
//#UC START# *C39BB06AEE83_5317040F0257get_var*
//#UC END# *C39BB06AEE83_5317040F0257get_var*
begin
//#UC START# *C39BB06AEE83_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C39BB06AEE83_5317040F0257get_impl*
end;//TcsAACImport.pm_GetZippedLogsFolder

procedure TcsAACImport.pm_SetZippedLogsFolder(const aValue: AnsiString);
//#UC START# *C39BB06AEE83_5317040F0257set_var*
//#UC END# *C39BB06AEE83_5317040F0257set_var*
begin
//#UC START# *C39BB06AEE83_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *C39BB06AEE83_5317040F0257set_impl*
end;//TcsAACImport.pm_SetZippedLogsFolder

function TcsAACImport.pm_GetMailToLog: AnsiString;
//#UC START# *3DAEC079F741_5317040F0257get_var*
//#UC END# *3DAEC079F741_5317040F0257get_var*
begin
//#UC START# *3DAEC079F741_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3DAEC079F741_5317040F0257get_impl*
end;//TcsAACImport.pm_GetMailToLog

procedure TcsAACImport.pm_SetMailToLog(const aValue: AnsiString);
//#UC START# *3DAEC079F741_5317040F0257set_var*
//#UC END# *3DAEC079F741_5317040F0257set_var*
begin
//#UC START# *3DAEC079F741_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3DAEC079F741_5317040F0257set_impl*
end;//TcsAACImport.pm_SetMailToLog

function TcsAACImport.pm_GetDuplicatesFolder: AnsiString;
//#UC START# *D39D5851137D_5317040F0257get_var*
//#UC END# *D39D5851137D_5317040F0257get_var*
begin
//#UC START# *D39D5851137D_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D39D5851137D_5317040F0257get_impl*
end;//TcsAACImport.pm_GetDuplicatesFolder

procedure TcsAACImport.pm_SetDuplicatesFolder(const aValue: AnsiString);
//#UC START# *D39D5851137D_5317040F0257set_var*
//#UC END# *D39D5851137D_5317040F0257set_var*
begin
//#UC START# *D39D5851137D_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D39D5851137D_5317040F0257set_impl*
end;//TcsAACImport.pm_SetDuplicatesFolder

function TcsAACImport.pm_GetLinkDataFile: AnsiString;
//#UC START# *668A1C86D75C_5317040F0257get_var*
//#UC END# *668A1C86D75C_5317040F0257get_var*
begin
//#UC START# *668A1C86D75C_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *668A1C86D75C_5317040F0257get_impl*
end;//TcsAACImport.pm_GetLinkDataFile

procedure TcsAACImport.pm_SetLinkDataFile(const aValue: AnsiString);
//#UC START# *668A1C86D75C_5317040F0257set_var*
//#UC END# *668A1C86D75C_5317040F0257set_var*
begin
//#UC START# *668A1C86D75C_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *668A1C86D75C_5317040F0257set_impl*
end;//TcsAACImport.pm_SetLinkDataFile

function TcsAACImport.pm_GetKeyThemesFile: AnsiString;
//#UC START# *7DA11EF26ECA_5317040F0257get_var*
//#UC END# *7DA11EF26ECA_5317040F0257get_var*
begin
//#UC START# *7DA11EF26ECA_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7DA11EF26ECA_5317040F0257get_impl*
end;//TcsAACImport.pm_GetKeyThemesFile

procedure TcsAACImport.pm_SetKeyThemesFile(const aValue: AnsiString);
//#UC START# *7DA11EF26ECA_5317040F0257set_var*
//#UC END# *7DA11EF26ECA_5317040F0257set_var*
begin
//#UC START# *7DA11EF26ECA_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *7DA11EF26ECA_5317040F0257set_impl*
end;//TcsAACImport.pm_SetKeyThemesFile

function TcsAACImport.pm_GetSourceIDList: SourceIDListHelper;
//#UC START# *9035D2C5EBFB_5317040F0257get_var*
//#UC END# *9035D2C5EBFB_5317040F0257get_var*
begin
//#UC START# *9035D2C5EBFB_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9035D2C5EBFB_5317040F0257get_impl*
end;//TcsAACImport.pm_GetSourceIDList

function TcsAACImport.pm_GetBaseArchiveName: AnsiString;
//#UC START# *312E8D98FCDE_5317040F0257get_var*
//#UC END# *312E8D98FCDE_5317040F0257get_var*
begin
//#UC START# *312E8D98FCDE_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *312E8D98FCDE_5317040F0257get_impl*
end;//TcsAACImport.pm_GetBaseArchiveName

procedure TcsAACImport.pm_SetBaseArchiveName(const aValue: AnsiString);
//#UC START# *312E8D98FCDE_5317040F0257set_var*
//#UC END# *312E8D98FCDE_5317040F0257set_var*
begin
//#UC START# *312E8D98FCDE_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *312E8D98FCDE_5317040F0257set_impl*
end;//TcsAACImport.pm_SetBaseArchiveName

function TcsAACImport.pm_GetDossierSourceIDList: DossierSourceIDListHelper;
//#UC START# *882FFB259B31_5317040F0257get_var*
//#UC END# *882FFB259B31_5317040F0257get_var*
begin
//#UC START# *882FFB259B31_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *882FFB259B31_5317040F0257get_impl*
end;//TcsAACImport.pm_GetDossierSourceIDList

function TcsAACImport.pm_GetMisspellsFileName: AnsiString;
//#UC START# *37380151D684_5317040F0257get_var*
//#UC END# *37380151D684_5317040F0257get_var*
begin
//#UC START# *37380151D684_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *37380151D684_5317040F0257get_impl*
end;//TcsAACImport.pm_GetMisspellsFileName

procedure TcsAACImport.pm_SetMisspellsFileName(const aValue: AnsiString);
//#UC START# *37380151D684_5317040F0257set_var*
//#UC END# *37380151D684_5317040F0257set_var*
begin
//#UC START# *37380151D684_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *37380151D684_5317040F0257set_impl*
end;//TcsAACImport.pm_SetMisspellsFileName

function TcsAACImport.pm_GetFASCorrectFileName: AnsiString;
//#UC START# *5A6581988F1C_5317040F0257get_var*
//#UC END# *5A6581988F1C_5317040F0257get_var*
begin
//#UC START# *5A6581988F1C_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5A6581988F1C_5317040F0257get_impl*
end;//TcsAACImport.pm_GetFASCorrectFileName

procedure TcsAACImport.pm_SetFASCorrectFileName(const aValue: AnsiString);
//#UC START# *5A6581988F1C_5317040F0257set_var*
//#UC END# *5A6581988F1C_5317040F0257set_var*
begin
//#UC START# *5A6581988F1C_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5A6581988F1C_5317040F0257set_impl*
end;//TcsAACImport.pm_SetFASCorrectFileName

function TcsAACImport.pm_GetDocTypesIDList: DocTypesIDListHelper;
//#UC START# *690F800534A8_5317040F0257get_var*
//#UC END# *690F800534A8_5317040F0257get_var*
begin
//#UC START# *690F800534A8_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *690F800534A8_5317040F0257get_impl*
end;//TcsAACImport.pm_GetDocTypesIDList

function TcsAACImport.pm_GetFASSourceIDList: FASSourceIDListHelper;
//#UC START# *CD07E0D87C7A_5317040F0257get_var*
//#UC END# *CD07E0D87C7A_5317040F0257get_var*
begin
//#UC START# *CD07E0D87C7A_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *CD07E0D87C7A_5317040F0257get_impl*
end;//TcsAACImport.pm_GetFASSourceIDList

function TcsAACImport.pm_GetSourceConvertFileName: AnsiString;
//#UC START# *AE660E36B8D7_5317040F0257get_var*
//#UC END# *AE660E36B8D7_5317040F0257get_var*
begin
//#UC START# *AE660E36B8D7_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *AE660E36B8D7_5317040F0257get_impl*
end;//TcsAACImport.pm_GetSourceConvertFileName

procedure TcsAACImport.pm_SetSourceConvertFileName(const aValue: AnsiString);
//#UC START# *AE660E36B8D7_5317040F0257set_var*
//#UC END# *AE660E36B8D7_5317040F0257set_var*
begin
//#UC START# *AE660E36B8D7_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *AE660E36B8D7_5317040F0257set_impl*
end;//TcsAACImport.pm_SetSourceConvertFileName

function TcsAACImport.pm_GetTypeRecodeFileName: AnsiString;
//#UC START# *71F17F64043F_5317040F0257get_var*
//#UC END# *71F17F64043F_5317040F0257get_var*
begin
//#UC START# *71F17F64043F_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *71F17F64043F_5317040F0257get_impl*
end;//TcsAACImport.pm_GetTypeRecodeFileName

procedure TcsAACImport.pm_SetTypeRecodeFileName(const aValue: AnsiString);
//#UC START# *71F17F64043F_5317040F0257set_var*
//#UC END# *71F17F64043F_5317040F0257set_var*
begin
//#UC START# *71F17F64043F_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *71F17F64043F_5317040F0257set_impl*
end;//TcsAACImport.pm_SetTypeRecodeFileName

function TcsAACImport.pm_GetSourceFileName: AnsiString;
//#UC START# *A9B421AC12B8_5317040F0257get_var*
//#UC END# *A9B421AC12B8_5317040F0257get_var*
begin
//#UC START# *A9B421AC12B8_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A9B421AC12B8_5317040F0257get_impl*
end;//TcsAACImport.pm_GetSourceFileName

procedure TcsAACImport.pm_SetSourceFileName(const aValue: AnsiString);
//#UC START# *A9B421AC12B8_5317040F0257set_var*
//#UC END# *A9B421AC12B8_5317040F0257set_var*
begin
//#UC START# *A9B421AC12B8_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *A9B421AC12B8_5317040F0257set_impl*
end;//TcsAACImport.pm_SetSourceFileName

function TcsAACImport.pm_GetPartialLoadPackSize: Integer;
//#UC START# *EA689AD3F5B8_5317040F0257get_var*
//#UC END# *EA689AD3F5B8_5317040F0257get_var*
begin
//#UC START# *EA689AD3F5B8_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *EA689AD3F5B8_5317040F0257get_impl*
end;//TcsAACImport.pm_GetPartialLoadPackSize

procedure TcsAACImport.pm_SetPartialLoadPackSize(aValue: Integer);
//#UC START# *EA689AD3F5B8_5317040F0257set_var*
//#UC END# *EA689AD3F5B8_5317040F0257set_var*
begin
//#UC START# *EA689AD3F5B8_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *EA689AD3F5B8_5317040F0257set_impl*
end;//TcsAACImport.pm_SetPartialLoadPackSize

function TcsAACImport.pm_GetCourtDecisionSabCheckerParams: Tl3Tag;
//#UC START# *EEAC3FDE87CC_5317040F0257get_var*
//#UC END# *EEAC3FDE87CC_5317040F0257get_var*
begin
//#UC START# *EEAC3FDE87CC_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *EEAC3FDE87CC_5317040F0257get_impl*
end;//TcsAACImport.pm_GetCourtDecisionSabCheckerParams

procedure TcsAACImport.pm_SetCourtDecisionSabCheckerParams(aValue: Tl3Tag);
//#UC START# *EEAC3FDE87CC_5317040F0257set_var*
//#UC END# *EEAC3FDE87CC_5317040F0257set_var*
begin
//#UC START# *EEAC3FDE87CC_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *EEAC3FDE87CC_5317040F0257set_impl*
end;//TcsAACImport.pm_SetCourtDecisionSabCheckerParams

function TcsAACImport.pm_GetTaskCountBeforeRun: Integer;
//#UC START# *FC475BE9818E_5317040F0257get_var*
//#UC END# *FC475BE9818E_5317040F0257get_var*
begin
//#UC START# *FC475BE9818E_5317040F0257get_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC475BE9818E_5317040F0257get_impl*
end;//TcsAACImport.pm_GetTaskCountBeforeRun

procedure TcsAACImport.pm_SetTaskCountBeforeRun(aValue: Integer);
//#UC START# *FC475BE9818E_5317040F0257set_var*
//#UC END# *FC475BE9818E_5317040F0257set_var*
begin
//#UC START# *FC475BE9818E_5317040F0257set_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC475BE9818E_5317040F0257set_impl*
end;//TcsAACImport.pm_SetTaskCountBeforeRun

class function TcsAACImport.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_5317040F0257_var*
//#UC END# *53AC03EE01FD_5317040F0257_var*
begin
//#UC START# *53AC03EE01FD_5317040F0257_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_5317040F0257_impl*
end;//TcsAACImport.GetTaggedDataType

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

initialization
//#UC START# *53B6C1B60033*
//#UC END# *53B6C1B60033*
{$IfEnd} // NOT Defined(Nemesis)

end.
