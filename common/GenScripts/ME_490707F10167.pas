unit nsMedicDictionTreeBase;
 {* Словарь медицинских терминов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicDictionTreeBase.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , l3TreeInterfaces
 , DynamicTreeUnit
 , afwInterfaces
;

type
 TnsMedicDictionTreeBase = class(TnsDataResetTreeStruct)
  {* Словарь медицинских терминов }
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function SettingsID: TafwSettingId; override;
  public
   class function Make: Il3SimpleTree;
 end;//TnsMedicDictionTreeBase
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsConst
 , SysUtils
 , DataAdapter
 , nsTypes
;

class function TnsMedicDictionTreeBase.Make: Il3SimpleTree;
//#UC START# *49070844012C_490707F10167_var*
var
 l_Tree : TnsMedicDictionTreeBase;
 l_Root : INodeBase;
//#UC END# *49070844012C_490707F10167_var*
begin
//#UC START# *49070844012C_490707F10167_impl*
 if not defDataAdapter.IsInpharmExists then
 begin
  Result := nil;
  Exit;
 end;
 l_Tree := Create(DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(c_MedDiction_NodeClass)), False);
 try
  Result := l_Tree;
 finally;
  FreeAndNil(l_Tree);
 end;
//#UC END# *49070844012C_490707F10167_impl*
end;//TnsMedicDictionTreeBase.Make

function TnsMedicDictionTreeBase.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_490707F10167_var*
//#UC END# *48FF64F60078_490707F10167_var*
begin
//#UC START# *48FF64F60078_490707F10167_impl*
 Result := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(c_MedDiction_NodeClass));
//#UC END# *48FF64F60078_490707F10167_impl*
end;//TnsMedicDictionTreeBase.ReAqurieUnfilteredRoot

function TnsMedicDictionTreeBase.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_490707F10167_var*
//#UC END# *48FF56D003E6_490707F10167_var*
begin
//#UC START# *48FF56D003E6_490707F10167_impl*
 Result := gi_cpMedicDiction;
//#UC END# *48FF56D003E6_490707F10167_impl*
end;//TnsMedicDictionTreeBase.SettingsID
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
