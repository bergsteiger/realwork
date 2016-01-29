unit alcuRegionImportTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuRegionImportTaskPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuRegionImportTaskPrim
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
  alcuImport,
  l3Variant,
  k2Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuRegionImportTaskPrim = class(TalcuImport)
 protected
 // property methods
   function pm_GetRegionIndex: Integer;
   procedure pm_SetRegionIndex(aValue: Integer);
   function pm_GetFTPParams: Tl3Tag;
   procedure pm_SetFTPParams(aValue: Tl3Tag);
   function pm_GetFileNameMask: AnsiString;
   procedure pm_SetFileNameMask(const aValue: AnsiString);
   function pm_GetSourceWarehouse: AnsiString;
   procedure pm_SetSourceWarehouse(const aValue: AnsiString);
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
   property SourceWarehouse: AnsiString
     read pm_GetSourceWarehouse
     write pm_SetSourceWarehouse;
 end;//TalcuRegionImportTaskPrim
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  RegionImportTask_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuRegionImportTaskPrim

function TalcuRegionImportTaskPrim.pm_GetRegionIndex: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrRegionIndex]);
end;//TalcuRegionImportTaskPrim.pm_GetRegionIndex

procedure TalcuRegionImportTaskPrim.pm_SetRegionIndex(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrRegionIndex, nil] := (aValue);
end;//TalcuRegionImportTaskPrim.pm_SetRegionIndex

function TalcuRegionImportTaskPrim.pm_GetFTPParams: Tl3Tag;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Attr[k2_attrFTPParams]);
end;//TalcuRegionImportTaskPrim.pm_GetFTPParams

procedure TalcuRegionImportTaskPrim.pm_SetFTPParams(aValue: Tl3Tag);
 {-}
begin
 TaggedData.AttrW[k2_attrFTPParams, nil] := (aValue);
end;//TalcuRegionImportTaskPrim.pm_SetFTPParams

function TalcuRegionImportTaskPrim.pm_GetFileNameMask: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrFileNameMask]);
end;//TalcuRegionImportTaskPrim.pm_GetFileNameMask

procedure TalcuRegionImportTaskPrim.pm_SetFileNameMask(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrFileNameMask, nil] := (aValue);
end;//TalcuRegionImportTaskPrim.pm_SetFileNameMask

function TalcuRegionImportTaskPrim.pm_GetSourceWarehouse: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSourceWarehouse]);
end;//TalcuRegionImportTaskPrim.pm_GetSourceWarehouse

procedure TalcuRegionImportTaskPrim.pm_SetSourceWarehouse(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrSourceWarehouse, nil] := (aValue);
end;//TalcuRegionImportTaskPrim.pm_SetSourceWarehouse

class function TalcuRegionImportTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typRegionImportTask;
end;//TalcuRegionImportTaskPrim.GetTaggedDataType

{$IfEnd} //ServerTasks

end.