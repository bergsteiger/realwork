unit nevFlatSubsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevFlatSubsList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::nevUtils::TnevFlatSubsList
//
// Плоский контейнер сабов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevTools,
  nevContainers,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IevSub;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevFlatSubsList = class(_l3InterfaceRefList_, InevFlatSubsList)
  {* Плоский контейнер сабов }
 protected
 // realized methods
   function pm_GetCount: Integer;
 end;//TnevFlatSubsList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TnevFlatSubsList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TnevFlatSubsList

function TnevFlatSubsList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_4A23947103C0get_var*
//#UC END# *4BB08B8902F2_4A23947103C0get_var*
begin
//#UC START# *4BB08B8902F2_4A23947103C0get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_4A23947103C0get_impl*
end;//TnevFlatSubsList.pm_GetCount

end.