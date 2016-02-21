unit csImportTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csImportTaskPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , ImportTask_Const
 , csTasksHelpers
 , evdTasksHelpers
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
;

function TcsImportTaskPrim.pm_GetDeleteIncluded: Boolean;
//#UC START# *47BFB74D5B66_53ABFE3202CFget_var*
//#UC END# *47BFB74D5B66_53ABFE3202CFget_var*
begin
//#UC START# *47BFB74D5B66_53ABFE3202CFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *47BFB74D5B66_53ABFE3202CFget_impl*
end;//TcsImportTaskPrim.pm_GetDeleteIncluded

procedure TcsImportTaskPrim.pm_SetDeleteIncluded(aValue: Boolean);
//#UC START# *47BFB74D5B66_53ABFE3202CFset_var*
//#UC END# *47BFB74D5B66_53ABFE3202CFset_var*
begin
//#UC START# *47BFB74D5B66_53ABFE3202CFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *47BFB74D5B66_53ABFE3202CFset_impl*
end;//TcsImportTaskPrim.pm_SetDeleteIncluded

function TcsImportTaskPrim.pm_GetIsAnnotation: Boolean;
//#UC START# *2F5C48AC4623_53ABFE3202CFget_var*
//#UC END# *2F5C48AC4623_53ABFE3202CFget_var*
begin
//#UC START# *2F5C48AC4623_53ABFE3202CFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *2F5C48AC4623_53ABFE3202CFget_impl*
end;//TcsImportTaskPrim.pm_GetIsAnnotation

procedure TcsImportTaskPrim.pm_SetIsAnnotation(aValue: Boolean);
//#UC START# *2F5C48AC4623_53ABFE3202CFset_var*
//#UC END# *2F5C48AC4623_53ABFE3202CFset_var*
begin
//#UC START# *2F5C48AC4623_53ABFE3202CFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *2F5C48AC4623_53ABFE3202CFset_impl*
end;//TcsImportTaskPrim.pm_SetIsAnnotation

function TcsImportTaskPrim.pm_GetIsRegion: Boolean;
//#UC START# *D08AD0DF0D21_53ABFE3202CFget_var*
//#UC END# *D08AD0DF0D21_53ABFE3202CFget_var*
begin
//#UC START# *D08AD0DF0D21_53ABFE3202CFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D08AD0DF0D21_53ABFE3202CFget_impl*
end;//TcsImportTaskPrim.pm_GetIsRegion

procedure TcsImportTaskPrim.pm_SetIsRegion(aValue: Boolean);
//#UC START# *D08AD0DF0D21_53ABFE3202CFset_var*
//#UC END# *D08AD0DF0D21_53ABFE3202CFset_var*
begin
//#UC START# *D08AD0DF0D21_53ABFE3202CFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *D08AD0DF0D21_53ABFE3202CFset_impl*
end;//TcsImportTaskPrim.pm_SetIsRegion

function TcsImportTaskPrim.pm_GetSourceDir: AnsiString;
//#UC START# *AA8B621AD004_53ABFE3202CFget_var*
//#UC END# *AA8B621AD004_53ABFE3202CFget_var*
begin
//#UC START# *AA8B621AD004_53ABFE3202CFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *AA8B621AD004_53ABFE3202CFget_impl*
end;//TcsImportTaskPrim.pm_GetSourceDir

procedure TcsImportTaskPrim.pm_SetSourceDir(const aValue: AnsiString);
//#UC START# *AA8B621AD004_53ABFE3202CFset_var*
//#UC END# *AA8B621AD004_53ABFE3202CFset_var*
begin
//#UC START# *AA8B621AD004_53ABFE3202CFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *AA8B621AD004_53ABFE3202CFset_impl*
end;//TcsImportTaskPrim.pm_SetSourceDir

function TcsImportTaskPrim.pm_GetSourceFiles: SourceFilesHelper;
//#UC START# *ED171EB46231_53ABFE3202CFget_var*
//#UC END# *ED171EB46231_53ABFE3202CFget_var*
begin
//#UC START# *ED171EB46231_53ABFE3202CFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *ED171EB46231_53ABFE3202CFget_impl*
end;//TcsImportTaskPrim.pm_GetSourceFiles

function TcsImportTaskPrim.pm_GetRegionIDList: RegionIDListHelper;
//#UC START# *7143938433F7_53ABFE3202CFget_var*
//#UC END# *7143938433F7_53ABFE3202CFget_var*
begin
//#UC START# *7143938433F7_53ABFE3202CFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *7143938433F7_53ABFE3202CFget_impl*
end;//TcsImportTaskPrim.pm_GetRegionIDList

function TcsImportTaskPrim.pm_GetSafeDir: AnsiString;
//#UC START# *C1E6916E281F_53ABFE3202CFget_var*
//#UC END# *C1E6916E281F_53ABFE3202CFget_var*
begin
//#UC START# *C1E6916E281F_53ABFE3202CFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *C1E6916E281F_53ABFE3202CFget_impl*
end;//TcsImportTaskPrim.pm_GetSafeDir

procedure TcsImportTaskPrim.pm_SetSafeDir(const aValue: AnsiString);
//#UC START# *C1E6916E281F_53ABFE3202CFset_var*
//#UC END# *C1E6916E281F_53ABFE3202CFset_var*
begin
//#UC START# *C1E6916E281F_53ABFE3202CFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *C1E6916E281F_53ABFE3202CFset_impl*
end;//TcsImportTaskPrim.pm_SetSafeDir

function TcsImportTaskPrim.pm_GetNeedSendMailReport: Boolean;
//#UC START# *D0134BFEABB1_53ABFE3202CFget_var*
//#UC END# *D0134BFEABB1_53ABFE3202CFget_var*
begin
//#UC START# *D0134BFEABB1_53ABFE3202CFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D0134BFEABB1_53ABFE3202CFget_impl*
end;//TcsImportTaskPrim.pm_GetNeedSendMailReport

procedure TcsImportTaskPrim.pm_SetNeedSendMailReport(aValue: Boolean);
//#UC START# *D0134BFEABB1_53ABFE3202CFset_var*
//#UC END# *D0134BFEABB1_53ABFE3202CFset_var*
begin
//#UC START# *D0134BFEABB1_53ABFE3202CFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *D0134BFEABB1_53ABFE3202CFset_impl*
end;//TcsImportTaskPrim.pm_SetNeedSendMailReport

class function TcsImportTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53ABFE3202CF_var*
//#UC END# *53AC03EE01FD_53ABFE3202CF_var*
begin
//#UC START# *53AC03EE01FD_53ABFE3202CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53ABFE3202CF_impl*
end;//TcsImportTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
