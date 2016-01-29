unit alcuAnoncedExportPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuAnoncedExportPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAnoncedExportPrim
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
  alcuExport,
  evdTasksHelpers,
  k2Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAnoncedExportPrim = class(TalcuExport)
 protected
 // property methods
   function pm_GetOnThursdayMode: Boolean;
   procedure pm_SetOnThursdayMode(aValue: Boolean);
   function pm_GetNotifyEMailList: AnsiString;
   procedure pm_SetNotifyEMailList(const aValue: AnsiString);
   function pm_GetAnoncedDate: Integer;
   procedure pm_SetAnoncedDate(aValue: Integer);
   function pm_GetAccGroupsIDList: AccGroupsIDListHelper;
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property OnThursdayMode: Boolean
     read pm_GetOnThursdayMode
     write pm_SetOnThursdayMode;
     {* Режим экспорта "по четвергам" }
   property NotifyEMailList: AnsiString
     read pm_GetNotifyEMailList
     write pm_SetNotifyEMailList;
   property AnoncedDate: Integer
     read pm_GetAnoncedDate
     write pm_SetAnoncedDate;
   property AccGroupsIDList: AccGroupsIDListHelper
     read pm_GetAccGroupsIDList;
 end;//TalcuAnoncedExportPrim
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  AnoncedExportTask_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuAnoncedExportPrim

function TalcuAnoncedExportPrim.pm_GetOnThursdayMode: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrOnThursdayMode]);
end;//TalcuAnoncedExportPrim.pm_GetOnThursdayMode

procedure TalcuAnoncedExportPrim.pm_SetOnThursdayMode(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrOnThursdayMode, nil] := (aValue);
end;//TalcuAnoncedExportPrim.pm_SetOnThursdayMode

function TalcuAnoncedExportPrim.pm_GetNotifyEMailList: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrNotifyEMailList]);
end;//TalcuAnoncedExportPrim.pm_GetNotifyEMailList

procedure TalcuAnoncedExportPrim.pm_SetNotifyEMailList(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrNotifyEMailList, nil] := (aValue);
end;//TalcuAnoncedExportPrim.pm_SetNotifyEMailList

function TalcuAnoncedExportPrim.pm_GetAnoncedDate: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrAnoncedDate]);
end;//TalcuAnoncedExportPrim.pm_GetAnoncedDate

procedure TalcuAnoncedExportPrim.pm_SetAnoncedDate(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrAnoncedDate, nil] := (aValue);
end;//TalcuAnoncedExportPrim.pm_SetAnoncedDate

function TalcuAnoncedExportPrim.pm_GetAccGroupsIDList: AccGroupsIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TAccGroupsIDListHelper.Make(TaggedData.cAtom(k2_attrAccGroupsIDList));
end;//TalcuAnoncedExportPrim.pm_GetAccGroupsIDList

class function TalcuAnoncedExportPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAnoncedExportTask;
end;//TalcuAnoncedExportPrim.GetTaggedDataType

{$IfEnd} //ServerTasks

end.