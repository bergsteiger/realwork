unit alcuAutoExportTaskPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoExportTaskPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , AutoExportTask_Const
 , evdDTTypes
 , evdTasksHelpers
 , k2Base
;

type
 TalcuAutoExportTaskPrim = class(TddProcessTask)
  protected
   function pm_GetToday: TDateTime;
   procedure pm_SetToday(aValue: TDateTime);
   function pm_GetCompileDate: TDateTime;
   procedure pm_SetCompileDate(aValue: TDateTime);
   function pm_GetVersionDate: TDateTime;
   procedure pm_SetVersionDate(aValue: TDateTime);
   function pm_GetOutFormat: TepSupportFileType;
   procedure pm_SetOutFormat(aValue: TepSupportFileType);
   function pm_GetAnnoUseAccGroups: Boolean;
   procedure pm_SetAnnoUseAccGroups(aValue: Boolean);
   function pm_GetDocumentsSource: TaeDocSource;
   procedure pm_SetDocumentsSource(aValue: TaeDocSource);
   function pm_GetWithEditions: Boolean;
   procedure pm_SetWithEditions(aValue: Boolean);
   function pm_GetAccGroupsIDList: AccGroupsIDListHelper;
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   function pm_GetAnnoTemplate: AnsiString;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   procedure pm_SetAnnoTemplate(const aValue: AnsiString);
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   function pm_GetBasesIDList: BasesIDListHelper;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   function pm_GetChangedDocTemplate: AnsiString;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   procedure pm_SetChangedDocTemplate(const aValue: AnsiString);
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   function pm_GetChangedRelTempate: AnsiString;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   procedure pm_SetChangedRelTempate(const aValue: AnsiString);
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   function pm_GetExecName: AnsiString;
   procedure pm_SetExecName(const aValue: AnsiString);
   function pm_GetExecParams: AnsiString;
   procedure pm_SetExecParams(const aValue: AnsiString);
   function pm_GetDocQueryFileName: AnsiString;
   procedure pm_SetDocQueryFileName(const aValue: AnsiString);
   {$If NOT Defined(AEByBelongs)}
   function pm_GetDoneFileName: AnsiString;
   {$IfEnd} // NOT Defined(AEByBelongs)
   {$If NOT Defined(AEByBelongs)}
   procedure pm_SetDoneFileName(const aValue: AnsiString);
   {$IfEnd} // NOT Defined(AEByBelongs)
   function pm_GetExportFolder: AnsiString;
   procedure pm_SetExportFolder(const aValue: AnsiString);
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   function pm_GetIncludedDocTemplate: AnsiString;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   procedure pm_SetIncludedDocTemplate(const aValue: AnsiString);
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   function pm_GetIncludedRelTemplate: AnsiString;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   procedure pm_SetIncludedRelTemplate(const aValue: AnsiString);
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   function pm_GetInfoDocTemplate: AnsiString;
   procedure pm_SetInfoDocTemplate(const aValue: AnsiString);
   function pm_GetInfoIDList: InfoIDListHelper;
   function pm_GetInfoRelTemplate: AnsiString;
   procedure pm_SetInfoRelTemplate(const aValue: AnsiString);
   function pm_GetNeedTopicList: Boolean;
   procedure pm_SetNeedTopicList(aValue: Boolean);
   function pm_GeteMailNotifyList: AnsiString;
   procedure pm_SeteMailNotifyList(const aValue: AnsiString);
   function pm_GetSMSNotifyList: AnsiString;
   procedure pm_SetSMSNotifyList(const aValue: AnsiString);
   function pm_GetPartSize: Integer;
   procedure pm_SetPartSize(aValue: Integer);
   function pm_GetMaxExportCount: Integer;
   procedure pm_SetMaxExportCount(aValue: Integer);
   function pm_GetStages: TaeStagesSet;
   procedure pm_SetStages(aValue: TaeStagesSet);
   function pm_GetExpandEditions: Boolean;
   procedure pm_SetExpandEditions(aValue: Boolean);
   function pm_GetInfoDocsIncludedOnly: Boolean;
   procedure pm_SetInfoDocsIncludedOnly(aValue: Boolean);
   {$If NOT Defined(Nemesis)}
   function GetDescription: AnsiString; override;
   {$IfEnd} // NOT Defined(Nemesis)
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Today: TDateTime
    read pm_GetToday
    write pm_SetToday;
   property CompileDate: TDateTime
    read pm_GetCompileDate
    write pm_SetCompileDate;
   property VersionDate: TDateTime
    read pm_GetVersionDate
    write pm_SetVersionDate;
   property OutFormat: TepSupportFileType
    read pm_GetOutFormat
    write pm_SetOutFormat;
   property AnnoUseAccGroups: Boolean
    read pm_GetAnnoUseAccGroups
    write pm_SetAnnoUseAccGroups;
   property DocumentsSource: TaeDocSource
    read pm_GetDocumentsSource
    write pm_SetDocumentsSource;
   property WithEditions: Boolean
    read pm_GetWithEditions
    write pm_SetWithEditions;
   property AccGroupsIDList: AccGroupsIDListHelper
    read pm_GetAccGroupsIDList;
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   property AnnoTemplate: AnsiString
    read pm_GetAnnoTemplate
    write pm_SetAnnoTemplate;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   property BasesIDList: BasesIDListHelper
    read pm_GetBasesIDList;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   property ChangedDocTemplate: AnsiString
    read pm_GetChangedDocTemplate
    write pm_SetChangedDocTemplate;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   property ChangedRelTempate: AnsiString
    read pm_GetChangedRelTempate
    write pm_SetChangedRelTempate;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   property ExecName: AnsiString
    read pm_GetExecName
    write pm_SetExecName;
   property ExecParams: AnsiString
    read pm_GetExecParams
    write pm_SetExecParams;
   property DocQueryFileName: AnsiString
    read pm_GetDocQueryFileName
    write pm_SetDocQueryFileName;
   {$If NOT Defined(AEByBelongs)}
   property DoneFileName: AnsiString
    read pm_GetDoneFileName
    write pm_SetDoneFileName;
   {$IfEnd} // NOT Defined(AEByBelongs)
   property ExportFolder: AnsiString
    read pm_GetExportFolder
    write pm_SetExportFolder;
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   property IncludedDocTemplate: AnsiString
    read pm_GetIncludedDocTemplate
    write pm_SetIncludedDocTemplate;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   {$If NOT Defined(LUK) AND NOT Defined(SGC)}
   property IncludedRelTemplate: AnsiString
    read pm_GetIncludedRelTemplate
    write pm_SetIncludedRelTemplate;
   {$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)
   property InfoDocTemplate: AnsiString
    read pm_GetInfoDocTemplate
    write pm_SetInfoDocTemplate;
   property InfoIDList: InfoIDListHelper
    read pm_GetInfoIDList;
   property InfoRelTemplate: AnsiString
    read pm_GetInfoRelTemplate
    write pm_SetInfoRelTemplate;
   property NeedTopicList: Boolean
    read pm_GetNeedTopicList
    write pm_SetNeedTopicList;
   property eMailNotifyList: AnsiString
    read pm_GeteMailNotifyList
    write pm_SeteMailNotifyList;
   property SMSNotifyList: AnsiString
    read pm_GetSMSNotifyList
    write pm_SetSMSNotifyList;
   property PartSize: Integer
    read pm_GetPartSize
    write pm_SetPartSize;
   property MaxExportCount: Integer
    read pm_GetMaxExportCount
    write pm_SetMaxExportCount;
   property Stages: TaeStagesSet
    read pm_GetStages
    write pm_SetStages;
   property ExpandEditions: Boolean
    read pm_GetExpandEditions
    write pm_SetExpandEditions;
   property InfoDocsIncludedOnly: Boolean
    read pm_GetInfoDocsIncludedOnly
    write pm_SetInfoDocsIncludedOnly;
 end;//TalcuAutoExportTaskPrim
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;

function TalcuAutoExportTaskPrim.pm_GetToday: TDateTime;
//#UC START# *72D12E8AD850_53B6A5FA0212get_var*
//#UC END# *72D12E8AD850_53B6A5FA0212get_var*
begin
//#UC START# *72D12E8AD850_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *72D12E8AD850_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetToday

procedure TalcuAutoExportTaskPrim.pm_SetToday(aValue: TDateTime);
//#UC START# *72D12E8AD850_53B6A5FA0212set_var*
//#UC END# *72D12E8AD850_53B6A5FA0212set_var*
begin
//#UC START# *72D12E8AD850_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *72D12E8AD850_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetToday

function TalcuAutoExportTaskPrim.pm_GetCompileDate: TDateTime;
//#UC START# *ED9E24C9A590_53B6A5FA0212get_var*
//#UC END# *ED9E24C9A590_53B6A5FA0212get_var*
begin
//#UC START# *ED9E24C9A590_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *ED9E24C9A590_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetCompileDate

procedure TalcuAutoExportTaskPrim.pm_SetCompileDate(aValue: TDateTime);
//#UC START# *ED9E24C9A590_53B6A5FA0212set_var*
//#UC END# *ED9E24C9A590_53B6A5FA0212set_var*
begin
//#UC START# *ED9E24C9A590_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *ED9E24C9A590_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetCompileDate

function TalcuAutoExportTaskPrim.pm_GetVersionDate: TDateTime;
//#UC START# *6414746F7355_53B6A5FA0212get_var*
//#UC END# *6414746F7355_53B6A5FA0212get_var*
begin
//#UC START# *6414746F7355_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *6414746F7355_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetVersionDate

procedure TalcuAutoExportTaskPrim.pm_SetVersionDate(aValue: TDateTime);
//#UC START# *6414746F7355_53B6A5FA0212set_var*
//#UC END# *6414746F7355_53B6A5FA0212set_var*
begin
//#UC START# *6414746F7355_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *6414746F7355_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetVersionDate

function TalcuAutoExportTaskPrim.pm_GetOutFormat: TepSupportFileType;
//#UC START# *94480B7D3AE9_53B6A5FA0212get_var*
//#UC END# *94480B7D3AE9_53B6A5FA0212get_var*
begin
//#UC START# *94480B7D3AE9_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *94480B7D3AE9_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetOutFormat

procedure TalcuAutoExportTaskPrim.pm_SetOutFormat(aValue: TepSupportFileType);
//#UC START# *94480B7D3AE9_53B6A5FA0212set_var*
//#UC END# *94480B7D3AE9_53B6A5FA0212set_var*
begin
//#UC START# *94480B7D3AE9_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *94480B7D3AE9_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetOutFormat

function TalcuAutoExportTaskPrim.pm_GetAnnoUseAccGroups: Boolean;
//#UC START# *0F53694021EC_53B6A5FA0212get_var*
//#UC END# *0F53694021EC_53B6A5FA0212get_var*
begin
//#UC START# *0F53694021EC_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0F53694021EC_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetAnnoUseAccGroups

procedure TalcuAutoExportTaskPrim.pm_SetAnnoUseAccGroups(aValue: Boolean);
//#UC START# *0F53694021EC_53B6A5FA0212set_var*
//#UC END# *0F53694021EC_53B6A5FA0212set_var*
begin
//#UC START# *0F53694021EC_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *0F53694021EC_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetAnnoUseAccGroups

function TalcuAutoExportTaskPrim.pm_GetDocumentsSource: TaeDocSource;
//#UC START# *67A11CF12F48_53B6A5FA0212get_var*
//#UC END# *67A11CF12F48_53B6A5FA0212get_var*
begin
//#UC START# *67A11CF12F48_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *67A11CF12F48_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetDocumentsSource

procedure TalcuAutoExportTaskPrim.pm_SetDocumentsSource(aValue: TaeDocSource);
//#UC START# *67A11CF12F48_53B6A5FA0212set_var*
//#UC END# *67A11CF12F48_53B6A5FA0212set_var*
begin
//#UC START# *67A11CF12F48_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *67A11CF12F48_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetDocumentsSource

function TalcuAutoExportTaskPrim.pm_GetWithEditions: Boolean;
//#UC START# *1D3E1AFBB1AA_53B6A5FA0212get_var*
//#UC END# *1D3E1AFBB1AA_53B6A5FA0212get_var*
begin
//#UC START# *1D3E1AFBB1AA_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1D3E1AFBB1AA_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetWithEditions

procedure TalcuAutoExportTaskPrim.pm_SetWithEditions(aValue: Boolean);
//#UC START# *1D3E1AFBB1AA_53B6A5FA0212set_var*
//#UC END# *1D3E1AFBB1AA_53B6A5FA0212set_var*
begin
//#UC START# *1D3E1AFBB1AA_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1D3E1AFBB1AA_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetWithEditions

function TalcuAutoExportTaskPrim.pm_GetAccGroupsIDList: AccGroupsIDListHelper;
//#UC START# *2D53CAC91C0A_53B6A5FA0212get_var*
//#UC END# *2D53CAC91C0A_53B6A5FA0212get_var*
begin
//#UC START# *2D53CAC91C0A_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2D53CAC91C0A_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetAccGroupsIDList

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetAnnoTemplate: AnsiString;
//#UC START# *3F7021CCF760_53B6A5FA0212get_var*
//#UC END# *3F7021CCF760_53B6A5FA0212get_var*
begin
//#UC START# *3F7021CCF760_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3F7021CCF760_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetAnnoTemplate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetAnnoTemplate(const aValue: AnsiString);
//#UC START# *3F7021CCF760_53B6A5FA0212set_var*
//#UC END# *3F7021CCF760_53B6A5FA0212set_var*
begin
//#UC START# *3F7021CCF760_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3F7021CCF760_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetAnnoTemplate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetBasesIDList: BasesIDListHelper;
//#UC START# *BB2E4495415F_53B6A5FA0212get_var*
//#UC END# *BB2E4495415F_53B6A5FA0212get_var*
begin
//#UC START# *BB2E4495415F_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *BB2E4495415F_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetBasesIDList
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetChangedDocTemplate: AnsiString;
//#UC START# *12A47F6A5A99_53B6A5FA0212get_var*
//#UC END# *12A47F6A5A99_53B6A5FA0212get_var*
begin
//#UC START# *12A47F6A5A99_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *12A47F6A5A99_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetChangedDocTemplate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetChangedDocTemplate(const aValue: AnsiString);
//#UC START# *12A47F6A5A99_53B6A5FA0212set_var*
//#UC END# *12A47F6A5A99_53B6A5FA0212set_var*
begin
//#UC START# *12A47F6A5A99_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *12A47F6A5A99_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetChangedDocTemplate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetChangedRelTempate: AnsiString;
//#UC START# *3299499C644F_53B6A5FA0212get_var*
//#UC END# *3299499C644F_53B6A5FA0212get_var*
begin
//#UC START# *3299499C644F_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3299499C644F_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetChangedRelTempate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetChangedRelTempate(const aValue: AnsiString);
//#UC START# *3299499C644F_53B6A5FA0212set_var*
//#UC END# *3299499C644F_53B6A5FA0212set_var*
begin
//#UC START# *3299499C644F_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3299499C644F_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetChangedRelTempate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

function TalcuAutoExportTaskPrim.pm_GetExecName: AnsiString;
//#UC START# *44ADF3DB2EBB_53B6A5FA0212get_var*
//#UC END# *44ADF3DB2EBB_53B6A5FA0212get_var*
begin
//#UC START# *44ADF3DB2EBB_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *44ADF3DB2EBB_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetExecName

procedure TalcuAutoExportTaskPrim.pm_SetExecName(const aValue: AnsiString);
//#UC START# *44ADF3DB2EBB_53B6A5FA0212set_var*
//#UC END# *44ADF3DB2EBB_53B6A5FA0212set_var*
begin
//#UC START# *44ADF3DB2EBB_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *44ADF3DB2EBB_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetExecName

function TalcuAutoExportTaskPrim.pm_GetExecParams: AnsiString;
//#UC START# *47395ABF0BA8_53B6A5FA0212get_var*
//#UC END# *47395ABF0BA8_53B6A5FA0212get_var*
begin
//#UC START# *47395ABF0BA8_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47395ABF0BA8_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetExecParams

procedure TalcuAutoExportTaskPrim.pm_SetExecParams(const aValue: AnsiString);
//#UC START# *47395ABF0BA8_53B6A5FA0212set_var*
//#UC END# *47395ABF0BA8_53B6A5FA0212set_var*
begin
//#UC START# *47395ABF0BA8_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47395ABF0BA8_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetExecParams

function TalcuAutoExportTaskPrim.pm_GetDocQueryFileName: AnsiString;
//#UC START# *7B8BD7B63B67_53B6A5FA0212get_var*
//#UC END# *7B8BD7B63B67_53B6A5FA0212get_var*
begin
//#UC START# *7B8BD7B63B67_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7B8BD7B63B67_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetDocQueryFileName

procedure TalcuAutoExportTaskPrim.pm_SetDocQueryFileName(const aValue: AnsiString);
//#UC START# *7B8BD7B63B67_53B6A5FA0212set_var*
//#UC END# *7B8BD7B63B67_53B6A5FA0212set_var*
begin
//#UC START# *7B8BD7B63B67_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *7B8BD7B63B67_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetDocQueryFileName

{$If NOT Defined(AEByBelongs)}
function TalcuAutoExportTaskPrim.pm_GetDoneFileName: AnsiString;
//#UC START# *40D93B6F6285_53B6A5FA0212get_var*
//#UC END# *40D93B6F6285_53B6A5FA0212get_var*
begin
//#UC START# *40D93B6F6285_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *40D93B6F6285_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetDoneFileName
{$IfEnd} // NOT Defined(AEByBelongs)

{$If NOT Defined(AEByBelongs)}
procedure TalcuAutoExportTaskPrim.pm_SetDoneFileName(const aValue: AnsiString);
//#UC START# *40D93B6F6285_53B6A5FA0212set_var*
//#UC END# *40D93B6F6285_53B6A5FA0212set_var*
begin
//#UC START# *40D93B6F6285_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *40D93B6F6285_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetDoneFileName
{$IfEnd} // NOT Defined(AEByBelongs)

function TalcuAutoExportTaskPrim.pm_GetExportFolder: AnsiString;
//#UC START# *414A329E3B08_53B6A5FA0212get_var*
//#UC END# *414A329E3B08_53B6A5FA0212get_var*
begin
//#UC START# *414A329E3B08_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *414A329E3B08_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetExportFolder

procedure TalcuAutoExportTaskPrim.pm_SetExportFolder(const aValue: AnsiString);
//#UC START# *414A329E3B08_53B6A5FA0212set_var*
//#UC END# *414A329E3B08_53B6A5FA0212set_var*
begin
//#UC START# *414A329E3B08_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *414A329E3B08_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetExportFolder

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetIncludedDocTemplate: AnsiString;
//#UC START# *E59BD98FD3D0_53B6A5FA0212get_var*
//#UC END# *E59BD98FD3D0_53B6A5FA0212get_var*
begin
//#UC START# *E59BD98FD3D0_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E59BD98FD3D0_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetIncludedDocTemplate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetIncludedDocTemplate(const aValue: AnsiString);
//#UC START# *E59BD98FD3D0_53B6A5FA0212set_var*
//#UC END# *E59BD98FD3D0_53B6A5FA0212set_var*
begin
//#UC START# *E59BD98FD3D0_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *E59BD98FD3D0_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetIncludedDocTemplate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetIncludedRelTemplate: AnsiString;
//#UC START# *9D45E4F9BEDA_53B6A5FA0212get_var*
//#UC END# *9D45E4F9BEDA_53B6A5FA0212get_var*
begin
//#UC START# *9D45E4F9BEDA_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9D45E4F9BEDA_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetIncludedRelTemplate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

{$If NOT Defined(LUK) AND NOT Defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetIncludedRelTemplate(const aValue: AnsiString);
//#UC START# *9D45E4F9BEDA_53B6A5FA0212set_var*
//#UC END# *9D45E4F9BEDA_53B6A5FA0212set_var*
begin
//#UC START# *9D45E4F9BEDA_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *9D45E4F9BEDA_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetIncludedRelTemplate
{$IfEnd} // NOT Defined(LUK) AND NOT Defined(SGC)

function TalcuAutoExportTaskPrim.pm_GetInfoDocTemplate: AnsiString;
//#UC START# *11DB597FB446_53B6A5FA0212get_var*
//#UC END# *11DB597FB446_53B6A5FA0212get_var*
begin
//#UC START# *11DB597FB446_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *11DB597FB446_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetInfoDocTemplate

procedure TalcuAutoExportTaskPrim.pm_SetInfoDocTemplate(const aValue: AnsiString);
//#UC START# *11DB597FB446_53B6A5FA0212set_var*
//#UC END# *11DB597FB446_53B6A5FA0212set_var*
begin
//#UC START# *11DB597FB446_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *11DB597FB446_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetInfoDocTemplate

function TalcuAutoExportTaskPrim.pm_GetInfoIDList: InfoIDListHelper;
//#UC START# *487C59BB0B60_53B6A5FA0212get_var*
//#UC END# *487C59BB0B60_53B6A5FA0212get_var*
begin
//#UC START# *487C59BB0B60_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *487C59BB0B60_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetInfoIDList

function TalcuAutoExportTaskPrim.pm_GetInfoRelTemplate: AnsiString;
//#UC START# *43C262E9E9D5_53B6A5FA0212get_var*
//#UC END# *43C262E9E9D5_53B6A5FA0212get_var*
begin
//#UC START# *43C262E9E9D5_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *43C262E9E9D5_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetInfoRelTemplate

procedure TalcuAutoExportTaskPrim.pm_SetInfoRelTemplate(const aValue: AnsiString);
//#UC START# *43C262E9E9D5_53B6A5FA0212set_var*
//#UC END# *43C262E9E9D5_53B6A5FA0212set_var*
begin
//#UC START# *43C262E9E9D5_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *43C262E9E9D5_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetInfoRelTemplate

function TalcuAutoExportTaskPrim.pm_GetNeedTopicList: Boolean;
//#UC START# *C66B62E66E49_53B6A5FA0212get_var*
//#UC END# *C66B62E66E49_53B6A5FA0212get_var*
begin
//#UC START# *C66B62E66E49_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C66B62E66E49_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetNeedTopicList

procedure TalcuAutoExportTaskPrim.pm_SetNeedTopicList(aValue: Boolean);
//#UC START# *C66B62E66E49_53B6A5FA0212set_var*
//#UC END# *C66B62E66E49_53B6A5FA0212set_var*
begin
//#UC START# *C66B62E66E49_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *C66B62E66E49_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetNeedTopicList

function TalcuAutoExportTaskPrim.pm_GeteMailNotifyList: AnsiString;
//#UC START# *D36ED259C9F6_53B6A5FA0212get_var*
//#UC END# *D36ED259C9F6_53B6A5FA0212get_var*
begin
//#UC START# *D36ED259C9F6_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D36ED259C9F6_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GeteMailNotifyList

procedure TalcuAutoExportTaskPrim.pm_SeteMailNotifyList(const aValue: AnsiString);
//#UC START# *D36ED259C9F6_53B6A5FA0212set_var*
//#UC END# *D36ED259C9F6_53B6A5FA0212set_var*
begin
//#UC START# *D36ED259C9F6_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D36ED259C9F6_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SeteMailNotifyList

function TalcuAutoExportTaskPrim.pm_GetSMSNotifyList: AnsiString;
//#UC START# *902CB7528998_53B6A5FA0212get_var*
//#UC END# *902CB7528998_53B6A5FA0212get_var*
begin
//#UC START# *902CB7528998_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *902CB7528998_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetSMSNotifyList

procedure TalcuAutoExportTaskPrim.pm_SetSMSNotifyList(const aValue: AnsiString);
//#UC START# *902CB7528998_53B6A5FA0212set_var*
//#UC END# *902CB7528998_53B6A5FA0212set_var*
begin
//#UC START# *902CB7528998_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *902CB7528998_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetSMSNotifyList

function TalcuAutoExportTaskPrim.pm_GetPartSize: Integer;
//#UC START# *F0AD21388FA6_53B6A5FA0212get_var*
//#UC END# *F0AD21388FA6_53B6A5FA0212get_var*
begin
//#UC START# *F0AD21388FA6_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F0AD21388FA6_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetPartSize

procedure TalcuAutoExportTaskPrim.pm_SetPartSize(aValue: Integer);
//#UC START# *F0AD21388FA6_53B6A5FA0212set_var*
//#UC END# *F0AD21388FA6_53B6A5FA0212set_var*
begin
//#UC START# *F0AD21388FA6_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *F0AD21388FA6_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetPartSize

function TalcuAutoExportTaskPrim.pm_GetMaxExportCount: Integer;
//#UC START# *E5B40FB406B9_53B6A5FA0212get_var*
//#UC END# *E5B40FB406B9_53B6A5FA0212get_var*
begin
//#UC START# *E5B40FB406B9_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E5B40FB406B9_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetMaxExportCount

procedure TalcuAutoExportTaskPrim.pm_SetMaxExportCount(aValue: Integer);
//#UC START# *E5B40FB406B9_53B6A5FA0212set_var*
//#UC END# *E5B40FB406B9_53B6A5FA0212set_var*
begin
//#UC START# *E5B40FB406B9_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *E5B40FB406B9_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetMaxExportCount

function TalcuAutoExportTaskPrim.pm_GetStages: TaeStagesSet;
//#UC START# *FC2A595BD750_53B6A5FA0212get_var*
//#UC END# *FC2A595BD750_53B6A5FA0212get_var*
begin
//#UC START# *FC2A595BD750_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC2A595BD750_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetStages

procedure TalcuAutoExportTaskPrim.pm_SetStages(aValue: TaeStagesSet);
//#UC START# *FC2A595BD750_53B6A5FA0212set_var*
//#UC END# *FC2A595BD750_53B6A5FA0212set_var*
begin
//#UC START# *FC2A595BD750_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC2A595BD750_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetStages

function TalcuAutoExportTaskPrim.pm_GetExpandEditions: Boolean;
//#UC START# *CBC40A3F22A1_53B6A5FA0212get_var*
//#UC END# *CBC40A3F22A1_53B6A5FA0212get_var*
begin
//#UC START# *CBC40A3F22A1_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *CBC40A3F22A1_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetExpandEditions

procedure TalcuAutoExportTaskPrim.pm_SetExpandEditions(aValue: Boolean);
//#UC START# *CBC40A3F22A1_53B6A5FA0212set_var*
//#UC END# *CBC40A3F22A1_53B6A5FA0212set_var*
begin
//#UC START# *CBC40A3F22A1_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *CBC40A3F22A1_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetExpandEditions

function TalcuAutoExportTaskPrim.pm_GetInfoDocsIncludedOnly: Boolean;
//#UC START# *3538557C30E3_53B6A5FA0212get_var*
//#UC END# *3538557C30E3_53B6A5FA0212get_var*
begin
//#UC START# *3538557C30E3_53B6A5FA0212get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3538557C30E3_53B6A5FA0212get_impl*
end;//TalcuAutoExportTaskPrim.pm_GetInfoDocsIncludedOnly

procedure TalcuAutoExportTaskPrim.pm_SetInfoDocsIncludedOnly(aValue: Boolean);
//#UC START# *3538557C30E3_53B6A5FA0212set_var*
//#UC END# *3538557C30E3_53B6A5FA0212set_var*
begin
//#UC START# *3538557C30E3_53B6A5FA0212set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3538557C30E3_53B6A5FA0212set_impl*
end;//TalcuAutoExportTaskPrim.pm_SetInfoDocsIncludedOnly

class function TalcuAutoExportTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B6A5FA0212_var*
//#UC END# *53AC03EE01FD_53B6A5FA0212_var*
begin
//#UC START# *53AC03EE01FD_53B6A5FA0212_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B6A5FA0212_impl*
end;//TalcuAutoExportTaskPrim.GetTaggedDataType

{$If NOT Defined(Nemesis)}
function TalcuAutoExportTaskPrim.GetDescription: AnsiString;
//#UC START# *53FB28170339_53B6A5FA0212_var*
//#UC END# *53FB28170339_53B6A5FA0212_var*
begin
//#UC START# *53FB28170339_53B6A5FA0212_impl*
 Result := 'Автоматический экспорт документов и аннотаций';
//#UC END# *53FB28170339_53B6A5FA0212_impl*
end;//TalcuAutoExportTaskPrim.GetDescription
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
