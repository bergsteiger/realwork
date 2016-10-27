unit csImportTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csImportTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsImportTaskPrim" MUID: (53ABFE3202CF)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsImportTaskPrim = class(TddProcessTask)
  protected
   function pm_GetDeleteIncluded: Boolean;
   procedure pm_SetDeleteIncluded(aValue: Boolean);
   function pm_GetIsAnnotation: Boolean;
   procedure pm_SetIsAnnotation(aValue: Boolean);
   function pm_GetIsRegion: Boolean;
   procedure pm_SetIsRegion(aValue: Boolean);
   function pm_GetSourceDir: AnsiString;
   procedure pm_SetSourceDir(const aValue: AnsiString);
   function pm_GetSourceFiles: SourceFilesHelper;
   function pm_GetRegionIDList: RegionIDListHelper;
   function pm_GetSafeDir: AnsiString;
   procedure pm_SetSafeDir(const aValue: AnsiString);
   function pm_GetNeedSendMailReport: Boolean;
   procedure pm_SetNeedSendMailReport(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property DeleteIncluded: Boolean
    read pm_GetDeleteIncluded
    write pm_SetDeleteIncluded;
   property IsAnnotation: Boolean
    read pm_GetIsAnnotation
    write pm_SetIsAnnotation;
   property IsRegion: Boolean
    read pm_GetIsRegion
    write pm_SetIsRegion;
   property SourceDir: AnsiString
    read pm_GetSourceDir
    write pm_SetSourceDir;
   property SourceFiles: SourceFilesHelper
    read pm_GetSourceFiles;
   property RegionIDList: RegionIDListHelper
    read pm_GetRegionIDList;
   property SafeDir: AnsiString
    read pm_GetSafeDir
    write pm_SetSafeDir;
   property NeedSendMailReport: Boolean
    read pm_GetNeedSendMailReport
    write pm_SetNeedSendMailReport;
 end;//TcsImportTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ImportTask_Const
 //#UC START# *53ABFE3202CFimpl_uses*
 //#UC END# *53ABFE3202CFimpl_uses*
;

function TcsImportTaskPrim.pm_GetDeleteIncluded: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrDeleteIncluded]);
end;//TcsImportTaskPrim.pm_GetDeleteIncluded

procedure TcsImportTaskPrim.pm_SetDeleteIncluded(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrDeleteIncluded, nil] := (aValue);
end;//TcsImportTaskPrim.pm_SetDeleteIncluded

function TcsImportTaskPrim.pm_GetIsAnnotation: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsAnnotation]);
end;//TcsImportTaskPrim.pm_GetIsAnnotation

procedure TcsImportTaskPrim.pm_SetIsAnnotation(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsAnnotation, nil] := (aValue);
end;//TcsImportTaskPrim.pm_SetIsAnnotation

function TcsImportTaskPrim.pm_GetIsRegion: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsRegion]);
end;//TcsImportTaskPrim.pm_GetIsRegion

procedure TcsImportTaskPrim.pm_SetIsRegion(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsRegion, nil] := (aValue);
end;//TcsImportTaskPrim.pm_SetIsRegion

function TcsImportTaskPrim.pm_GetSourceDir: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSourceDir]);
end;//TcsImportTaskPrim.pm_GetSourceDir

procedure TcsImportTaskPrim.pm_SetSourceDir(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSourceDir, nil] := (aValue);
end;//TcsImportTaskPrim.pm_SetSourceDir

function TcsImportTaskPrim.pm_GetSourceFiles: SourceFilesHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TSourceFilesHelper.Make(TaggedData.cAtom(k2_attrSourceFiles));
end;//TcsImportTaskPrim.pm_GetSourceFiles

function TcsImportTaskPrim.pm_GetRegionIDList: RegionIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TRegionIDListHelper.Make(TaggedData.cAtom(k2_attrRegionIDList));
end;//TcsImportTaskPrim.pm_GetRegionIDList

function TcsImportTaskPrim.pm_GetSafeDir: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSafeDir]);
end;//TcsImportTaskPrim.pm_GetSafeDir

procedure TcsImportTaskPrim.pm_SetSafeDir(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSafeDir, nil] := (aValue);
end;//TcsImportTaskPrim.pm_SetSafeDir

function TcsImportTaskPrim.pm_GetNeedSendMailReport: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedSendMailReport]);
end;//TcsImportTaskPrim.pm_GetNeedSendMailReport

procedure TcsImportTaskPrim.pm_SetNeedSendMailReport(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrNeedSendMailReport, nil] := (aValue);
end;//TcsImportTaskPrim.pm_SetNeedSendMailReport

class function TcsImportTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typImportTask;
end;//TcsImportTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
