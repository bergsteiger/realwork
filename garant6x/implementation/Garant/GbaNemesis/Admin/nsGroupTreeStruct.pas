unit nsGroupTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/nsGroupTreeStruct.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::Users::TnsGroupTreeStruct
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  nsDataResetTreeStruct,
  afwInterfaces,
  DynamicTreeUnit
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TnsGroupTreeStruct = class(TnsDataResetTreeStruct)
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   function SettingsID: TafwSettingId; override;
 end;//TnsGroupTreeStruct
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  DataAdapter,
  nsConst
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TnsGroupTreeStruct

function TnsGroupTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_49E8213D00F6_var*
//#UC END# *48FF64F60078_49E8213D00F6_var*
begin
//#UC START# *48FF64F60078_49E8213D00F6_impl*
 Result := defDataAdapter.GetGroupsTree;
//#UC END# *48FF64F60078_49E8213D00F6_impl*
end;//TnsGroupTreeStruct.ReAqurieUnfilteredRoot

function TnsGroupTreeStruct.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_49E8213D00F6_var*
//#UC END# *48FF56D003E6_49E8213D00F6_var*
begin
//#UC START# *48FF56D003E6_49E8213D00F6_impl*
 Result := gi_cpGroupList;
//#UC END# *48FF56D003E6_49E8213D00F6_impl*
end;//TnsGroupTreeStruct.SettingsID

{$IfEnd} //Admin

end.