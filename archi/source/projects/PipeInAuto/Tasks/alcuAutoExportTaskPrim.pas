unit alcuAutoExportTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuAutoExportTaskPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAutoExportTaskPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  evdDTTypes,
  evdTasksHelpers,
  k2Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAutoExportTaskPrim = class(TddProcessTask)
 protected
 // property methods
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
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   function pm_GetAnnoTemplate: AnsiString;
   procedure pm_SetAnnoTemplate(const aValue: AnsiString);
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   function pm_GetBasesIDList: BasesIDListHelper;
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   function pm_GetChangedDocTemplate: AnsiString;
   procedure pm_SetChangedDocTemplate(const aValue: AnsiString);
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   function pm_GetChangedRelTempate: AnsiString;
   procedure pm_SetChangedRelTempate(const aValue: AnsiString);
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   function pm_GetExecName: AnsiString;
   procedure pm_SetExecName(const aValue: AnsiString);
   function pm_GetExecParams: AnsiString;
   procedure pm_SetExecParams(const aValue: AnsiString);
   function pm_GetDocQueryFileName: AnsiString;
   procedure pm_SetDocQueryFileName(const aValue: AnsiString);
   {$If defined(ServerTasks) AND not defined(AEByBelongs)}
   function pm_GetDoneFileName: AnsiString;
   procedure pm_SetDoneFileName(const aValue: AnsiString);
   {$IfEnd} //ServerTasks AND not AEByBelongs
   function pm_GetExportFolder: AnsiString;
   procedure pm_SetExportFolder(const aValue: AnsiString);
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   function pm_GetIncludedDocTemplate: AnsiString;
   procedure pm_SetIncludedDocTemplate(const aValue: AnsiString);
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   function pm_GetIncludedRelTemplate: AnsiString;
   procedure pm_SetIncludedRelTemplate(const aValue: AnsiString);
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   function pm_GetInfoDocTemplate: AnsiString;
   procedure pm_SetInfoDocTemplate(const aValue: AnsiString);
   function pm_GetInfoIDList: InfoIDListHelper;
   function pm_GetInfoRelTemplate: AnsiString;
   procedure pm_SetInfoRelTemplate(const aValue: AnsiString);
   function pm_GetNeedTopicList: Boolean;
   procedure pm_SetNeedTopicList(aValue: Boolean);
   function pm_GetEMailNotifyList: AnsiString;
   procedure pm_SetEMailNotifyList(const aValue: AnsiString);
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
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
    {$If not defined(Nemesis)}
   function GetDescription: AnsiString; override;
    {$IfEnd} //not Nemesis
 public
 // public properties
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
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   property AnnoTemplate: AnsiString
     read pm_GetAnnoTemplate
     write pm_SetAnnoTemplate;
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   property BasesIDList: BasesIDListHelper
     read pm_GetBasesIDList;
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   property ChangedDocTemplate: AnsiString
     read pm_GetChangedDocTemplate
     write pm_SetChangedDocTemplate;
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   property ChangedRelTempate: AnsiString
     read pm_GetChangedRelTempate
     write pm_SetChangedRelTempate;
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   property ExecName: AnsiString
     read pm_GetExecName
     write pm_SetExecName;
   property ExecParams: AnsiString
     read pm_GetExecParams
     write pm_SetExecParams;
   property DocQueryFileName: AnsiString
     read pm_GetDocQueryFileName
     write pm_SetDocQueryFileName;
   {$If defined(ServerTasks) AND not defined(AEByBelongs)}
   property DoneFileName: AnsiString
     read pm_GetDoneFileName
     write pm_SetDoneFileName;
   {$IfEnd} //ServerTasks AND not AEByBelongs
   property ExportFolder: AnsiString
     read pm_GetExportFolder
     write pm_SetExportFolder;
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   property IncludedDocTemplate: AnsiString
     read pm_GetIncludedDocTemplate
     write pm_SetIncludedDocTemplate;
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
   {$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
   property IncludedRelTemplate: AnsiString
     read pm_GetIncludedRelTemplate
     write pm_SetIncludedRelTemplate;
   {$IfEnd} //ServerTasks AND not LUK AND not SGC
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
     read pm_GetEMailNotifyList
     write pm_SetEMailNotifyList;
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
 end;//TalcuAutoExportTaskPrim
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  AutoExportTask_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuAutoExportTaskPrim

function TalcuAutoExportTaskPrim.pm_GetToday: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrToday]);
end;//TalcuAutoExportTaskPrim.pm_GetToday

procedure TalcuAutoExportTaskPrim.pm_SetToday(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrToday, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetToday

function TalcuAutoExportTaskPrim.pm_GetCompileDate: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrCompileDate]);
end;//TalcuAutoExportTaskPrim.pm_GetCompileDate

procedure TalcuAutoExportTaskPrim.pm_SetCompileDate(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrCompileDate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetCompileDate

function TalcuAutoExportTaskPrim.pm_GetVersionDate: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrVersionDate]);
end;//TalcuAutoExportTaskPrim.pm_GetVersionDate

procedure TalcuAutoExportTaskPrim.pm_SetVersionDate(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrVersionDate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetVersionDate

function TalcuAutoExportTaskPrim.pm_GetOutFormat: TepSupportFileType;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TepSupportFileType(TaggedData.IntA[k2_attrOutFormat]);
end;//TalcuAutoExportTaskPrim.pm_GetOutFormat

procedure TalcuAutoExportTaskPrim.pm_SetOutFormat(aValue: TepSupportFileType);
 {-}
begin
 TaggedData.IntW[k2_attrOutFormat, nil] := Ord(aValue);
end;//TalcuAutoExportTaskPrim.pm_SetOutFormat

function TalcuAutoExportTaskPrim.pm_GetAnnoUseAccGroups: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrAnnoUseAccGroups]);
end;//TalcuAutoExportTaskPrim.pm_GetAnnoUseAccGroups

procedure TalcuAutoExportTaskPrim.pm_SetAnnoUseAccGroups(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrAnnoUseAccGroups, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetAnnoUseAccGroups

function TalcuAutoExportTaskPrim.pm_GetDocumentsSource: TaeDocSource;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TaeDocSource(TaggedData.IntA[k2_attrDocumentsSource]);
end;//TalcuAutoExportTaskPrim.pm_GetDocumentsSource

procedure TalcuAutoExportTaskPrim.pm_SetDocumentsSource(aValue: TaeDocSource);
 {-}
begin
 TaggedData.IntW[k2_attrDocumentsSource, nil] := Ord(aValue);
end;//TalcuAutoExportTaskPrim.pm_SetDocumentsSource

function TalcuAutoExportTaskPrim.pm_GetWithEditions: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrWithEditions]);
end;//TalcuAutoExportTaskPrim.pm_GetWithEditions

procedure TalcuAutoExportTaskPrim.pm_SetWithEditions(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrWithEditions, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetWithEditions

function TalcuAutoExportTaskPrim.pm_GetAccGroupsIDList: AccGroupsIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TAccGroupsIDListHelper.Make(TaggedData.cAtom(k2_attrAccGroupsIDList));
end;//TalcuAutoExportTaskPrim.pm_GetAccGroupsIDList

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetAnnoTemplate: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrAnnoTemplate]);
end;//TalcuAutoExportTaskPrim.pm_GetAnnoTemplate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetAnnoTemplate(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrAnnoTemplate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetAnnoTemplate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetBasesIDList: BasesIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TBasesIDListHelper.Make(TaggedData.cAtom(k2_attrBasesIDList));
end;//TalcuAutoExportTaskPrim.pm_GetBasesIDList
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetChangedDocTemplate: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrChangedDocTemplate]);
end;//TalcuAutoExportTaskPrim.pm_GetChangedDocTemplate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetChangedDocTemplate(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrChangedDocTemplate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetChangedDocTemplate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetChangedRelTempate: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrChangedRelTempate]);
end;//TalcuAutoExportTaskPrim.pm_GetChangedRelTempate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetChangedRelTempate(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrChangedRelTempate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetChangedRelTempate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

function TalcuAutoExportTaskPrim.pm_GetExecName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrExecName]);
end;//TalcuAutoExportTaskPrim.pm_GetExecName

procedure TalcuAutoExportTaskPrim.pm_SetExecName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrExecName, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetExecName

function TalcuAutoExportTaskPrim.pm_GetExecParams: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrExecParams]);
end;//TalcuAutoExportTaskPrim.pm_GetExecParams

procedure TalcuAutoExportTaskPrim.pm_SetExecParams(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrExecParams, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetExecParams

function TalcuAutoExportTaskPrim.pm_GetDocQueryFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocQueryFileName]);
end;//TalcuAutoExportTaskPrim.pm_GetDocQueryFileName

procedure TalcuAutoExportTaskPrim.pm_SetDocQueryFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrDocQueryFileName, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetDocQueryFileName

{$If defined(ServerTasks) AND not defined(AEByBelongs)}
function TalcuAutoExportTaskPrim.pm_GetDoneFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDoneFileName]);
end;//TalcuAutoExportTaskPrim.pm_GetDoneFileName
{$IfEnd} //ServerTasks AND not AEByBelongs

{$If defined(ServerTasks) AND not defined(AEByBelongs)}
procedure TalcuAutoExportTaskPrim.pm_SetDoneFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrDoneFileName, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetDoneFileName
{$IfEnd} //ServerTasks AND not AEByBelongs

function TalcuAutoExportTaskPrim.pm_GetExportFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrExportFolder]);
end;//TalcuAutoExportTaskPrim.pm_GetExportFolder

procedure TalcuAutoExportTaskPrim.pm_SetExportFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrExportFolder, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetExportFolder

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetIncludedDocTemplate: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrIncludedDocTemplate]);
end;//TalcuAutoExportTaskPrim.pm_GetIncludedDocTemplate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetIncludedDocTemplate(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrIncludedDocTemplate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetIncludedDocTemplate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
function TalcuAutoExportTaskPrim.pm_GetIncludedRelTemplate: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrIncludedRelTemplate]);
end;//TalcuAutoExportTaskPrim.pm_GetIncludedRelTemplate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

{$If defined(ServerTasks) AND not defined(LUK) AND not defined(SGC)}
procedure TalcuAutoExportTaskPrim.pm_SetIncludedRelTemplate(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrIncludedRelTemplate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetIncludedRelTemplate
{$IfEnd} //ServerTasks AND not LUK AND not SGC

function TalcuAutoExportTaskPrim.pm_GetInfoDocTemplate: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrInfoDocTemplate]);
end;//TalcuAutoExportTaskPrim.pm_GetInfoDocTemplate

procedure TalcuAutoExportTaskPrim.pm_SetInfoDocTemplate(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrInfoDocTemplate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetInfoDocTemplate

function TalcuAutoExportTaskPrim.pm_GetInfoIDList: InfoIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TInfoIDListHelper.Make(TaggedData.cAtom(k2_attrInfoIDList));
end;//TalcuAutoExportTaskPrim.pm_GetInfoIDList

function TalcuAutoExportTaskPrim.pm_GetInfoRelTemplate: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrInfoRelTemplate]);
end;//TalcuAutoExportTaskPrim.pm_GetInfoRelTemplate

procedure TalcuAutoExportTaskPrim.pm_SetInfoRelTemplate(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrInfoRelTemplate, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetInfoRelTemplate

function TalcuAutoExportTaskPrim.pm_GetNeedTopicList: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedTopicList]);
end;//TalcuAutoExportTaskPrim.pm_GetNeedTopicList

procedure TalcuAutoExportTaskPrim.pm_SetNeedTopicList(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrNeedTopicList, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetNeedTopicList

function TalcuAutoExportTaskPrim.pm_GetEMailNotifyList: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attreMailNotifyList]);
end;//TalcuAutoExportTaskPrim.pm_GetEMailNotifyList

procedure TalcuAutoExportTaskPrim.pm_SetEMailNotifyList(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attreMailNotifyList, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetEMailNotifyList

function TalcuAutoExportTaskPrim.pm_GetSMSNotifyList: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSMSNotifyList]);
end;//TalcuAutoExportTaskPrim.pm_GetSMSNotifyList

procedure TalcuAutoExportTaskPrim.pm_SetSMSNotifyList(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrSMSNotifyList, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetSMSNotifyList

function TalcuAutoExportTaskPrim.pm_GetPartSize: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrPartSize]);
end;//TalcuAutoExportTaskPrim.pm_GetPartSize

procedure TalcuAutoExportTaskPrim.pm_SetPartSize(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrPartSize, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetPartSize

function TalcuAutoExportTaskPrim.pm_GetMaxExportCount: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrMaxExportCount]);
end;//TalcuAutoExportTaskPrim.pm_GetMaxExportCount

procedure TalcuAutoExportTaskPrim.pm_SetMaxExportCount(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrMaxExportCount, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetMaxExportCount

function TalcuAutoExportTaskPrim.pm_GetStages: TaeStagesSet;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := k2_typAutoExportTask_Stages_ToSet(TaggedData.IntA[k2_attrStages]);
end;//TalcuAutoExportTaskPrim.pm_GetStages

procedure TalcuAutoExportTaskPrim.pm_SetStages(aValue: TaeStagesSet);
 {-}
begin
 TaggedData.IntW[k2_attrStages, nil] := k2_typAutoExportTask_Stages_FromSet(aValue);
end;//TalcuAutoExportTaskPrim.pm_SetStages

function TalcuAutoExportTaskPrim.pm_GetExpandEditions: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExpandEditions]);
end;//TalcuAutoExportTaskPrim.pm_GetExpandEditions

procedure TalcuAutoExportTaskPrim.pm_SetExpandEditions(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrExpandEditions, nil] := (aValue);
end;//TalcuAutoExportTaskPrim.pm_SetExpandEditions

class function TalcuAutoExportTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAutoExportTask;
end;//TalcuAutoExportTaskPrim.GetTaggedDataType

{$If not defined(Nemesis)}
function TalcuAutoExportTaskPrim.GetDescription: AnsiString;
//#UC START# *53FB28170339_53B6A5FA0212_var*
//#UC END# *53FB28170339_53B6A5FA0212_var*
begin
//#UC START# *53FB28170339_53B6A5FA0212_impl*
 Result := 'Автоматический экспорт документов и аннотаций';
//#UC END# *53FB28170339_53B6A5FA0212_impl*
end;//TalcuAutoExportTaskPrim.GetDescription
{$IfEnd} //not Nemesis

{$IfEnd} //ServerTasks

end.