unit nsNavigatorTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsNavigatorTreeStruct.pas"
// Начат: 2004/03/01 08:52:40 
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::Rubricator::TnsNavigatorTreeStruct
//
// Дерево навигатора с поддержкой сброса кэшированных данных
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
 TnsNavigatorTreeStruct = class(TnsDataResetTreeStruct)
  {* Дерево навигатора с поддержкой сброса кэшированных данных }
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   function SettingsID: TafwSettingId; override;
 public
 // public methods
   class function Make: Il3SimpleTree;
     {* Создаёт экземпляр дерева навигатора (которое в оболочке справа) }
 end;//TnsNavigatorTreeStruct
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsConst,
  nsTypes,
  nsRubricatorCache
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsNavigatorTreeStruct

class function TnsNavigatorTreeStruct.Make: Il3SimpleTree;
//#UC START# *4907242100D7_490723DC0096_var*
//#UC END# *4907242100D7_490723DC0096_var*
begin
//#UC START# *4907242100D7_490723DC0096_impl*
 Result := inherited Make(TnsRubricatorCache.Instance.RubricatorRoot, False);
//#UC END# *4907242100D7_490723DC0096_impl*
end;//TnsNavigatorTreeStruct.Make

function TnsNavigatorTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_490723DC0096_var*
//#UC END# *48FF64F60078_490723DC0096_var*
begin
//#UC START# *48FF64F60078_490723DC0096_impl*
 case BeenReseted of
  rtsRoot :
   Result := TnsRubricatorCache.Instance.RubricatorRoot;
  else
   Result := inherited ReAqurieUnfilteredRoot;
 end//case BeenReseted of
//#UC END# *48FF64F60078_490723DC0096_impl*
end;//TnsNavigatorTreeStruct.ReAqurieUnfilteredRoot

function TnsNavigatorTreeStruct.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_490723DC0096_var*
//#UC END# *48FF56D003E6_490723DC0096_var*
begin
//#UC START# *48FF56D003E6_490723DC0096_impl*
 Result := gi_cpNavigator;
//#UC END# *48FF56D003E6_490723DC0096_impl*
end;//TnsNavigatorTreeStruct.SettingsID

{$IfEnd} //not Admin AND not Monitorings

end.