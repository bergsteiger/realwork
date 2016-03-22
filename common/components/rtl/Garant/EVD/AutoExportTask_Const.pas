unit AutoExportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AutoExportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::AutoExportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutoExportTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdDTTypes,
  evdTasks_Schema
  ;

function k2_typAutoExportTask_OutFormat: AutoExportTask_OutFormat_Tag;

function k2_typAutoExportTask_DocumentsSource: AutoExportTask_DocumentsSource_Tag;

function k2_typAutoExportTask_AccGroupsIDList: AutoExportTask_AccGroupsIDList_Tag;
{$If not defined(LUK) AND not defined(SGC)}

function k2_typAutoExportTask_BasesIDList: AutoExportTask_BasesIDList_Tag;
{$IfEnd} //not LUK AND not SGC

function k2_typAutoExportTask_InfoIDList: AutoExportTask_InfoIDList_Tag;

function k2_typAutoExportTask_Stages: AutoExportTask_Stages_Tag;
function k2_typAutoExportTask_Stages_FromSet(const aValue : TaeStagesSet): Integer;
function k2_typAutoExportTask_Stages_ToSet(const aValue : Integer): TaeStagesSet;

function k2_attrToday: Integer;

function k2_attrCompileDate: Integer;

function k2_attrVersionDate: Integer;

function k2_attrOutFormat: Integer;

function k2_attrAnnoUseAccGroups: Integer;

function k2_attrDocumentsSource: Integer;

function k2_attrWithEditions: Integer;

function k2_attrAccGroupsIDList: Integer;

{$If not defined(LUK) AND not defined(SGC)}
function k2_attrAnnoTemplate: Integer;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
function k2_attrBasesIDList: Integer;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
function k2_attrChangedDocTemplate: Integer;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
function k2_attrChangedRelTempate: Integer;
{$IfEnd} //not LUK AND not SGC

function k2_attrExecName: Integer;

function k2_attrExecParams: Integer;

function k2_attrDocQueryFileName: Integer;

{$If not defined(AEByBelongs)}
function k2_attrDoneFileName: Integer;
{$IfEnd} //not AEByBelongs

function k2_attrExportFolder: Integer;

{$If not defined(LUK) AND not defined(SGC)}
function k2_attrIncludedDocTemplate: Integer;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
function k2_attrIncludedRelTemplate: Integer;
{$IfEnd} //not LUK AND not SGC

function k2_attrInfoDocTemplate: Integer;

function k2_attrInfoIDList: Integer;

function k2_attrInfoRelTemplate: Integer;

function k2_attrNeedTopicList: Integer;

function k2_attreMailNotifyList: Integer;

function k2_attrSMSNotifyList: Integer;

function k2_attrPartSize: Integer;

function k2_attrMaxExportCount: Integer;

function k2_attrStages: Integer;

function k2_attrExpandEditions: Integer;

function k2_attrInfoDocsIncludedOnly: Integer;
function k2_typAutoExportTask: AutoExportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutoExportTask : AutoExportTaskTag = nil;

// start class AutoExportTaskTag

function k2_typAutoExportTask: AutoExportTaskTag;
begin
 if (g_AutoExportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoExportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoExportTask;
 end;//g_AutoExportTask = nil
 Result := g_AutoExportTask;
end;
var
 g_k2_attrToday: Integer = -1;

function k2_attrToday: Integer;
begin
 if (g_k2_attrToday = -1) then
  g_k2_attrToday :=  Tk2Attributes.Instance.CheckIDByName('Today');
 Result := g_k2_attrToday;
end;

var
 g_k2_attrCompileDate: Integer = -1;

function k2_attrCompileDate: Integer;
begin
 if (g_k2_attrCompileDate = -1) then
  g_k2_attrCompileDate :=  Tk2Attributes.Instance.CheckIDByName('CompileDate');
 Result := g_k2_attrCompileDate;
end;

var
 g_k2_attrVersionDate: Integer = -1;

function k2_attrVersionDate: Integer;
begin
 if (g_k2_attrVersionDate = -1) then
  g_k2_attrVersionDate :=  Tk2Attributes.Instance.CheckIDByName('VersionDate');
 Result := g_k2_attrVersionDate;
end;

var
 g_k2_attrOutFormat: Integer = -1;

function k2_attrOutFormat: Integer;
begin
 if (g_k2_attrOutFormat = -1) then
  g_k2_attrOutFormat :=  Tk2Attributes.Instance.CheckIDByName('OutFormat');
 Result := g_k2_attrOutFormat;
end;

var
 g_k2_attrAnnoUseAccGroups: Integer = -1;

function k2_attrAnnoUseAccGroups: Integer;
begin
 if (g_k2_attrAnnoUseAccGroups = -1) then
  g_k2_attrAnnoUseAccGroups :=  Tk2Attributes.Instance.CheckIDByName('AnnoUseAccGroups');
 Result := g_k2_attrAnnoUseAccGroups;
end;

var
 g_k2_attrDocumentsSource: Integer = -1;

function k2_attrDocumentsSource: Integer;
begin
 if (g_k2_attrDocumentsSource = -1) then
  g_k2_attrDocumentsSource :=  Tk2Attributes.Instance.CheckIDByName('DocumentsSource');
 Result := g_k2_attrDocumentsSource;
end;

var
 g_k2_attrWithEditions: Integer = -1;

function k2_attrWithEditions: Integer;
begin
 if (g_k2_attrWithEditions = -1) then
  g_k2_attrWithEditions :=  Tk2Attributes.Instance.CheckIDByName('WithEditions');
 Result := g_k2_attrWithEditions;
end;

var
 g_k2_attrAccGroupsIDList: Integer = -1;

function k2_attrAccGroupsIDList: Integer;
begin
 if (g_k2_attrAccGroupsIDList = -1) then
  g_k2_attrAccGroupsIDList :=  Tk2Attributes.Instance.CheckIDByName('AccGroupsIDList');
 Result := g_k2_attrAccGroupsIDList;
end;

{$If not defined(LUK) AND not defined(SGC)}
var
 g_k2_attrAnnoTemplate: Integer = -1;

function k2_attrAnnoTemplate: Integer;
begin
 if (g_k2_attrAnnoTemplate = -1) then
  g_k2_attrAnnoTemplate :=  Tk2Attributes.Instance.CheckIDByName('AnnoTemplate');
 Result := g_k2_attrAnnoTemplate;
end;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
var
 g_k2_attrBasesIDList: Integer = -1;

function k2_attrBasesIDList: Integer;
begin
 if (g_k2_attrBasesIDList = -1) then
  g_k2_attrBasesIDList :=  Tk2Attributes.Instance.CheckIDByName('BasesIDList');
 Result := g_k2_attrBasesIDList;
end;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
var
 g_k2_attrChangedDocTemplate: Integer = -1;

function k2_attrChangedDocTemplate: Integer;
begin
 if (g_k2_attrChangedDocTemplate = -1) then
  g_k2_attrChangedDocTemplate :=  Tk2Attributes.Instance.CheckIDByName('ChangedDocTemplate');
 Result := g_k2_attrChangedDocTemplate;
end;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
var
 g_k2_attrChangedRelTempate: Integer = -1;

function k2_attrChangedRelTempate: Integer;
begin
 if (g_k2_attrChangedRelTempate = -1) then
  g_k2_attrChangedRelTempate :=  Tk2Attributes.Instance.CheckIDByName('ChangedRelTempate');
 Result := g_k2_attrChangedRelTempate;
end;
{$IfEnd} //not LUK AND not SGC

var
 g_k2_attrExecName: Integer = -1;

function k2_attrExecName: Integer;
begin
 if (g_k2_attrExecName = -1) then
  g_k2_attrExecName :=  Tk2Attributes.Instance.CheckIDByName('ExecName');
 Result := g_k2_attrExecName;
end;

var
 g_k2_attrExecParams: Integer = -1;

function k2_attrExecParams: Integer;
begin
 if (g_k2_attrExecParams = -1) then
  g_k2_attrExecParams :=  Tk2Attributes.Instance.CheckIDByName('ExecParams');
 Result := g_k2_attrExecParams;
end;

var
 g_k2_attrDocQueryFileName: Integer = -1;

function k2_attrDocQueryFileName: Integer;
begin
 if (g_k2_attrDocQueryFileName = -1) then
  g_k2_attrDocQueryFileName :=  Tk2Attributes.Instance.CheckIDByName('DocQueryFileName');
 Result := g_k2_attrDocQueryFileName;
end;

{$If not defined(AEByBelongs)}
var
 g_k2_attrDoneFileName: Integer = -1;

function k2_attrDoneFileName: Integer;
begin
 if (g_k2_attrDoneFileName = -1) then
  g_k2_attrDoneFileName :=  Tk2Attributes.Instance.CheckIDByName('DoneFileName');
 Result := g_k2_attrDoneFileName;
end;
{$IfEnd} //not AEByBelongs

var
 g_k2_attrExportFolder: Integer = -1;

function k2_attrExportFolder: Integer;
begin
 if (g_k2_attrExportFolder = -1) then
  g_k2_attrExportFolder :=  Tk2Attributes.Instance.CheckIDByName('ExportFolder');
 Result := g_k2_attrExportFolder;
end;

{$If not defined(LUK) AND not defined(SGC)}
var
 g_k2_attrIncludedDocTemplate: Integer = -1;

function k2_attrIncludedDocTemplate: Integer;
begin
 if (g_k2_attrIncludedDocTemplate = -1) then
  g_k2_attrIncludedDocTemplate :=  Tk2Attributes.Instance.CheckIDByName('IncludedDocTemplate');
 Result := g_k2_attrIncludedDocTemplate;
end;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
var
 g_k2_attrIncludedRelTemplate: Integer = -1;

function k2_attrIncludedRelTemplate: Integer;
begin
 if (g_k2_attrIncludedRelTemplate = -1) then
  g_k2_attrIncludedRelTemplate :=  Tk2Attributes.Instance.CheckIDByName('IncludedRelTemplate');
 Result := g_k2_attrIncludedRelTemplate;
end;
{$IfEnd} //not LUK AND not SGC

var
 g_k2_attrInfoDocTemplate: Integer = -1;

function k2_attrInfoDocTemplate: Integer;
begin
 if (g_k2_attrInfoDocTemplate = -1) then
  g_k2_attrInfoDocTemplate :=  Tk2Attributes.Instance.CheckIDByName('InfoDocTemplate');
 Result := g_k2_attrInfoDocTemplate;
end;

var
 g_k2_attrInfoIDList: Integer = -1;

function k2_attrInfoIDList: Integer;
begin
 if (g_k2_attrInfoIDList = -1) then
  g_k2_attrInfoIDList :=  Tk2Attributes.Instance.CheckIDByName('InfoIDList');
 Result := g_k2_attrInfoIDList;
end;

var
 g_k2_attrInfoRelTemplate: Integer = -1;

function k2_attrInfoRelTemplate: Integer;
begin
 if (g_k2_attrInfoRelTemplate = -1) then
  g_k2_attrInfoRelTemplate :=  Tk2Attributes.Instance.CheckIDByName('InfoRelTemplate');
 Result := g_k2_attrInfoRelTemplate;
end;

var
 g_k2_attrNeedTopicList: Integer = -1;

function k2_attrNeedTopicList: Integer;
begin
 if (g_k2_attrNeedTopicList = -1) then
  g_k2_attrNeedTopicList :=  Tk2Attributes.Instance.CheckIDByName('NeedTopicList');
 Result := g_k2_attrNeedTopicList;
end;

var
 g_k2_attreMailNotifyList: Integer = -1;

function k2_attreMailNotifyList: Integer;
begin
 if (g_k2_attreMailNotifyList = -1) then
  g_k2_attreMailNotifyList :=  Tk2Attributes.Instance.CheckIDByName('eMailNotifyList');
 Result := g_k2_attreMailNotifyList;
end;

var
 g_k2_attrSMSNotifyList: Integer = -1;

function k2_attrSMSNotifyList: Integer;
begin
 if (g_k2_attrSMSNotifyList = -1) then
  g_k2_attrSMSNotifyList :=  Tk2Attributes.Instance.CheckIDByName('SMSNotifyList');
 Result := g_k2_attrSMSNotifyList;
end;

var
 g_k2_attrPartSize: Integer = -1;

function k2_attrPartSize: Integer;
begin
 if (g_k2_attrPartSize = -1) then
  g_k2_attrPartSize :=  Tk2Attributes.Instance.CheckIDByName('PartSize');
 Result := g_k2_attrPartSize;
end;

var
 g_k2_attrMaxExportCount: Integer = -1;

function k2_attrMaxExportCount: Integer;
begin
 if (g_k2_attrMaxExportCount = -1) then
  g_k2_attrMaxExportCount :=  Tk2Attributes.Instance.CheckIDByName('MaxExportCount');
 Result := g_k2_attrMaxExportCount;
end;

var
 g_k2_attrStages: Integer = -1;

function k2_attrStages: Integer;
begin
 if (g_k2_attrStages = -1) then
  g_k2_attrStages :=  Tk2Attributes.Instance.CheckIDByName('Stages');
 Result := g_k2_attrStages;
end;

var
 g_k2_attrExpandEditions: Integer = -1;

function k2_attrExpandEditions: Integer;
begin
 if (g_k2_attrExpandEditions = -1) then
  g_k2_attrExpandEditions :=  Tk2Attributes.Instance.CheckIDByName('ExpandEditions');
 Result := g_k2_attrExpandEditions;
end;

var
 g_k2_attrInfoDocsIncludedOnly: Integer = -1;

function k2_attrInfoDocsIncludedOnly: Integer;
begin
 if (g_k2_attrInfoDocsIncludedOnly = -1) then
  g_k2_attrInfoDocsIncludedOnly :=  Tk2Attributes.Instance.CheckIDByName('InfoDocsIncludedOnly');
 Result := g_k2_attrInfoDocsIncludedOnly;
end;


var
 g_AutoExportTask_OutFormat : AutoExportTask_OutFormat_Tag = nil;

// start class OutFormat

function k2_typAutoExportTask_OutFormat: AutoExportTask_OutFormat_Tag;
begin
 if (g_AutoExportTask_OutFormat = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoExportTask_OutFormat := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoExportTask_OutFormat;
 end;//g_AutoExportTask = nil
 Result := g_AutoExportTask_OutFormat;
end;

var
 g_AutoExportTask_DocumentsSource : AutoExportTask_DocumentsSource_Tag = nil;

// start class DocumentsSource

function k2_typAutoExportTask_DocumentsSource: AutoExportTask_DocumentsSource_Tag;
begin
 if (g_AutoExportTask_DocumentsSource = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoExportTask_DocumentsSource := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoExportTask_DocumentsSource;
 end;//g_AutoExportTask = nil
 Result := g_AutoExportTask_DocumentsSource;
end;

var
 g_AutoExportTask_AccGroupsIDList : AutoExportTask_AccGroupsIDList_Tag = nil;

// start class AccGroupsIDList

function k2_typAutoExportTask_AccGroupsIDList: AutoExportTask_AccGroupsIDList_Tag;
begin
 if (g_AutoExportTask_AccGroupsIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoExportTask_AccGroupsIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoExportTask_AccGroupsIDList;
 end;//g_AutoExportTask = nil
 Result := g_AutoExportTask_AccGroupsIDList;
end;
{$If not defined(LUK) AND not defined(SGC)}

var
 g_AutoExportTask_BasesIDList : AutoExportTask_BasesIDList_Tag = nil;

// start class BasesIDList

function k2_typAutoExportTask_BasesIDList: AutoExportTask_BasesIDList_Tag;
begin
 if (g_AutoExportTask_BasesIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoExportTask_BasesIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoExportTask_BasesIDList;
 end;//g_AutoExportTask = nil
 Result := g_AutoExportTask_BasesIDList;
end;
{$IfEnd} //not LUK AND not SGC

var
 g_AutoExportTask_InfoIDList : AutoExportTask_InfoIDList_Tag = nil;

// start class InfoIDList

function k2_typAutoExportTask_InfoIDList: AutoExportTask_InfoIDList_Tag;
begin
 if (g_AutoExportTask_InfoIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoExportTask_InfoIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoExportTask_InfoIDList;
 end;//g_AutoExportTask = nil
 Result := g_AutoExportTask_InfoIDList;
end;

var
 g_AutoExportTask_Stages : AutoExportTask_Stages_Tag = nil;

// start class Stages

function k2_typAutoExportTask_Stages: AutoExportTask_Stages_Tag;
begin
 if (g_AutoExportTask_Stages = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoExportTask_Stages := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoExportTask_Stages;
 end;//g_AutoExportTask = nil
 Result := g_AutoExportTask_Stages;
end;

function k2_typAutoExportTask_Stages_FromSet(const aValue : TaeStagesSet): Integer;
var
 l_Value : Integer;
begin
 Assert(SizeOf(l_Value) >= SizeOf(aValue));
 l_Value := 0;
 System.Move(aValue, l_Value, SizeOf(aValue));
 Result := l_Value;
end;

function k2_typAutoExportTask_Stages_ToSet(const aValue : Integer): TaeStagesSet;
var
 l_Value : TaeStagesSet;
begin
 Assert(SizeOf(l_Value) <= SizeOf(aValue));
 l_Value := [];
 System.Move(aValue, l_Value, SizeOf(l_Value));
 Result := l_Value;
end;


end.