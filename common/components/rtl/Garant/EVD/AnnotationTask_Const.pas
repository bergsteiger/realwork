unit AnnotationTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AnnotationTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::AnnotationTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AnnotationTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typAnnotationTask_BelongsIDList: AnnotationTask_BelongsIDList_Tag;
{$If not defined(Region)}

function k2_typAnnotationTask_ExcludeAccGroupsIDList: AnnotationTask_ExcludeAccGroupsIDList_Tag;
{$IfEnd} //not Region

function k2_typAnnotationTask_AccGroupsIDList: AnnotationTask_AccGroupsIDList_Tag;

function k2_typAnnotationTask_CommentsIDList: AnnotationTask_CommentsIDList_Tag;

function k2_typAnnotationTask_ExcludeDocTypesIDList: AnnotationTask_ExcludeDocTypesIDList_Tag;

function k2_typAnnotationTask_ExcludeDocBasesIDList: AnnotationTask_ExcludeDocBasesIDList_Tag;

function k2_attrNeedAnalyzeLog: Integer;

function k2_attrTargetFolder: Integer;

function k2_attreMailNotifyList: Integer;

function k2_attrExternalProcessor: Integer;

function k2_attrOutFolder: Integer;

function k2_attrPrimeRobotEMail: Integer;

function k2_attrExportDocuments: Integer;

function k2_attrDocListFileName: Integer;

function k2_attrDocListFolder: Integer;

function k2_attrEndDateKind: Integer;

function k2_attrStartDate: Integer;

function k2_attrBelongsIDList: Integer;

{$If not defined(Region)}
function k2_attrExcludeAccGroupsIDList: Integer;
{$IfEnd} //not Region

function k2_attrAccGroupsIDList: Integer;

function k2_attrCommentsIDList: Integer;

function k2_attrExcludeDocTypesIDList: Integer;

function k2_attrExcludeDocBasesIDList: Integer;
function k2_typAnnotationTask: AnnotationTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AnnotationTask : AnnotationTaskTag = nil;

// start class AnnotationTaskTag

function k2_typAnnotationTask: AnnotationTaskTag;
begin
 if (g_AnnotationTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnnotationTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnnotationTask;
 end;//g_AnnotationTask = nil
 Result := g_AnnotationTask;
end;
var
 g_k2_attrNeedAnalyzeLog: Integer = -1;

function k2_attrNeedAnalyzeLog: Integer;
begin
 if (g_k2_attrNeedAnalyzeLog = -1) then
  g_k2_attrNeedAnalyzeLog :=  Tk2Attributes.Instance.CheckIDByName('NeedAnalyzeLog');
 Result := g_k2_attrNeedAnalyzeLog;
end;

var
 g_k2_attrTargetFolder: Integer = -1;

function k2_attrTargetFolder: Integer;
begin
 if (g_k2_attrTargetFolder = -1) then
  g_k2_attrTargetFolder :=  Tk2Attributes.Instance.CheckIDByName('TargetFolder');
 Result := g_k2_attrTargetFolder;
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
 g_k2_attrExternalProcessor: Integer = -1;

function k2_attrExternalProcessor: Integer;
begin
 if (g_k2_attrExternalProcessor = -1) then
  g_k2_attrExternalProcessor :=  Tk2Attributes.Instance.CheckIDByName('ExternalProcessor');
 Result := g_k2_attrExternalProcessor;
end;

var
 g_k2_attrOutFolder: Integer = -1;

function k2_attrOutFolder: Integer;
begin
 if (g_k2_attrOutFolder = -1) then
  g_k2_attrOutFolder :=  Tk2Attributes.Instance.CheckIDByName('OutFolder');
 Result := g_k2_attrOutFolder;
end;

var
 g_k2_attrPrimeRobotEMail: Integer = -1;

function k2_attrPrimeRobotEMail: Integer;
begin
 if (g_k2_attrPrimeRobotEMail = -1) then
  g_k2_attrPrimeRobotEMail :=  Tk2Attributes.Instance.CheckIDByName('PrimeRobotEMail');
 Result := g_k2_attrPrimeRobotEMail;
end;

var
 g_k2_attrExportDocuments: Integer = -1;

function k2_attrExportDocuments: Integer;
begin
 if (g_k2_attrExportDocuments = -1) then
  g_k2_attrExportDocuments :=  Tk2Attributes.Instance.CheckIDByName('ExportDocuments');
 Result := g_k2_attrExportDocuments;
end;

var
 g_k2_attrDocListFileName: Integer = -1;

function k2_attrDocListFileName: Integer;
begin
 if (g_k2_attrDocListFileName = -1) then
  g_k2_attrDocListFileName :=  Tk2Attributes.Instance.CheckIDByName('DocListFileName');
 Result := g_k2_attrDocListFileName;
end;

var
 g_k2_attrDocListFolder: Integer = -1;

function k2_attrDocListFolder: Integer;
begin
 if (g_k2_attrDocListFolder = -1) then
  g_k2_attrDocListFolder :=  Tk2Attributes.Instance.CheckIDByName('DocListFolder');
 Result := g_k2_attrDocListFolder;
end;

var
 g_k2_attrEndDateKind: Integer = -1;

function k2_attrEndDateKind: Integer;
begin
 if (g_k2_attrEndDateKind = -1) then
  g_k2_attrEndDateKind :=  Tk2Attributes.Instance.CheckIDByName('EndDateKind');
 Result := g_k2_attrEndDateKind;
end;

var
 g_k2_attrStartDate: Integer = -1;

function k2_attrStartDate: Integer;
begin
 if (g_k2_attrStartDate = -1) then
  g_k2_attrStartDate :=  Tk2Attributes.Instance.CheckIDByName('StartDate');
 Result := g_k2_attrStartDate;
end;

var
 g_k2_attrBelongsIDList: Integer = -1;

function k2_attrBelongsIDList: Integer;
begin
 if (g_k2_attrBelongsIDList = -1) then
  g_k2_attrBelongsIDList :=  Tk2Attributes.Instance.CheckIDByName('BelongsIDList');
 Result := g_k2_attrBelongsIDList;
end;

{$If not defined(Region)}
var
 g_k2_attrExcludeAccGroupsIDList: Integer = -1;

function k2_attrExcludeAccGroupsIDList: Integer;
begin
 if (g_k2_attrExcludeAccGroupsIDList = -1) then
  g_k2_attrExcludeAccGroupsIDList :=  Tk2Attributes.Instance.CheckIDByName('ExcludeAccGroupsIDList');
 Result := g_k2_attrExcludeAccGroupsIDList;
end;
{$IfEnd} //not Region

var
 g_k2_attrAccGroupsIDList: Integer = -1;

function k2_attrAccGroupsIDList: Integer;
begin
 if (g_k2_attrAccGroupsIDList = -1) then
  g_k2_attrAccGroupsIDList :=  Tk2Attributes.Instance.CheckIDByName('AccGroupsIDList');
 Result := g_k2_attrAccGroupsIDList;
end;

var
 g_k2_attrCommentsIDList: Integer = -1;

function k2_attrCommentsIDList: Integer;
begin
 if (g_k2_attrCommentsIDList = -1) then
  g_k2_attrCommentsIDList :=  Tk2Attributes.Instance.CheckIDByName('CommentsIDList');
 Result := g_k2_attrCommentsIDList;
end;

var
 g_k2_attrExcludeDocTypesIDList: Integer = -1;

function k2_attrExcludeDocTypesIDList: Integer;
begin
 if (g_k2_attrExcludeDocTypesIDList = -1) then
  g_k2_attrExcludeDocTypesIDList :=  Tk2Attributes.Instance.CheckIDByName('ExcludeDocTypesIDList');
 Result := g_k2_attrExcludeDocTypesIDList;
end;

var
 g_k2_attrExcludeDocBasesIDList: Integer = -1;

function k2_attrExcludeDocBasesIDList: Integer;
begin
 if (g_k2_attrExcludeDocBasesIDList = -1) then
  g_k2_attrExcludeDocBasesIDList :=  Tk2Attributes.Instance.CheckIDByName('ExcludeDocBasesIDList');
 Result := g_k2_attrExcludeDocBasesIDList;
end;


var
 g_AnnotationTask_BelongsIDList : AnnotationTask_BelongsIDList_Tag = nil;

// start class BelongsIDList

function k2_typAnnotationTask_BelongsIDList: AnnotationTask_BelongsIDList_Tag;
begin
 if (g_AnnotationTask_BelongsIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnnotationTask_BelongsIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnnotationTask_BelongsIDList;
 end;//g_AnnotationTask = nil
 Result := g_AnnotationTask_BelongsIDList;
end;
{$If not defined(Region)}

var
 g_AnnotationTask_ExcludeAccGroupsIDList : AnnotationTask_ExcludeAccGroupsIDList_Tag = nil;

// start class ExcludeAccGroupsIDList

function k2_typAnnotationTask_ExcludeAccGroupsIDList: AnnotationTask_ExcludeAccGroupsIDList_Tag;
begin
 if (g_AnnotationTask_ExcludeAccGroupsIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnnotationTask_ExcludeAccGroupsIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnnotationTask_ExcludeAccGroupsIDList;
 end;//g_AnnotationTask = nil
 Result := g_AnnotationTask_ExcludeAccGroupsIDList;
end;
{$IfEnd} //not Region

var
 g_AnnotationTask_AccGroupsIDList : AnnotationTask_AccGroupsIDList_Tag = nil;

// start class AccGroupsIDList

function k2_typAnnotationTask_AccGroupsIDList: AnnotationTask_AccGroupsIDList_Tag;
begin
 if (g_AnnotationTask_AccGroupsIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnnotationTask_AccGroupsIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnnotationTask_AccGroupsIDList;
 end;//g_AnnotationTask = nil
 Result := g_AnnotationTask_AccGroupsIDList;
end;

var
 g_AnnotationTask_CommentsIDList : AnnotationTask_CommentsIDList_Tag = nil;

// start class CommentsIDList

function k2_typAnnotationTask_CommentsIDList: AnnotationTask_CommentsIDList_Tag;
begin
 if (g_AnnotationTask_CommentsIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnnotationTask_CommentsIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnnotationTask_CommentsIDList;
 end;//g_AnnotationTask = nil
 Result := g_AnnotationTask_CommentsIDList;
end;

var
 g_AnnotationTask_ExcludeDocTypesIDList : AnnotationTask_ExcludeDocTypesIDList_Tag = nil;

// start class ExcludeDocTypesIDList

function k2_typAnnotationTask_ExcludeDocTypesIDList: AnnotationTask_ExcludeDocTypesIDList_Tag;
begin
 if (g_AnnotationTask_ExcludeDocTypesIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnnotationTask_ExcludeDocTypesIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnnotationTask_ExcludeDocTypesIDList;
 end;//g_AnnotationTask = nil
 Result := g_AnnotationTask_ExcludeDocTypesIDList;
end;

var
 g_AnnotationTask_ExcludeDocBasesIDList : AnnotationTask_ExcludeDocBasesIDList_Tag = nil;

// start class ExcludeDocBasesIDList

function k2_typAnnotationTask_ExcludeDocBasesIDList: AnnotationTask_ExcludeDocBasesIDList_Tag;
begin
 if (g_AnnotationTask_ExcludeDocBasesIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnnotationTask_ExcludeDocBasesIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnnotationTask_ExcludeDocBasesIDList;
 end;//g_AnnotationTask = nil
 Result := g_AnnotationTask_ExcludeDocBasesIDList;
end;


end.