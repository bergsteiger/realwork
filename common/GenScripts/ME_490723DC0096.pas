unit nsNavigatorTreeStruct;
 {* Дерево навигатора с поддержкой сброса кэшированных данных }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsNavigatorTreeStruct.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsNavigatorTreeStruct" MUID: (490723DC0096)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 TnsNavigatorTreeStruct = class(TnsDataResetTreeStruct)
  {* Дерево навигатора с поддержкой сброса кэшированных данных }
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function SettingsID: TafwSettingId; override;
  public
   class function Make: Il3SimpleTree;
    {* Создаёт экземпляр дерева навигатора (которое в оболочке справа) }
 end;//TnsNavigatorTreeStruct
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsConst
 , nsTypes
 , nsRubricatorCache
;

class function TnsNavigatorTreeStruct.Make: Il3SimpleTree;
 {* Создаёт экземпляр дерева навигатора (которое в оболочке справа) }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
