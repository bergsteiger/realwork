unit alcuRegionAutoExportTaskPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuRegionAutoExportTaskPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuAutoExportTask
 , l3Variant
 , k2Base
;

type
 TalcuRegionAutoExportTaskPrim = class(TalcuAutoExportTask)
  protected
   function pm_GetRegionIndex: Integer;
   procedure pm_SetRegionIndex(aValue: Integer);
   function pm_GetFTPParams: Tl3Tag;
   procedure pm_SetFTPParams(aValue: Tl3Tag);
   function pm_GetFileNameMask: AnsiString;
   procedure pm_SetFileNameMask(const aValue: AnsiString);
   function pm_GetResultWarehouse: AnsiString;
   procedure pm_SetResultWarehouse(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property RegionIndex: Integer
    read pm_GetRegionIndex
    write pm_SetRegionIndex;
   property FTPParams: Tl3Tag
    read pm_GetFTPParams
    write pm_SetFTPParams;
   property FileNameMask: AnsiString
    read pm_GetFileNameMask
    write pm_SetFileNameMask;
   property ResultWarehouse: AnsiString
    read pm_GetResultWarehouse
    write pm_SetResultWarehouse;
 end;//TalcuRegionAutoExportTaskPrim
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , RegionAutoExportTask_Const
;

function TalcuRegionAutoExportTaskPrim.pm_GetRegionIndex: Integer;
//#UC START# *348B7F231B99_540466FA008Bget_var*
//#UC END# *348B7F231B99_540466FA008Bget_var*
begin
//#UC START# *348B7F231B99_540466FA008Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *348B7F231B99_540466FA008Bget_impl*
end;//TalcuRegionAutoExportTaskPrim.pm_GetRegionIndex

procedure TalcuRegionAutoExportTaskPrim.pm_SetRegionIndex(aValue: Integer);
//#UC START# *348B7F231B99_540466FA008Bset_var*
//#UC END# *348B7F231B99_540466FA008Bset_var*
begin
//#UC START# *348B7F231B99_540466FA008Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *348B7F231B99_540466FA008Bset_impl*
end;//TalcuRegionAutoExportTaskPrim.pm_SetRegionIndex

function TalcuRegionAutoExportTaskPrim.pm_GetFTPParams: Tl3Tag;
//#UC START# *E962DB912BF7_540466FA008Bget_var*
//#UC END# *E962DB912BF7_540466FA008Bget_var*
begin
//#UC START# *E962DB912BF7_540466FA008Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E962DB912BF7_540466FA008Bget_impl*
end;//TalcuRegionAutoExportTaskPrim.pm_GetFTPParams

procedure TalcuRegionAutoExportTaskPrim.pm_SetFTPParams(aValue: Tl3Tag);
//#UC START# *E962DB912BF7_540466FA008Bset_var*
//#UC END# *E962DB912BF7_540466FA008Bset_var*
begin
//#UC START# *E962DB912BF7_540466FA008Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *E962DB912BF7_540466FA008Bset_impl*
end;//TalcuRegionAutoExportTaskPrim.pm_SetFTPParams

function TalcuRegionAutoExportTaskPrim.pm_GetFileNameMask: AnsiString;
//#UC START# *91FF306EFAB4_540466FA008Bget_var*
//#UC END# *91FF306EFAB4_540466FA008Bget_var*
begin
//#UC START# *91FF306EFAB4_540466FA008Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *91FF306EFAB4_540466FA008Bget_impl*
end;//TalcuRegionAutoExportTaskPrim.pm_GetFileNameMask

procedure TalcuRegionAutoExportTaskPrim.pm_SetFileNameMask(const aValue: AnsiString);
//#UC START# *91FF306EFAB4_540466FA008Bset_var*
//#UC END# *91FF306EFAB4_540466FA008Bset_var*
begin
//#UC START# *91FF306EFAB4_540466FA008Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *91FF306EFAB4_540466FA008Bset_impl*
end;//TalcuRegionAutoExportTaskPrim.pm_SetFileNameMask

function TalcuRegionAutoExportTaskPrim.pm_GetResultWarehouse: AnsiString;
//#UC START# *1E7A33327C44_540466FA008Bget_var*
//#UC END# *1E7A33327C44_540466FA008Bget_var*
begin
//#UC START# *1E7A33327C44_540466FA008Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1E7A33327C44_540466FA008Bget_impl*
end;//TalcuRegionAutoExportTaskPrim.pm_GetResultWarehouse

procedure TalcuRegionAutoExportTaskPrim.pm_SetResultWarehouse(const aValue: AnsiString);
//#UC START# *1E7A33327C44_540466FA008Bset_var*
//#UC END# *1E7A33327C44_540466FA008Bset_var*
begin
//#UC START# *1E7A33327C44_540466FA008Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *1E7A33327C44_540466FA008Bset_impl*
end;//TalcuRegionAutoExportTaskPrim.pm_SetResultWarehouse

class function TalcuRegionAutoExportTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_540466FA008B_var*
//#UC END# *53AC03EE01FD_540466FA008B_var*
begin
//#UC START# *53AC03EE01FD_540466FA008B_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_540466FA008B_impl*
end;//TalcuRegionAutoExportTaskPrim.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
