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
 //#UC START# *53B6A4F300DEimpl_uses*
 //#UC END# *53B6A4F300DEimpl_uses*
;

function TcsAnnotationTask.pm_GetNeedAnalyzeLog: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedAnalyzeLog]);
end;//TcsAnnotationTask.pm_GetNeedAnalyzeLog

procedure TcsAnnotationTask.pm_SetNeedAnalyzeLog(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrNeedAnalyzeLog, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetNeedAnalyzeLog

function TcsAnnotationTask.pm_GetTargetFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTargetFolder]);
end;//TcsAnnotationTask.pm_GetTargetFolder

procedure TcsAnnotationTask.pm_SetTargetFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTargetFolder, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetTargetFolder

function TcsAnnotationTask.pm_GeteMailNotifyList: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attreMailNotifyList]);
end;//TcsAnnotationTask.pm_GeteMailNotifyList

procedure TcsAnnotationTask.pm_SeteMailNotifyList(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attreMailNotifyList, nil] := (aValue);
end;//TcsAnnotationTask.pm_SeteMailNotifyList

function TcsAnnotationTask.pm_GetExternalProcessor: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrExternalProcessor]);
end;//TcsAnnotationTask.pm_GetExternalProcessor

procedure TcsAnnotationTask.pm_SetExternalProcessor(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrExternalProcessor, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetExternalProcessor

function TcsAnnotationTask.pm_GetOutFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrOutFolder]);
end;//TcsAnnotationTask.pm_GetOutFolder

procedure TcsAnnotationTask.pm_SetOutFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrOutFolder, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetOutFolder

function TcsAnnotationTask.pm_GetPrimeRobotEMail: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrPrimeRobotEMail]);
end;//TcsAnnotationTask.pm_GetPrimeRobotEMail

procedure TcsAnnotationTask.pm_SetPrimeRobotEMail(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrPrimeRobotEMail, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetPrimeRobotEMail

function TcsAnnotationTask.pm_GetExportDocuments: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportDocuments]);
end;//TcsAnnotationTask.pm_GetExportDocuments

procedure TcsAnnotationTask.pm_SetExportDocuments(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportDocuments, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetExportDocuments

function TcsAnnotationTask.pm_GetDocListFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocListFileName]);
end;//TcsAnnotationTask.pm_GetDocListFileName

procedure TcsAnnotationTask.pm_SetDocListFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDocListFileName, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetDocListFileName

function TcsAnnotationTask.pm_GetDocListFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocListFolder]);
end;//TcsAnnotationTask.pm_GetDocListFolder

procedure TcsAnnotationTask.pm_SetDocListFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDocListFolder, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetDocListFolder

function TcsAnnotationTask.pm_GetEndDateKind: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrEndDateKind]);
end;//TcsAnnotationTask.pm_GetEndDateKind

procedure TcsAnnotationTask.pm_SetEndDateKind(aValue: Integer);
begin
 TaggedData.IntW[k2_attrEndDateKind, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetEndDateKind

function TcsAnnotationTask.pm_GetStartDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrStartDate]);
end;//TcsAnnotationTask.pm_GetStartDate

procedure TcsAnnotationTask.pm_SetStartDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrStartDate, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetStartDate

function TcsAnnotationTask.pm_GetBelongsIDList: BelongsIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TBelongsIDListHelper.Make(TaggedData.cAtom(k2_attrBelongsIDList));
end;//TcsAnnotationTask.pm_GetBelongsIDList

{$If NOT Defined(Region)}
function TcsAnnotationTask.pm_GetExcludeAccGroupsIDList: ExcludeAccGroupsIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TExcludeAccGroupsIDListHelper.Make(TaggedData.cAtom(k2_attrExcludeAccGroupsIDList));
end;//TcsAnnotationTask.pm_GetExcludeAccGroupsIDList
{$IfEnd} // NOT Defined(Region)

function TcsAnnotationTask.pm_GetAccGroupsIDList: AccGroupsIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TAccGroupsIDListHelper.Make(TaggedData.cAtom(k2_attrAccGroupsIDList));
end;//TcsAnnotationTask.pm_GetAccGroupsIDList

function TcsAnnotationTask.pm_GetCommentsIDList: CommentsIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TCommentsIDListHelper.Make(TaggedData.cAtom(k2_attrCommentsIDList));
end;//TcsAnnotationTask.pm_GetCommentsIDList

function TcsAnnotationTask.pm_GetExcludeDocTypesIDList: ExcludeDocTypesIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TExcludeDocTypesIDListHelper.Make(TaggedData.cAtom(k2_attrExcludeDocTypesIDList));
end;//TcsAnnotationTask.pm_GetExcludeDocTypesIDList

function TcsAnnotationTask.pm_GetExcludeDocBasesIDList: ExcludeDocBasesIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TExcludeDocBasesIDListHelper.Make(TaggedData.cAtom(k2_attrExcludeDocBasesIDList));
end;//TcsAnnotationTask.pm_GetExcludeDocBasesIDList

function TcsAnnotationTask.pm_GetAnnoFilenameTemplate: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrAnnoFilenameTemplate]);
end;//TcsAnnotationTask.pm_GetAnnoFilenameTemplate

procedure TcsAnnotationTask.pm_SetAnnoFilenameTemplate(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrAnnoFilenameTemplate, nil] := (aValue);
end;//TcsAnnotationTask.pm_SetAnnoFilenameTemplate

function TcsAnnotationTask.GetDescription: AnsiString;
//#UC START# *53FB28170339_53B6A4F300DE_var*
//#UC END# *53FB28170339_53B6A4F300DE_var*
begin
//#UC START# *53FB28170339_53B6A4F300DE_impl*
 Result := 'Экспорт Прайм';
//#UC END# *53FB28170339_53B6A4F300DE_impl*
end;//TcsAnnotationTask.GetDescription

class function TcsAnnotationTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAnnotationTask;
end;//TcsAnnotationTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
