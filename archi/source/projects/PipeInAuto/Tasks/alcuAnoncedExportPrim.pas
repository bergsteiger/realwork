unit alcuAnoncedExportPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAnoncedExportPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAnoncedExportPrim" MUID: (53DB5CFF017D)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExport
 , k2Base
;

type
 TalcuAnoncedExportPrim = class(TalcuExport)
  protected
   function pm_GetOnThursdayMode: Boolean;
   procedure pm_SetOnThursdayMode(aValue: Boolean);
   function pm_GetNotifyEMailList: AnsiString;
   procedure pm_SetNotifyEMailList(const aValue: AnsiString);
   function pm_GetAnoncedDate: Integer;
   procedure pm_SetAnoncedDate(aValue: Integer);
   function pm_GetAccGroupsIDList: AccGroupsIDListHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
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
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , AnoncedExportTask_Const
 //#UC START# *53DB5CFF017Dimpl_uses*
 //#UC END# *53DB5CFF017Dimpl_uses*
;

function TalcuAnoncedExportPrim.pm_GetOnThursdayMode: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrOnThursdayMode]);
end;//TalcuAnoncedExportPrim.pm_GetOnThursdayMode

procedure TalcuAnoncedExportPrim.pm_SetOnThursdayMode(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrOnThursdayMode, nil] := (aValue);
end;//TalcuAnoncedExportPrim.pm_SetOnThursdayMode

function TalcuAnoncedExportPrim.pm_GetNotifyEMailList: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrNotifyEMailList]);
end;//TalcuAnoncedExportPrim.pm_GetNotifyEMailList

procedure TalcuAnoncedExportPrim.pm_SetNotifyEMailList(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrNotifyEMailList, nil] := (aValue);
end;//TalcuAnoncedExportPrim.pm_SetNotifyEMailList

function TalcuAnoncedExportPrim.pm_GetAnoncedDate: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrAnoncedDate]);
end;//TalcuAnoncedExportPrim.pm_GetAnoncedDate

procedure TalcuAnoncedExportPrim.pm_SetAnoncedDate(aValue: Integer);
begin
 TaggedData.IntW[k2_attrAnoncedDate, nil] := (aValue);
end;//TalcuAnoncedExportPrim.pm_SetAnoncedDate

function TalcuAnoncedExportPrim.pm_GetAccGroupsIDList: AccGroupsIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TAccGroupsIDListHelper.Make(TaggedData.cAtom(k2_attrAccGroupsIDList));
end;//TalcuAnoncedExportPrim.pm_GetAccGroupsIDList

class function TalcuAnoncedExportPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAnoncedExportTask;
end;//TalcuAnoncedExportPrim.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
