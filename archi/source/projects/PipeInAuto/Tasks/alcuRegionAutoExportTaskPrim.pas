unit alcuRegionAutoExportTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuRegionAutoExportTaskPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuRegionAutoExportTaskPrim
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
  alcuAutoExportTask,
  l3Variant,
  k2Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuRegionAutoExportTaskPrim = class(TalcuAutoExportTask)
 protected
 // property methods
   function pm_GetRegionIndex: Integer;
   procedure pm_SetRegionIndex(aValue: Integer);
   function pm_GetFTPParams: Tl3Tag;
   procedure pm_SetFTPParams(aValue: Tl3Tag);
   function pm_GetFileNameMask: AnsiString;
   procedure pm_SetFileNameMask(const aValue: AnsiString);
   function pm_GetResultWarehouse: AnsiString;
   procedure pm_SetResultWarehouse(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
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
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  RegionAutoExportTask_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuRegionAutoExportTaskPrim

function TalcuRegionAutoExportTaskPrim.pm_GetRegionIndex: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrRegionIndex]);
end;//TalcuRegionAutoExportTaskPrim.pm_GetRegionIndex

procedure TalcuRegionAutoExportTaskPrim.pm_SetRegionIndex(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrRegionIndex, nil] := (aValue);
end;//TalcuRegionAutoExportTaskPrim.pm_SetRegionIndex

function TalcuRegionAutoExportTaskPrim.pm_GetFTPParams: Tl3Tag;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Attr[k2_attrFTPParams]);
end;//TalcuRegionAutoExportTaskPrim.pm_GetFTPParams

procedure TalcuRegionAutoExportTaskPrim.pm_SetFTPParams(aValue: Tl3Tag);
 {-}
begin
 TaggedData.AttrW[k2_attrFTPParams, nil] := (aValue);
end;//TalcuRegionAutoExportTaskPrim.pm_SetFTPParams

function TalcuRegionAutoExportTaskPrim.pm_GetFileNameMask: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrFileNameMask]);
end;//TalcuRegionAutoExportTaskPrim.pm_GetFileNameMask

procedure TalcuRegionAutoExportTaskPrim.pm_SetFileNameMask(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrFileNameMask, nil] := (aValue);
end;//TalcuRegionAutoExportTaskPrim.pm_SetFileNameMask

function TalcuRegionAutoExportTaskPrim.pm_GetResultWarehouse: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrResultWarehouse]);
end;//TalcuRegionAutoExportTaskPrim.pm_GetResultWarehouse

procedure TalcuRegionAutoExportTaskPrim.pm_SetResultWarehouse(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrResultWarehouse, nil] := (aValue);
end;//TalcuRegionAutoExportTaskPrim.pm_SetResultWarehouse

class function TalcuRegionAutoExportTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typRegionAutoExportTask;
end;//TalcuRegionAutoExportTaskPrim.GetTaggedDataType

{$IfEnd} //ServerTasks

end.