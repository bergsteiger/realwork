unit nsMedicDictionTreeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsMedicDictionTreeBase.pas"
// Начат: 2008/03/06 10:02:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic$Unit::TnsMedicDictionTreeBase
//
// Словарь медицинских терминов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  nsDataResetTreeStruct,
  afwInterfaces,
  DynamicTreeUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicDictionTreeBase = class(TnsDataResetTreeStruct)
  {* Словарь медицинских терминов }
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   function SettingsID: TafwSettingId; override;
 public
 // public methods
   class function Make: Il3SimpleTree;
 end;//TnsMedicDictionTreeBase
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsConst,
  SysUtils,
  DataAdapter,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMedicDictionTreeBase

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

{$IfEnd} //not Admin AND not Monitorings

end.