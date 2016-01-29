unit nevPointList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevPointList.pas"
// Начат: 20.03.2008 17:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::nevUtils::TnevPointList
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
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = InevPoint;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevPointList = class(_l3InterfaceRefList_)
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//TnevPointList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TnevPointList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TnevPointList

{$If not defined(DesignTimeLibrary)}
class function TnevPointList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_47E2750502E9_var*
//#UC END# *47A6FEE600FC_47E2750502E9_var*
begin
//#UC START# *47A6FEE600FC_47E2750502E9_impl*
 Result := true;
//#UC END# *47A6FEE600FC_47E2750502E9_impl*
end;//TnevPointList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.