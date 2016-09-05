unit nsGroupTreeStruct;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\nsGroupTreeStruct.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsGroupTreeStruct" MUID: (49E8213D00F6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , DynamicTreeUnit
 , afwInterfaces
;

type
 TnsGroupTreeStruct = class(TnsDataResetTreeStruct)
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function SettingsID: TafwSettingId; override;
 end;//TnsGroupTreeStruct
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , DataAdapter
 , nsConst
 //#UC START# *49E8213D00F6impl_uses*
 //#UC END# *49E8213D00F6impl_uses*
;

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
{$IfEnd} // Defined(Admin)

end.
