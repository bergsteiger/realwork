unit csAnnotationTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csAnnotationTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsAnnotationTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csProcessTask,
  evdTasksHelpers,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsAnnotationTask = class(TddProcessTask)
 protected
 // property methods
   function pm_GetNeedAnalyzeLog: Boolean;
   procedure pm_SetNeedAnalyzeLog(aValue: Boolean);
   function pm_GetTargetFolder: AnsiString;
   procedure pm_SetTargetFolder(const aValue: AnsiString);
   function pm_GetEMailNotifyList: AnsiString;
   procedure pm_SetEMailNotifyList(const aValue: AnsiString);
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
   {$If not defined(Nemesis) AND not defined(Region)}
   function pm_GetExcludeAccGroupsIDList: ExcludeAccGroupsIDListHelper;
   {$IfEnd} //not Nemesis AND not Region
   function pm_GetAccGroupsIDList: AccGroupsIDListHelper;
   function pm_GetCommentsIDList: CommentsIDListHelper;
   function pm_GetExcludeDocTypesIDList: ExcludeDocTypesIDListHelper;
   function pm_GetExcludeDocBasesIDList: ExcludeDocBasesIDListHelper;
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
   function GetDescription: AnsiString; override;
 public
 // public properties
   property NeedAnalyzeLog: Boolean
     read pm_GetNeedAnalyzeLog
     write pm_SetNeedAnalyzeLog;
   property TargetFolder: AnsiString
     read pm_GetTargetFolder
     write pm_SetTargetFolder;
   property eMailNotifyList: AnsiString
     read pm_GetEMailNotifyList
     write pm_SetEMailNotifyList;
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
   {$If not defined(Nemesis) AND not defined(Region)}
   property ExcludeAccGroupsIDList: ExcludeAccGroupsIDListHelper
     read pm_GetExcludeAccGroupsIDList;
   {$IfEnd} //not Nemesis AND not Region
   property AccGroupsIDList: AccGroupsIDListHelper
     read pm_GetAccGroupsIDList;
   property CommentsIDList: CommentsIDListHelper
     read pm_GetCommentsIDList;
   property ExcludeDocTypesIDList: ExcludeDocTypesIDListHelper
     read pm_GetExcludeDocTypesIDList;
   property ExcludeDocBasesIDList: ExcludeDocBasesIDListHelper
     read pm_GetExcludeDocBasesIDList;
 end;//TcsAnnotationTask
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  AnnotationTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsAnnotationTask

function TcsAnnotationTask.pm_GetNeedAnalyzeLog: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedAnalyzeLog]);
end;//TcsAnnotationTask.pm_GetNeedAnalyzeLog

procedure TcsAnnotationTask.pm_SetNeedAnalyzeLog(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrNeedAnalyzeLog, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetNeedAnalyzeLog

function TcsAnnotationTask.pm_GetTargetFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTargetFolder]);
end;//TcsAnnotationTask.pm_GetTargetFolder

procedure TcsAnnotationTask.pm_SetTargetFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTargetFolder, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetTargetFolder

function TcsAnnotationTask.pm_GetEMailNotifyList: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attreMailNotifyList]);
end;//TcsAnnotationTask.pm_GetEMailNotifyList

procedure TcsAnnotationTask.pm_SetEMailNotifyList(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attreMailNotifyList, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetEMailNotifyList

function TcsAnnotationTask.pm_GetExternalProcessor: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrExternalProcessor]);
end;//TcsAnnotationTask.pm_GetExternalProcessor

procedure TcsAnnotationTask.pm_SetExternalProcessor(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrExternalProcessor, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetExternalProcessor

function TcsAnnotationTask.pm_GetOutFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrOutFolder]);
end;//TcsAnnotationTask.pm_GetOutFolder

procedure TcsAnnotationTask.pm_SetOutFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrOutFolder, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetOutFolder

function TcsAnnotationTask.pm_GetPrimeRobotEMail: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrPrimeRobotEMail]);
end;//TcsAnnotationTask.pm_GetPrimeRobotEMail

procedure TcsAnnotationTask.pm_SetPrimeRobotEMail(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrPrimeRobotEMail, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetPrimeRobotEMail

function TcsAnnotationTask.pm_GetExportDocuments: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportDocuments]);
end;//TcsAnnotationTask.pm_GetExportDocuments

procedure TcsAnnotationTask.pm_SetExportDocuments(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrExportDocuments, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetExportDocuments

function TcsAnnotationTask.pm_GetDocListFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocListFileName]);
end;//TcsAnnotationTask.pm_GetDocListFileName

procedure TcsAnnotationTask.pm_SetDocListFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrDocListFileName, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetDocListFileName

function TcsAnnotationTask.pm_GetDocListFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocListFolder]);
end;//TcsAnnotationTask.pm_GetDocListFolder

procedure TcsAnnotationTask.pm_SetDocListFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrDocListFolder, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetDocListFolder

function TcsAnnotationTask.pm_GetEndDateKind: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrEndDateKind]);
end;//TcsAnnotationTask.pm_GetEndDateKind

procedure TcsAnnotationTask.pm_SetEndDateKind(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrEndDateKind, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetEndDateKind

function TcsAnnotationTask.pm_GetStartDate: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrStartDate]);
end;//TcsAnnotationTask.pm_GetStartDate

procedure TcsAnnotationTask.pm_SetStartDate(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrStartDate, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetStartDate

function TcsAnnotationTask.pm_GetBelongsIDList: BelongsIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TBelongsIDListHelper.Make(TaggedData.cAtom(k2_attrBelongsIDList));
end;//TcsAnnotationTask.pm_GetBelongsIDList

{$If not defined(Nemesis) AND not defined(Region)}
function TcsAnnotationTask.pm_GetExcludeAccGroupsIDList: ExcludeAccGroupsIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TExcludeAccGroupsIDListHelper.Make(TaggedData.cAtom(k2_attrExcludeAccGroupsIDList));
end;//TcsAnnotationTask.pm_GetExcludeAccGroupsIDList
{$IfEnd} //not Nemesis AND not Region

function TcsAnnotationTask.pm_GetAccGroupsIDList: AccGroupsIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TAccGroupsIDListHelper.Make(TaggedData.cAtom(k2_attrAccGroupsIDList));
end;//TcsAnnotationTask.pm_GetAccGroupsIDList

function TcsAnnotationTask.pm_GetCommentsIDList: CommentsIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TCommentsIDListHelper.Make(TaggedData.cAtom(k2_attrCommentsIDList));
end;//TcsAnnotationTask.pm_GetCommentsIDList

function TcsAnnotationTask.pm_GetExcludeDocTypesIDList: ExcludeDocTypesIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TExcludeDocTypesIDListHelper.Make(TaggedData.cAtom(k2_attrExcludeDocTypesIDList));
end;//TcsAnnotationTask.pm_GetExcludeDocTypesIDList

function TcsAnnotationTask.pm_GetExcludeDocBasesIDList: ExcludeDocBasesIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TExcludeDocBasesIDListHelper.Make(TaggedData.cAtom(k2_attrExcludeDocBasesIDList));
end;//TcsAnnotationTask.pm_GetExcludeDocBasesIDList

class function TcsAnnotationTask.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAnnotationTask;
end;//TcsAnnotationTask.GetTaggedDataType

function TcsAnnotationTask.GetDescription: AnsiString;
//#UC START# *53FB28170339_53B6A4F300DE_var*
//#UC END# *53FB28170339_53B6A4F300DE_var*
begin
//#UC START# *53FB28170339_53B6A4F300DE_impl*
 Result := 'Экспорт Прайм';
//#UC END# *53FB28170339_53B6A4F300DE_impl*
end;//TcsAnnotationTask.GetDescription

{$IfEnd} //not Nemesis

end.