unit alcuRegionImportTaskPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuRegionImportTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuRegionImportTaskPrim" MUID: (5408670901C0)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuImport
 , l3Variant
 , k2Base
;

type
 TalcuRegionImportTaskPrim = class(TalcuImport)
  protected
   function pm_GetRegionIndex: Integer;
   procedure pm_SetRegionIndex(aValue: Integer);
   function pm_GetFTPParams: Tl3Tag;
   procedure pm_SetFTPParams(aValue: Tl3Tag);
   function pm_GetFileNameMask: AnsiString;
   procedure pm_SetFileNameMask(const aValue: AnsiString);
   function pm_GetSourceWarehouse: AnsiString;
   procedure pm_SetSourceWarehouse(const aValue: AnsiString);
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
   property SourceWarehouse: AnsiString
    read pm_GetSourceWarehouse
    write pm_SetSourceWarehouse;
 end;//TalcuRegionImportTaskPrim
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , RegionImportTask_Const
;

function TalcuRegionImportTaskPrim.pm_GetRegionIndex: Integer;
//#UC START# *3915CE580102_5408670901C0get_var*
//#UC END# *3915CE580102_5408670901C0get_var*
begin
//#UC START# *3915CE580102_5408670901C0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3915CE580102_5408670901C0get_impl*
end;//TalcuRegionImportTaskPrim.pm_GetRegionIndex

procedure TalcuRegionImportTaskPrim.pm_SetRegionIndex(aValue: Integer);
//#UC START# *3915CE580102_5408670901C0set_var*
//#UC END# *3915CE580102_5408670901C0set_var*
begin
//#UC START# *3915CE580102_5408670901C0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3915CE580102_5408670901C0set_impl*
end;//TalcuRegionImportTaskPrim.pm_SetRegionIndex

function TalcuRegionImportTaskPrim.pm_GetFTPParams: Tl3Tag;
//#UC START# *409C9CBD99AF_5408670901C0get_var*
//#UC END# *409C9CBD99AF_5408670901C0get_var*
begin
//#UC START# *409C9CBD99AF_5408670901C0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *409C9CBD99AF_5408670901C0get_impl*
end;//TalcuRegionImportTaskPrim.pm_GetFTPParams

procedure TalcuRegionImportTaskPrim.pm_SetFTPParams(aValue: Tl3Tag);
//#UC START# *409C9CBD99AF_5408670901C0set_var*
//#UC END# *409C9CBD99AF_5408670901C0set_var*
begin
//#UC START# *409C9CBD99AF_5408670901C0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *409C9CBD99AF_5408670901C0set_impl*
end;//TalcuRegionImportTaskPrim.pm_SetFTPParams

function TalcuRegionImportTaskPrim.pm_GetFileNameMask: AnsiString;
//#UC START# *29E6C621FC61_5408670901C0get_var*
//#UC END# *29E6C621FC61_5408670901C0get_var*
begin
//#UC START# *29E6C621FC61_5408670901C0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *29E6C621FC61_5408670901C0get_impl*
end;//TalcuRegionImportTaskPrim.pm_GetFileNameMask

procedure TalcuRegionImportTaskPrim.pm_SetFileNameMask(const aValue: AnsiString);
//#UC START# *29E6C621FC61_5408670901C0set_var*
//#UC END# *29E6C621FC61_5408670901C0set_var*
begin
//#UC START# *29E6C621FC61_5408670901C0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *29E6C621FC61_5408670901C0set_impl*
end;//TalcuRegionImportTaskPrim.pm_SetFileNameMask

function TalcuRegionImportTaskPrim.pm_GetSourceWarehouse: AnsiString;
//#UC START# *82B0A5CFAC45_5408670901C0get_var*
//#UC END# *82B0A5CFAC45_5408670901C0get_var*
begin
//#UC START# *82B0A5CFAC45_5408670901C0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *82B0A5CFAC45_5408670901C0get_impl*
end;//TalcuRegionImportTaskPrim.pm_GetSourceWarehouse

procedure TalcuRegionImportTaskPrim.pm_SetSourceWarehouse(const aValue: AnsiString);
//#UC START# *82B0A5CFAC45_5408670901C0set_var*
//#UC END# *82B0A5CFAC45_5408670901C0set_var*
begin
//#UC START# *82B0A5CFAC45_5408670901C0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *82B0A5CFAC45_5408670901C0set_impl*
end;//TalcuRegionImportTaskPrim.pm_SetSourceWarehouse

class function TalcuRegionImportTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_5408670901C0_var*
//#UC END# *53AC03EE01FD_5408670901C0_var*
begin
//#UC START# *53AC03EE01FD_5408670901C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_5408670901C0_impl*
end;//TalcuRegionImportTaskPrim.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
