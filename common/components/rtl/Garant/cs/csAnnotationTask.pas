unit csAnnotationTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csAnnotationTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsAnnotationTask" MUID: (53B6A4F300DE)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , evdTasksHelpers
 , k2Base
;

type
 TcsAnnotationTask = class(TddProcessTask)
  protected
   function pm_GetNeedAnalyzeLog: Boolean;
   procedure pm_SetNeedAnalyzeLog(aValue: Boolean);
   function pm_GetTargetFolder: AnsiString;
   procedure pm_SetTargetFolder(const aValue: AnsiString);
   function pm_GeteMailNotifyList: AnsiString;
   procedure pm_SeteMailNotifyList(const aValue: AnsiString);
   function pm_GetExternalProcessor: AnsiString;
   procedure pm_SetExternalProcessor(const aValue: AnsiString);
   function pm_GetOutFolder: AnsiString;
   procedure pm_SetOutFolder(const aValue: AnsiString);
   function pm_GetPrimeRobotEMail: AnsiString;
   procedure pm_SetPrimeRobotEMail(const aValue: AnsiString);
   function pm_GetExportDocuments: Boolean;
   procedure pm_SetExportDocuments(aValue: Boolean);
   function pm_GetDocListFileName: AnsiString;
   procedure pm_SetDocListFileName(const aValue: AnsiString);
   function pm_GetDocListFolder: AnsiString;
   procedure pm_SetDocListFolder(const aValue: AnsiString);
   function pm_GetEndDateKind: Integer;
   procedure pm_SetEndDateKind(aValue: Integer);
   function pm_GetStartDate: TDateTime;
   procedure pm_SetStartDate(aValue: TDateTime);
   function pm_GetBelongsIDList: BelongsIDListHelper;
   {$If NOT Defined(Region)}
   function pm_GetExcludeAccGroupsIDList: ExcludeAccGroupsIDListHelper;
   {$IfEnd} // NOT Defined(Region)
   function pm_GetAccGroupsIDList: AccGroupsIDListHelper;
   function pm_GetCommentsIDList: CommentsIDListHelper;
   function pm_GetExcludeDocTypesIDList: ExcludeDocTypesIDListHelper;
   function pm_GetExcludeDocBasesIDList: ExcludeDocBasesIDListHelper;
   function pm_GetAnnoFilenameTemplate: AnsiString;
   procedure pm_SetAnnoFilenameTemplate(const aValue: AnsiString);
   function GetDescription: AnsiString; override;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property NeedAnalyzeLog: Boolean
    read pm_GetNeedAnalyzeLog
    write pm_SetNeedAnalyzeLog;
   property TargetFolder: AnsiString
    read pm_GetTargetFolder
    write pm_SetTargetFolder;
   property eMailNotifyList: AnsiString
    read pm_GeteMailNotifyList
    write pm_SeteMailNotifyList;
   property ExternalProcessor: AnsiString
    read pm_GetExternalProcessor
    write pm_SetExternalProcessor;
   property OutFolder: AnsiString
    read pm_GetOutFolder
    write pm_SetOutFolder;
   property PrimeRobotEMail: AnsiString
    read pm_GetPrimeRobotEMail
    write pm_SetPrimeRobotEMail;
   property ExportDocuments: Boolean
    read pm_GetExportDocuments
    write pm_SetExportDocuments;
   property DocListFileName: AnsiString
    read pm_GetDocListFileName
    write pm_SetDocListFileName;
   property DocListFolder: AnsiString
    read pm_GetDocListFolder
    write pm_SetDocListFolder;
   property EndDateKind: Integer
    read pm_GetEndDateKind
    write pm_SetEndDateKind;
   property StartDate: TDateTime
    read pm_GetStartDate
    write pm_SetStartDate;
   property BelongsIDList: BelongsIDListHelper
    read pm_GetBelongsIDList;
   {$If NOT Defined(Region)}
   property ExcludeAccGroupsIDList: ExcludeAccGroupsIDListHelper
    read pm_GetExcludeAccGroupsIDList;
   {$IfEnd} // NOT Defined(Region)
   property AccGroupsIDList: AccGroupsIDListHelper
    read pm_GetAccGroupsIDList;
   property CommentsIDList: CommentsIDListHelper
    read pm_GetCommentsIDList;
   property ExcludeDocTypesIDList: ExcludeDocTypesIDListHelper
    read pm_GetExcludeDocTypesIDList;
   property ExcludeDocBasesIDList: ExcludeDocBasesIDListHelper
    read pm_GetExcludeDocBasesIDList;
   property AnnoFilenameTemplate: AnsiString
    read pm_GetAnnoFilenameTemplate
    write pm_SetAnnoFilenameTemplate;
 end;//TcsAnnotationTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , AnnotationTask_Const
;

function TcsAnnotationTask.pm_GetNeedAnalyzeLog: Boolean;
//#UC START# *1F601DCE4A3F_53B6A4F300DEget_var*
//#UC END# *1F601DCE4A3F_53B6A4F300DEget_var*
begin
//#UC START# *1F601DCE4A3F_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1F601DCE4A3F_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetNeedAnalyzeLog

procedure TcsAnnotationTask.pm_SetNeedAnalyzeLog(aValue: Boolean);
//#UC START# *1F601DCE4A3F_53B6A4F300DEset_var*
//#UC END# *1F601DCE4A3F_53B6A4F300DEset_var*
begin
//#UC START# *1F601DCE4A3F_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *1F601DCE4A3F_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetNeedAnalyzeLog

function TcsAnnotationTask.pm_GetTargetFolder: AnsiString;
//#UC START# *CA6CDE6F7B4E_53B6A4F300DEget_var*
//#UC END# *CA6CDE6F7B4E_53B6A4F300DEget_var*
begin
//#UC START# *CA6CDE6F7B4E_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *CA6CDE6F7B4E_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetTargetFolder

procedure TcsAnnotationTask.pm_SetTargetFolder(const aValue: AnsiString);
//#UC START# *CA6CDE6F7B4E_53B6A4F300DEset_var*
//#UC END# *CA6CDE6F7B4E_53B6A4F300DEset_var*
begin
//#UC START# *CA6CDE6F7B4E_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *CA6CDE6F7B4E_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetTargetFolder

function TcsAnnotationTask.pm_GeteMailNotifyList: AnsiString;
//#UC START# *FAE514267827_53B6A4F300DEget_var*
//#UC END# *FAE514267827_53B6A4F300DEget_var*
begin
//#UC START# *FAE514267827_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *FAE514267827_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GeteMailNotifyList

procedure TcsAnnotationTask.pm_SeteMailNotifyList(const aValue: AnsiString);
//#UC START# *FAE514267827_53B6A4F300DEset_var*
//#UC END# *FAE514267827_53B6A4F300DEset_var*
begin
//#UC START# *FAE514267827_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *FAE514267827_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SeteMailNotifyList

function TcsAnnotationTask.pm_GetExternalProcessor: AnsiString;
//#UC START# *B477D597CC89_53B6A4F300DEget_var*
//#UC END# *B477D597CC89_53B6A4F300DEget_var*
begin
//#UC START# *B477D597CC89_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *B477D597CC89_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetExternalProcessor

procedure TcsAnnotationTask.pm_SetExternalProcessor(const aValue: AnsiString);
//#UC START# *B477D597CC89_53B6A4F300DEset_var*
//#UC END# *B477D597CC89_53B6A4F300DEset_var*
begin
//#UC START# *B477D597CC89_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *B477D597CC89_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetExternalProcessor

function TcsAnnotationTask.pm_GetOutFolder: AnsiString;
//#UC START# *BCEE2ED614AC_53B6A4F300DEget_var*
//#UC END# *BCEE2ED614AC_53B6A4F300DEget_var*
begin
//#UC START# *BCEE2ED614AC_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *BCEE2ED614AC_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetOutFolder

procedure TcsAnnotationTask.pm_SetOutFolder(const aValue: AnsiString);
//#UC START# *BCEE2ED614AC_53B6A4F300DEset_var*
//#UC END# *BCEE2ED614AC_53B6A4F300DEset_var*
begin
//#UC START# *BCEE2ED614AC_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *BCEE2ED614AC_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetOutFolder

function TcsAnnotationTask.pm_GetPrimeRobotEMail: AnsiString;
//#UC START# *9EEA6F3A1B4C_53B6A4F300DEget_var*
//#UC END# *9EEA6F3A1B4C_53B6A4F300DEget_var*
begin
//#UC START# *9EEA6F3A1B4C_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *9EEA6F3A1B4C_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetPrimeRobotEMail

procedure TcsAnnotationTask.pm_SetPrimeRobotEMail(const aValue: AnsiString);
//#UC START# *9EEA6F3A1B4C_53B6A4F300DEset_var*
//#UC END# *9EEA6F3A1B4C_53B6A4F300DEset_var*
begin
//#UC START# *9EEA6F3A1B4C_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *9EEA6F3A1B4C_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetPrimeRobotEMail

function TcsAnnotationTask.pm_GetExportDocuments: Boolean;
//#UC START# *825B22688897_53B6A4F300DEget_var*
//#UC END# *825B22688897_53B6A4F300DEget_var*
begin
//#UC START# *825B22688897_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *825B22688897_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetExportDocuments

procedure TcsAnnotationTask.pm_SetExportDocuments(aValue: Boolean);
//#UC START# *825B22688897_53B6A4F300DEset_var*
//#UC END# *825B22688897_53B6A4F300DEset_var*
begin
//#UC START# *825B22688897_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *825B22688897_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetExportDocuments

function TcsAnnotationTask.pm_GetDocListFileName: AnsiString;
//#UC START# *567746EE09DC_53B6A4F300DEget_var*
//#UC END# *567746EE09DC_53B6A4F300DEget_var*
begin
//#UC START# *567746EE09DC_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *567746EE09DC_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetDocListFileName

procedure TcsAnnotationTask.pm_SetDocListFileName(const aValue: AnsiString);
//#UC START# *567746EE09DC_53B6A4F300DEset_var*
//#UC END# *567746EE09DC_53B6A4F300DEset_var*
begin
//#UC START# *567746EE09DC_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *567746EE09DC_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetDocListFileName

function TcsAnnotationTask.pm_GetDocListFolder: AnsiString;
//#UC START# *C48CF8712E07_53B6A4F300DEget_var*
//#UC END# *C48CF8712E07_53B6A4F300DEget_var*
begin
//#UC START# *C48CF8712E07_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *C48CF8712E07_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetDocListFolder

procedure TcsAnnotationTask.pm_SetDocListFolder(const aValue: AnsiString);
//#UC START# *C48CF8712E07_53B6A4F300DEset_var*
//#UC END# *C48CF8712E07_53B6A4F300DEset_var*
begin
//#UC START# *C48CF8712E07_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *C48CF8712E07_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetDocListFolder

function TcsAnnotationTask.pm_GetEndDateKind: Integer;
//#UC START# *6381E44B2E08_53B6A4F300DEget_var*
//#UC END# *6381E44B2E08_53B6A4F300DEget_var*
begin
//#UC START# *6381E44B2E08_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *6381E44B2E08_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetEndDateKind

procedure TcsAnnotationTask.pm_SetEndDateKind(aValue: Integer);
//#UC START# *6381E44B2E08_53B6A4F300DEset_var*
//#UC END# *6381E44B2E08_53B6A4F300DEset_var*
begin
//#UC START# *6381E44B2E08_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *6381E44B2E08_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetEndDateKind

function TcsAnnotationTask.pm_GetStartDate: TDateTime;
//#UC START# *8A1E0AE8CB7B_53B6A4F300DEget_var*
//#UC END# *8A1E0AE8CB7B_53B6A4F300DEget_var*
begin
//#UC START# *8A1E0AE8CB7B_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *8A1E0AE8CB7B_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetStartDate

procedure TcsAnnotationTask.pm_SetStartDate(aValue: TDateTime);
//#UC START# *8A1E0AE8CB7B_53B6A4F300DEset_var*
//#UC END# *8A1E0AE8CB7B_53B6A4F300DEset_var*
begin
//#UC START# *8A1E0AE8CB7B_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *8A1E0AE8CB7B_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetStartDate

function TcsAnnotationTask.pm_GetBelongsIDList: BelongsIDListHelper;
//#UC START# *5D3ADD07A946_53B6A4F300DEget_var*
//#UC END# *5D3ADD07A946_53B6A4F300DEget_var*
begin
//#UC START# *5D3ADD07A946_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5D3ADD07A946_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetBelongsIDList

{$If NOT Defined(Region)}
function TcsAnnotationTask.pm_GetExcludeAccGroupsIDList: ExcludeAccGroupsIDListHelper;
//#UC START# *6707D6197BF1_53B6A4F300DEget_var*
//#UC END# *6707D6197BF1_53B6A4F300DEget_var*
begin
//#UC START# *6707D6197BF1_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *6707D6197BF1_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetExcludeAccGroupsIDList
{$IfEnd} // NOT Defined(Region)

function TcsAnnotationTask.pm_GetAccGroupsIDList: AccGroupsIDListHelper;
//#UC START# *EA8E68593727_53B6A4F300DEget_var*
//#UC END# *EA8E68593727_53B6A4F300DEget_var*
begin
//#UC START# *EA8E68593727_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *EA8E68593727_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetAccGroupsIDList

function TcsAnnotationTask.pm_GetCommentsIDList: CommentsIDListHelper;
//#UC START# *233505BF6553_53B6A4F300DEget_var*
//#UC END# *233505BF6553_53B6A4F300DEget_var*
begin
//#UC START# *233505BF6553_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *233505BF6553_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetCommentsIDList

function TcsAnnotationTask.pm_GetExcludeDocTypesIDList: ExcludeDocTypesIDListHelper;
//#UC START# *EADD467C12D8_53B6A4F300DEget_var*
//#UC END# *EADD467C12D8_53B6A4F300DEget_var*
begin
//#UC START# *EADD467C12D8_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *EADD467C12D8_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetExcludeDocTypesIDList

function TcsAnnotationTask.pm_GetExcludeDocBasesIDList: ExcludeDocBasesIDListHelper;
//#UC START# *D68C918F0216_53B6A4F300DEget_var*
//#UC END# *D68C918F0216_53B6A4F300DEget_var*
begin
//#UC START# *D68C918F0216_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D68C918F0216_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetExcludeDocBasesIDList

function TcsAnnotationTask.pm_GetAnnoFilenameTemplate: AnsiString;
//#UC START# *4CB23D5CE07C_53B6A4F300DEget_var*
//#UC END# *4CB23D5CE07C_53B6A4F300DEget_var*
begin
//#UC START# *4CB23D5CE07C_53B6A4F300DEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CB23D5CE07C_53B6A4F300DEget_impl*
end;//TcsAnnotationTask.pm_GetAnnoFilenameTemplate

procedure TcsAnnotationTask.pm_SetAnnoFilenameTemplate(const aValue: AnsiString);
//#UC START# *4CB23D5CE07C_53B6A4F300DEset_var*
//#UC END# *4CB23D5CE07C_53B6A4F300DEset_var*
begin
//#UC START# *4CB23D5CE07C_53B6A4F300DEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CB23D5CE07C_53B6A4F300DEset_impl*
end;//TcsAnnotationTask.pm_SetAnnoFilenameTemplate

class function TcsAnnotationTask.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B6A4F300DE_var*
//#UC END# *53AC03EE01FD_53B6A4F300DE_var*
begin
//#UC START# *53AC03EE01FD_53B6A4F300DE_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B6A4F300DE_impl*
end;//TcsAnnotationTask.GetTaggedDataType

function TcsAnnotationTask.GetDescription: AnsiString;
//#UC START# *53FB28170339_53B6A4F300DE_var*
//#UC END# *53FB28170339_53B6A4F300DE_var*
begin
//#UC START# *53FB28170339_53B6A4F300DE_impl*
 Result := 'Экспорт Прайм';
//#UC END# *53FB28170339_53B6A4F300DE_impl*
end;//TcsAnnotationTask.GetDescription
{$IfEnd} // NOT Defined(Nemesis)

end.
